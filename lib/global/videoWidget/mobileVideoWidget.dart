import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'dart:html' as html;
import 'dart:ui_web' as ui;

class MobileVideoWidget extends StatefulWidget {
  final String title;
  const MobileVideoWidget({Key? key, required this.title}) : super(key: key);

  @override
  State<MobileVideoWidget> createState() => _MobileVideoWidgetState();
}

class _MobileVideoWidgetState extends State<MobileVideoWidget> {
  late String _viewType;
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _viewType = 'video-${DateTime.now().millisecondsSinceEpoch}';

    // 初始化 VideoPlayerController 来获取正确的 assets 路径
    _controller = VideoPlayerController.asset('assets/video/${Uri.encodeComponent('${widget.title}.mp4')}')
      ..initialize().then((_) {
        // 获取视频路径并注册 VideoElement
        final videoUrl = _controller.dataSource; // 获取 assets 的 URL
        ui.platformViewRegistry.registerViewFactory(_viewType, (int viewId) {
          final video = html.VideoElement()
            ..src = videoUrl // 使用从 VideoPlayerController 获取的路径
            ..controls = true
            ..autoplay = false
            ..muted = false
            ..style.width = '100%'
            ..style.height = '100%';
          return video;
        });
        setState(() {}); // 刷新 UI
      });
  }

  @override
  void dispose() {
    _controller.dispose(); // 清理 VideoPlayerController
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.black,
      insetPadding: const EdgeInsets.all(20),
      child: SizedBox(
        width: 320,
        height: 200,
        child: _controller.value.isInitialized
            ? HtmlElementView(viewType: _viewType)
            : const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}