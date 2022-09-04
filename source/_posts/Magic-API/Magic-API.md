---
title: Magic-API 学习笔记
categories: 开源框架
tags: Magic-API
abbrlink: '36e0671'
date: 2020-07-08 15:40:07
---
## Magic-API 学习笔记

### 注解

- @Configuration
- [@ConditionalOnClass({DataSource.class,RequestMappingHandlerMapping.class})](https://blog.csdn.net/lbh199466/article/details/88303897)
- @AutoConfigureAfter({DataSourceAutoConfiguration.class})
- @EnableConfigurationProperties(MagicAPIProperties.class)
- @NestedConfigurationProperty
- [Spring Boot 之 spring.factories](https://www.cnblogs.com/huanghzm/p/12217630.html)

- [springboot之additional-spring-configuration-metadata.json自定义提示](https://blog.csdn.net/weixin_43367055/article/details/100174407)





### Swagger 使用

#### 1. pom 依赖

```xml
<!-- 引入swagger2 -->
<dependency>
    <groupId>io.springfox</groupId>
    <artifactId>springfox-swagger2</artifactId>
    <version>2.9.2</version>
</dependency>
<dependency>
    <groupId>io.springfox</groupId>
    <artifactId>springfox-swagger-ui</artifactId>
    <version>2.9.2</version>
</dependency>
```

#### 2.配置


- Swagger 配置

```java
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import springfox.documentation.builders.ApiInfoBuilder;
import springfox.documentation.builders.PathSelectors;
import springfox.documentation.builders.RequestHandlerSelectors;
import springfox.documentation.service.ApiInfo;
import springfox.documentation.service.Contact;
import springfox.documentation.spi.DocumentationType;
import springfox.documentation.spring.web.plugins.Docket;
import springfox.documentation.swagger2.annotations.EnableSwagger2;

/**
 * @author renyongzhen
 */
@Configuration
@EnableSwagger2
public class SwaggerConfig {


    /**
     * 创建swagger对象:
     *
     * @return
     */
    @Bean
    public Docket mapRestApi() {
        return new Docket(DocumentationType.SWAGGER_2).groupName("xxx管理系统API")
                .apiInfo(apiInfo()).select()
                .apis(RequestHandlerSelectors.basePackage("com.xxx.xxx.controller"))
                .paths(PathSelectors.any())
                .build();
    }

    /**
     * 设置api信息
     * title:swagger题目
     * description:描述
     * cotact:创建者
     * @return
     */
    private ApiInfo apiInfo() {
        return new ApiInfoBuilder()
                .title("xxx微服务API")
                .description("xxxx描述")
                .contact(new Contact("xxxName",null ,"xxx@qq.com"))
                .version("1.0")
                .build();
    }
}
```

- 打印Swagger地址

```java
package com.example.neo4jdemo.config;

import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.web.context.WebServerInitializedEvent;
import org.springframework.context.ApplicationListener;
import org.springframework.stereotype.Component;

import java.net.Inet4Address;
import java.net.UnknownHostException;

/**
 * @Description 控制台输出 Swagger 接口文档地址
 **/
@Component
@Slf4j
public class SwaggerPrintConfig implements ApplicationListener<WebServerInitializedEvent> {
    @Override
    public void onApplicationEvent(WebServerInitializedEvent event) {
        try {
            //获取IP
            String hostAddress = Inet4Address.getLocalHost().getHostAddress();
            //获取端口号
            int port = event.getWebServer().getPort();
            //获取应用名
            String applicationName = event.getApplicationContext().getApplicationName();
            log.info("项目启动启动成功！接口文档地址: http://" + hostAddress + ":" + event.getWebServer().getPort() + applicationName + "/swagger-ui.html");
        } catch (UnknownHostException e) {
            e.printStackTrace();
        }
    }
}

```






---

[ 博客园-Swagger介绍及使用](https://www.jianshu.com/p/349e130e40d5)

![image-20210326225548075](https://gitee.com/KawYang/image/raw/master/img/image-20210326225548075.png)

![image-20210326225615139](https://gitee.com/KawYang/image/raw/master/img/image-20210326225615139.png)

<img src="https://gitee.com/KawYang/image/raw/master/img/image-20210326230622476.png" alt="image-20210326230622476" style= />

![image-20210326231022339](https://gitee.com/KawYang/image/raw/master/img/image-20210326231022339.png)

