import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_blog/indexPage/indexBook/indexBook.dart';
import 'package:github_blog/indexPage/indexProgram/indexProgram.dart';
import 'package:github_blog/innerAssets/videoAsset/videoData.dart';

void main() {
  test('All current images exist and no unused source image remains', () {
    final used = <String>{
      ...websiteProjects.map((p) => p.image),
      ...collectionEntries.map((p) => p.image),
      ...videos.map((video) => video.cover),
    };
    final pattern =
        RegExp(r'''assets/(?:image|icon)/[^'"\s]+\.(?:png|jpg|webp)''');
    for (final file in Directory('lib')
        .listSync(recursive: true)
        .whereType<File>()
        .where((p) => p.path.endsWith('.dart'))) {
      used.addAll(pattern
          .allMatches(file.readAsStringSync())
          .map((m) => m.group(0)!)
          .where((p) => !p.contains(r'$')));
    }
    final actual = <String>{
      for (final dir in ['assets/image', 'assets/icon'])
        ...Directory(dir)
            .listSync(recursive: true)
            .whereType<File>()
            .where((p) => RegExp(r'\.(png|jpg|webp)$').hasMatch(p.path))
            .map((p) => p.path.replaceAll(r'\', '/')),
    };
    expect(used.difference(actual), isEmpty,
        reason: 'Missing referenced image');
    expect(actual.difference(used), isEmpty, reason: 'Unused source image');
  });
}
