import 'package:flutter/material.dart';
import '../homepage/homePage.dart';
import '../innerAssets/videoAsset/videoData.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  final uri = Uri.tryParse(settings.name ?? '/');
  final parts = uri?.pathSegments ?? [];
  final video = parts.length == 2 && parts.first == 'videos'
      ? videoById(parts.last)
      : null;
  if (video != null) {
    return MaterialPageRoute(
      settings: settings,
      builder: (_) => HomePage(video: video),
    );
  }
  return MaterialPageRoute(
    settings: const RouteSettings(name: '/homePage'),
    builder: (_) => HomePage(
      initialSection: parts.isNotEmpty && parts.first == 'videos' ? 1 : 0,
    ),
  );
}

List<Route<dynamic>> initialRoutes(String name) {
  final uri = Uri.tryParse(name);
  final parts = uri?.pathSegments ?? [];
  final video = parts.length == 2 && parts.first == 'videos'
      ? videoById(parts.last)
      : null;
  if (video != null) {
    final homeKey = GlobalKey<HomePageState>();
    return [
      MaterialPageRoute(
        settings: const RouteSettings(name: '/homePage'),
        builder: (_) => HomePage(key: homeKey, initialSection: 1),
      ),
      MaterialPageRoute(
        settings: RouteSettings(name: name),
        builder: (_) => HomePage(
          video: video,
          onSectionSelected: (section) =>
              homeKey.currentState?.selectSection(section),
        ),
      ),
    ];
  }
  return [onGenerateRoute(RouteSettings(name: name))];
}
