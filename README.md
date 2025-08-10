## Website / 网址

GitHub：[https://shadowplusing.website/](https://shadowplusing.website/)

Gitee：[https://shadow-xjy.gitee.io/](https://shadow-xjy.gitee.io/)

## 预览

![手机web端画面](https://img-blog.csdnimg.cn/3a7af8b41d86473194b0ca53cc0e5f6c.jpeg#pic_center)

![PC端画面](https://img-blog.csdnimg.cn/b93090d4a9684d7dbedb54496f76bf67.png#pic_center)

## 版本环境

#### 框架

Flutter：2.10.4+

#### 语言

Dart：2.16.2+

#### IDEA

Android Studio

## 仓库

GitHub：[https://github.com/shAdow-XJY/shAdow-XJY.github.io](https://github.com/shAdow-XJY/shAdow-XJY.github.io)

Gitee：[https://gitee.com/shAdow-XJY/shAdow-XJY](https://gitee.com/shAdow-XJY/shAdow-XJY)

## 打包前资源刷新

#### build cmd

flutter build web --release
[flutter build web --web-renderer html --release] ❌

✅ 新的flutter版本没法用html构建了，一定需要下载渲染器了，太难绷了
flutter build web --release
flutter build web --wasm --release

#### Web静态字体包体积压缩（可选）

相关项目仓库链接：[subFontPackage 字体包压缩](https://github.com/shAdow-XJY/subFontPackage)
