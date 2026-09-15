import 'dart:async';
import 'dart:html' as html;
import 'package:flutter/material.dart';
import '../../innerAssets/videoAsset/videoData.dart';

class VideoSurface extends StatefulWidget {
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
  State<VideoSurface> createState() => _VideoSurfaceState();
}

class _VideoSurfaceState extends State<VideoSurface> {
  final _subscriptions = <StreamSubscription<dynamic>>[];
  html.VideoElement? _video;
  html.IFrameElement? _frame;
  html.Element? _host;
  Timer? _timeout;
  bool _disposed = false;

  void _status(String value) {
    if (_disposed) return;
    // Platform creation can occur while Flutter is building the platform view.
    scheduleMicrotask(() {
      if (mounted && !_disposed) widget.onStatus(value);
    });
  }

  void _create(Object object) {
    if (_disposed) return;
    final host = object as html.Element;
    _host = host;
    host.style
      ..width = '100%'
      ..height = '100%'
      ..backgroundColor = '#000';
    _timeout = Timer(const Duration(seconds: 15), () => _status('timeout'));
    if (widget.source == VideoSource.local) {
      final video = html.VideoElement()
        ..controls = true
        ..autoplay = false
        ..preload = 'metadata'
        ..setAttribute('playsinline', '')
        ..setAttribute('aria-label', widget.video.title)
        ..poster = videoAssetUrl(
          Uri.parse(html.document.baseUri!),
          widget.video.cover,
        ).toString();
      _video = video;
      video.style
        ..width = '100%'
        ..height = '100%'
        ..objectFit = 'contain';
      _subscriptions.addAll([
        video.onLoadedMetadata.listen((_) {
          _status('loading');
        }),
        video.onCanPlay.listen((_) {
          _timeout?.cancel();
          _status(video.paused ? 'ready' : 'playing');
        }),
        video.onPlaying.listen((_) {
          _timeout?.cancel();
          _status('playing');
        }),
        video.onPause.listen((_) => _status('paused')),
        video.onWaiting.listen((_) => _status('buffering')),
        video.onEnded.listen((_) => _status('ended')),
        video.onError.listen((_) {
          _timeout?.cancel();
          _status('error');
        }),
      ]);
      video.src = videoAssetUrl(
        Uri.parse(html.document.baseUri!),
        widget.video.asset,
      ).toString();
      host.append(video);
    } else {
      final frame = html.IFrameElement()
        ..title = '${widget.video.title} · ${widget.source.label}'
        ..allowFullscreen = true
        ..setAttribute(
          'allow',
          'fullscreen; encrypted-media; picture-in-picture',
        )
        ..setAttribute('referrerpolicy', 'strict-origin-when-cross-origin');
      _frame = frame;
      frame.style
        ..width = '100%'
        ..height = '100%'
        ..border = '0';
      _subscriptions.addAll([
        frame.onLoad.listen((_) {
          _timeout?.cancel();
          _status('embedded');
        }),
        frame.onError.listen((_) {
          _timeout?.cancel();
          _status('error');
        }),
      ]);
      frame.src = widget.video.embedUrl(widget.source).toString();
      host.append(frame);
    }
  }

  @override
  void dispose() {
    _disposed = true;
    _timeout?.cancel();
    for (final sub in _subscriptions) {
      sub.cancel();
    }
    final video = _video;
    if (video != null) {
      video.pause();
      video.removeAttribute('src');
      video.load();
      video.remove();
    }
    if (_frame != null) {
      _frame!.src = 'about:blank';
      _frame!.remove();
    }
    _host?.children.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      HtmlElementView.fromTagName(tagName: 'div', onElementCreated: _create);
}
