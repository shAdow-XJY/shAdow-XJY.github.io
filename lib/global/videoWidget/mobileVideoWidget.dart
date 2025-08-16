import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:html' as html;
import 'dart:ui_web' as ui;
import 'package:responsive_builder/responsive_builder.dart'; // 确保已导入

class MobileVideoWidget extends StatefulWidget {
  final String title;
  const MobileVideoWidget({Key? key, required this.title}) : super(key: key);

  @override
  State<MobileVideoWidget> createState() => _MobileVideoWidgetState();
}

class _MobileVideoWidgetState extends State<MobileVideoWidget> {
  late String _viewType;
  bool _isViewFactoryRegistered = false;
  String? _constructedVideoUrl;
  bool _isLoading = true; // 新增：用于控制加载指示器的显示

  @override
  void initState() {
    super.initState();
    _viewType = 'html-video-player-${widget.key.toString()}-${DateTime.now().millisecondsSinceEpoch}';

    String videoPathSegment;
    const bool isProduction = bool.fromEnvironment('dart.vm.product');

    if (kIsWeb) {
      if (isProduction) {
        videoPathSegment = 'assets/assets/video/';
      } else {
        videoPathSegment = 'assets/video/';
      }

      // 假设 widget.title 是原始的、未编码的标题，例如 "夏日预告企划"
      String rawFileName = '${widget.title}.mp4'; // "夏日预告企划.mp4"

      // 第一次编码：将中文等特殊字符转换为 %xx 形式
      String singleEncodedFileName = Uri.encodeComponent(rawFileName);
      // singleEncodedFileName 现在是 "%E5%A4%8F%E6%97%A5%E9%A2%84%E5%91%8A%E4%BC%81%E5%88%92.mp4"

      // 第二次处理：如果 video_player 的成功 URL 是将第一次编码结果中的 '%' 替换为 '%25'
      // 那么我们需要手动进行这个替换，或者对 singleEncodedFileName 再次进行某种形式的编码，
      // 以达到 video_player 使用的 URL 格式。

      // 为了精确匹配 video_player 的行为，如果它真的是将 % 编码为 %25
      // 这通常意味着对一个已经编码的字符串又做了一次“组件”编码，
      // 或者更直接地，是对其中的 '%' 字符进行了替换。

      // 尝试模拟 video_player 的双重编码行为
      // 如果 video_player 的 dataSource 是通过对 singleEncodedFileName 再次 Uri.encodeComponent 得到的
      // (这很奇怪，但如果它工作了，我们就得尝试)
      // String doubleEncodedFileName = Uri.encodeComponent(singleEncodedFileName);
      // 这种做法会将 singleEncodedFileName 中的 % 编码成 %25，. 编码成 %2E 等，可能不是我们想要的。

      // 更可能是 video_player 在某个阶段生成的 URL 字符串就是 %25 开头的。
      // 如果GitHub Pages服务器上的文件名本身就含有 % (例如文件名是 "%E5%A4%8F...mp4")
      // 那么对这个文件名字符串进行 Uri.encodeComponent 就会把其中的 % 变成 %25.

      // 让我们基于这样一个假设：服务器上的文件名就是单次编码后的结果，
      // 即 `docs/assets/assets/video/` 目录下实际的文件名是 `%E5%A4%8F%E6%97%A5%E9%A2%84%E5%91%8A%E4%BC%81%E5%88%92.mp4`
      // 如果是这种情况，那么 video_player 在使用这个文件名作为路径的一部分时，
      // 如果它对这个文件名字符串又调用了 Uri.encodeComponent，就会导致 % -> %25。

      // 基于您的观察（video_player 成功的是 %25...），最直接的模拟是：
      String finalFileNameForRequest;
      if (isProduction) { // 假设只有生产环境的 video_player URL 是双重编码的
        // 对单次编码的结果中的每个 '%' 替换为 '%25'
        // 这是一种强制匹配 video_player 观察到的行为的方式
        finalFileNameForRequest = singleEncodedFileName.replaceAll('%', '%25');
      } else {
        finalFileNameForRequest = singleEncodedFileName; // 开发环境可能不需要双重编码
      }

      // 或者，如果 video_player 的逻辑是简单地对单次编码的结果再进行一次组件编码：
      // （再次强调，这对于标准的 URL 编码行为来说是不寻常的，但我们需要匹配工作的东西）
      // if (isProduction) {
      //     finalFileNameForRequest = Uri.encodeComponent(singleEncodedFileName);
      // } else {
      //     finalFileNameForRequest = singleEncodedFileName;
      // }


      _constructedVideoUrl = '$videoPathSegment$finalFileNameForRequest';

      print('Constructed video URL for HtmlElementView (Attempting double encoding like): $_constructedVideoUrl');

    } else {
      _constructedVideoUrl = null;
      print("HtmlElementView is not supported on non-web platforms for video playback here.");
      _isLoading = false;
    }

    if (kIsWeb && _constructedVideoUrl != null && !_isViewFactoryRegistered) {
      ui.platformViewRegistry.registerViewFactory(_viewType, (int viewId) {
        final videoElement = html.VideoElement()
          ..src = _constructedVideoUrl!
          ..controls = true
          ..autoplay = false
          ..muted = false
          ..style.width = '100%'
          ..style.height = '100%';

        // 监听视频是否可以开始播放，以隐藏加载指示器
        videoElement.onCanPlay.listen((_) {
          if (mounted) {
            setState(() {
              _isLoading = false;
            });
          }
        });
        // 也可以监听 error 事件
        videoElement.onError.listen((html.Event e) {
          if (mounted) {
            print("HTML Video Element Error: ${videoElement.error}");
            setState(() {
              _isLoading = false; // 出错也隐藏加载，并显示错误信息（如果需要）
            });
          }
        });


        return videoElement;
      });
      _isViewFactoryRegistered = true;
      // 注意：这里不再立即 setState，让 videoElement 的事件来驱动 _isLoading 的变化
    } else if (!kIsWeb) {
      if (mounted) {
        setState(() {
          _isLoading = false; //确保非web平台也更新loading状态
        });
      }
    }
    // 如果URL构建失败，也应该更新loading状态
    if (kIsWeb && _constructedVideoUrl == null && mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        EdgeInsets padding; // 使用 EdgeInsets 而不是 var
        if (sizingInformation.deviceScreenType == DeviceScreenType.desktop ||
            sizingInformation.deviceScreenType == DeviceScreenType.tablet) {
          padding = const EdgeInsets.symmetric(
            vertical: 50.0,
            horizontal: 100.0,
          );
        } else { // Mobile
          padding = const EdgeInsets.symmetric(
            vertical: 80.0, // 可以根据需要微调
            horizontal: 10.0,
          );
        }

        Widget content;

        if (!kIsWeb || _constructedVideoUrl == null) {
          content = const Center(
            child: Text(
              kIsWeb ? "Video URL could not be constructed." : "Video playback not supported on this platform.",
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
          );
        } else if (!_isViewFactoryRegistered && kIsWeb) { // 确保在注册前显示加载
          content = const Center(child: CircularProgressIndicator(color: Colors.purple));
        }
        else {
          content = Stack(
            alignment: Alignment.center, // 确保 Stack 内的子组件也居中
            children: [
              Center( // 确保 AspectRatio 居中
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: HtmlElementView(viewType: _viewType),
                ),
              ),
              // if (_isLoading) // 使用新的 _isLoading 状态
              //   const Center(
              //     child: CircularProgressIndicator(
              //       color: Colors.purple, // 与您的示例一致
              //       // backgroundColor: Colors.purple, // 如果想用背景色
              //     ),
              //   ),
            ],
          );
        }

        return Dialog(
          backgroundColor: Colors.black,
          insetPadding: padding, // 使用 ResponsiveBuilder 计算的 padding
          child: content,
        );
      },
    );
  }
}