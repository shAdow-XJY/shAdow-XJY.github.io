import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_blog/global/videoWidget/videoSurface.dart';
import 'package:github_blog/indexPage/indexVideo/indexVideo.dart';
import 'package:github_blog/indexPage/indexVideo/videoWatch.dart';
import 'package:github_blog/innerAssets/videoAsset/videoData.dart';
import 'package:github_blog/router/router.dart';
import 'package:github_blog/homepage/homePage.dart';

void main() {
  testWidgets('Selecting a mobile drawer section exits the watch route', (
    tester,
  ) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(390, 844);
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(
      const MaterialApp(
        initialRoute: '/videos/summer-preview',
        onGenerateInitialRoutes: initialRoutes,
        onGenerateRoute: onGenerateRoute,
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Open navigation menu'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('nav-2')));
    await tester.pumpAndSettle();
    expect(find.byType(VideoWatch), findsNothing);
    expect(find.byType(HomePage), findsOneWidget);
    expect(find.text('Websites'), findsWidgets);
    expect(tester.takeException(), isNull);
  });
  test('Raw video assets resolve once against root or deployment subpath', () {
    for (final prefix in ['/', '/blog/']) {
      final url = videoAssetUrl(
        Uri.parse('https://example.com$prefix'),
        videos.first.asset,
      );
      expect(
        Uri.decodeComponent(url.path),
        '${prefix}assets/${videos.first.asset}',
      );
      expect(
        url.toString(),
        endsWith('/assets/assets/video/summer-preview.mp4'),
      );
      expect(url.toString(), isNot(contains('%')));
    }
    for (final video in videos) {
      expect(
        RegExp(r'^[a-zA-Z0-9_./-]+$').hasMatch(video.asset),
        isTrue,
        reason: 'Media filenames must remain ASCII across Flutter build modes',
      );
    }
    expect(videoById('unknown'), isNull);
    expect(
      videos.first.originalUrl(VideoSource.youtube).host,
      'www.youtube.com',
    );
    expect(
      videos.first.embedUrl(VideoSource.bilibili).queryParameters['autoplay'],
      '0',
    );
  });

  for (final size in [
    const Size(320, 568),
    const Size(390, 844),
    const Size(768, 1024),
    const Size(1280, 900),
    const Size(844, 390),
  ]) {
    testWidgets('List, watch and return at $size', (tester) async {
      tester.view.devicePixelRatio = 1;
      tester.view.physicalSize = size;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await tester.pumpWidget(
        MaterialApp(
          builder: (context, child) => MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaler: TextScaler.linear(size.width == 320 ? 1.6 : 1),
            ),
            child: child!,
          ),
          home: const Scaffold(body: IndexVideo()),
          onGenerateRoute: (settings) => MaterialPageRoute(
            settings: settings,
            builder: (_) => Scaffold(body: VideoWatch(video: videos.first)),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      await tester.ensureVisible(
        find.byKey(const ValueKey('video-summer-preview')),
      );
      await tester.tap(find.byKey(const ValueKey('video-summer-preview')));
      await tester.pumpAndSettle();
      expect(find.byType(VideoWatch), findsOneWidget);
      expect(
        tester.widget<VideoSurface>(find.byType(VideoSurface)).source,
        VideoSource.local,
      );
      await tester.ensureVisible(find.byKey(const ValueKey('source-youtube')));
      await tester.tap(find.byKey(const ValueKey('source-youtube')));
      await tester.pumpAndSettle();
      expect(
        tester.widget<VideoSurface>(find.byType(VideoSurface)).source,
        VideoSource.youtube,
      );
      expect(find.text('Open original'), findsOneWidget);
      expect(tester.takeException(), isNull);
      await tester.ensureVisible(find.byKey(const ValueKey('back-to-videos')));
      await tester.tap(find.byKey(const ValueKey('back-to-videos')));
      await tester.pumpAndSettle();
      expect(find.byType(VideoWatch), findsNothing);
      final card = tester.widget<InkWell>(
        find.byKey(const ValueKey('video-summer-preview')),
      );
      expect(card.focusNode!.hasFocus, isTrue);
    });
  }

  testWidgets('Failure, retry and source changes replace the media surface', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: VideoWatch(video: videos.first)),
      ),
    );
    await tester.pumpAndSettle();
    var surface = tester.widget<VideoSurface>(find.byType(VideoSurface));
    final firstKey = surface.key;
    surface.onStatus('error');
    await tester.pumpAndSettle();
    expect(find.textContaining('could not load'), findsOneWidget);
    await tester.ensureVisible(find.byKey(const ValueKey('retry-video')));
    await tester.tap(find.byKey(const ValueKey('retry-video')));
    await tester.pumpAndSettle();
    surface = tester.widget<VideoSurface>(find.byType(VideoSurface));
    expect(surface.key, isNot(firstKey));
    expect(surface.source, VideoSource.local);
    surface.onStatus('timeout');
    await tester.pumpAndSettle();
    expect(find.textContaining('longer than expected'), findsOneWidget);
    await tester.ensureVisible(find.byKey(const ValueKey('source-bilibili')));
    await tester.tap(find.byKey(const ValueKey('source-bilibili')));
    await tester.pumpAndSettle();
    surface = tester.widget<VideoSurface>(find.byType(VideoSurface));
    expect(surface.source, VideoSource.bilibili);
    surface.onStatus('embedded');
    await tester.pumpAndSettle();
    expect(find.textContaining('If playback is unavailable'), findsOneWidget);
    expect(find.byKey(const ValueKey('retry-video')), findsNothing);
    await tester.pumpWidget(const SizedBox());
    await tester.pump(const Duration(seconds: 20));
    expect(tester.takeException(), isNull);
  });

  test(
    'Video deep links have a Videos list beneath them for back navigation',
    () {
      final routes = initialRoutes('/videos/summer-preview');
      expect(routes.length, 2);
      expect(routes.last.settings.name, '/videos/summer-preview');
      expect(initialRoutes('/videos/unknown').length, 1);
    },
  );
}
