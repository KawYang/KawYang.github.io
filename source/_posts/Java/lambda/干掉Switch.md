---
title: 干掉Switch
author: KawYang
top: false
cover: true
toc: true
mathjax: false
categories: Lambda
tags:
  - Java
  - 优化
  - lambda
abbrlink: ceb286b0
date: 2021-05-09 11:25:38
coverImg:
img:
---
> **优化目标**： 去掉Switch

## 背景介绍

> 对于前端页面的筛选查询，查询条件具有不确定性，不同的字段可能使用的条件也是不同的，需要对不同的字段创建不同的查询条件。
>
> - 查询：使用MyBatsiPlus 的 QueryWrapper 进行单表查询。
>
> - 根据JSONObject 对象中的不同的Key调用不同的QueryWrapper 对象方法，组织查询条件。

## 优化前

```java
/**
 * @author <a href="mailto:1595550476@qq.com">KawYang</a>
 * Created by MacBook Pro on 2021/05/06.
 */
@Service
public class ThirdPartLogServiceImpl implements ThirdPartLogService {

    @Autowired
    private RequestLogMapper requestLogMapper;

   	// 模糊查询列表方法
    @Override
    public List<LogInfo> getList(JSONObject jsonObject, Integer page, Integer size) {

        // 根据JSONObject组织 QueryWrapper
        QueryWrapper<RequestLog> queryWrapper = new QueryWrapper<>();
        makeQuery(jsonObject, queryWrapper);
      
        queryWrapper.orderByAsc("id");
        queryWrapper.last("limit " +((page-1) * size) + "," +size);

        return requestLogMapper.selectList(queryWrapper).stream()
                .peek(System.out::println)
                .map(RequestLog::transToResponse)
                .collect(Collectors.toList());
    }

  	// 待优化的代码块 - 去掉 代码中的 switch 
    private void makeQuery(JSONObject jsonObject, QueryWrapper queryWrapper) {
        jsonObject.keySet().stream()
          		// 过滤掉错误条件
		          .filter(e->jsonObject.getObject(e, Object.class) != null && !jsonObject.getString(e).isEmpty()
        ).forEach(e ->{
            switch (e){
                case "endTime":
                    queryWrapper.le(keyMap.get(e), jsonObject.getObject(e, Date.class)); break;
                case "startTime":
                    queryWrapper.ge(keyMap.get(e), jsonObject.getObject(e, Date.class)); break;
                default:
                    queryWrapper.eq(keyMap.get(e), jsonObject.getObject(e, String.class)); break;
            }

        });
    }

    /**
     * jsonObject.key -> table.key
     * 将 JSONObject 的 Key 转换成 表 中的Kay
     */
    private static final Map<String, String> keyMap = new HashMap<String, String>(){
        {
            put("startTime", "add_time");
            put("endTime", "add_time");
            put("doctor", "doctor");
            put("subType", "sub_type");
            put("status", "status");
            put("backStatus", "back_status");
        }
    };

}

```

> **分析**: Switch max 执行的次数为 ： jsonObject 的 Kay 的数量 与 swatch 的case 数量的 **笛卡尔积** 时间复杂度为 $O(n^2)$
>
> **优化**: 由于 startTime 和 endTime 只处理一次, 可以先处理，再用循环处理默认方法 ->将时间复杂度降成 $O(n)$.
>
> 函数式接口的定义： 执行的方法`queryWrapper.le(keyMap.get(e), jsonObject.getObject(e, Date.class))`中有三个参数 ， 其中 e 在 前两个case 中可以写死，所以可以需要定义两个参数。方法中不需要返回值，可以选择java8 的 `BiConsumer`函数接口。
>
> ```java
> @FunctionalInterface
> public interface BiConsumer<T, U>{
> void accept(T t, U u);
> ...
> }
> ```

## 初次优化

```java
  	// 先定义函数式接口  - 不同的 Key 值调用不同的方法
    private BiConsumer<JSONObject, QueryWrapper> FN1 = (json, queryWrapper) -> queryWrapper.le(keyMap.get("endTime"), json.getObject("endTime", Date.class));
    private BiConsumer<JSONObject, QueryWrapper> FN2 = (json, queryWrapper) -> queryWrapper.ge(keyMap.get("startTime"), json.getObject("startTime", Date.class));

    private void makeQuery(JSONObject jsonObject, QueryWrapper queryWrapper) {
      	// 先将  startTime 和 endTime 进行处理
      	if (jsonObject.containsKey("endTime")) FN1.accept(jsonObject, queryWrapper);
        if (jsonObject.containsKey("startTime")) FN2.accept(jsonObject, queryWrapper);
        jsonObject.keySet().stream()
          			// 过滤掉已处理
                .filter(d -> d != "endTime" && d != "startTime")
          			// 过滤掉错误数据
                .filter(e-> jsonObject.getObject(e, Object.class) != null && !jsonObject.getString(e).isEmpty())
          			// 未处理的组织 queryWrapper
                .forEach(e -> queryWrapper.eq(keyMap.get(e), jsonObject.getObject(e, String.class)));
    }

    /**
     * jsonObject.key -> table.key
     */
    private static final Map<String, String> keyMap = new HashMap<String, String>(){
        {
            put("startTime", "add_time");
            put("endTime", "add_time");
            put("doctor", "doctor");
            put("subType", "sub_type");
            put("status", "status");
            put("backStatus", "back_status");
        }
    };

}
```

> **缺点**： 只将前两个 case 转换成函数式方法，默认处理方法未处理，导致内容不够整洁。

## 再次优化

```java

    /**
     * 组织查询条件
     */
    private final Consumer3<JSONObject, QueryWrapper<RequestLog>, String> FN1 = (json, queryWrapper, key) -> queryWrapper.le(keyMap.get(key), json.getObject(key, Date.class));
    private final Consumer3<JSONObject, QueryWrapper<RequestLog>, String> FN2 = (json, queryWrapper, key) -> queryWrapper.ge(keyMap.get(key), json.getObject(key, Date.class));
    private final Consumer3<JSONObject, QueryWrapper<RequestLog>, String> FN3 = (json, queryWrapper, key) -> queryWrapper.eq(keyMap.get(key), json.getString(key));

		// 使用表驱动的方式
    private final  HashMap<String, Consumer3<JSONObject, QueryWrapper<RequestLog>, String>>
        funcMap = new HashMap<String, Consumer3<JSONObject, QueryWrapper<RequestLog>, String>>(){
        {
            put("endTime", FN1);
            put("startTime", FN2);
            put("other", FN3);
        }
    };


    private void makeQuery(JSONObject jsonObject, QueryWrapper<RequestLog> queryWrapper) {

        jsonObject.keySet().stream()
          			// 筛选出符合条件的数据
                .filter(e -> jsonObject.getObject(e, Object.class) != null && !jsonObject.getString(e).isEmpty())
          			//
                .forEach(e ->{
                    if(funcMap.containsKey(e)) funcMap.get(e).accept(jsonObject, queryWrapper,e);
                    else funcMap.get("other").accept(jsonObject, queryWrapper,e);
                });
    }

```

> **总结**:  采用表驱动的方式，将不同的查询条件，`分发`到不同的函数式方法中，完成条件的拼接。
>
> 在 makeQuery 方法中 遍历一次就可完成 条件的拼接。时间复杂度为 $O(n)$

