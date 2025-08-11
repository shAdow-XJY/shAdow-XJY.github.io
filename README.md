## Website / 网址

GitHub：[https://shadowplusing.website/](https://shadowplusing.website/)

Gitee：[https://shadow-xjy.gitee.io/](https://shadow-xjy.gitee.io/)

## 预览

![手机web端画面](https://img-blog.csdnimg.cn/3a7af8b41d86473194b0ca53cc0e5f6c.jpeg#pic_center)

![PC端画面](https://img-blog.csdnimg.cn/b93090d4a9684d7dbedb54496f76bf67.png#pic_center)

## 版本环境

<details>
<summary>flutter --version</summary>
<div>
Flutter 3.29.2 • channel stable • https://github.com/flutter/flutter.git
Framework • revision c236373904 (5 months ago) • 2025-03-13 16:17:06 -0400
Engine • revision 18b71d647a
Tools • Dart 3.7.2 • DevTools 2.42.3
</div>
</details>

#### IDEA

Android Studio

## 仓库

GitHub：[https://github.com/shAdow-XJY/shAdow-XJY.github.io](https://github.com/shAdow-XJY/shAdow-XJY.github.io)

Gitee：[https://gitee.com/shAdow-XJY/shAdow-XJY](https://gitee.com/shAdow-XJY/shAdow-XJY)

## 打包前资源刷新

#### build cmd

```
flutter build web --no-web-resources-cdn --release
```

<details>
<summary>flutter build web</summary>
<div>
flutter build web --release
[flutter build web --web-renderer html --release] ❌

✅ 新的flutter版本没法用html构建了，一定需要下载渲染器了，太难绷了
flutter build web --release
flutter build web --wasm --release

flutter build web --no-web-resources-cdn --release
这样打包时，canvaskit.wasm 会直接放进你的 build/web/canvaskit/ 目录，访问时直接从你的服务器下载，不会去 gstatic 了。

优点
•	不依赖 Google CDN
•	访问速度取决于你的服务器

缺点
•	包体积会变大（多 1.1~1.5 MB）
</div>
</details>

#### Web静态字体包体积压缩（可选）

相关项目仓库链接：[subFontPackage 字体包压缩](https://github.com/shAdow-XJY/subFontPackage)
