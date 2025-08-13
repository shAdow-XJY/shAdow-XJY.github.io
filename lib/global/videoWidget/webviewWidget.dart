import 'dart:ui_web' as ui; // 新导入，替代 platformViewRegistry
import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../innerAssets/videoAsset/videoData.dart';

class WebviewWidget extends StatefulWidget {
  final String title;
  final int source; // 1: youtube; 2: bilibili

  const WebviewWidget({
    Key? key,
    required this.title,
    required this.source,
  }) : super(key: key);

  @override
  State<WebviewWidget> createState() => _WebviewWidgetState();
}

class _WebviewWidgetState extends State<WebviewWidget> {
  late String viewType;
  bool loading = true;

  @override
  void initState() {
    super.initState();

    final videoUrls = VideoData.videoData[widget.title];
    String iframeHtml = '';
    if (videoUrls != null) {
      iframeHtml = widget.source == 1
          ? (videoUrls['youtube'] ?? '')
          : (videoUrls['bilibili'] ?? '');
    }

    if (iframeHtml.isEmpty) {
      iframeHtml = '<p style="color:white;">视频未找到</p>';
    }

    // 生成唯一 viewType
    viewType = 'iframe_${DateTime.now().millisecondsSinceEpoch}';

    // 注册 HTML iframe
    ui.platformViewRegistry.registerViewFactory(
      viewType,
          (int viewId) {
        final element = html.DivElement()
          ..setInnerHtml(
            iframeHtml,
            validator: html.NodeValidatorBuilder.common()
              ..allowElement('iframe', attributes: [
                'src',
                'style',
                'frameborder',
                'allow',
                'allowfullscreen',
                'scrolling',
                'referrerpolicy'
              ])
              ..allowHtml5(),
          )
          ..style.width = '100%'
          ..style.height = '100%';

        Future.delayed(const Duration(milliseconds: 300), () {
          if (mounted) {
            setState(() => loading = false);
          }
        });

        return element;
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        var padding = const EdgeInsets.symmetric(
          vertical: 50.0,
          horizontal: 100.0,
        );
        if (sizingInformation.deviceScreenType == DeviceScreenType.mobile) {
          padding = const EdgeInsets.symmetric(
            vertical: 100.0,
            horizontal: 5.0,
          );
        }

        return Dialog(
          backgroundColor: Colors.black,
          insetPadding: padding,
          child: Stack(
            children: [
              // 居中 + 16:9 宽高比
              Center(
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: HtmlElementView(viewType: viewType),
                ),
              ),
              if (loading)
                const Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.purple,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}