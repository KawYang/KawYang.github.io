---
title: BeautifulSoup 学习示例
author: KawYang
top: false
cover: false
toc: true
mathjax: false
tags:
  - 爬虫
  - Python
categories: Python
abbrlink: f6b0f828
date: 2020-08-28 21:03:01
img: https://gitee.com/KawYang/image/raw/master/img/image-20210829231533624.png
coverImg:

---

# BeautifulSoup

> [BeautifulSoup](https://www.crummy.com/software/BeautifulSoup/bs4/doc/)
>
> 说明： 本文章从 jupyter-notebook 导出，代码示例后边附带执行结果

## 基本使用

```python
from bs4 import BeautifulSoup
import lxml


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

soup = BeautifulSoup(html,'lxml')
print(soup.prettify())
print(soup.title.string)
print(soup.find('span')==None)
```

```shell

    <html>
     <head>
      <title>
       This is a title
      </title>
     </head>
     <body>
      <div id="songs-list'&gt;
    &lt;h2 class=" title="">
       经典老歌
       <p class="introduction">
        经典老歌列表
       </p>
       <ul class="list-group" id="list">
        <li data-view="2">
         一路上有你
        </li>
        <li data-view="7">
         <a href="/2.mp3" singer="任贤齐">
          沧海一声笑
         </a>
        </li>
        <li class="active" data-view="4">
         <a href="/3.mp3" singer="齐秦">
          往事随风
         </a>
        </li>
        <li data-view="6">
         <a href="/4.mp3" singer="beyond">
          光辉岁月
         </a>
        </li>
        <li data="">
         <a href="/5.mp3" singer="陈慧琳">
          记事本
         </a>
        </li>
        <li data="">
         <a href='*/6.mp3"' singer="邓丽君">
          但愿人长久
         </a>
        </li>
       </ul>
      </div>
     </body>
    </html>
    
    This is a title
    True
```

## 标签选择器


```python
from bs4 import BeautifulSoup
import lxml


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

soup = BeautifulSoup(html,'lxml')
print(soup.prettify())
print(soup.title.string)
print(soup.title)
print(soup.head)
print(soup.p)
print(soup.title.name)
```

```shell
    <html>
     <head>
      <title>
       This is a title
      </title>
     </head>
     <body>
      <div id="songs-list'&gt;
    &lt;h2 class=" title="">
       经典老歌
       <p class="introduction">
        经典老歌列表
       </p>
       <ul class="list-group" id="list">
        <li data-view="2">
         一路上有你
        </li>
        <li data-view="7">
         <a href="/2.mp3" singer="任贤齐">
          沧海一声笑
         </a>
        </li>
        <li class="active" data-view="4">
         <a href="/3.mp3" singer="齐秦">
          往事随风
         </a>
        </li>
        <li data-view="6">
         <a href="/4.mp3" singer="beyond">
          光辉岁月
         </a>
        </li>
        <li data="">
         <a href="/5.mp3" singer="陈慧琳">
          记事本
         </a>
        </li>
        <li data="">
         <a href='*/6.mp3"' singer="邓丽君">
          但愿人长久
         </a>
        </li>
       </ul>
      </div>
     </body>
    </html>
    
    This is a title
    <title>This is a title</title>
    <head><title>This is a title</title></head>
    <p class="introduction">
        经典老歌列表
    </p>
    title
```

## 获取属性


```python
from bs4 import BeautifulSoup
import lxml


html = """
<html><head><title>This is a title</title></head>
    <body>
        <div id="songs-list'>
            <h2 class="title">经典老歌</h2>
            <p class="introduction" name='name.p'>
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

soup = BeautifulSoup(html,'lxml')
print(soup.p.attrs['name'])
print(soup.p['name'])

# 获取内容
print(soup.p.string.strip())

# 嵌套选择
print(type(soup.head))

print(soup.head.title.string)

# 子节点和父节点
# 子节点
print(soup.ul.contents)

# 迭代器类型
for i,child in enumerate(soup.ul.children):
    print(i,child)
    
# 所有子孙节点
for i,child in enumerate(soup.ul.descendants):
    print(i,child)
    
# 父节点
print(soup.ul.parent)

# 父节点
print(soup.ul.parents)
for i,child in enumerate(soup.ul.parents):
    print(i,child)
    
# 兄弟节点

print(list(enumerate(soup.ul.next_sibling)))
print(list (enumerate(soup.ul.previous_sibling)))
```

```shell

    name.p
    name.p
    经典老歌列表
    <class 'bs4.element.Tag'>
    This is a title
    ['\n', <li data-view="2">一路上有你</li>, '\n', <li data-view="7">
    <a href="/2.mp3" singer="任贤齐">沧海一声笑</a>
    </li>, '\n', <li class="active" data-view="4">
    <a href="/3.mp3" singer="齐秦">往事随风</a>
    </li>, '\n', <li data-view="6"><a href="/4.mp3" singer="beyond">光辉岁月</a></li>, <li data=""><a href="/5.mp3" singer="陈慧琳">记事本</a> </li>, <li data="">
    <a href='*/6.mp3"' singer="邓丽君">但愿人长久</a>
    </li>, '\n']
    0 
    
    1 <li data-view="2">一路上有你</li>
    2 
    
    3 <li data-view="7">
    <a href="/2.mp3" singer="任贤齐">沧海一声笑</a>
    </li>
    4 
    
    5 <li class="active" data-view="4">
    <a href="/3.mp3" singer="齐秦">往事随风</a>
    </li>
    6 
    
    7 <li data-view="6"><a href="/4.mp3" singer="beyond">光辉岁月</a></li>
    8 <li data=""><a href="/5.mp3" singer="陈慧琳">记事本</a> </li>
    9 <li data="">
    <a href='*/6.mp3"' singer="邓丽君">但愿人长久</a>
    </li>
    10 
    
    0 
    
    1 <li data-view="2">一路上有你</li>
    2 一路上有你
    3 
    
    4 <li data-view="7">
    <a href="/2.mp3" singer="任贤齐">沧海一声笑</a>
    </li>
    5 
    
    6 <a href="/2.mp3" singer="任贤齐">沧海一声笑</a>
    7 沧海一声笑
    8 
    
    9 
    
    10 <li class="active" data-view="4">
    <a href="/3.mp3" singer="齐秦">往事随风</a>
    </li>
    11 
    
    12 <a href="/3.mp3" singer="齐秦">往事随风</a>
    13 往事随风
    14 
    
    15 
    
    16 <li data-view="6"><a href="/4.mp3" singer="beyond">光辉岁月</a></li>
    17 <a href="/4.mp3" singer="beyond">光辉岁月</a>
    18 光辉岁月
    19 <li data=""><a href="/5.mp3" singer="陈慧琳">记事本</a> </li>
    20 <a href="/5.mp3" singer="陈慧琳">记事本</a>
    21 记事本
    22  
    23 <li data="">
    <a href='*/6.mp3"' singer="邓丽君">但愿人长久</a>
    </li>
    24 
    
    25 <a href='*/6.mp3"' singer="邓丽君">但愿人长久</a>
    26 但愿人长久
    27 
    
    28 
    
    <div id="songs-list'&gt;
                &lt;h2 class=" title="">经典老歌
                <p class="introduction" name="name.p">
                    经典老歌列表
                </p>
    <ul class="list-group" id="list">
    <li data-view="2">一路上有你</li>
    <li data-view="7">
    <a href="/2.mp3" singer="任贤齐">沧海一声笑</a>
    </li>
    <li class="active" data-view="4">
    <a href="/3.mp3" singer="齐秦">往事随风</a>
    </li>
    <li data-view="6"><a href="/4.mp3" singer="beyond">光辉岁月</a></li><li data=""><a href="/5.mp3" singer="陈慧琳">记事本</a> </li><li data="">
    <a href='*/6.mp3"' singer="邓丽君">但愿人长久</a>
    </li>
    </ul>
    </div>
    <generator object PageElement.parents at 0x1141de200>
    0 <div id="songs-list'&gt;
                &lt;h2 class=" title="">经典老歌
                <p class="introduction" name="name.p">
                    经典老歌列表
                </p>
    <ul class="list-group" id="list">
    <li data-view="2">一路上有你</li>
    <li data-view="7">
    <a href="/2.mp3" singer="任贤齐">沧海一声笑</a>
    </li>
    <li class="active" data-view="4">
    <a href="/3.mp3" singer="齐秦">往事随风</a>
    </li>
    <li data-view="6"><a href="/4.mp3" singer="beyond">光辉岁月</a></li><li data=""><a href="/5.mp3" singer="陈慧琳">记事本</a> </li><li data="">
    <a href='*/6.mp3"' singer="邓丽君">但愿人长久</a>
    </li>
    </ul>
    </div>
    1 <body>
    <div id="songs-list'&gt;
                &lt;h2 class=" title="">经典老歌
                <p class="introduction" name="name.p">
                    经典老歌列表
                </p>
    <ul class="list-group" id="list">
    <li data-view="2">一路上有你</li>
    <li data-view="7">
    <a href="/2.mp3" singer="任贤齐">沧海一声笑</a>
    </li>
    <li class="active" data-view="4">
    <a href="/3.mp3" singer="齐秦">往事随风</a>
    </li>
    <li data-view="6"><a href="/4.mp3" singer="beyond">光辉岁月</a></li><li data=""><a href="/5.mp3" singer="陈慧琳">记事本</a> </li><li data="">
    <a href='*/6.mp3"' singer="邓丽君">但愿人长久</a>
    </li>
    </ul>
    </div>
    </body>
    2 <html><head><title>This is a title</title></head>
    <body>
    <div id="songs-list'&gt;
                &lt;h2 class=" title="">经典老歌
                <p class="introduction" name="name.p">
                    经典老歌列表
                </p>
    <ul class="list-group" id="list">
    <li data-view="2">一路上有你</li>
    <li data-view="7">
    <a href="/2.mp3" singer="任贤齐">沧海一声笑</a>
    </li>
    <li class="active" data-view="4">
    <a href="/3.mp3" singer="齐秦">往事随风</a>
    </li>
    <li data-view="6"><a href="/4.mp3" singer="beyond">光辉岁月</a></li><li data=""><a href="/5.mp3" singer="陈慧琳">记事本</a> </li><li data="">
    <a href='*/6.mp3"' singer="邓丽君">但愿人长久</a>
    </li>
    </ul>
    </div>
    </body>
    </html>
    3 <html><head><title>This is a title</title></head>
    <body>
    <div id="songs-list'&gt;
                &lt;h2 class=" title="">经典老歌
                <p class="introduction" name="name.p">
                    经典老歌列表
                </p>
    <ul class="list-group" id="list">
    <li data-view="2">一路上有你</li>
    <li data-view="7">
    <a href="/2.mp3" singer="任贤齐">沧海一声笑</a>
    </li>
    <li class="active" data-view="4">
    <a href="/3.mp3" singer="齐秦">往事随风</a>
    </li>
    <li data-view="6"><a href="/4.mp3" singer="beyond">光辉岁月</a></li><li data=""><a href="/5.mp3" singer="陈慧琳">记事本</a> </li><li data="">
    <a href='*/6.mp3"' singer="邓丽君">但愿人长久</a>
    </li>
    </ul>
    </div>
    </body>
    </html>
    
    [(0, '\n')]
    [(0, '\n')]
```

## 标准选择器

`find_all(name ,attrs,recursive,text,**kwargs)`

> 可以根据标签名、属性、内容查找文档


```python
html =''' 
<!DOCTYPE html>
<html>
    <head>
        <title>sufee Admin后台管理员系统模板_模板之家cssMoban.com</title>
            <meta http-equiv=Content-Type content="text/html; charset=utf-8">
            <meta name="keywords" content="网页模板,网站模板,DIV+CSS模板,CSS模板,企业网站模板下载" />
            <meta name="description" content="sufee Admin后台管理员系统模板演示 下载,精品网页模板、企业网站模板、博客模板等几千种免费网页模板下载尽在模板之家cssMoban.com" />
            <link rel="shortcut icon" type="image/x-icon" href="/favicon.ico" />
            <link type="text/css" rel="stylesheet" href="http://static.cssmoban.com/statics/min/styles.css?v2" />
            <script src="http://static.cssmoban.com/statics/min/lazys.js?v2" charset="utf-8"></script>
        <!--[if lt IE 9]>
        <link href="http://static.cssmoban.com/statics/min/cssies.css" type="text/css" rel="stylesheet"/>
        <script src="http://static.cssmoban.com/statics/min/jsies.js" charset="utf-8"></script>
    <![endif]-->
    </head>
<body>

        <section class="page-top">
            <div class="container col-media-main">
                <div class="logo"><a href="/">模板之家</a></div>
                    <nav class="menu">
                        <ul>
                            <li><a href="/" target="_parent">首页</a></li>
                            <li><a href="/cssthemes/" class="active" target="_parent">网站模板</a></li>
                            <li><a href="/wpthemes/" class="active" target="_parent">WP模板</a></li>
                            <li><a href="/tags.asp" target="_parent">模板标签</a></li>
                                <script src="http://www.cssmoban.com/statics/js/20170901.js?v4" charset="utf-8"></script>
                        </ul>
                    </nav>
            <div class="search">
                <div class="bdcs-search">
                    <form id="cse-search-box" class="search-form" action="http://so.cssmoban.com/cse/search" target="_blank">
                        <input name="s" type="hidden" value="7097020869459475331" />
                        <input name="q" type="text" class="form-control search-form-input" id="q" placeholder="请输入关键词..." size="28" />
                        <input id="go" class="bdcs-search-form-submit " type="submit" value="搜索" />
                    </form>
                </div>
            </div>
        </section>
    </body>
</html>
'''
import lxml
from bs4 import BeautifulSoup
soup = BeautifulSoup(html,'lxml')
print(soup.find_all('a'))
print(type(soup.find_all('a')[0]))

for div in soup.find_all('div'):
    for i in div.find_all('a'):
        print(i)
```

```shell
    [<a href="/">模板之家</a>, <a href="/" target="_parent">首页</a>, <a class="active" href="/cssthemes/" target="_parent">网站模板</a>, <a class="active" href="/wpthemes/" target="_parent">WP模板</a>, <a href="/tags.asp" target="_parent">模板标签</a>]
    <class 'bs4.element.Tag'>
    <a href="/">模板之家</a>
    <a href="/" target="_parent">首页</a>
    <a class="active" href="/cssthemes/" target="_parent">网站模板</a>
    <a class="active" href="/wpthemes/" target="_parent">WP模板</a>
    <a href="/tags.asp" target="_parent">模板标签</a>
    <a href="/">模板之家</a>
```


```python
html =''' 
<!DOCTYPE html>
<html>
    <head>
        <title>sufee Admin后台管理员系统模板_模板之家cssMoban.com</title>
            <meta http-equiv=Content-Type content="text/html; charset=utf-8">
            <meta name="keywords" content="网页模板,网站模板,DIV+CSS模板,CSS模板,企业网站模板下载" />
            <meta name="description" content="sufee Admin后台管理员系统模板演示 下载,精品网页模板、企业网站模板、博客模板等几千种免费网页模板下载尽在模板之家cssMoban.com" />
            <link rel="shortcut icon" type="image/x-icon" href="/favicon.ico" />
            <link type="text/css" rel="stylesheet" href="http://static.cssmoban.com/statics/min/styles.css?v2" />
            <script src="http://static.cssmoban.com/statics/min/lazys.js?v2" charset="utf-8"></script>
        <!--[if lt IE 9]>
        <link href="http://static.cssmoban.com/statics/min/cssies.css" type="text/css" rel="stylesheet"/>
        <script src="http://static.cssmoban.com/statics/min/jsies.js" charset="utf-8"></script>
    <![endif]-->
    </head>
<body>

        <section class="page-top">
            <div class="asdsdsd">
                <div class="logo">container<a href="/">模板之家</a></div>
                    <nav class="menu">
                        <ul>
                            <li><a href="/" target="_parent">首页</a></li>
                            <li><a href="/cssthemes/" class="active" target="_parent">网站模板</a></li>
                            <li><a href="/wpthemes/" class="active" target="_parent">WP模板</a></li>
                            <li><a href="/tags.asp" target="_parent">模板标签</a></li>
                                <script src="http://www.cssmoban.com/statics/js/20170901.js?v4" charset="utf-8"></script>
                        </ul>
                    </nav>
            <div class="search">
                <div class="bdcs-search">
                    <form id="1" class="search-form" action="http://so.cssmoban.com/cse/search" target="_blank">
                        <input name="keywords" type="hidden" value="7097020869459475331" />
                        <input name="q" type="text" class="form-control search-form-input" id="q" placeholder="请输入关键词..." size="28" />
                        <input id="1" class="2" type="submit" value="搜索" />
                    </form>
                </div>
            </div>
        </section>
    </body>
</html>
'''
import lxml
from bs4 import BeautifulSoup
soup = BeautifulSoup(html,'lxml')
print(soup.find_all(attrs={'name':'keywords'}))
print(soup.find_all(id='1'))
print(soup.find_all(class_='2'))
```

```shell

    [<meta content="网页模板,网站模板,DIV+CSS模板,CSS模板,企业网站模板下载" name="keywords"/>, <input name="keywords" type="hidden" value="7097020869459475331"/>]
    [<form action="http://so.cssmoban.com/cse/search" class="search-form" id="1" target="_blank">
    <input name="keywords" type="hidden" value="7097020869459475331"/>
    <input class="form-control search-form-input" id="q" name="q" placeholder="请输入关键词..." size="28" type="text"/>
    <input class="2" id="1" type="submit" value="搜索"/>
    </form>, <input class="2" id="1" type="submit" value="搜索"/>]
    [<input class="2" id="1" type="submit" value="搜索"/>]
```


```python
html =''' 
<!DOCTYPE html>
<html>
    <head>
        <title>sufee Admin后台管理员系统模板_模板之家cssMoban.com</title>
            <meta http-equiv=Content-Type content="text/html; charset=utf-8">
            <meta name="keywords" content="网页模板,网站模板,DIV+CSS模板,CSS模板,企业网站模板下载" />
            <meta name="description" content="sufee Admin后台管理员系统模板演示 下载,精品网页模板、企业网站模板、博客模板等几千种免费网页模板下载尽在模板之家cssMoban.com" />
            <link rel="shortcut icon" type="image/x-icon" href="/favicon.ico" />
            <link type="text/css" rel="stylesheet" href="http://static.cssmoban.com/statics/min/styles.css?v2" />
            <script src="http://static.cssmoban.com/statics/min/lazys.js?v2" charset="utf-8"></script>
        <!--[if lt IE 9]>
        <link href="http://static.cssmoban.com/statics/min/cssies.css" type="text/css" rel="stylesheet"/>
        <script src="http://static.cssmoban.com/statics/min/jsies.js" charset="utf-8"></script>
    <![endif]-->
    </head>
<body>

        <section class="page-top">
            <div class="asdsdsd">
                <div class="logo">container<a href="/">模板之家</a></div>
                    <nav class="menu">
                        <ul>
                            <li><a href="/" target="_parent">首页</a></li>
                            <li><a href="/cssthemes/" class="active" target="_parent">网站模板</a></li>
                            <li><a href="/wpthemes/" class="active" target="_parent">WP模板</a></li>
                            <li><a href="/tags.asp" target="_parent">模板标签</a></li>
                                <script src="http://www.cssmoban.com/statics/js/20170901.js?v4" charset="utf-8"></script>
                        </ul>
                    </nav>
            <div class="search">
                <div class="bdcs-search">
                    <form id="1" class="search-form" action="http://so.cssmoban.com/cse/search" target="_blank">
                        <input name="keywords" type="hidden" value="7097020869459475331" />
                        <input name="q" type="text" class="form-control search-form-input" id="q" placeholder="请输入关键词..." size="28" />
                        <input id="1" class="2" type="submit" value="搜索" />
                    </form>
                </div>
            </div>
        </section>
    </body>
</html>
'''
import lxml
from bs4 import BeautifulSoup
soup = BeautifulSoup(html,'lxml')
print(type(soup.find_all(text='首页')[0]))
```
```shell
    <class 'bs4.element.NavigableString'>
```

## CSS选择器


```python
html =''' 
<!DOCTYPE html>
<html>
    <head>
        <title>sufee Admin后台管理员系统模板_模板之家cssMoban.com</title>
            <meta http-equiv=Content-Type content="text/html; charset=utf-8">
            <meta name="keywords" content="网页模板,网站模板,DIV+CSS模板,CSS模板,企业网站模板下载" />
            <meta name="description" content="sufee Admin后台管理员系统模板演示 下载,精品网页模板、企业网站模板、博客模板等几千种免费网页模板下载尽在模板之家cssMoban.com" />
            <link rel="shortcut icon" type="image/x-icon" href="/favicon.ico" />
            <link type="text/css" rel="stylesheet" href="http://static.cssmoban.com/statics/min/styles.css?v2" />
            <script src="http://static.cssmoban.com/statics/min/lazys.js?v2" charset="utf-8"></script>
    </head>
<body>

        <section class="page-top">
            <div class="logo1">
                <div class="logo">container<a href="/">模板之家</a></div>
                    <nav class="menu">
                        <ul>
                            <li><a href="/" target="_parent">首页</a></li>
                            <li><a href="/cssthemes/" class="active" target="_parent">网站模板</a></li>
                            <li><a href="/wpthemes/" class="active" target="_parent">WP模板</a></li>
                            <li><a href="/tags.asp" target="_parent">模板标签</a></li>
                                <script src="http://www.cssmoban.com/statics/js/20170901.js?v4" charset="utf-8"></script>
                        </ul>
                    </nav>
            <div id="1" class="search">
                <div class="bdcs-search">
                    <form id="1" class="search-form" action="http://so.cssmoban.com/cse/search" target="_blank">
                        <input name="keywords" type="hidden" value="7097020869459475331" />
                        <input name="q" type="text" class="form-control search-form-input" id="q" placeholder="请输入关键词..." size="28" />
                        <input id="1" class="2" type="submit" value="搜索" />
                    </form>
                </div>
            </div>
        </section>
    </body>
</html>
'''
import lxml
from bs4 import BeautifulSoup
soup = BeautifulSoup(html,'lxml')
# class .(?)
print(soup.select('.logo1 .logo'))
# 标签
print(soup.select('ul li'))
# id  
print(soup.find(id='1'))
# print(soup.select('#1'))

```

```shell

    [<div class="logo">container<a href="/">模板之家</a></div>]
    [<li><a href="/" target="_parent">首页</a></li>, <li><a class="active" href="/cssthemes/" target="_parent">网站模板</a></li>, <li><a class="active" href="/wpthemes/" target="_parent">WP模板</a></li>, <li><a href="/tags.asp" target="_parent">模板标签</a></li>]
    <div class="search" id="1">
    <div class="bdcs-search">
    <form action="http://so.cssmoban.com/cse/search" class="search-form" id="1" target="_blank">
    <input name="keywords" type="hidden" value="7097020869459475331"/>
    <input class="form-control search-form-input" id="q" name="q" placeholder="请输入关键词..." size="28" type="text"/>
    <input class="2" id="1" type="submit" value="搜索"/>
    </form>
    </div>
    </div>



    ---------------------------------------------------------------------------
    
    AttributeError                            Traceback (most recent call last)
    
    <ipython-input-2-f07e167d42ca> in <module>
         49 # print(soup.select('#1'))
         50 
    ---> 51 print(html.xpath('//div'))


    AttributeError: 'str' object has no attribute 'xpath'
```
# 总结

> 推荐使用lxml解析库，必要时使用html.parser  
> 标签选择筛选功能弱但是速度快  
> 建议使用find()、find_all() 查询匹配单个结果或者多个结果  
> 如果对CSS选择器熟悉建议使用select0  
> 记住常用的获取属性和文本值的方法  
