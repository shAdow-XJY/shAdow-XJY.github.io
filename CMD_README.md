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
flutter test --no-pub test/widget_test.dart test/collections_test.dart test/font_collection_test.dart test/assets_test.dart
flutter analyze --no-pub
flutter build web --no-pub --no-web-resources-cdn --release
flutter build web --no-pub --release
python3 -m http.server 8765 --bind 127.0.0.1 --directory build/web
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

## 本次验收（2026-09-15）

- 17 项针对性测试通过：响应式布局、导航、链接失败重试、字体字符收集和图片引用完整性。
- JavaScript release 构建通过；Wasm 尚受现有 `dart:html` / `dart:js` 依赖限制。
- 字体覆盖检查通过（131 个所需字符），两个正文字体共 82,228 bytes，比本轮前减少 72.6%。
- 已检查 Collections 的桌面、平板、320/390px 手机与横屏，以及中文显示；保留第 3 种方案的深紫、月光插画与清晰的图文分区。
- 静态分析仍有 33 项历史诊断（4 warning、29 info），不代表工程已零警告。
- 仅清理源码图片；`docs/` 原有发布产物保持不变，本轮未发布网站。
