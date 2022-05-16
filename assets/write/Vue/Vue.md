# github_blog

A new GitHub web blog designed myself with the Flutter.

## init
1. flutter build web --release
2. cd ./build/web
3.
>> git init
>> git remote add origin git@github.com:shAdow-XJY/shAdow-XJY.github.io.git
>> git add .
>> git commit -m "Init Flutter web project"
>> git push origin master

## project upgrade
1. flutter build web --release
2. cd ./build/web
3. git add .
4. git commit -m ""
5. git push origin master

## write upgrade
1. change or add new file in assets/write/
2. run the [file_generator.dart] first in test/file_generator
3. necessarily add new assets path in asset/write/ for example [- assets/write/Flutter/] in pubspec.yaml
4. if you wanna test , [stop main.dart] and [start main.dart] ,not try hot reload just by start main.dart
5. then you can upgrade the project [project upgrade]

## something to talk
1. if the project run normally in local but github page.
   view the Network without cache (F12 when opening the github page,like check the file request path.)
2. for the assets file .md or .txt in Web
   I choose to generate the Index file in the Android Studio (Function code:test/file_generator.dart)
   before I build the release web.

## pack referrence
1. [sidebarx](https://github.com/Frezyx/sidebarx)
2. [url_launcher: ^6.1.0](https://pub.dev/packages/url_launcher)
3. [clock_loader](https://github.com/Mindinventory/clock_loader)
4. [audioplayers: ^0.20.1](https://pub.dev/packages/audioplayers)

## referrence
1. [how deploy on github](https://dev.to/myracledesign/setup-a-flutter-web-project-on-github-pages-3eka)
2. [git using github and gitee together](https://blog.csdn.net/qq_41664096/article/details/106569858)
3. [listen the loading of image](https://blog.csdn.net/campchan/article/details/118560059)
4. [MouseRegion](https://www.liujunmin.com/flutter/gesture/mouse_region.html)
5. [SlideTransition](https://blog.csdn.net/zl18603543572/article/details/95259555)
6. [local music](https://blog.csdn.net/weixin_44934496/article/details/112526027)
7. [dart:io use](https://blog.csdn.net/qq_41097495/article/details/106441389)