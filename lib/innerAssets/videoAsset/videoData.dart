enum VideoSource { local, bilibili, youtube }

extension VideoSourceLabel on VideoSource {
  String get label => switch (this) {
    VideoSource.local => 'On this site',
    VideoSource.bilibili => 'Bilibili',
    VideoSource.youtube => 'YouTube',
  };
}

class VideoEntry {
  const VideoEntry({
    required this.id,
    required this.title,
    required this.cover,
    required this.asset,
    required this.youtubeId,
    required this.bilibiliId,
  });
  final String id;
  final String title;
  final String cover;
  final String asset;
  final String youtubeId;
  final String bilibiliId;

  Uri embedUrl(VideoSource source) => source == VideoSource.youtube
      ? Uri.https('www.youtube.com', '/embed/$youtubeId', {'autoplay': '0'})
      : Uri.https('player.bilibili.com', '/player.html', {
          'bvid': bilibiliId,
          'p': '1',
          'autoplay': '0',
        });
  Uri originalUrl(VideoSource source) => source == VideoSource.youtube
      ? Uri.https('www.youtube.com', '/watch', {'v': youtubeId})
      : Uri.https('www.bilibili.com', '/video/$bilibiliId/');
}

const videos = [
  VideoEntry(
    id: 'summer-preview',
    title: '夏日预告企划',
    cover: 'assets/image/video/summer-preview.webp',
    asset: 'assets/video/summer-preview.mp4',
    youtubeId: 'ZI-GnWGzAMo',
    bilibiliId: 'BV1gT4y1k7dz',
  ),
];

VideoEntry? videoById(String id) {
  for (final video in videos) {
    if (video.id == id) return video;
  }
  return null;
}

// Flutter serves asset keys beneath assets/ in both debug and release.
// Media uses ASCII filenames: Flutter percent-escapes non-ASCII output names.
// Display titles are independent of filenames; no debug/release encoding branches.
Uri videoAssetUrl(Uri base, String asset) =>
    base.resolveUri(Uri(path: 'assets/$asset'));
