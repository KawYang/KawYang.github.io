---
title: Selenium学习示例
author: KawYang
top: false
cover: false
toc: true
mathjax: true
categories: Python
tags:
  - Python
  - 爬虫
abbrlink: a31ea4d6
date: 2020-08-29 22:36:30
img:
coverImg:
---

# Selenium

## 基本使用


```python
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.support.wait import WebDriverWait

browser = webdriver.Chrome()
try:
    browser.get('https://www.zhipin.com/c101010100-p100199/?ka=search_100199')
#     input = browser.find_element_by_id('kw')
#     input.send_keys('Python')
#     input.send_keys(Keys.ENTER)
    wait = WebDriverWait(browser,10)
    wait.until(EC.presence_of_element_located((By.CLASS_NAME,'info-primary')))
    print(browser.current_url)
    print(browser.get_cookies())
    print(browser.page_source)

finally:
#     browser.close()
    print('finish!')
```



```shell
finish
```

# 声明浏览器对象


```python
from selenium import webdriver

browser = webdriver.Chrome()
# browser = webdriver.Firefox()
# browser = webdriver.Edge()
browser1 = webdriver.Safari()

browser.close()
browser1.close()
```

## 访问页面


```python
from selenium import webdriver

browser = webdriver.Chrome()

browser.get('http://www.taobao.com')
print(browser.page_source)
browser.close()
```

## 查找元素

### 单个元素


```python
from selenium import webdriver

browser = webdriver.Chrome()

browser.get('https://www.lagou.com/beijing-zhaopin/Java/10')
x = browser.find_element_by_xpath('//div[@class="pager_container"]/a[last()]')
print(type(x))
print(x.get_attribute('href'))
browser.close()
```

```shell
<class 'selenium.webdriver.remote.webelement.WebElement'>
https://www.lagou.com/beijing-zhaopin/Java/11/
```



```python
from selenium import webdriver
from selenium.webdriver.common.by import By

browser = webdriver.Chrome()
browser.get('https://www.taobao.com')
input_first = browser.find_element(By.ID,'q')
print(input_first)
browser.close()
```

## 多个元素


```python
from selenium import webdriver
from selenium.webdriver.common.by import By

browser = webdriver.Chrome()
browser.get('https://www.taobao.com')
input_first = browser.find_elements_by_css_selector('.service-bd li')
# 列表
for i in input_first:
    print(i)
    
input_first = browser.find_elements(By.CSS_SELECTOR,'.service-bd li')
# 列表
for i in input_first:
    print(i)
browser.close()
```

## 元素交互操作

### 对获取的元素调用交互方法

```python
from selenium import webdriver
from selenium.webdriver.common.by import By
import time

browser = webdriver.Chrome()
browser.get('https://www.taobao.com')
input_first = browser.find_element_by_id('q')

input_first.send_keys('iPhone')
time.sleep(3)
input_first.clear()
input_first.send_keys('iPad')
button = browser.find_element_by_class_name('btn-search')
button.click()
time.sleep(3)
browser.close()
```

更多操作：https://selenium-python.readthedocs.io/api.html#module-selenium.webdriver.remote.webelement

## 交互动作

>  将动作附加到动作链中串行执行


```python
from selenium import webdriver
from selenium.webdriver import ActionChains


try:
    b = webdriver.Chrome()
    url = 'https://www.runoob.com/try/try.php?filename=jqueryui-api-droppable'

    b.get(url)
    # 切换到 frame 标签
    b.switch_to.frame('iframeResult')
    # 被拖拽对象
    source = b.find_element_by_css_selector('#draggable')
    target = b.find_element_by_css_selector('#droppable')
    # 声明一个动作队列
    actions = ActionChains(b)
    actions.drag_and_drop(source, target)
    actions.perform()
except Exception as e:
    print(e)
finally:
    b.close()

```

更多操作：https://selenium-python.readthedocs.io/api.html#module-selenium.webdriver.common.action_chains

## 执行JavaScript


```python
from selenium import webdriver

b = webdriver.Chrome()

b.get('https://www.zhihu.com/explore')
b.execute_script('window.scrollTo(0, document.body.scrollHeight)')
b.execute_script('alert("To Button")')

```

# 获取元素信息



```python
from selenium import webdriver
from selenium.webdriver import ActionChains
from selenium.webdriver.common.by import By

b = webdriver.Chrome()
url = 'https://www.zhihu.com/explore'
b.get(url)
# print(b.page_source)
# 属性含有空格 报错
logo = b.find_element(By.CLASS_NAME ,"AppHeader-inner")
print(logo)

# 获取属性
print(logo.get_attribute('class'))

# 获取文本值

print(logo.text)

# 获取ID、位置、标签名、大小

print(logo.id)
print(logo.location)
print(logo.size)
```

```shell
<selenium.webdriver.remote.webelement.WebElement (session="214a06174092bc2912b9af1d370e9f26", element="2d66204b-57a7-4258-b395-6eef76f741de")>
AppHeader-inner
首页
发现
等你来答
登录加入知乎
2d66204b-57a7-4258-b395-6eef76f741de
{'x': 76, 'y': 0}
{'height': 52, 'width': 1032}
```


# Fram


```python
from selenium import webdriver
from selenium.common.exceptions import NotImplementedError

try:
    b = webdriver.Chrome()
    url = 'https://www.runoob.com/try/try.php?filename=jqueryui-api-droppable'
    b.get(url)
    # 切换到 frame 标签
    b.switch_to.frame('iframeResult')
    # 被拖拽对象
    source = b.find_element_by_css_selector('#draggable')
    try:
        s = b.find_element_by_class_name('container')
    except NotImplementedError:
        print("No")
    # 回去
    s.switch_to.parent_frame()
    s = b.find_element_by_class_name('container')
    print(s)
except Exception as e:
    print(e)

```




```shell
ImportError: cannot import name 'NotImplementedError' from 'selenium.common.exceptions' (/Library/Frameworks/Python.framework/Versions/3.8/lib/python3.8/site-packages/selenium/common/exceptions.py)
```

# 等待

## 隐式等待

    当使用隐式等待 执行测试的时候，如果 webdriver 没有在DOM中找到元素，将继续等待，超出设定时间后则抛出异常


```python
from selenium import webdriver

browser = webdriver.Chrome()
# 等待 10 s
browser.implicitly_wait(10)
browser.get('http://www.baidu.com')
input = browser.find_element_by_link_text('#0000cc')

print(input)
```


```shell
NoSuchElementException: Message: no such element: Unable to locate element: {"method":"link text","selector":"#0000cc"}
  (Session info: chrome=80.0.3987.132)
```



## 显式等待

指定等待条件和最长等待时间


```python
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC

b = webdriver.Chrome()
b.get('https://www.taobao.com')
wait = WebDriverWait(b,10)
# 参数为 元组类型
input = wait.until(EC.presence_of_element_located((By.ID, 'q')))
button = wait.until(EC.element_to_be_clickable((By.CSS_SELECTOR, '.btn-search')))

print(input, button)
```

```shell
<selenium.webdriver.remote.webelement.WebElement (session="76f1dc9a46a670633392632ae49d64a8", element="f4c9f80d-e808-4147-838f-5aa1ad3391f8")> <selenium.webdriver.remote.webelement.WebElement (session="76f1dc9a46a670633392632ae49d64a8", element="ca703ce2-1e34-4726-8538-97ba688f1f75")>
```


```python
## 前进后退

import time
from selenium import webdriver

b = webdriver.Chrome()

b.get('http:')
b.get('http:')
b.get('http:')
b.get('http:')
# 后退
b.back()
# 前进
b.forward()
b.close()
```

# Cookies


```python
from selenium import webdriver

b = webdriver.Chrome()
b.get("")
print(b.get_cookies())
b.add_cookie({'name':'name','domain':'www.zhihu.com'})
print(b.get_cookies())
b.delete_all_cookies()
print(b.get_cookies())
```

## 选项卡管理


```python

import selenium
from selenium import webdriver

b = webdriver.Chrome()
b.get(url)
b.execute_script('window.open()')

print(b.window_handles)

b.switch_to_window(b.window_handles[1])

b.get(url2)

b.switch_to_window(b.window_handles[0])

b.get(url3)

```

## 异常处理


```python
# 是 Try - Catch 吗？ 当时没记 😓

```

## 无界面测试


```python
from selenium import webdriver
from pyvirtualdisplay import Display

display = Display(visible=1, size=(800,600))
display.start()

browser = webdriver.Chrome()
browser.get('http://www.baidu.com')
print(browser.page_source)
```




```shell
EasyProcessError: start error <EasyProcess cmd_param=['Xephyr', '-help'] cmd=['Xephyr', '-help'] oserror=[Errno 20] Not a directory: 'Xephyr' return_code=None stdout="None" stderr="None" timeout_happened=False>
```
