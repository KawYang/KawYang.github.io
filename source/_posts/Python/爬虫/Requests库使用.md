---
title: Requests库使用
author: KawYang
top: false
cover: false
toc: true
mathjax: false
categories: Python
tags:
    - 爬虫
    - Python
abbrlink: 7e933fdb
date: 2020-08-29 22:11:30
img: https://gitee.com/KawYang/image/raw/master/img/20210829232303.png
coverImg:
---

# Requests库详解

> [Requests -PyPi](https://pypi.org/project/requests/)
>
> 说明: 本文章从 jupyter-notebook 导出，代码示例后边附带执行结果

> 用法方便，基于urllib库

## 实例


```python
import requests

response =  requests.get("http://www.baidu.com")
print(type(response))
print(response.status_code)
print(response.text)
print(response.cookies)
```

```html
<class 'requests.models.Response'>
200
<!DOCTYPE html>
<!--STATUS OK--><html> <head><meta http-equiv=content-type content=text/html;charset=utf-8><meta http-equiv=X-UA-Compatible content=IE=Edge>
...
<img src=//www.baidu.com/img/gs.gif> </p> </div> </div> </div> </body> </html>
<RequestsCookieJar[<Cookie BDORZ=27315 for .baidu.com/>]>
```


## 各种请求方式


```python
import requests

requests.post("http://httpbin/post")
requests.put("http://httpbin/put")
requests.delete("http://httpbin/delete")
requests.head("http://httpbin/get")
requests.options("http://httpbin/get")
```

## 请求

### 基本的GET请求

#### 基本使用


```python
import requests

response = requests.get("http://httpbin.org/get")

print(response.text)
```

```json
{
  "args": {}, 
  "headers": {
    "Accept": "*/*", 
    "Accept-Encoding": "gzip, deflate", 
    "Host": "httpbin.org", 
    "User-Agent": "python-requests/2.23.0", 
    "X-Amzn-Trace-Id": "Root=1-5e6894cf-dd476ea0264c09203cb3eb4c"
  }, 
  "origin": "27.205.175.189", 
  "url": "http://httpbin.org/get"
}
```




```python
import requests

params = {
    'name':'test',
    'age':33
}
response = requests.get("http://httpbin.org/get",params=params)

print(response.text)
```



```json
{
  "args": {
    "age": "33", 
    "name": "test"
  }, 
  "headers": {
    "Accept": "*/*", 
    "Accept-Encoding": "gzip, deflate", 
    "Host": "httpbin.org", 
    "User-Agent": "python-requests/2.23.0", 
    "X-Amzn-Trace-Id": "Root=1-5e689536-ae4ddf7caa1c912651d621fa"
  }, 
  "origin": "27.205.175.189", 
  "url": "http://httpbin.org/get?name=test&age=33"
}
```



## 解析Json


```python
import requests
import json

response = requests.get("http://httpbin.org/get")
print(type(response.text))

# 结果一样
print(response.json())
print(json.loads(response.text))

print(type(response.json()))
```



```shell
<class 'str'>
{'args': {}, 'headers': {'Accept': '*/*', 'Accept-Encoding': 'gzip, deflate', 'Host': 'httpbin.org', 'User-Agent': 'python-requests/2.23.0', 'X-Amzn-Trace-Id': 'Root=1-5e6895d6-1aad3eb76a5c7c63c7fea561'}, 'origin': '27.205.175.189', 'url': 'http://httpbin.org/get'}
{'args': {}, 'headers': {'Accept': '*/*', 'Accept-Encoding': 'gzip, deflate', 'Host': 'httpbin.org', 'User-Agent': 'python-requests/2.23.0', 'X-Amzn-Trace-Id': 'Root=1-5e6895d6-1aad3eb76a5c7c63c7fea561'}, 'origin': '27.205.175.189', 'url': 'http://httpbin.org/get'}
<class 'dict'>
```

## 解析二进制文件



```python
import requests

response = requests.get('https://github.com/favicon.ico')

with open("/Users/mac/MyCodes/python/github.ico",'wb') as f:
    f.write(response.content)
    f.close()
print('finish!')
```



```shell
finish!
```

## 添加 headers



```python
import requests

response = requests.get("https://www.zhihu.com/explore")
print(response.text)
```



```html
<html>
<head><title>400 Bad Request</title></head>
<body bgcolor="white">
<center><h1>400 Bad Request</h1></center>
<hr><center>openresty</center>
</body>
</html>
```




```python
import requests
from bs4 import BeautifulSoup 

headers = {
    'User-Agent':'Mozilla/5.0(Macintosh; Intel Mac OS X 10_15_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.132 Safari/537.36',
}
response = requests.get(r"https://www.zhipin.com/c100010000/?page=4",headers=headers)
soup = BeautifulSoup(response.text)

print(soup.body)
```



```html
<body>
<div class="data-tips">
<div class="tip-inner">
<div class="boss-loading">
<span class="component-b">B</span><span class="component-o">O</span><span class="component-s1">S</span><span class="component-s2">S</span>
<p class="gray">æ­£å¨å è½½ä¸­...</p>
</div>
</div>
</div>
<script>
...
</script>
</body>
```

## 基本POST 请求


```python
import requests

data = {'name':'test'}
headers = {
    'User-Agent':'Mozilla/5.0(Macintosh; Intel Mac OS X 10_15_3)AppleWebKit/537.36(KHTML, like Gecko) Chrome/80.0.3987.132 Safari/537.36',
}

response = requests.post("http://httpbin.org/post",data=data,headers=headers)

print(response.text)
```

```json
{
  "args": {}, 
  "data": "", 
  "files": {}, 
  "form": {
    "name": "test"
  }, 
  "headers": {
    "Accept": "*/*", 
    "Accept-Encoding": "gzip, deflate", 
    "Content-Length": "9", 
    "Content-Type": "application/x-www-form-urlencoded", 
    "Host": "httpbin.org", 
    "User-Agent": "Mozilla/5.0(Macintosh; Intel Mac OS X 10_15_3)AppleWebKit/537.36(KHTML, like Gecko) Chrome/80.0.3987.132 Safari/537.36", 
    "X-Amzn-Trace-Id": "Root=1-5e689a93-f3271ea041ec2120f9e5bc20"
  }, 
  "json": null, 
  "origin": "27.205.175.189", 
  "url": "http://httpbin.org/post"
}
```



## 响应

### response 属性


```python
import requests

response = requests.get("http://www.baidu.com")
print(response.status_code)
print(response.headers)
print(response.cookies)
print(response.url)
print(response.history)

```

```shell
200
{'Cache-Control': 'private, no-cache, no-store, proxy-revalidate, no-transform', 'Connection': 'keep-alive', 'Content-Encoding': 'gzip', 'Content-Type': 'text/html', 'Date': 'Wed, 11 Mar 2020 08:19:20 GMT', 'Last-Modified': 'Mon, 23 Jan 2017 13:27:32 GMT', 'Pragma': 'no-cache', 'Server': 'bfe/1.0.8.18', 'Set-Cookie': 'BDORZ=27315; max-age=86400; domain=.baidu.com; path=/', 'Transfer-Encoding': 'chunked'}
<RequestsCookieJar[<Cookie BDORZ=27315 for .baidu.com/>]>
http://www.baidu.com/
[]
```


### 状态码判断


```python
import requests

response = requests.get("http://www.baidu.com")
exit() if not response.status_code == requests.codes.ok else print("finish")
```

```shell
finish
```


# 高级操作
## 文件上传


```python
import requests

file = {'file':open("/Users/mac/MyCodes/python/github.ico",'rb')}
response = requests.post('http://httpbin.org/post',files=file)
print(response.text)
```

```json
{
  "args": {}, 
  "data": "", 
  "files": {
    "file": "data:application/octet-stream;base64,AAABAAIAEBAAAAEAIAAoBQAAJgAAACAgAAABACAAKBQAAE4FAAAoAAAAEAAAACAAAAABACAAAAAAAAAFAAAAAAAAAAAAAAAAAAAAAAAAAAA ... ...    AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA="
  }, 
  "form": {}, 
  "headers": {
    "Accept": "*/*", 
    "Accept-Encoding": "gzip, deflate", 
    "Content-Length": "6664", 
    "Content-Type": "multipart/form-data; boundary=28fce0800b1ded6aed8db6c1a4acce7f", 
    "Host": "httpbin.org", 
    "User-Agent": "python-requests/2.23.0", 
    "X-Amzn-Trace-Id": "Root=1-5e68a090-b62f797cf14d9e1b07a80229"
  }, 
  "json": null, 
  "origin": "27.205.175.189", 
  "url": "http://httpbin.org/post"
}
```



## 获取Cookie


```python
import requests

response = requests.get("http://www.baidu.com")
print(response.cookies)
for key,value in response.cookies.items():
    print(key+"="+value)
```

```shell
<RequestsCookieJar[<Cookie BDORZ=27315 for .baidu.com/>]>
BDORZ=27315
```


## 会话维持
### 模拟登陆


```python
import requests

#两个过程相对独立
# 相当于 一个浏览器设置cookie 另一个浏览器访问
requests.get("http://httpbin.org/cookies/set/number/12345")
response = requests.get("http://httpbin.org/cookies")
print(response.text)
```

```json
{
  "cookies": {}
}
```




```python
import requests

s = requests.Session();

# 维持回话信息 自动处理
s.get("http://httpbin.org/cookies/set/number/12345")
response = s.get("http://httpbin.org/cookies")


print(response.text)
```

```json
{
  "cookies": {
    "number": "12345"
  }
}
```



### 证书验证

https 监测整数 如果不合法 抛出 SSLError


```python
import requests

response = requests.get("https://www.12306.cn",verify = False)
print(response)
```

```shell
<Response [200]>
```

```python
import requests

from requests.packages import urllib3
urllib3.disable_warnings()

response = requests.get("https://www.12306.cn",verify = False)
print(response)
```

```shell
<Response [200]>
```


### 代理设置



```python
import requests

proxies = {
    'http':'http://user:password@127.0.0.0.1:9743'
}

response = requests.get("http://www.baidu.com",proxies=proxies)

print(response.status_code)
```


```shell
gaierror: [Errno 8] nodename nor servname provided, or not known
ProxyError: HTTPConnectionPool(host='127.0.0.0.1', port=9743): Max retries exceeded with url: http://www.baidu.com/ (Caused by ProxyError('Cannot connect to proxy.', NewConnectionError('<urllib3.connection.HTTPConnection object at 0x111b30220>: Failed to establish a new connection: [Errno 8] nodename nor servname provided, or not known')))
```


```python
# socks 代理
pip3 install 'requests[socks]'

import requests

proxies = {
    'http':'sock5:http://user:password@127.0.0.0.1:9743'
}

response = requests.get("http://www.baidu.com",proxies=proxies)

print(response.status_code)
```

## 超时设置

抛出ReadTimeout 


```python
import requests

requests.get(url,timeout=1)
```

## 认证设


```python
import requests

from requests.auth import HTTPBasicAuth

r = requests.get("http://120.27.34.24:9001",auth=HTTPBasicAuth('user','123'))
print(r.status_code)
```

```shell
	# 当时测试异常 Error
    KeyboardInterrupt: 
```



```python
import requests

from requests.auth import HTTPBasicAuth

r = requests.get("http://120.27.34.24:9001",auth=('user','123'))
print(r.status_code)
```

## 异常处理

先捕捉子类异常 然后捕捉父类异常


```python
import requests

headers = {
               'User-Agent': 'Mozilla/5.0 (Windows NT 5.1; U; en; rv:1.8.1) Gecko/20061208 Firefox/2.0.0 Opera 9.50'
        }
proxies = {
  "http": "http://60.216.20.213:8001",
  "https": "https://60.216.20.214:8001"
}

#http://www.dianping.com/shop/129152119
try:
    for i in range(129152000,129152119):
        print(requests.get('http://www.baidu.com',proxies=proxies))
        print(requests.get('http://www.dianping.com/shop/'+str(i), headers=headers,proxies=proxies))
        print('http://www.dianping.com/shop/'+str(i))
except Exception as e:
    print(e)
```

```shell
	# 当时测试异常 Error

    HTTPConnectionPool(host='60.216.20.213', port=8001): Max retries exceeded with url: http://www.baidu.com/ (Caused by ProxyError('Cannot connect to proxy.', NewConnectionError('<urllib3.connection.HTTPConnection object at 0x1135dd880>: Failed to establish a new connection: [Errno 60] Operation timed out')))
```
