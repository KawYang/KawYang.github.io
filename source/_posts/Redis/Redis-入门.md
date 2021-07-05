---
title: Redis-入门
categories: Redis
tags: Redis
abbrlink: 2b6be590
date: 2020-07-08 15:40:07
---

# Redis - 入门

<img src="https://gitee.com/KawYang/image/raw/master/img/image-20210213110833451.png" alt="image-20210213110833451" style="margin-left: 5%; zoom: 200%;"  />

---


# Redis(Remote Dictionary Server)

> Key - Value  的非关系型数据库，C语言编写的，提供多种持久化机制，基于内存的存储的，提供了主从，哨兵以及集群的搭建方式，更加方便的横向和垂直拓展。



## 目标

> 1. Redis基于内存存储数据和读取数据 => 提高存储速度
> 2. 将Session共享数据存放在 Redis中 => 多服务器存储共享
> 3. Redis接收用户请求是单线程的 => 解决多服务器锁不能互斥的问题

NoSQL => 非关系型数据库 => Not Only SQL

## 安装

> 1. 下载
> 2. 编译

## 启动

> 1. 启动服务： `redis-server`
> 2. 连接redis：`redis-cli`

## 配置

> config get *

