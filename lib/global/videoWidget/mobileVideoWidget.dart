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
      _constructedVideoUrl = '$videoPathSegment${Uri.encodeComponent('${widget.title}.mp4')}';
      print('Constructed video URL for HtmlElementView: $_constructedVideoUrl');
    } else {
      _constructedVideoUrl = null;
      print("HtmlElementView is not supported on non-web platforms for video playback here.");
      _isLoading = false; // 非 web 平台，直接标记加载完成（或错误）
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
          content = Center(
            child: Text(
              kIsWeb ? "Video URL could not be constructed." : "Video playback not supported on this platform.",
              style: const TextStyle(color: Colors.white),
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
              if (_isLoading) // 使用新的 _isLoading 状态
                const Center(
                  child: CircularProgressIndicator(
                    color: Colors.purple, // 与您的示例一致
                    // backgroundColor: Colors.purple, // 如果想用背景色
                  ),
                ),
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