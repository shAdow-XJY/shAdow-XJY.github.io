import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
    _viewType = 'video-${DateTime.now().millisecondsSinceEpoch}';

    // 注册 HTML video
    ui.platformViewRegistry.registerViewFactory(_viewType, (int viewId) {
      final video = html.VideoElement()
        ..src = 'assets/video/${Uri.encodeComponent('${widget.title}.mp4')}'
        ..controls = true
        ..autoplay = false
        ..muted = false
        ..style.width = '100%'
        ..style.height = '100%';

      return video;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.black,
      insetPadding: const EdgeInsets.all(20),
      child: SizedBox(
        width: 320,
        height: 200,
        child: HtmlElementView(viewType: _viewType), // 桌面端可继续用 video_player
      ),
    );
  }
}
