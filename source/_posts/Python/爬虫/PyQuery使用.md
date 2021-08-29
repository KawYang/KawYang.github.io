---
title: PyQuery学习示例
author: KawYang
top: false
cover: false
toc: true
mathjax: true
categories: Python
tags:
    - 爬虫
    - Python
abbrlink: d622284c
date: 2020-08-29 21:56:13
img:
coverImg:
---

# PyQuery

> 说明： 本文章从 jupyter-notebook 导出，代码示例后边附带执行结果

## 初始化

```python
html = """
<html><head><title>This is a title</title></head>
<body>
<div id="songs-list'>
<h2 class="title">经典老歌</h2>
<p class="introduction">
    经典老歌列表
</p>
<ul id="list" class="list-group">
    <li data-view="2">一路上有你</li>
    <li data-view="7">
        <a href="/2.mp3" singer="任贤齐">沧海一声笑</a>
    </li>
    <li data-view="4" class="active">
        <a href="/3.mp3" singer="齐秦">往事随风</a>
    </li>
    <li data-view="6"><a href="/4.mp3" singer="beyond">光辉岁月</a></li><li data一view="5"><a href="/5.mp3" singer="陈慧琳">记事本</a> </i> <li data一view=*5">
        <a href=*/6.mp3" singer="邓丽君">但愿人长久</a>
    </li>
</ul>
</div>
</body>
</html>
"""

from pyquery import PyQuery as pq
# 初始化
doc = pq(html)
print(doc('li'))

doc = pq(url='http://www.baidu.com')
print(doc)

doc = pq(filename='demo.html')
```

```shell
<li data-view="2">一路上有你</li>
    <li data-view="7">
        <a href="/2.mp3" singer="任贤齐">沧海一声笑</a>
    </li>
    <li data-view="4" class="active">
        <a href="/3.mp3" singer="齐秦">往事随风</a>
    </li>
    <li data-view="6"><a href="/4.mp3" singer="beyond">光辉岁月</a></li><li data=""><a href="/5.mp3" singer="陈慧琳">记事本</a>  </li><li data="">
        <a href="*/6.mp3&quot;" singer="邓丽君">但愿人长久</a>
    </li>

<html> <head><meta http-equiv="content-type" content="text/html;charset=utf-8"/><meta http-equiv="X-UA-Compatible" content="IE=Edge"/><meta content="always" name="referrer"/><link rel="stylesheet" type="text/css" href="http://s1.bdstatic.com/r/www/cache/bdorz/baidu.min.css"/><title>ç¾åº¦ä¸ä¸ï¼ä½ å°±ç¥é</title></head> <body link="#0000cc"> <div id="wrapper"> <div id="head"> <div class="head_wrapper"> <div class="s_form"> <div class="s_form_wrapper"> <div id="lg"> <img hidefocus="true" src="//www.baidu.com/img/bd_logo1.png" width="270" height="129"/> </div> <form id="form" name="f" action="//www.baidu.com/s" class="fm"> <input type="hidden" name="bdorz_come" value="1"/> <input type="hidden" name="ie" value="utf-8"/> <input type="hidden" name="f" value="8"/> <input type="hidden" name="rsv_bp" value="1"/> <input type="hidden" name="rsv_idx" value="1"/> <input type="hidden" name="tn" value="baidu"/><span class="bg s_ipt_wr"><input id="kw" name="wd" class="s_ipt" value="" maxlength="255" autocomplete="off" autofocus=""/></span><span class="bg s_btn_wr"><input type="submit" id="su" value="ç¾åº¦ä¸ä¸" class="bg s_btn"/></span> </form> </div> </div> <div id="u1"> <a href="http://news.baidu.com" name="tj_trnews" class="mnav">æ°é»</a> <a href="http://www.hao123.com" name="tj_trhao123" class="mnav">hao123</a> <a href="http://map.baidu.com" name="tj_trmap" class="mnav">å°å¾</a> <a href="http://v.baidu.com" name="tj_trvideo" class="mnav">è§é¢</a> <a href="http://tieba.baidu.com" name="tj_trtieba" class="mnav">è´´å§</a> <noscript> <a href="http://www.baidu.com/bdorz/login.gif?login&amp;tpl=mn&amp;u=http%3A%2F%2Fwww.baidu.com%2f%3fbdorz_come%3d1" name="tj_login" class="lb">ç»å½</a> </noscript> <script>document.write('&lt;a href="http://www.baidu.com/bdorz/login.gif?login&amp;tpl=mn&amp;u='+ encodeURIComponent(window.location.href+ (window.location.search === "" ? "?" : "&amp;")+ "bdorz_come=1")+ '" name="tj_login" class="lb"&gt;ç»å½&lt;/a&gt;');</script> <a href="//www.baidu.com/more/" name="tj_briicon" class="bri" style="display: block;">æ´å¤äº§å</a> </div> </div> </div> <div id="ftCon"> <div id="ftConw"> <p id="lh"> <a href="http://home.baidu.com">å³äºç¾åº¦</a> <a href="http://ir.baidu.com">About Baidu</a> </p> <p id="cp">©2017 Baidu <a href="http://www.baidu.com/duty/">ä½¿ç¨ç¾åº¦åå¿è¯»</a>  <a href="http://jianyi.baidu.com/" class="cp-feedback">æè§åé¦</a> äº¬ICPè¯030173å·  <img src="//www.baidu.com/img/gs.gif"/> </p> </div> </div> </div> </body> </html>
```

# 基本CSS选择器


```python
html = """
<html><head><title>This is a title</title></head>
<body>
<div id="songs-list'>
<h2 class="title">经典老歌</h2>
<p class="introduction">
    经典老歌列表
</p>
<ul id="list" class="list-group">
    <li data-view="2">一路上有你</li>
    <li data-view="7">
        <a href="/2.mp3" singer="任贤齐">沧海一声笑</a>
    </li>
    <li data-view="4" class="active">
        <a href="/3.mp3" singer="齐秦">往事随风</a>
    </li>
    <li data-view="6"><a href="/4.mp3" singer="beyond">光辉岁月</a></li><li data一view="5"><a href="/5.mp3" singer="陈慧琳">记事本</a> </i> <li data一view=*5">
        <a href=*/6.mp3" singer="邓丽君">但愿人长久</a>
    </li>
</ul>
</div>
</body>
</html>
"""

from pyquery import PyQuery as pq
# 初始化
doc = pq(html)
print(doc('#list .active a'))
```

```html

    <a href="/3.mp3" singer="&#x9F50;&#x79E6;">往事随风</a>

```



# 查找元素
## 查找子元素


```python
html = """
<html><head><title>This is a title</title></head>
<body>
<div id="songs-list'>
<h2 class="title">经典老歌</h2>
<p class="introduction">
    经典老歌列表
</p>
<ul id="list" class="list-group">
    <li data-view="2">一路上有你</li>
    <li data-view="7">
        <a href="/2.mp3" singer="任贤齐">沧海一声笑</a>
    </li>
    <li data-view="4" class="active">
        <a href="/3.mp3" singer="齐秦">往事随风</a>
    </li>
    <li data-view="6"><a href="/4.mp3" singer="beyond">光辉岁月</a></li><li data一view="5"><a href="/5.mp3" singer="陈慧琳">记事本</a> </i> <li data一view=*5">
        <a href=*/6.mp3" singer="邓丽君">但愿人长久</a>
    </li>
</ul>
</div>
</body>
</html>
"""

from pyquery import PyQuery as pq

doc = pq(html)
iterms = doc('#list')
print(type(iterms))
print(iterms)
# 层次符合即可
print(iterms.find('li'))

# 直接子标签

list = iterms.children()

print(list)

list = iterms.children('.active')
print(list)
```
```shell
<class 'pyquery.pyquery.PyQuery'>
<ul id="list" class="list-group">
    <li data-view="2">一路上有你</li>
    <li data-view="7">
        <a href="/2.mp3" singer="任贤齐">沧海一声笑</a>
    </li>
    <li data-view="4" class="active">
        <a href="/3.mp3" singer="齐秦">往事随风</a>
    </li>
    <li data-view="6"><a href="/4.mp3" singer="beyond">光辉岁月</a></li><li data=""><a href="/5.mp3" singer="陈慧琳">记事本</a>  </li><li data="">
        <a href="*/6.mp3&quot;" singer="邓丽君">但愿人长久</a>
    </li>
</ul>

<li data-view="2">一路上有你</li>
    <li data-view="7">
        <a href="/2.mp3" singer="任贤齐">沧海一声笑</a>
    </li>
    <li data-view="4" class="active">
        <a href="/3.mp3" singer="齐秦">往事随风</a>
    </li>
    <li data-view="6"><a href="/4.mp3" singer="beyond">光辉岁月</a></li><li data=""><a href="/5.mp3" singer="陈慧琳">记事本</a>  </li><li data="">
        <a href="*/6.mp3&quot;" singer="邓丽君">但愿人长久</a>
    </li>

<li data-view="2">一路上有你</li>
    <li data-view="7">
        <a href="/2.mp3" singer="任贤齐">沧海一声笑</a>
    </li>
    <li data-view="4" class="active">
        <a href="/3.mp3" singer="齐秦">往事随风</a>
    </li>
    <li data-view="6"><a href="/4.mp3" singer="beyond">光辉岁月</a></li><li data=""><a href="/5.mp3" singer="陈慧琳">记事本</a>  </li><li data="">
        <a href="*/6.mp3&quot;" singer="邓丽君">但愿人长久</a>
    </li>

<li data-view="4" class="active">
        <a href="/3.mp3" singer="齐秦">往事随风</a>
    </li>
```


## 父元素


```python
html = """
<html><head><title>This is a title</title></head>
<body>
<div id="songs-list'>
<h2 class="title">经典老歌</h2>
<p class="introduction">
    经典老歌列表
</p>
<ul id="list" class="list-group">
    <li data-view="2">一路上有你</li>
    <li data-view="7">
        <a href="/2.mp3" singer="任贤齐">沧海一声笑</a>
    </li>
    <li data-view="4" class="active">
        <a href="/3.mp3" singer="齐秦">往事随风</a>
    </li>
    <li data-view="6"><a href="/4.mp3" singer="beyond">光辉岁月</a></li><li data一view="5"><a href="/5.mp3" singer="陈慧琳">记事本</a> </i> <li data一view=*5">
        <a href=*/6.mp3" singer="邓丽君">但愿人长久</a>
    </li>
</ul>
</div>
</body>
</html>
"""

from pyquery import PyQuery as pq

doc = pq(html)
container = doc('.active').parent()
print(container)

container = doc('.active').parents()
print(type(container))
print(container)


container = doc('.active').parents('#list')
print(container)
```

```shell
<ul id="list" class="list-group">
    <li data-view="2">一路上有你</li>
    <li data-view="7">
        <a href="/2.mp3" singer="任贤齐">沧海一声笑</a>
    </li>
    <li data-view="4" class="active">
        <a href="/3.mp3" singer="齐秦">往事随风</a>
    </li>
    <li data-view="6"><a href="/4.mp3" singer="beyond">光辉岁月</a></li><li data=""><a href="/5.mp3" singer="陈慧琳">记事本</a>  </li><li data="">
        <a href="*/6.mp3&quot;" singer="邓丽君">但愿人长久</a>
    </li>
</ul>

<class 'pyquery.pyquery.PyQuery'>
<html><head><title>This is a title</title></head>
<body>
<div id="songs-list'&gt;&#10;&lt;h2 class=" title="">经典老歌
<p class="introduction">
    经典老歌列表
</p>
<ul id="list" class="list-group">
    <li data-view="2">一路上有你</li>
    <li data-view="7">
        <a href="/2.mp3" singer="任贤齐">沧海一声笑</a>
    </li>
    <li data-view="4" class="active">
        <a href="/3.mp3" singer="齐秦">往事随风</a>
    </li>
    <li data-view="6"><a href="/4.mp3" singer="beyond">光辉岁月</a></li><li data=""><a href="/5.mp3" singer="陈慧琳">记事本</a>  </li><li data="">
        <a href="*/6.mp3&quot;" singer="邓丽君">但愿人长久</a>
    </li>
</ul>
</div>
</body>
</html><body>
<div id="songs-list'&gt;&#10;&lt;h2 class=" title="">经典老歌
<p class="introduction">
    经典老歌列表
</p>
<ul id="list" class="list-group">
    <li data-view="2">一路上有你</li>
    <li data-view="7">
        <a href="/2.mp3" singer="任贤齐">沧海一声笑</a>
    </li>
    <li data-view="4" class="active">
        <a href="/3.mp3" singer="齐秦">往事随风</a>
    </li>
    <li data-view="6"><a href="/4.mp3" singer="beyond">光辉岁月</a></li><li data=""><a href="/5.mp3" singer="陈慧琳">记事本</a>  </li><li data="">
        <a href="*/6.mp3&quot;" singer="邓丽君">但愿人长久</a>
    </li>
</ul>
</div>
</body>
<div id="songs-list'&gt;&#10;&lt;h2 class=" title="">经典老歌
<p class="introduction">
    经典老歌列表
</p>
<ul id="list" class="list-group">
    <li data-view="2">一路上有你</li>
    <li data-view="7">
        <a href="/2.mp3" singer="任贤齐">沧海一声笑</a>
    </li>
    <li data-view="4" class="active">
        <a href="/3.mp3" singer="齐秦">往事随风</a>
    </li>
    <li data-view="6"><a href="/4.mp3" singer="beyond">光辉岁月</a></li><li data=""><a href="/5.mp3" singer="陈慧琳">记事本</a>  </li><li data="">
        <a href="*/6.mp3&quot;" singer="邓丽君">但愿人长久</a>
    </li>
</ul>
</div>
<ul id="list" class="list-group">
    <li data-view="2">一路上有你</li>
    <li data-view="7">
        <a href="/2.mp3" singer="任贤齐">沧海一声笑</a>
    </li>
    <li data-view="4" class="active">
        <a href="/3.mp3" singer="齐秦">往事随风</a>
    </li>
    <li data-view="6"><a href="/4.mp3" singer="beyond">光辉岁月</a></li><li data=""><a href="/5.mp3" singer="陈慧琳">记事本</a>  </li><li data="">
        <a href="*/6.mp3&quot;" singer="邓丽君">但愿人长久</a>
    </li>
</ul>

<ul id="list" class="list-group">
    <li data-view="2">一路上有你</li>
    <li data-view="7">
        <a href="/2.mp3" singer="任贤齐">沧海一声笑</a>
    </li>
    <li data-view="4" class="active">
        <a href="/3.mp3" singer="齐秦">往事随风</a>
    </li>
    <li data-view="6"><a href="/4.mp3" singer="beyond">光辉岁月</a></li><li data=""><a href="/5.mp3" singer="陈慧琳">记事本</a>  </li><li data="">
        <a href="*/6.mp3&quot;" singer="邓丽君">但愿人长久</a>
    </li>
</ul>
```



## 兄弟元素


```python
html = """
<html><head><title>This is a title</title></head>
<body>
<div id="songs-list'>
<h2 class="title">经典老歌</h2>
<p class="introduction">
    经典老歌列表
</p>
<ul id="list" class="list-group">
    <li id='list1 active' data-view="2">一路上有你</li>
    <li data-view="7">
        <a href="/2.mp3" singer="任贤齐">沧海一声笑</a>
    </li>
    <li data-view="4" class="active">
        <a href="/3.mp3" singer="齐秦">往事随风</a>
    </li>
    <li data-view="6"><a href="/4.mp3" singer="beyond">光辉岁月</a></li><li data一view="5"><a href="/5.mp3" singer="陈慧琳">记事本</a> </i> <li data一view=*5">
        <a href=*/6.mp3" singer="邓丽君">但愿人长久</a>
    </li>
</ul>
</div>
</body>
</html>
"""

from pyquery import PyQuery as pq

doc = pq(html)
li = doc('#list #list1\ active')
print(li)

print(li.siblings())
print(li.siblings('.active'))
```

```html
<li id="list1 active" data-view="2">一路上有你</li>
    
<li data-view="7">
        <a href="/2.mp3" singer="任贤齐">沧海一声笑</a>
    </li>
    <li data-view="4" class="active">
        <a href="/3.mp3" singer="齐秦">往事随风</a>
    </li>
    <li data-view="6"><a href="/4.mp3" singer="beyond">光辉岁月</a></li><li data=""><a href="/5.mp3" singer="陈慧琳">记事本</a>  </li><li data="">
        <a href="*/6.mp3&quot;" singer="邓丽君">但愿人长久</a>
    </li>

<li data-view="4" class="active">
        <a href="/3.mp3" singer="齐秦">往事随风</a>
    </li>
```



## 遍历


```python
html = """
<html><head><title>This is a title</title></head>
<body>
<div id="songs-list'>
<h2 class="title">经典老歌</h2>
<p class="introduction">
    经典老歌列表
</p>
<ul id="list" class="list-group">
    <li data-view="2">一路上有你</li>
    <li data-view="7">
        <a href="/2.mp3" singer="任贤齐">沧海一声笑</a>
    </li>
    <li data-view="4" class="active">
        <a href="/3.mp3" singer="齐秦">往事随风</a>
    </li>
    <li data-view="6"><a href="/4.mp3" singer="beyond">光辉岁月</a></li><li data一view="5"><a href="/5.mp3" singer="陈慧琳">记事本</a> </i> <li data一view=*5">
        <a href=*/6.mp3" singer="邓丽君">但愿人长久</a>
    </li>
</ul>
</div>
</body>
</html>
"""

from pyquery import PyQuery as pq

doc = pq(html)
container = doc('li')
print(container)

lis = container.items()

for i in lis:
    print(type(i))
    print(i)
    
```

```html
<li data-view="2">一路上有你</li>
    <li data-view="7">
        <a href="/2.mp3" singer="任贤齐">沧海一声笑</a>
    </li>
    <li data-view="4" class="active">
        <a href="/3.mp3" singer="齐秦">往事随风</a>
    </li>
    <li data-view="6"><a href="/4.mp3" singer="beyond">光辉岁月</a></li><li data=""><a href="/5.mp3" singer="陈慧琳">记事本</a>  </li><li data="">
        <a href="*/6.mp3&quot;" singer="邓丽君">但愿人长久</a>
    </li>

<class 'pyquery.pyquery.PyQuery'>
<li data-view="2">一路上有你</li>
    
<class 'pyquery.pyquery.PyQuery'>
<li data-view="7">
        <a href="/2.mp3" singer="任贤齐">沧海一声笑</a>
    </li>
    
<class 'pyquery.pyquery.PyQuery'>
<li data-view="4" class="active">
        <a href="/3.mp3" singer="齐秦">往事随风</a>
    </li>
    
<class 'pyquery.pyquery.PyQuery'>
<li data-view="6"><a href="/4.mp3" singer="beyond">光辉岁月</a></li>
<class 'pyquery.pyquery.PyQuery'>
<li data=""><a href="/5.mp3" singer="陈慧琳">记事本</a>  </li>
<class 'pyquery.pyquery.PyQuery'>
<li data="">
        <a href="*/6.mp3&quot;" singer="邓丽君">但愿人长久</a>
    </li>
```



## 获取信息


```python
html = """
<html><head><title>This is a title</title></head>
<body>
<div id="songs-list'>
<h2 class="title">经典老歌</h2>
<p class="introduction">
    经典老歌列表
</p>
<ul id="list" class="list-group">
    <li data-view="2">一路上有你</li>
    <li data-view="7">
        <a href="/2.mp3" singer="任贤齐">沧海一声笑</a>
    </li>
    <li data-view="4" class="active">
        <a href="/3.mp3" singer="齐秦">往事随风</a>
    </li>
    <li data-view="6"><a href="/4.mp3" singer="beyond">光辉岁月</a></li><li data一view="5"><a href="/5.mp3" singer="陈慧琳">记事本</a> </i> <li data一view=*5">
        <a href=*/6.mp3" singer="邓丽君">但愿人长久</a>
    </li>
</ul>
</div>
</body>
</html>
"""

from pyquery import PyQuery as pq

doc = pq(html)
container = doc('li')
print(container)

lis = container.items()
# 获取属性
for i in lis:
    print(i.attr('href'))
    # 获取文本
    print(i.text())
    print(i.attr.href)
    # 获取 html
    print(i.html())


```

```shell
<li data-view="2">一路上有你</li>
    <li data-view="7">
        <a href="/2.mp3" singer="任贤齐">沧海一声笑</a>
    </li>
    <li data-view="4" class="active">
        <a href="/3.mp3" singer="齐秦">往事随风</a>
    </li>
    <li data-view="6"><a href="/4.mp3" singer="beyond">光辉岁月</a></li><li data=""><a href="/5.mp3" singer="陈慧琳">记事本</a>  </li><li data="">
        <a href="*/6.mp3&quot;" singer="邓丽君">但愿人长久</a>
    </li>

None
一路上有你
None
一路上有你
None
沧海一声笑
None

        <a href="/2.mp3" singer="&#x4EFB;&#x8D24;&#x9F50;">沧海一声笑</a>
    
None
往事随风
None

        <a href="/3.mp3" singer="&#x9F50;&#x79E6;">往事随风</a>
    
None
光辉岁月
None
<a href="/4.mp3" singer="beyond">光辉岁月</a>
None
记事本
None
<a href="/5.mp3" singer="&#x9648;&#x6167;&#x7433;">记事本</a>  
None
但愿人长久
None

        <a href="*/6.mp3&quot;" singer="&#x9093;&#x4E3D;&#x541B;">但愿人长久</a>
```



# DOM 操作

## addClass、removeClass



```python
html = """
<html><head><title>This is a title</title></head>
<body>
<div id="songs-list'>
<h2 class="title">经典老歌</h2>
<p class="introduction">
    经典老歌列表
</p>
<ul id="list" class="list-group">
    <li data-view="2">一路上有你</li>
    <li data-view="7">沧海一声笑
        <a href="/2.mp3" singer="任贤齐"></a>
    </li>
    <li data-view="4" class="active">往事随风
        <a href="/3.mp3" singer="齐秦"></a>
    </li>
    <li data-view="6"><a href="/4.mp3" singer="beyond">光辉岁月</a></li><li data一view="5"><a href="/5.mp3" singer="陈慧琳">记事本</a> </i> <li data一view=*5">
        <a href=*/6.mp3" singer="邓丽君">但愿人长久</a>
    </li>
</ul>
</div>
</body>
</html>
"""

from pyquery import PyQuery as pq

doc = pq(html)
container = doc('#list .active')
print(container)

container.remove_class('active')
print(container)

container.add_class('active1')
print(container)

#attr、css

container.attr('name', 'link')
print(container)

container.attr('name', 'link1')
print(container)

container.css('font-size', '14px')
print(container)

container.css('font-size', '18px')
print(container)

# remove
container.find('a').remove()
print(container.text())

# 其他 PyQuery API

```

```shell
<li data-view="4" class="active">往事随风
        <a href="/3.mp3" singer="齐秦"/>
    </li>
    
<li data-view="4" class="">往事随风
        <a href="/3.mp3" singer="齐秦"/>
    </li>
    
<li data-view="4" class="active1">往事随风
        <a href="/3.mp3" singer="齐秦"/>
    </li>
    
<li data-view="4" class="active1" name="link">往事随风
        <a href="/3.mp3" singer="齐秦"/>
    </li>
    
<li data-view="4" class="active1" name="link1">往事随风
        <a href="/3.mp3" singer="齐秦"/>
    </li>
    
<li data-view="4" class="active1" name="link1" style="font-size: 14px">往事随风
        <a href="/3.mp3" singer="齐秦"/>
    </li>
    
<li data-view="4" class="active1" name="link1" style="font-size: 18px">往事随风
        <a href="/3.mp3" singer="齐秦"/>
    </li>
    
往事随风
```


# 伪类选择器


```python
html = """
<html><head><title>This is a title</title></head>
<body>
<div id="songs-list'>
<h2 class="title">经典老歌</h2>
<p class="introduction">
    经典老歌列表
</p>
<ul id="list" class="list-group">
    <li data-view="2">1一路上有你</li>
    <li data-view="7">2沧海一声笑
        <a href="/2.mp3" singer="任贤齐"></a>
    </li>
    <li data-view="4" class="active">3往事随风
        <a href="/3.mp3" singer="齐秦"></a>
    </li>
    <li data-view="6"><a href="/4.mp3" singer="beyond">4光辉岁月</a></li><li data一view="5"><a href="/5.mp3" singer="陈慧琳">5记事本</a> </i> <li data一view=*5">
        <a href=*/6.mp3" singer="邓丽君">6但愿人长久</a>
    </li>
</ul>
</div>
</body>
</html>
"""

from pyquery import PyQuery as pq

doc = pq(html)
container = doc('li:first-child')
print(container)

container = doc('li:last-child')
print(container)

# 比2 大的标签
container = doc('li:gt(2)')
print(container)

container = doc('li:nth-child(2)')
print(container)

container = doc('li:nth-child(2n)')
print(container)

container = doc('li:contains(齐秦)')
print(container)

container = doc('li:contains(往事)')
print(container)
```

```html
<li data-view="2">1一路上有你</li>
    
<li data="">
        <a href="*/6.mp3&quot;" singer="邓丽君">6但愿人长久</a>
    </li>

<li data-view="6"><a href="/4.mp3" singer="beyond">4光辉岁月</a></li><li data=""><a href="/5.mp3" singer="陈慧琳">5记事本</a>  </li><li data="">
        <a href="*/6.mp3&quot;" singer="邓丽君">6但愿人长久</a>
    </li>

<li data-view="7">2沧海一声笑
        <a href="/2.mp3" singer="任贤齐"/>
    </li>
    
<li data-view="7">2沧海一声笑
        <a href="/2.mp3" singer="任贤齐"/>
    </li>
    <li data-view="6"><a href="/4.mp3" singer="beyond">4光辉岁月</a></li><li data="">
        <a href="*/6.mp3&quot;" singer="邓丽君">6但愿人长久</a>
    </li>
```


​    
```html
<li data-view="4" class="active">3往事随风
        <a href="/3.mp3" singer="齐秦"/>
    </li>
```
