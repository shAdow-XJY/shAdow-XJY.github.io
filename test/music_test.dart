import 'package:flutter_test/flutter_test.dart';
import 'package:github_blog/global/musicPlayer.dart';

void main() {
  test('Music URLs preserve the deployment host and exclude hash routes', () {
    const asset = 'assets/music/KoheiTanaka_BeyondtheHappyEnd.mp3';
    for (final prefix in ['/', '/blog/']) {
      for (final route in ['', '#/', '#/homePage', '#/videos/summer-preview']) {
        final base = Uri.parse('https://shadowplusing.website$prefix$route');
        final url = musicAssetUrl(base, asset);
        expect(
          url.toString(),
          'https://shadowplusing.website${prefix}assets/$asset',
        );
        expect(url.host, 'shadowplusing.website');
        expect(url.fragment, isEmpty);
      }
    }
    expect(
      musicAssetUrl(
        Uri.parse(
          'https://shadowplusing.website/blog/index.html?v=1#/homePage',
        ),
        asset,
      ).toString(),
      'https://shadowplusing.website/blog/assets/$asset',
    );
  });
}
