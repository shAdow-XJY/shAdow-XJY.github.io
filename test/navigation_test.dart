import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_blog/global/navigation/siteNavigation.dart';

void main() {
  testWidgets(
    'Avatar interpolates from square to circle and handles short screens',
    (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 152,
              child: SiteNavigation(selectedIndex: 0, onSelected: (_) {}),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      final avatar = find.byKey(const ValueKey('navigation-avatar'));
      expect(tester.getSize(avatar), const Size(88, 88));
      expect(
        (tester.widget<AnimatedContainer>(avatar).decoration as BoxDecoration)
            .borderRadius,
        BorderRadius.zero,
      );
      await tester.tap(find.byKey(const ValueKey('navigation-toggle')));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 90));
      expect(tester.getSize(avatar).width, inExclusiveRange(40, 88));
      await tester.pumpAndSettle();
      expect(tester.getSize(avatar), const Size(40, 40));
      expect(
        (tester.widget<AnimatedContainer>(avatar).decoration as BoxDecoration)
            .borderRadius,
        BorderRadius.circular(20),
      );
      tester.view.physicalSize = const Size(844, 390);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await tester.pumpAndSettle();
      await tester.scrollUntilVisible(find.byKey(const ValueKey('nav-5')), 100);
      expect(tester.takeException(), isNull);
    },
  );
  testWidgets(
    'Reduced motion switches avatar without animated intermediate size',
    (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(disableAnimations: true),
            child: Scaffold(
              body: SizedBox(
                width: 152,
                child: SiteNavigation(selectedIndex: 0, onSelected: (_) {}),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const ValueKey('navigation-toggle')));
      await tester.pump();
      expect(
        tester.getSize(find.byKey(const ValueKey('navigation-avatar'))),
        const Size(40, 40),
      );
    },
  );
}
