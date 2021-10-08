---
title: MySQL&PostgresQL慢查询日志
author: KawYang
top: false
cover: false
toc: true
mathjax: false
categories: SQL
tags:
  - SQL
abbrlink: b92ce138
date: 2021-10-06 19:38:35
img: https://www.postgresql.org/media/img/misc/banner.jpg
coverImg: https://www.postgresql.org/media/img/misc/banner.jpg
---
## MySQL

### 查看设置

```sql
$ mysql -u root -p
Enter password: 
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 18
Server version: 8.0.21 Homebrew

Copyright (c) 2000, 2020, Oracle and/or its affiliates. All rights reserved.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> show variables like '%query%';
+------------------------------+-----------------------------------+
| Variable_name                | Value                             |
+------------------------------+-----------------------------------+
| binlog_rows_query_log_events | OFF                               |
| ft_query_expansion_limit     | 20                                |
| have_query_cache             | NO                                |
| long_query_time              | 10.000000                         |
| query_alloc_block_size       | 8192                              |
| query_prealloc_size          | 8192                              |
| slow_query_log               | OFF                               |
| slow_query_log_file          | /usr/local/var/mysql/Pro-slow.log |
+------------------------------+-----------------------------------+
8 rows in set (0.00 sec)
```

- long_query_time : 设置记录查询语句时间的阈值, 单位 (S)
- slow_query_log : 慢查询日志的开关
- slow_query_log_file : 慢查询日志的路径,`文件路径可以不用设置,如果mysql对当前路径不能写,日志开关不起作用`

### 修改配置文件

> 修改 `/usr/local/etc/my.cnf ` 配置文件内容,在[mysqld]中提那家一下内容

```vim
long_query_time=1 
slow_query_log =1
slow_query_log_file= /usr/local/var/mysql/Pro-slow.log
log_queries_not_using_indexes=1 # 开启无索引的查询记录
```

### 重启 

```shell
# Mac
> mysql.server restart

# Linux 
> service mysqld restart
```

### 测试

```shell
mysql> show variables like '%query%';
+------------------------------+-----------------------------------+
| Variable_name                | Value                             |
+------------------------------+-----------------------------------+
| binlog_rows_query_log_events | OFF                               |
| ft_query_expansion_limit     | 20                                |
| have_query_cache             | NO                                |
| long_query_time              | 1.000000                          |
| query_alloc_block_size       | 8192                              |
| query_prealloc_size          | 8192                              |
| slow_query_log               | ON                                |
| slow_query_log_file          | /usr/local/var/mysql/Pro-slow.log |
+------------------------------+-----------------------------------+
8 rows in set (0.01 sec)

mysql> select sleep(2);
+----------+
| sleep(2) |
+----------+
|        0 |
+----------+
1 row in set (2.00 sec)
mysql> exit
Bye
$ cat /usr/local/var/mysql/Pro-slow.log
/usr/local/Cellar/mysql/8.0.21/bin/mysqld, Version: 8.0.21 (Homebrew). started with:
Tcp port: 3306  Unix socket: /tmp/mysql.sock
Time                 Id Command    Argument
# Time: 2021-10-06T12:52:12.249937Z
# User@Host: root[root] @ localhost []  Id:     8
# Query_time: 2.003272  Lock_time: 0.000000 Rows_sent: 1  Rows_examined: 1
SET timestamp=1633524730;
select sleep(2);

```

> 删除日志文件后需要重启mysql 才能保存,不然文件不会重建.

### 修改日志文件存储到挂载磁盘

```shell
# 1. 移动日志文件到 /home下
mv /usr/local/var/mysql/Pro-slow.log /home/
# 2. 在原本日志路径建立软连接
ln -s /home/Pro-slow.log /usr/local/var/mysql/Pro-slow.log
```

## PostgreSQL[<sup>1</sup>](#refer-anchor-1)

> 当前 PostgreSQL 使用的是docker 镜像,对应 版本为 `daocloud.io/library/postgres:11-alpine`

PostgreSQL 设置[<sup>3</sup>](#refer-anchor-3):

| 参数名称                   | 状态                           | 说明                                                         |
| -------------------------- | ------------------------------ | ------------------------------------------------------------ |
| logging_collector          | on                             | Start a subprocess to capture stderr output and/or csvlogs into log files. |
| log_min_duration_statement | 1s                             | Sets the minimum execution time above which statements will be logged. |
| log_filename               | postgresql-%Y-%m-%d_%H%M%S.log | Sets the file name pattern for log files.                    |
|log_rotation_size                      | 100MB                                    | Automatic log file rotation will occur after N kilobytes.|
|log_directory                          | log                                      | Sets the destination directory for log files.|

### 查看设置

```shell
$ psql -h localhost -U postgres -p 3456
Password for user postgres: 
psql (13.4, server 11.4)
Type "help" for help.

postgres=# show log_min_duration_statement;
 log_min_duration_statement 
----------------------------
 1s
(1 row)

postgres=# 
```



### 修改设置

> 通过 `docker exec -it posgres /bin/bash` 进入docker 容器,修改 `/var/lib/postgresql/data/postgresql.conf`文件,修改内容如下:

![image-20211006215637406](https://gitee.com/KawYang/image/raw/master/img/image-20211008172936048.png)



### 重新加载设置

> 参考[<sup>1</sup>](#refer-anchor-1)

### 测试

> 日志文件设置为 log 的存储位置为 `/var/lib/postgresql/data/log/`

```shell
$ psql -h localhost -U postgres -p 3456  
Password for user postgres: 
psql (13.4, server 11.4)
Type "help" for help.

postgres=# select pg_sleep(2);
 pg_sleep 
----------
 
(1 row)

postgres=# exit

$ docker exec -it postgres /bin/bash                                                                                                                                                                                     22:45  
bash-5.0# cd /var/lib/postgresql/data/log/
bash-5.0# ls
postgresql-2021-10-06_144542.log
bash-5.0# cat postgresql-2021-10-06_144542.log 
2021-10-06 14:45:42.013 UTC [19] LOG:  database system was shut down at 2021-10-06 14:45:40 UTC
2021-10-06 14:45:42.016 UTC [1] LOG:  database system is ready to accept connections
2021-10-06 14:47:05.283 UTC [42] FATAL:  password authentication failed for user "postgres"
2021-10-06 14:47:05.283 UTC [42] DETAIL:  Password does not match for user "postgres".
	Connection matched pg_hba.conf line 95: "host all all all md5"
2021-10-06 14:47:22.512 UTC [44] LOG:  duration: 2001.597 ms  statement: select pg_sleep(2);
bash-5.0# 

```

### 配置修改错误后，docker 不能重启解决方案[<sup>2</sup>](#refer-anchor-2)

> `虽然docker容器未启动,但是docker cp 命令依然可以用,所以使用docker cp命令拷贝出来,修改正确后再拷贝回相对应的位置,即可.`

虽然 Linux 能找到容器文件的挂载位置,但是Mac没找到相应的文件.

`screen ~/Library/Containers/com.docker.docker/Data/vms/0/tty`

# 参考内容

<h5 id ='refer-anchor-1'><a href ="https://www.jianshu.com/p/78fe12174d25">postgresql开启慢查询日志</a></h5>
<h5 id ='refer-anchor-2'><a href ="https://zhuanlan.zhihu.com/p/159426055">Docker容器无法启动,里面的配置文件如何修改</a></h5>   

<h5 id ='refer-anchor-3'><a href ="https://www.cnblogs.com/alianbog/p/5596921.html">Postgresql日志收集</a></h5>   

