import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../global/siteStyle.dart';
import '../../global/videoWidget/videoSurface.dart';
import '../../innerAssets/videoAsset/videoData.dart';

class VideoWatch extends StatefulWidget {
  const VideoWatch({super.key, required this.video});
  final VideoEntry video;
  @override
  State<VideoWatch> createState() => _VideoWatchState();
}

class _VideoWatchState extends State<VideoWatch> {
  VideoSource _source = VideoSource.local;
  String _status = 'loading';
  int _attempt = 0;

  void _change(VideoSource source) => setState(() {
    _source = source;
    _status = 'loading';
    _attempt++;
  });

  Future<void> _original() async {
    try {
      if (await launchUrl(
        widget.video.originalUrl(_source),
        mode: LaunchMode.externalApplication,
      )) {
        return;
      }
    } catch (_) {
      /* The actionable message below also covers blocked popups. */
    }
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Could not open the original video. Please try again.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, box) {
      final failed = _status == 'error' || _status == 'timeout';
      final message = switch (_status) {
        'loading' => 'Loading video…',
        'buffering' => 'Buffering…',
        'ready' => 'Ready when you are. Press play to begin.',
        'playing' => 'Playing',
        'paused' => 'Paused',
        'ended' => 'Finished. You can replay or return to Videos.',
        'embedded' =>
          'Player loaded. If playback is unavailable, switch source or open the original.',
        'timeout' =>
          'This source is taking longer than expected. Retry or choose another source.',
        _ => 'This video could not load. Retry or choose another source.',
      };
      return SingleChildScrollView(
        padding: EdgeInsets.all(box.maxWidth < 600 ? 16 : 32),
        child: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1120),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextButton.icon(
                  key: const ValueKey('back-to-videos'),
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Back to Videos'),
                ),
                const SizedBox(height: 16),
                Text(
                  widget.video.title,
                  style: siteHeading.copyWith(fontSize: 32),
                ),
                const SizedBox(height: 24),
                ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: VideoSurface(
                      key: ValueKey(
                        '${widget.video.id}-${_source.name}-$_attempt',
                      ),
                      video: widget.video,
                      source: _source,
                      onStatus: (value) {
                        if (mounted) setState(() => _status = value);
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    for (final source in VideoSource.values)
                      ChoiceChip(
                        key: ValueKey('source-${source.name}'),
                        label: Text(source.label),
                        selected: _source == source,
                        selectedColor: siteSelected,
                        onSelected: (selected) {
                          if (selected && _source != source) _change(source);
                        },
                      ),
                  ],
                ),
                const SizedBox(height: 16),
                Semantics(
                  liveRegion: failed,
                  child: Text(
                    message,
                    key: const ValueKey('video-status'),
                    style: siteBody,
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 12,
                  runSpacing: 8,
                  children: [
                    if (failed)
                      OutlinedButton.icon(
                        key: const ValueKey('retry-video'),
                        onPressed: () => _change(_source),
                        icon: const Icon(Icons.refresh),
                        label: const Text('Retry'),
                      ),
                    if (_source != VideoSource.local)
                      TextButton.icon(
                        onPressed: _original,
                        icon: const Icon(Icons.open_in_new),
                        label: const Text('Open original'),
                      ),
                  ],
                ),
                const SizedBox(height: 24),
                const Divider(color: siteDivider),
                const SizedBox(height: 16),
                const Text(
                  'A small moment, worth another look.',
                  style: siteBody,
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
