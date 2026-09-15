# ShadowPlusing

基于 Flutter Web 的个人博客与项目展示站，保留深紫色、插画背景和玻璃效果。

- 网站：[shadowplusing.website](https://shadowplusing.website/)
- 源码：[GitHub](https://github.com/shAdow-XJY/shAdow-XJY.github.io)
- 开发、字体打包、测试及发布步骤：[CMD_README.md](CMD_README.md)

## 运行环境

已验证：macOS、Flutter **3.35.7**、Dart **3.9.2**。当前维护平台为 **Web**；原生平台目录仍保留，但 Web 专用依赖使原生构建不在支持范围内。SDK 约束已与已验证工具链对齐：Dart ≥3.9、Flutter ≥3.35。

```sh
flutter pub get
flutter build web --no-pub --no-web-resources-cdn --release --pwa-strategy=none
python3 tool/preview_web.py --port 8765
```

打开 [本地预览](http://127.0.0.1:8765/)。`build/web/` 是构建输出；`docs/` 是历史发布产物，按维护约定保留，不能代表当前源码效果。

## 结构与内容维护

入口为 `lib/main.dart` → `lib/router/router.dart` → `lib/homepage/homePage.dart`。六个栏目由首页内部选择状态切换；视频播放视图支持 `/#/videos/summer-preview` 直达、刷新和浏览器返回，其他栏目尚无独立 URL。

| 栏目 | 修改入口 | 内容 |
| --- | --- | --- |
| Home | `lib/indexPage/indexHome/indexHome.dart` | 欢迎语、背景、社交入口；桌面和手机分支需一起核对 |
| Videos | `lib/innerAssets/videoAsset/videoData.dart` | `videos` 类型化列表；标题与文件名分离，媒体文件使用 ASCII 名称，保留站内 / Bilibili / YouTube 三种来源 |
| Websites | `lib/indexPage/indexBook/indexBook.dart` | `websiteProjects`；桌面列表＋详情，小屏展开列表 |
| Collections | `lib/indexPage/indexProgram/indexProgram.dart` | `collectionEntries`；Game Center / Novel Center，宽屏并排、小屏纵向，无自动轮播 |
| People | `lib/indexPage/indexPeople/indexPeople.dart` | 头像、名称、阅读进度 |
| Favorite | `lib/indexPage/indexFavorite/indexFavorite.dart` | 收藏图片与标题 |

共享导航在 `lib/global/navigation/siteNavigation.dart`，颜色与字体样式在 `lib/global/siteStyle.dart`，音乐列表在 `lib/global/musicPlayer.dart`。新增文案后重新运行字体流程；新增资源目录后更新 `pubspec.yaml`。

## 资源约定

- 当前项目插画：`assets/image/book/redesign/`；Collections 插画：`assets/image/collections/`。均为单独生成的 1280×720 WebP。
- 首页背景、头像、Favorite 图片、视频封面及仍在使用的图标保留。源码中无引用的旧 Websites / Collections 图片及 repositories 图标已删除；历史 `docs/` 副本保留至下一次正式更新发布产物。
- WDXL 用于标题及中文，Roboto / SiteBody 用于正文。只把字体子集放入 `assets/fonts/`；完整源字体、字符清单、工具环境保存在忽略的 `local/`。
- 字体授权见 `assets/fonts/WDXL_LICENSE.txt` 和 `assets/fonts/site/Roboto_LICENSE.txt`，不得随普通资料清理删除。

## 本次整理结果

- 工程说明只维护本 README 与 CMD_README；旧分散文档及设计草稿已移除，历史可从 Git 查询。
- Collections 改为两个明确入口，图片与 Websites 延续同一紫色夜景风格，文案和按钮不压在复杂图片上。
- 删除8个源码图片/图标，共3,976,658 bytes；新增两张 Collections 插画共313,200 bytes。
- 两款字体当前共77,216 bytes；更新视频文案后重跑子集流程，127个所需字符全部覆盖。

## 导航与视频

- 自定义侧栏顶部使用现有头像，展开为88px正方形、收起为40px圆形，180ms同步过渡；支持减少动画。`sidebarx` 已移除。
- 视频列表在桌面为16:9封面卡片、手机为紧凑列表；点击直接进入独立播放视图，返回保留列表位置与焦点。
- 站内视频统一使用原生 HTML 控制条，支持播放、暂停、进度、音量与浏览器全屏；加载失败有重试和换源。嵌入来源保留原站入口。
- 进入播放视图暂停本站背景音乐，返回不自动恢复；换源和退出会释放旧媒体元素与订阅。
- 原中文视频改名为 `assets/video/summer-preview.mp4`，避免构建输出文件名编码差异；不要恢复按 debug/release 猜测编码次数的分支。

## 后续优化边界

侧栏动画已隔离主内容布局，手机栏目选择后关闭抽屉，音乐图标订阅实际播放状态。真实设备动画帧耗时仍需测量，不能声称首次卡顿彻底消失。Edge普通窗口曾出现图标缺失，而InPrivate正常；当前字体与源码包含全部六个导航图标，排查步骤见CMD_README。保留字体裁剪，不把浏览器个人配置问题改成一套专用图标。Web媒体仍使用 `dart:html`，音频依赖也有Web限制，本轮不承诺Wasm。旧文章生成流程已脱离当前导航。
