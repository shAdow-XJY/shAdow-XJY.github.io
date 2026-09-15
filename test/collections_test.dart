import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_blog/indexPage/indexProgram/indexProgram.dart';

void main() {
  for (final size in [
    const Size(320, 568),
    const Size(390, 844),
    const Size(768, 1024),
    const Size(1280, 900),
    const Size(844, 390)
  ]) {
    testWidgets('Both collections remain reachable at $size', (tester) async {
      tester.view.devicePixelRatio = 1;
      tester.view.physicalSize = size;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await tester.pumpWidget(MaterialApp(
          home: MediaQuery(
              data: MediaQueryData(
                  size: size,
                  textScaler: TextScaler.linear(size.width == 320 ? 1.5 : 1)),
              child: const Scaffold(body: IndexProgram()))));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      final first =
          tester.getTopLeft(find.byKey(const ValueKey('collection-0')));
      final second =
          tester.getTopLeft(find.byKey(const ValueKey('collection-1')));
      if (size.width < 760) {
        expect(second.dy, greaterThan(first.dy));
      } else {
        expect(second.dx, greaterThan(first.dx));
        expect(second.dy, first.dy);
      }
      await tester
          .ensureVisible(find.byKey(const ValueKey('open-collection-1')));
      await tester.pumpAndSettle();
      expect(find.text('Open reading space'), findsOneWidget);
      expect(tester.takeException(), isNull);
      await tester.pumpWidget(const SizedBox());
      await tester.pump(const Duration(seconds: 4));
      expect(tester.takeException(), isNull);
    });
  }
  testWidgets('Collection launch failure offers retry for the same destination',
      (tester) async {
    const channel = MethodChannel('plugins.flutter.io/url_launcher');
    final launches = <String>[];
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (call) async {
      if (call.method == 'launch') {
        launches.add(call.arguments['url'] as String);
        return false;
      }
      return true;
    });
    addTearDown(() => TestDefaultBinaryMessengerBinding
        .instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null));
    await tester
        .pumpWidget(const MaterialApp(home: Scaffold(body: IndexProgram())));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.byKey(const ValueKey('open-collection-0')));
    await tester.tap(find.byKey(const ValueKey('open-collection-0')));
    await tester.pumpAndSettle();
    expect(find.text('Could not open this collection. Please try again.'),
        findsOneWidget);
    await tester.tap(find.text('Retry'));
    await tester.pumpAndSettle();
    expect(launches, [collectionEntries[0].url, collectionEntries[0].url]);
  });
}
