import 'dart:ui' show SemanticsAction;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_blog/indexPage/indexBook/indexBook.dart';
import 'package:github_blog/global/navigation/siteNavigation.dart';

void main() {
  Future<void> showProjects(WidgetTester tester, Size size,
      {double scale = 1}) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = size;
    await tester.pumpWidget(MaterialApp(
        home: MediaQuery(
            data: MediaQueryData(
                size: size, textScaler: TextScaler.linear(scale)),
            child: const Scaffold(body: IndexBook()))));
    await tester.pumpAndSettle();
  }

  for (final width in [320.0, 360.0, 390.0, 430.0, 768.0, 1280.0]) {
    testWidgets('Projects remain usable at width $width', (tester) async {
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await showProjects(tester, Size(width, 844));
      expect(tester.takeException(), isNull);
      final lastProject = find.byKey(const ValueKey('project-4'));
      await tester.scrollUntilVisible(lastProject, 180,
          scrollable: find.byType(Scrollable).first);
      await tester.pumpAndSettle();
      await tester.ensureVisible(lastProject);
      await tester.tap(lastProject);
      await tester.pumpAndSettle();
      await tester.ensureVisible(find.byKey(const ValueKey('open-project')));
      expect(find.text(websiteProjects[4].description), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets(
      'Accordion collapses and selected project survives responsive round trip',
      (tester) async {
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await showProjects(tester, const Size(1280, 800));
    await tester.tap(find.byKey(const ValueKey('project-1')));
    await tester.pumpAndSettle();
    await showProjects(tester, const Size(390, 844));
    expect(find.text(websiteProjects[1].description), findsOneWidget);
    final handle = tester.ensureSemantics();
    final data = tester
        .getSemantics(find.byKey(const ValueKey('project-semantics-1')))
        .getSemanticsData();
    expect(data.hasAction(SemanticsAction.tap), isTrue);
    expect(data.flagsCollection.isExpanded, isTrue);
    handle.dispose();
    await tester.tap(find.byKey(const ValueKey('project-1')));
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('open-project')), findsNothing);
    await tester.tap(find.byKey(const ValueKey('project-1')));
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('open-project')), findsOneWidget);
    await showProjects(tester, const Size(1280, 800));
    expect(find.text(websiteProjects[1].description), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Large text and short landscape can scroll to the last project',
      (tester) async {
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await showProjects(tester, const Size(320, 568), scale: 1.6);
    expect(tester.takeException(), isNull);
    await showProjects(tester, const Size(772, 302));
    await tester.scrollUntilVisible(
        find.byKey(const ValueKey('project-4')), 160);
    await tester.tap(find.byKey(const ValueKey('project-4')));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.byKey(const ValueKey('open-project')));
    expect(tester.takeException(), isNull);
  });

  testWidgets(
      'Sidebar animation leaves content constraints unchanged and supports keyboard',
      (tester) async {
    var layouts = 0;
    var selected = -1;
    await tester.pumpWidget(MaterialApp(
        home: Scaffold(
            body: Stack(children: [
      Positioned.fill(
          left: 72,
          child: LayoutBuilder(builder: (_, constraints) {
            layouts++;
            return const ColoredBox(
                key: ValueKey('content'), color: Colors.black);
          })),
      Positioned(
          left: 0,
          top: 0,
          bottom: 0,
          width: 220,
          child: SiteNavigation(
              wide: false, selectedIndex: 2, onSelected: (i) => selected = i)),
    ]))));
    final initialLayouts = layouts;
    final initialSize = tester.getSize(find.byKey(const ValueKey('content')));
    await tester.tap(find.byKey(const ValueKey('navigation-toggle')));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 90));
    expect(tester.getSize(find.byKey(const ValueKey('content'))), initialSize);
    await tester.pumpAndSettle();
    expect(layouts, initialLayouts);
    await tester.tap(find.byKey(const ValueKey('nav-2')));
    expect(selected, 2);
    await tester.sendKeyEvent(LogicalKeyboardKey.tab);
    await tester.sendKeyEvent(LogicalKeyboardKey.enter);
    await tester.pumpAndSettle();
    expect(selected, 0);
    await tester.sendKeyEvent(LogicalKeyboardKey.tab);
    await tester.sendKeyEvent(LogicalKeyboardKey.enter);
    await tester.pumpAndSettle();
    expect(selected, 1);
    expect(tester.takeException(), isNull);
  });
}
