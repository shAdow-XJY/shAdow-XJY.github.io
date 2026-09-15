import 'package:flutter/material.dart';
import '../../innerAssets/videoAsset/videoData.dart';

class VideoSurface extends StatelessWidget {
  const VideoSurface({
    super.key,
    required this.video,
    required this.source,
    required this.onStatus,
  });
  final VideoEntry video;
  final VideoSource source;
  final ValueChanged<String> onStatus;
  @override
  Widget build(BuildContext context) => const ColoredBox(
    color: Colors.black,
    child: Center(child: Text('Open in a web browser to play.')),
  );
}
