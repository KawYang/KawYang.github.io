---
title: Urllib库学习示例
author: KawYang
top: false
cover: false
toc: true
mathjax: true
categories: Python
tags:
  - Python
  - 爬虫
abbrlink: 335fcf78
date: 2020-08-29 22:47:42
img: https://gitee.com/KawYang/image/raw/master/img/20210829232938.png
coverImg: https://gitee.com/KawYang/image/raw/master/img/20210829232938.png
---

# urllib库详解

> [Urllib](https://docs.python.org/3/library/urllib.html)
>
> 说明: 本文章从 jupyter-notebook 导出，代码示例后边附带执行结果

## urlopen

```python
import urllib.request
respons = urllib.request.urlopen('http://www.baidu.com')
print(respons.read())
```

```shell
b'<!DOCTYPE html>\n<!--STATUS OK-- ....
GMT";\n}\n</script>\n\n\n\n</body>\n</html>\n\n\r\n\n\n\r\n'
```



```python
from urllib import request,parse

data = bytes(parse.urlencode({'hello','world'}),encoding='utf8')K
respons = request.urlopen("http://httpbin.org/post",data=data)
print(respons.read()
```


```shell
TypeError: not a valid non-string sequence or mapping object
```

```python
import urllib.request
import urllib.parse


response = urllib.request.urlopen('http://httpbin.org/get',timeout=1)
print(response.read())
```

```shell
b'{\n  "args": {}, \n  "headers": {\n    "Accept-Encoding": "identity", \n    "Host": "httpbin.org", \n    "User-Agent": "Python-urllib/3.8", \n    "X-Amzn-Trace-Id": "Root=1-5e685eb4-d59a135ce1fa43cca8b5ee52"\n  }, \n  "origin": "27.205.175.189", \n  "url": "http://httpbin.org/get"\n}\n'
```



```python
import socket
import urllib.request
import urllib.error

try:
    response = urllib.request.urlopen("http://httpbin.org/get",timeout=0.1)
except urllib.error.URLError as e:
    if isinstance(e.reason,socket.timeout):
        print("time out")
```

```shell
time out
```


# 响应

## 相应类型


```python
import urllib.requestrespons = urllib.request.urlopen('http://www.baidu.com')print(type(respons))
```

```shell
<class 'http.client.HTTPResponse'>
```


## 状态码、响应头


```python
import urllib.requestresponse = urllib.request.urlopen("http://www.baidu.com")print(response.status)print(response.getheaders())print(response.getheader("Server"))
```

```shell
200[('Bdpagetype', '1'), ('Bdqid', '0x9d1c4a77001313ef'), ('Cache-Control', 'private'), ('Content-Type', 'text/html;charset=utf-8'), ('Date', 'Wed, 11 Mar 2020 04:10:39 GMT'), ('Expires', 'Wed, 11 Mar 2020 04:10:11 GMT'), ('P3p', 'CP=" OTI DSP COR IVA OUR IND COM "'), ('P3p', 'CP=" OTI DSP COR IVA OUR IND COM "'), ('Server', 'BWS/1.1'), ('Set-Cookie', 'BAIDUID=7480366FF79E5FF56CAC7898C7D55AF6:FG=1; expires=Thu, 31-Dec-37 23:55:55 GMT; max-age=2147483647; path=/; domain=.baidu.com'), ('Set-Cookie', 'BIDUPSID=7480366FF79E5FF56CAC7898C7D55AF6; expires=Thu, 31-Dec-37 23:55:55 GMT; max-age=2147483647; path=/; domain=.baidu.com'), ('Set-Cookie', 'PSTM=1583899839; expires=Thu, 31-Dec-37 23:55:55 GMT; max-age=2147483647; path=/; domain=.baidu.com'), ('Set-Cookie', 'BAIDUID=7480366FF79E5FF5A8DA60736A18B286:FG=1; max-age=31536000; expires=Thu, 11-Mar-21 04:10:39 GMT; domain=.baidu.com; path=/; version=1; comment=bd'), ('Set-Cookie', 'BDSVRTM=0; path=/'), ('Set-Cookie', 'BD_HOME=1; path=/'), ('Set-Cookie', 'H_PS_PSSID=30962_1448_21126_30825_30823_26350_30717; path=/; domain=.baidu.com'), ('Traceid', '1583899839273736577011321005438265398255'), ('Vary', 'Accept-Encoding'), ('Vary', 'Accept-Encoding'), ('X-Ua-Compatible', 'IE=Edge,chrome=1'), ('Connection', 'close'), ('Transfer-Encoding', 'chunked')]BWS/1.1
```

## Request


```python
import urllib.request
response = urllib.request.urlopen("http://www.baidu.com")
print(response.read().decode('utf8'))
```



```shell
<!DOCTYPE html><!--STATUS OK--><html><head>        就是页面
```



 

```python
from urllib import request,parse

url = "http://www.httpbin.org/post"
headers = {    'user-agent':'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.132 Safari/537.36',}
dict = {    'name':'Germey'}data = bytes(parse.urlencode(dict),encoding='utf8')
# 创建Request对象
req = request.Request(url=url,data=data,headers=headers,method='POST')
# 添加 Header 方式
req.add_header('host','httpbin.org')
response = request.urlopen(req)
print(response.read().decode('utf-8'))
```

```json
{  "args": {},   "data": "",   "files": {},   "form": {    "name": "Germey"  },   "headers": {    "Accept-Encoding": "identity",     "Content-Length": "11",     "Content-Type": "application/x-www-form-urlencoded",     "Host": "httpbin.org",     "User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.132 Safari/537.36",     "X-Amzn-Trace-Id": "Root=1-5e687f6b-f4593ed1a5edb7c20cb7a5b0"  },   "json": null,   "origin": "27.205.175.189",   "url": "http://httpbin.org/post"}
```



## Handler

---

>  辅助工具


### 代理


```python
import urllib.request

proxy_handler = urllib.request.ProxyHandler({
    'http':'http://127.0.0.1:9743'
})
try:
    opener = urllib.request.build_opener(proxy_handler)
    response = opener.open ('http://httpbin.org/get')
    print(response.read())
except Exception as e:
    print(e)
```

```shell
<urlopen error [Errno 61] Connection refused>
```


### Cookie

---

> 维持登录状态


```python
import http.cookiejar,urllib.request

cookie = http.cookiejar.CookieJar()
handler = urllib.request.HTTPCookieProcessor(cookie)
opener = urllib.request.build_opener(handler)
response = opener.open("http://www.baidu.com")

for item in cookie:
    print(item.name +"="+item.value)
```

```shell
BAIDUID=16DDE24800BD4A43500B34B419C6C3D6:FG=1
BIDUPSID=16DDE24800BD4A43D4069E48CBA88E8D
H_PS_PSSID=30962_1430_21118_30839_30824_30717
PSTM=1583909187
BDSVRTM=0
BD_HOME=1
```



```python
# 将Cookie保存到文件中

import http.cookiejar,urllib.request

filename = "/Users/mac/MyCodes/python/cookie.txt"
cookie = http.cookiejar.MozillaCookieJar(filename)
handler = urllib.request.HTTPCookieProcessor(cookie)
opener = urllib.request.build_opener(handler)
response = opener.open("http://www.baidu.com")
cookie.save(ignore_discard=True,ignore_expires=True)

```




```python
# 将Cookie保存到文件中

import http.cookiejar,urllib.request

filename = "/Users/mac/MyCodes/python/cookie1.txt"
cookie = http.cookiejar.LWPCookieJar(filename)
handler = urllib.request.HTTPCookieProcessor(cookie)
opener = urllib.request.build_opener(handler)
response = opener.open("http://www.baidu.com")
cookie.save(ignore_discard=True,ignore_expires=True)
```




```python
# 读取Cookie

import http.cookiejar,urllib.request

cookie = http.cookiejar.LWPCookieJar()
# 读取Cookie
cookie.load("/Users/mac/MyCodes/python/cookie1.txt",ignore_discard=True,ignore_expires=True)

handler = urllib.request.HTTPCookieProcessor(cookie)
opener = urllib.request.build_opener(handler)

response = opener.open("http://www.baidu.com")
print(response.read().decode('utf-8'))
```

```shell
# 测试结果内容非常多,影响阅读.所以都删了
```





## 异常处理


```python
from urllib import request,error

try:
    response = request.urlopen("http://cuiqingcai.com/index.htm")
except error.URLError as e:
    print(e.reason)
```

```shell
[SSL: CERTIFICATE_VERIFY_FAILED] certificate verify failed: unable to get local issuer certificate (_ssl.c:1108)
```



```python
from urllib import request,error

try:
    response = request.urlopen("http://cuiqingcai.com/index.htm")
except error.HTTPError as e:
    print(e.reason,e.code,e.headers,sep='\n')
except error.URLError as e:
    print(e.reason)
else:
    print('Request Successfully')
```

```shell
[SSL: CERTIFICATE_VERIFY_FAILED] certificate verify failed: unable to get local issuer certificate (_ssl.c:1108)
```



```python
import socket
import urllib.request
import urllib.error

try:
    response = request.urlopen("http://www.baidu.com",timeout=0.01)
except urllib.error.URLError as e:
    print(e.reason)
    if isinstance(e.reason,socket.timeout):
        print("TIME OUT")
```

```shell
shelltimed out
TIME OUT
```

## URL解析

## urlparse

`urllib.parse.urlparse(urlstring, scheme='', allow_fragments=True)`



```python
from urllib.parse import urlparse

result = urlparse('http://www.baidu.com/index.html;user?id=5#comment')
print(type(result),result)

```

```html
<class 'urllib.parse.ParseResult'> ParseResult(scheme='http', netloc='www.baidu.com', path='/index.html', params='user', query='id=5', fragment='comment')
```



```python
from urllib.parse import urlparse

result = urlparse('www.baidu.com/index.html;user?id=5#comment',scheme='https')
print(type(result),result)

```

```html
<class 'urllib.parse.ParseResult'> ParseResult(scheme='https', netloc='', path='www.baidu.com/index.html', params='user', query='id=5', fragment='comment')
```



```python
from urllib.parse import urlparse

result = urlparse('www.baidu.com/index.html;user?id=5#comment',scheme='https',allow_fragments=False)
print(type(result),result)

```

```shell
<class 'urllib.parse.ParseResult'> ParseResult(scheme='https', netloc='', path='www.baidu.com/index.html', params='user', query='id=5#comment', fragment='')
```


## urlunparse

> url拼接


## urljoin



```python
from urllib.parse import urljoin
print(urljoin('http://www.cwi.nl/%7Eguido/Python.html', 'FAQ.html'))
print(urljoin('http://www.cwi.nl/%7Eguido/Python.html','//www.python.org/%7Eguido'))

```

```shell
http://www.cwi.nl/%7Eguido/FAQ.html
http://www.python.org/%7Eguido
```

## urlencode

> 字典转换成URL参数


```python
from urllib.parse import urlencode

params = {
    'name':'test',
    'age':33
}
base_url = "http://www.baidu.com?"
print(base_url+urlencode(params))
```

```shell
http://www.baidu.com?name=test&age=33
```


## urllib.robotparser

设置某些网址不能访问
