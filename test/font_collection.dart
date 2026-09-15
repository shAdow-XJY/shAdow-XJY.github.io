import 'dart:io';

/// Collects string literals across all current Dart sources, not old article paths.
/// The token match consumes comments before looking for quoted text. Keeping ASCII
/// also covers dynamic numbers, URLs and keyboard/toolkit labels.
Set<int> collectFontCodePoints(String source) {
  final result = <int>{for (var i = 32; i <= 126; i++) i};
  final tokens = RegExp(
    r'//[^\n]*|/\*[\s\S]*?\*/'
    r'|r?"""[\s\S]*?"""'
    "|r?'''[\\s\\S]*?'''"
    r'''|r?"(?:\\.|[^"\\])*"'''
    r"|r?'(?:\\.|[^'\\])*'",
  );
  final unicodeEscape =
      RegExp(r'\\u\{([0-9a-fA-F]+)\}|\\u([0-9a-fA-F]{4})|\\x([0-9a-fA-F]{2})');
  for (final match in tokens.allMatches(source)) {
    var value = match.group(0)!;
    if (value.startsWith('//') || value.startsWith('/*')) continue;
    if (!value.startsWith('r')) {
      value = value.replaceAllMapped(
          unicodeEscape,
          (m) => String.fromCharCode(
              int.parse(m.group(1) ?? m.group(2) ?? m.group(3)!, radix: 16)));
    }
    result.addAll(value.runes.where((r) => r >= 32));
  }
  return result;
}

Future<void> main(List<String> arguments) async {
  final root = Directory.current;
  final source = Directory('${root.path}/lib');
  if (!source.existsSync()) {
    throw StateError('Run from the project root (lib/ is missing).');
  }
  final files = source
      .listSync(recursive: true)
      .whereType<File>()
      .where((file) => file.path.endsWith('.dart'))
      .toList()
    ..sort((a, b) => a.path.compareTo(b.path));
  final points = <int>{};
  for (final file in files) {
    points.addAll(collectFontCodePoints(await file.readAsString()));
  }
  // Optional extra characters for text that is supplied outside Dart literals.
  final extra = File('${root.path}/local/fonts/extra-characters.txt');
  if (extra.existsSync()) {
    points.addAll((await extra.readAsString()).runes.where((r) => r >= 32));
  }
  final ordered = points.toList()..sort();
  final output = File('${root.path}/local/fonts/fontcontent.txt');
  await output.parent.create(recursive: true);
  await output.writeAsString(String.fromCharCodes(ordered));
  stdout.writeln(
      '${files.length} Dart files; ${ordered.length} characters → ${output.path}');
}
