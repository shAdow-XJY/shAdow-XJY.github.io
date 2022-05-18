# github_blog

A new GitHub web blog done myself with the Flutter.

## init 
1. flutter build web --release
2. cd ./build/web
3. 
 git init
 git remote add origin git@github.com:shAdow-XJY/shAdow-XJY.github.io.git
 git add .
 git commit -m "Init Flutter web project"
 git push origin master

## project upgrade
//// jsdelivr: https://cdn.jsdelivr.net/npm/canvaskit-wasm@0.33.0/bin/
//// 饿了么: https://npm.elemecdn.com/browse/canvaskit-wasm@0.33.0/bin/
//// 饿了么: https://github.elemecdn.com/browse/canvaskit-wasm@0.33.0/bin/
// tnnd贼ex，换个镜像源，要不就是没有，有的快一点换个浏览器直接就变慢了，换了台电脑也慢，手机也不行。
// 在官方源或者镜像源将wasm下载下来，放在assets,用自己运行的网站项目中保存下来
// 在pub。yaml ：【    - assets/canvaskit-wasm@0.33.0/bin/】
#### preupgrade
#### run file_generator.dart
#### run font_collection.dart;  and then run the pip cmd in local/fonts/(using python tools: fonttools)
1. flutter build web --release 
> mirror source 
> flutter build web --release --dart-define=FLUTTER_WEB_CANVASKIT_URL=https://github.elemecdn.com/browse/canvaskit-wasm@0.33.0/bin/
> github path with DNS
> flutter build web --release --dart-define=FLUTTER_WEB_CANVASKIT_URL=https://shadowplusing.website/assets/assets/canvaskit-wasm@0.33.0/bin/
2. cd ./build/web
3. git add .
4. git commit -m ""
5. git push origin master

## write upgrade
1. change or add new file in assets/write/
2. run the [file_generator.dart] first in test/file_generator
3. necessarily add new assets path in asset/write/ for example [- assets/write/Flutter/] in pubspec.yaml
4. igit lfs trackf you wanna test , [stop main.dart] and [start main.dart] ,not try hot reload just by start main.dart
5. then you can upgrade the project [project upgrade]
## small the size of font pack 
1. use the [font_collection.dart] to collect all the font we use in the projection.
2. use the [fonttools(python tool)] to generate a new small font pack from the old big one.(old one store in the local/fonts/)

## something to talk
1. if the project run normally in local but github page. 
   view the Network without cache (F12 when opening the github page,like check the file request path.)
2. for the assets file .md or .txt in Web
   I choose to generate the Index file in the Android Studio (Function code:test/file_generator.dart)
   before I build the release web.
3. 解决中文路径乱码问题
   asset request file name with chinese or other language char. 
   do the best way is to encode the media.file(like .mp4) name before we use it every time.
   [such as .asset('assets/video/${Uri.encodeComponent(filename)})]
4. solve video fullscreen
   use js.fullscreen.api,listen to the fullScreen state every time change the size.
   
## flutter web run slowly
### canvakit.wasm
1. run on the web , [F12] to check the [canvaskit.wasm], see the version we need/use in request header URL
   for example , now my request url is [https://unpkg.com/canvaskit-wasm@0.33.0/bin/canvaskit.wasm]
   version is 0.33.0
2. -look for mirror source of the [canvaskit.wasm], I choose the [jsDelivr][https://cdn.jsdelivr.net/npm/canvaskit-wasm@0.33.0/bin/]
   -then you can add the additional cmd when build or run .
   -for me , I add these in the Android Studio , [Edit Configurations...]which in the main.dart(near we click the run button)
   -build web --release [flutter build web --release --dart-define=FLUTTER_WEB_CANVASKIT_URL=https://cdn.jsdelivr.net/npm/canvaskit-wasm@0.33.0/bin/]
   -the vesion best as same as the one you run on the local.[local F12 to check]
### first time white page 
1. in the web/index.html add the CSS preload animation
### fonts download online or local fonts pack too big
1. using local font pack with fonttools.
### assets/canvakit.wasm
1. download [canvaskit-wasm@0.33.0/bin] in assets/canvaskit-wasm@0.33.0/bin
2. to make it assets file, althogh first it's also slowly, but after this time, 
   it will take a little! a little! time to use the wasm,I think it because I make my site CDN.
3. flutter build web --release --dart-define=FLUTTER_WEB_CANVASKIT_URL=https://shadowplusing.website/assets/assets/canvaskit-wasm@0.33.0/bin/
结论:(我的域名有为github page添加CDN解析)浏览器第一次下载可能需要十几二十几秒，有时好的时候是十秒内，这只是说第一次的情况，接下来在停用缓存的情况下刷新，重开进入，都是几毫秒的耗时。
### assets/canvakit.wasm ---gitee
1. gitee 仓库同步 github仓库，这样[canvaskit-wasm@0.33.0/bin]在GitHub和Gitee都有一个地址，可以尝试使用gitee的地址看看速度怎么样

### define assets font
1. use the local assets fonts in assets if the fonts download online too long

## pack referrence
1. [sidebarx](https://github.com/Frezyx/sidebarx)
2. [url_launcher: ^6.1.0](https://pub.dev/packages/url_launcher)
3. [clock_loader](https://github.com/Mindinventory/clock_loader) //remove already
4. [assets_audio_player](https://pub.dev/packages/assets_audio_player)
5. [flutter_markdown](https://pub.dev/packages/flutter_markdown)
6. [CSS stair loader animation](https://codepen.io/ispal/full/mVaaJe)
7. [video_player: ^2.4.0](https://pub.flutter-io.cn/packages/video_player/example)
8. [js: ^0.6.3](https://pub.flutter-io.cn/packages/js)
9. [auto_size_text: ^3.0.0](https://pub.dev/packages/auto_size_text)
10. [webviewx: ^0.2.1](https://pub.dev/packages/webviewx)
11. [responsive_builder: ^0.4.2](https://pub.dev/packages/responsive_builder)
12. [vertical_card_pager: ^1.5.0](https://pub.dev/packages/vertical_card_pager)

## referrence
1.  [how deploy on github](https://dev.to/myracledesign/setup-a-flutter-web-project-on-github-pages-3eka)
2.  [git using github and gitee together](https://blog.csdn.net/qq_41664096/article/details/106569858)
3.  [listen the loading of image](https://blog.csdn.net/campchan/article/details/118560059) //remove already
4.  [MouseRegion](https://www.liujunmin.com/flutter/gesture/mouse_region.html)
5.  [SlideTransition](https://blog.csdn.net/zl18603543572/article/details/95259555)
6.  [local music](https://blog.csdn.net/weixin_44934496/article/details/112526027)
7.  [dart:io use](https://blog.csdn.net/qq_41097495/article/details/106441389)
8.  [flutter web run slowly](https://blog.csdn.net/qq_35867494/article/details/118516893)
9.  [0xColor and #Color](https://blog.csdn.net/qq_33210042/article/details/78644118)
10. [request path show encode result](https://blog.csdn.net/pathfinder163/article/details/6289424)
11. [path encode](https://blog.csdn.net/qq_32760901/article/details/91378853)
12. [video player](https://flutter.cn/docs/cookbook/plugins/play-video)
13. [flutter use js function](https://zhuanlan.zhihu.com/p/376370125)
14. [Flutter GridView](https://www.jianshu.com/p/fb3bf633ee12)
15. [fonttools](https://cyh.me/2020/04/font-minification/)
16. [web list mouse drag control](https://cloud.tencent.com/developer/ask/sof/749407)

## file and server refer
1. [tomcat](https://www.cnblogs.com/beginner-boy/p/7806680.html)
2. [tomcat webapp](https://blog.csdn.net/qq_38967150/article/details/118722115)
3. [cloud server]()
4. [tomcat https](https://segmentfault.com/a/1190000009780545)
5. [check 端口开放](https://www.cnblogs.com/tongying/p/13182340.html)

## fail to use , but maybe useful one day
1.  [dio: ^4.0.6](it's useful without doubt.)
2.  [shelf_proxy: ^1.0.1](use to solve some cors ,but you konw, company protects greatly)

