import 'package:flutter/material.dart';
import '../../global/siteStyle.dart';
import '../../innerAssets/videoAsset/videoData.dart';

class IndexVideo extends StatefulWidget {
  const IndexVideo({Key? key, this.onOpen}) : super(key: key);
  final Future<void> Function(VideoEntry)? onOpen;
  @override
  State<IndexVideo> createState() => _IndexVideoState();
}

class _IndexVideoState extends State<IndexVideo> {
  final _focus = {for (final video in videos) video.id: FocusNode()};
  bool _opening = false;

  Future<void> _open(VideoEntry video) async {
    if (_opening) return;
    _opening = true;
    try {
      if (widget.onOpen != null) {
        await widget.onOpen!(video);
      } else {
        await Navigator.of(context).pushNamed('/videos/${video.id}');
      }
    } finally {
      _opening = false;
      if (mounted) _focus[video.id]!.requestFocus();
    }
  }

  @override
  void dispose() {
    for (final node in _focus.values) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, box) {
      final compact = box.maxWidth < 600;
      final largeText = MediaQuery.textScalerOf(context).scale(16) > 22;
      final padding = compact ? 16.0 : 32.0;
      final width = (box.maxWidth - padding * 2).clamp(0.0, 1120.0);
      final columns = compact ? 1 : (width / 300).floor().clamp(1, 3);
      final cardWidth = (width - (columns - 1) * 24) / columns;
      return SingleChildScrollView(
        key: const PageStorageKey('video-list'),
        padding: EdgeInsets.all(padding),
        child: Align(
          alignment: Alignment.topCenter,
          child: SizedBox(
            width: width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (MediaQuery.sizeOf(context).width >= 700) ...[
                  Text('Videos', style: siteHeading.copyWith(fontSize: 36)),
                  const SizedBox(height: 8),
                ],
                const Text(
                  'Small moments, captured in motion.',
                  style: siteBody,
                ),
                const SizedBox(height: 28),
                Wrap(
                  spacing: 24,
                  runSpacing: 24,
                  children: [
                    for (final video in videos)
                      SizedBox(
                        width: cardWidth,
                        child: Material(
                          color: siteSurface,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                            side: const BorderSide(color: siteDivider),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: InkWell(
                            key: ValueKey('video-${video.id}'),
                            focusNode: _focus[video.id],
                            onTap: () => _open(video),
                            focusColor: siteAccent.withValues(alpha: .25),
                            hoverColor: siteAccent.withValues(alpha: .1),
                            child: compact && !largeText
                                ? Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 112,
                                          child: _cover(video),
                                        ),
                                        const SizedBox(width: 16),
                                        Expanded(
                                          child: _caption(video, compact: true),
                                        ),
                                      ],
                                    ),
                                  )
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      _cover(video),
                                      Padding(
                                        padding: const EdgeInsets.all(20),
                                        child: _caption(video),
                                      ),
                                    ],
                                  ),
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );

  Widget _cover(VideoEntry video) => AspectRatio(
    aspectRatio: 16 / 9,
    child: Image.asset(
      video.cover,
      fit: BoxFit.cover,
      cacheWidth: 960,
      excludeFromSemantics: true,
    ),
  );
  Widget _caption(VideoEntry video, {bool compact = false}) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        video.title,
        style: siteHeading.copyWith(fontSize: compact ? 20 : 26),
      ),
      const SizedBox(height: 12),
      Row(
        children: [
          const Icon(
            Icons.play_circle_outline,
            size: 22,
            color: Color(0xFFB69AFF),
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              'Watch video',
              style: siteBody.copyWith(color: const Color(0xFFE7E2FA)),
            ),
          ),
        ],
      ),
    ],
  );
}
