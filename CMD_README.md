# 命令与执行步骤

以下命令在项目根目录执行。环境基线：Flutter 3.35.7 / Dart 3.9.2；构建只写 `build/web/`，不会自动更新或发布 `docs/`。

## 1. 恢复依赖与开发

```sh
flutter --version
flutter pub get
flutter run -d chrome
```

最后一条用于日常 debug；本次验收采用 release。新增 assets / 字体后完整重启或重新构建。不要执行历史 `test/file_generator.dart` 或 `test/file_operation_test.dart`：它们使用旧目录并会写文件，不是测试套件。

## 2. 字体精简（原 Dart → FontTools 流程）

修复后的 `test/font_collection.dart` 收集全部 `lib/**/*.dart` 字符串、转义 Unicode 和 ASCII，不再读取已删除的文章目录，也不再使用 Windows 硬编码路径。`tool/subset_fonts.py` 用完整源字体生成子集并校验字符覆盖，避免反复裁剪子集导致新文案缺字。

### 第一次配置

```sh
python3 -m venv local/font-tools-env
local/font-tools-env/bin/python -m pip install fonttools==4.59.2
```

Windows 对应可执行文件为 `local/font-tools-env/Scripts/python.exe`。

### 每次修改文案后

```sh
dart run test/font_collection.dart
local/font-tools-env/bin/python tool/subset_fonts.py
local/font-tools-env/bin/python tool/subset_fonts.py --check
```

若 Flutter 不在 PATH，第二条增加 `--flutter-root /你的/Flutter/SDK/目录`。Windows 同样替换 Python 路径。外部动态文字应提前写入 `local/fonts/extra-characters.txt`，再执行上述流程；当前项目没有远程文章主入口。

- `local/fonts/fontcontent.txt`：自动生成字符清单，UTF-8纯文本。
- `local/fonts/source/`：完整源字体缓存，不进入发布包。WDXL 从 [Google Fonts 固定版本](https://github.com/google/fonts/tree/bf89c62d616373be66ef9cb28d970891dd48df02/ofl/wdxllubrifontsc) 获取；Roboto 从 Flutter 3.35.7 的 `bin/cache/artifacts/material_fonts/` 复制。脚本校验 SHA-256，不静默更换字体版本。
- `assets/fonts/`：生成后用于应用的字体子集及许可证。
- `local/fonts/subset-report.json`：每次实际字节数和字符覆盖记录。缺失字符或源字体校验失败时停止，不忽略错误继续发布。
- 旧 `pyftsubset NotoSansSC-Regular.otf --text-file=fontcontent.txt ...` 是同一流程的历史手动形式，当前使用 WDXL / Roboto，不再覆盖 Noto 或写入旧 E: 盘路径。

## 3. 测试与 release 预览

```sh
flutter test --no-pub test/widget_test.dart test/collections_test.dart test/font_collection_test.dart test/assets_test.dart test/video_test.dart test/navigation_test.dart
python3 -m unittest discover -s test -p 'preview_server_test.py'
flutter analyze --no-pub
flutter build web --no-pub --no-web-resources-cdn --release --pwa-strategy=none
python3 tool/preview_web.py --port 8765
```

打开 [本地预览](http://127.0.0.1:8765/)。旧 Service Worker 可能暂时显示旧版；检查 Application/Network，或改用未使用的端口核对新构建。Python 预览不模拟线上压缩、CDN 或完整缓存策略。

验收至少覆盖320/390/430手机、768平板、1280桌面及低高度横屏，检查导航、两个 Collections 按钮、Websites 选择与展开、中文阅读条目、音乐与视频入口。字体或图片调整不能只检查构建退出码。

静态分析仍有历史组件和旧脚本提示；不能将 `flutter analyze` 非零误写为全部通过。构建的 Wasm dry run 提示当前 Web API 不兼容属于已知限制，默认 JS release 可构建。

## 4. 更新本地发布产物与上线

本轮按要求保留 `docs/`。准备正式发布时：

1. 完成字体流程、回归测试和 release 页面验证。
2. 将 `build/web/` **完整替换**到 `docs/`，删除旧生成文件，核对 `CNAME`（来自 `web/CNAME`，若实际存在）和域名配置；不要只手改编码后的媒体文件名。
3. 预览 `docs/`，检查视频路径、外链、缓存更新和子路径。子路径构建需显式设置 `--base-href /子路径/` 并另行验证。
4. 检查 Git diff 后再提交/推送，由仓库 Pages 配置发布。本项目不自动执行这一步，也不要在 build/web 中初始化第二个 Git 仓库。
5. 回滚以先前已验证的完整提交/产物为单位，重新核对缓存版本，不只恢复某张图片。

旧 `--web-renderer html`、固定 CanvasKit 镜像及 Flutter 2.x 命令不适用于当前操作入口。

## 前轮 Collections 验收（2026-09-15）

- 17 项针对性测试通过：响应式布局、导航、链接失败重试、字体字符收集和图片引用完整性。
- JavaScript release 构建通过；Wasm 尚受现有 `dart:html` / `dart:js` 依赖限制。
- 字体覆盖检查通过（131 个所需字符），两个正文字体共 82,228 bytes，比本轮前减少 72.6%。
- 已检查 Collections 的桌面、平板、320/390px 手机与横屏，以及中文显示；保留第 3 种方案的深紫、月光插画与清晰的图文分区。
- 静态分析仍有 33 项历史诊断（4 warning、29 info），不代表工程已零警告。
- 仅清理源码图片；`docs/` 原有发布产物保持不变，本轮未发布网站。


## Edge 普通窗口图标排查

**证据**：用户确认Chrome、内置浏览器及Edge InPrivate均正常；Edge普通窗口曾缺失。线上 `main.dart.js`、`FontManifest.json`、Material Icons、启动脚本与Service Worker与本轮修改前的本地构建逐字节一致；字体包含六个导航图标。本轮通过Edge原生窗口复查时，普通窗口也已显示六个图标，期间未清缓存或改安全设置。因此目前定位为普通窗口环境问题，旧缓存优先，扩展仍需排除，不能声称已抓到唯一根因。

若复发，仅针对 `https://shadowplusing.website/` 检查：

1. 打开开发者工具 → Network，勾选 Disable cache；Application → Service Workers 勾选 Bypass for network，再刷新。记录 `assets/FontManifest.json`、`assets/fonts/MaterialIcons-Regular.otf` 的状态、来源与响应，不只检查HTTP 200。
2. 若这样恢复，使用Application移除本站旧Service Worker和Cache Storage，并清除此站的缓存文件；保留Cookies、密码和其他站点数据。完成后取消诊断用的Bypass/Disable cache。
3. 若绕过缓存仍异常，检查Console的字体解码/WebGL错误与扩展拦截记录，再与禁用扩展的新配置比较。不要默认关闭跟踪防护或浏览器安全功能。
4. 发布时整包更新，不混用新JS和旧字体。当前服务端字体响应观察到 `cache-control: max-age=86400`；若以后确认CDN旧缓存，Cloudflare应对入口、字体清单、Service Worker和未带内容哈希的字体采用重新验证策略，并定向清除这些URL的缓存。本轮不修改线上Cloudflare设置。

参考：[Flutter图标字体缓存问题](https://github.com/flutter/flutter/issues/136585)、[Edge缓存检查](https://learn.microsoft.com/en-us/microsoft-edge/devtools/storage/cache)。这些资料支持排查方法，不代替本项目复现证据。

## 视频维护与专项验收

- 在 `lib/innerAssets/videoAsset/videoData.dart` 添加稳定ID、显示标题、封面、ASCII站内文件路径、平台视频ID。不要再放整段iframe HTML，也不要让标题决定文件路径。
- 路由形式：`/#/videos/<id>`；直接刷新先构建Videos列表再显示播放视图，返回有明确落点。无效ID回到Videos列表。
- 修改依赖后若构建报已删除的 `video_player_web` 注册器错误，删除生成缓存 `.dart_tool/flutter_build/` 后重新构建；不修改 `docs/` 或SDK缓存。
- 本轮28项widget/数据测试通过，覆盖5种屏幕尺寸、放大文字、头像方圆动画、减少动画、失败重试、来源替换、返回焦点及路径规则；站内路径已在真实release产物验证。
- 全屏使用浏览器原生控制，无第二份Flutter全屏布尔状态；系统不支持时仍可内联播放。第三方iframe的load只表示文档加载，不等于媒体已可播放。

### 本轮实际验证（2026-09-15）

- Edge原生浏览器：站内播放、暂停、拖至1:15、2:27结束状态、原生全屏与Esc退出；浏览器返回恢复Videos，进入播放页暂停音乐，返回后不自动恢复。Bilibili、YouTube嵌入页面均能载入；不把iframe load当作平台视频播放成功证明。
- 真实404错误态已复现并截图，提供重试和换源。中文媒体名经Flutter构建后产生编码路径差异，现将源MP4重命名为ASCII，文件内容不变，封面改为真实画面的960px WebP（21,938 bytes，原PNG为1,043,478 bytes）。
- 320/390手机、768平板及844横屏均有Edge设备仿真截图；5种尺寸及放大文字另有widget回归。仿真不等于iOS真机验证。头像方圆过渡、减少动画和内容布局稳定性有测试覆盖，真实设备首次展开帧耗时尚未量化。
- `tool/preview_web.py` 支持HTTP Range，拖动验证不能使用不支持分段请求的简单HTTP服务器；对应Python回归覆盖200、206和416。
- 本轮捕获Flutter默认离线Service Worker的 `Cache.put: Partial response (status code 206) is unsupported`，并看到重复媒体请求。因此Flutter 3.35.7的推荐release命令使用 `--pwa-strategy=none`；本项目不提供离线播放保证。此项是已复现的媒体缓存问题，不能据此宣称Edge图标问题唯一根因已找到。
- `none`参数不保证已安装的旧Service Worker立即退出。正式整包更新时还需验证普通窗口升级，并按上节定向移除本站旧worker/cache；不要删除其他站点数据。当前仅本地构建，`docs/`和线上站点未更新。
- 当前[Flutter Web FAQ](https://docs.flutter.dev/platform-integration/web/faq)已不再推荐默认离线worker；本文命令以本机3.35.7的`flutter build web --help`为准。
