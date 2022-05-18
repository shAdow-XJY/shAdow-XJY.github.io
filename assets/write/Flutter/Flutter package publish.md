# Flutter package 打包发布

教程资料：

 按照下面的详细步骤即可完整走完发布过程。

> [(2条消息) flutter-发布一个package到pub.dev 超详细教程_ai_pple的博客-CSDN博客_pub.dev](https://blog.csdn.net/ai_pple/article/details/108535418)



### 发布问题

##### 主要是国内有wall

打开包路径终端：

` Android Studio 直接打开Terminal`

` 文件目录下鼠标右键或者(Shift+鼠标右键)，选择 在终端打开`

` cmd 一直cd 到包路径下`



---

##### 设置临时代理

主要是国内连接google超时。

终端运行 `curl www.google.com` 会超时，设置好代理(最好服务器选USA等地)，选择hk可能会有重定向，返回的结果不对（即很短）。  



设置终端临时代理时，要http和https一起设置，防止类似http://accounts.google.com之类的资源临时移动到https://accounts.google.com 问题。  



终端命令如下，端口根据自己的代理查看，设置后运行 `curl www.google.com`返回很长的xml表示正常，不正常就再换代理节点。  

```
set http_proxy = 127.0.0.1:10809
set https_proxy = 127.0.0.1:10809
```

***注意：设置临时代理，终端窗口关闭后可能需要重新再设置一遍。***



---



##### 中国镜像源的问题

可能用了镜像源也会影响到发布吧，我没遇到，在Github的Issue有解决方法。

> [Publish plugin in china · Issue #17070 · flutter/flutter (github.com)](https://github.com/flutter/flutter/issues/17070)

```
export PUB_HOSTED_URL=https://pub.flutter-io.cn
export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn
```

### 

### 参考

1. [(2条消息) flutter-发布一个package到pub.dev 超详细教程_ai_pple的博客-CSDN博客_pub.dev](https://blog.csdn.net/ai_pple/article/details/108535418)

2. [(2条消息) Flutter篇 （三）发布package到pub.dev_狗屎糖的博客-CSDN博客_flutter package](https://blog.csdn.net/sxt_zls/article/details/89450453)

3. [Publish plugin in china · Issue #17070 · flutter/flutter (github.com)](https://github.com/flutter/flutter/issues/17070)

4. [[Flutter] Android Studio 三步发布Flutter插件 - 掘金 (juejin.cn)](https://juejin.cn/post/6844903746913173518)
