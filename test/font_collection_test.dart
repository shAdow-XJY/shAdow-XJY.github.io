import 'package:flutter_test/flutter_test.dart';
import 'font_collection.dart';

void main() {
  test(
      'Collect literal Unicode, interpolation and escaped characters; skip comments',
      () {
    const code = "// 注释\nconst title = '阅读'; /* 丢弃 */ const error = '找不到视频';\n"
        r"const escaped = '\u2460\u{1F600}'; const number = '$count / 100';";
    final points = collectFontCodePoints(code);
    expect(points.containsAll('阅读找不到视频①😀0123456789'.runes), isTrue);
    expect(points.contains('注'.runes.first), isFalse);
    expect(points.contains('丢'.runes.first), isFalse);
  });
}
