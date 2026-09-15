# ShadowPlusing

基于 Flutter Web 的个人博客与项目展示站，保留深紫色、插画背景和玻璃效果。

- 网站：[shadowplusing.website](https://shadowplusing.website/)
- 源码：[GitHub](https://github.com/shAdow-XJY/shAdow-XJY.github.io)
- 开发、字体打包、测试及发布步骤：[CMD_README.md](CMD_README.md)

## 运行环境

已验证：macOS、Flutter **3.35.7**、Dart **3.9.2**。当前维护平台为 **Web**；原生平台目录仍保留，但 Web 专用依赖使原生构建不在支持范围内。`pubspec.yaml` 的历史 SDK 约束尚未现代化，使用上述版本恢复依赖；锁文件随工具链解析可能变化。

```sh
flutter pub get
flutter build web --no-pub --no-web-resources-cdn --release
python3 -m http.server 8765 --bind 127.0.0.1 --directory build/web
```

打开 [本地预览](http://127.0.0.1:8765/)。`build/web/` 是构建输出；`docs/` 是历史发布产物，按维护约定保留，不能代表当前源码效果。

## 结构与内容维护

入口为 `lib/main.dart` → `lib/router/router.dart` → `lib/homepage/homePage.dart`。六个栏目由首页内部选择状态切换，目前没有栏目独立 URL、刷新恢复或浏览器前进后退功能。

| 栏目 | 修改入口 | 内容 |
| --- | --- | --- |
| Home | `lib/indexPage/indexHome/indexHome.dart` | 欢迎语、背景、社交入口；桌面和手机分支需一起核对 |
| Videos | `lib/innerAssets/videoAsset/videoData.dart` | 三种来源；`assets/image/video/` 与 `assets/video/` 使用同标题文件名 |
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
- 两款字体从300,580 bytes降至82,228 bytes（约减少72.6%）；当前131个字符全部覆盖。

## 后续优化边界

侧栏动画已隔离主内容布局，手机栏目选择后关闭抽屉，音乐图标订阅实际播放状态。尚未取得真实设备帧 trace，不能声称首次卡顿彻底消失。全屏标准 API、iframe 加载失败反馈、栏目 URL 与历史 Markdown 模块仍待后续整理；当前含 `dart:html` / `dart:js`，不能直接开启 Wasm。旧文章生成流程已脱离当前导航，不应作为日常构建步骤。
