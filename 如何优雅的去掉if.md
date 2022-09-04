## 如何优雅的去掉if

根据不同的条件处理不同的方法,将处理的内容抽取出来,进行抽象.IService;

```java
package com.yang.service;

/**
 * @author <a href="mailto:1595550476@qq.com">KawYang</a>
 * Created by MacBook Pro on 2021/12/29.
 */
public interface IService {

    void func();
  
}
```

### 1. 使用枚举类

- 分别实现不同的分支方法

  ```java
  /**
   * @author <a href="mailto:1595550476@qq.com">KawYang</a>
   * Created by MacBook Pro on 2021/12/29.
   */
  public class IServiceImpl implements IService {
      @Override
      public void func() {
          System.out.println("IService Impl !");
      }
  }
  
  /**
   * @author <a href="mailto:1595550476@qq.com">KawYang</a>
   * Created by MacBook Pro on 2021/12/29.
   */
  public class IServiceImpl2 implements IService {
      @Override
      public void func() {
          System.out.println("IServiceImpl2!");
      }
  }
  ```

  

- 定义枚举类

  ```java
  package com.yang.use;
  
  import com.yang.service.IService;
  import com.yang.service.impl.IServiceImpl;
  import com.yang.service.impl.IServiceImpl2;
  
  /**
   * @author <a href="mailto:1595550476@qq.com">KawYang</a>
   * Created by MacBook Pro on 2021/12/29.
   */
  public enum ServiceEnum {
  
      /**
       * 测试1
       */
      SERVICE_1("1", IServiceImpl.class),
  
      /**
       * 测试2
       */
      SERVICE_2("2", IServiceImpl2.class);
  
      private String id;
  
      private Class<? extends IService> service;
  
    
      public static ServiceEnum getServiceById(String id){
          for (ServiceEnum value : ServiceEnum.values()) {
              if (value.id.equals(id)) {
                  return value;
              }
          }
          return SERVICE_1;
      }
  
      public IService getServiceImpl(){
          try {
              return service.newInstance();
          } catch (InstantiationException | IllegalAccessException e) {
              e.printStackTrace();
          }
          return null;
      }
  	// 省略 get/set/init
  }
  ```

  > 1. 定义 getServiceEnum方法,通过id , 进行判断,返回 对应的 Enum 类
  >
  > 2. 定义getServiceImpl 方法,将 class 转换成 实现类.

### 2. 表驱动的方式