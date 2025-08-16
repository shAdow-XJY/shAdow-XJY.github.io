import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../global/GradientProgressBar.dart';

class IndexPeople extends StatefulWidget {
  const IndexPeople({Key? key}) : super(key: key);

  @override
  _IndexPeopleState createState() => _IndexPeopleState();
}

class _IndexPeopleState extends State<IndexPeople> {
  // 示例数据：title, current, max
  final List<Map<String, dynamic>> progressItems = [
    {"title": "《西游①成事智慧》", "current": 71.0, "max": 462.0},
    {"title": "《哈利·波特与密室》", "current": 6.0, "max": 261.0},
    {"title": "《爆笑校园②》", "current": 132.0, "max": 223.0},
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: theme.canvasColor,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: 200,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset('assets/image/avatar.jpg'),
                  ),
                ),
              ),
            ],
          ),
          AutoSizeText(
            'ShadowPlus',
            minFontSize: 10.0,
            style: TextStyle(
              color: Colors.white,
              fontSize: 50,
              fontWeight: FontWeight.w900,
              shadows: [
                BoxShadow(
                  blurRadius: 5,
                  color: Colors.white.withOpacity(0.54),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // --- 可滚动列表部分 START ---
          Expanded( // 确保 ListView 有一个有界的高度，以占据剩余的垂直空间
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16.0), // 给列表项左右内边距
              itemCount: progressItems.length,
              itemBuilder: (BuildContext context, int index) { // itemBuilder 的完整签名
                final item = progressItems[index]; // 获取当前项的数据
                double current = item["current"] as double;
                double max = item["max"] as double;
                double value = (max > 0) ? (current / max) : 0.0;

                // 返回每个列表项的 Widget
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0), // 给每个列表项上下外边距
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 标题 + 数值在同一行
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // 使用 Flexible 或 Expanded 避免长标题溢出
                          Flexible(
                            child: Text(
                              item["title"],
                              style: const TextStyle(
                                fontSize: 24, // 调整字体大小
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              overflow: TextOverflow.ellipsis, // 标题过长时显示省略号
                            ),
                          ),
                          const SizedBox(width: 8), // 给标题和数值之间一些间距
                          Text(
                            "${current.toInt()}/${max.toInt()}",
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6), // 进度条和上方文本的间距
                      ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: GradientProgressBar( // 您的自定义进度条
                          value: value,
                          height: 10,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}