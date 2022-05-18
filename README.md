## 预览

![手机web端画面](https://img-blog.csdnimg.cn/3a7af8b41d86473194b0ca53cc0e5f6c.jpeg#pic_center)
![PC端画面](https://img-blog.csdnimg.cn/b93090d4a9684d7dbedb54496f76bf67.png#pic_center)

## 版本环境

#### 框架

Flutter：2.10.4

#### 语言

Dart：2.16.2

#### IDEA

Android Studio

## 下载

GitHub：[shAdow-XJY/github_blog: the source code of the github.io](https://github.com/shAdow-XJY/github_blog)

Gitee：[github_blog: github page——博客源码工程 框架：flutter (gitee.com)](https://gitee.com/shAdowPlusing/github_blog)

#### 使用

1. 工程只面向Web平台，不支持其它移动端、桌面端平台（主要是使用了浏览器的js接口调用），直接运行工程即可。

2. 可能会有 <u>***Cannot run with sound null safety ***</u> 报错。使用run命令时，添加额外命令--no-sound-null-safety 即可。Android Studio可添加额外参数，不用每一次手动添加——[关于Flutter报Cannot run with sound null safety的解决方法 - 知乎 (zhihu.com)](https://zhuanlan.zhihu.com/p/405838959)

## 自定义内容更新

##### 目前文件格式有限制,原因是代码里加载文件代码写死了，后续有机会的话会进一步优化。

### Write 模块更新

1. 在 ***assets/write/*** 路径下，创建一个自定义名字的 ***文件夹（如Flutter）*** ，在文件夹里面可以添加自己的.md文件（如Flutter.md、Flutter123.md）。

2. 在 ***assets/icon/write/*** 路径下添加文件夹同名的图标.png图片。

3. 在pubspec.yaml的assets：添加 ***- assets/write/Flutter/***

### Program 模块更新

在 ***assets/program/*** 路径下，添加自己的.md文件（如Program.md）即可。

### Video 模块更新

#### 视频封面

在 ***assets/image/video/*** 下添加与视频同名的 ***.png*** 图片,如夏日预告企划.png。

#### assets/video更新

在 ***assets/video/*** 路径下放入自己的 ***夏日预告企划.mp4*** 文件，注意，如果是GitHub Page之类的博客网页，文件大小会受限，如GitHub仓库大小限制1G，***单文件传输限制100M，所以视频文件不能过大。***

#### Youtube、Bilibili视频源

1. Youtube更新：在 ***assets/videoIndex/*** 下创建一个文本文件，写入参数https://www.youtube.com/embed/ZI-GnWGzAMo，文件修改为 ***夏日预告企划.youtube***

2. Bilibili更新：在 ***assets/videoIndex/*** 下创建一个文本文件，写入参数//player.bilibili.com/player.html?aid=938701785&bvid=BV1gT4y1k7dz&cid=711347686&page=1，文件修改为 ***夏日预告企划.bilibili***

> 参数获取：
>
> > > 在B站视频下面的分享，复制嵌入代码，如：*<u>src="//player.bilibili.com/player.html?aid=938701785&bvid=BV1gT4y1k7dz&cid=711347686&page=1" scrolling="no" border="0" frameborder="no" framespacing="0" allowfullscreen="true"</u>*
> > >
> > > > 参数即为src=""的内容//player.bilibili.com/player.html?aid=938701785&bvid=BV1gT4y1k7dz&cid=711347686&page=1  
> > > > 在Youtube视频下面的分享，复制嵌入代码，如  
> > > >  *<u>width="640" height="360" src="https://www.youtube.com/embed/ZI-GnWGzAMo" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen</u>*  
> > > > 参数即为src=""内容https://www.youtube.com/embed/ZI-GnWGzAMo

## 运行/打包前资源刷新

#### 如果有进行上面的自定义内容更改，需要进行资源文件的更新才能运行正常。

更新步骤：

> 1. 进入 ***github_blog/test/*** 下的file_generator.dart,运行main函数。

如果没有python环境，可忽略下面步骤，将github_blog/local/下的NotoSansSC-Regular.otf复制，覆盖assets/fonts/里面的字体，缺点是中文字体包太大，加载慢。

或者直接不做修改，运行时网站会自己在网上下载字体。

> 1. 进入 ***github_blog/test/*** 下的font_collection.dart,运行main函数。
     >
     >    > 2. 在 ***github_blog/local/*** 下，打开cmd，运行python命令 ***pip install fontTools***
     >    > 3. 再在cmd上运行 ***runcmd with pip.txt*** 里面的python命令。
               >    >
               >    >    > 其中的 ***--output-file=*** 可根据自己的路径修改。
