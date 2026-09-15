import 'package:flutter/material.dart';
import '../../global/videoWidget/videoCard.dart';
import '../../innerAssets/videoAsset/videoData.dart';

class IndexVideo extends StatelessWidget {
  const IndexVideo({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) =>
      LayoutBuilder(builder: (context, constraints) {
        final titles = VideoData.videoData.keys.toList();
        final compact = constraints.maxWidth < 600;
        Widget card(int index) => VideoCard(
            compact: compact,
            imageUrl: 'assets/image/video/${titles[index]}.png',
            videoName: titles[index],
            videoDescription: 'Choose a video source');
        if (compact) {
          return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: titles.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (_, index) => card(index));
        }
        return GridView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: titles.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount:
                    (constraints.maxWidth / 260).floor().clamp(2, 5),
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: .9),
            itemBuilder: (_, index) => card(index));
      });
}
