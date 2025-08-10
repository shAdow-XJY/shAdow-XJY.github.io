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

          // 新增列表部分
          Column(
            children: progressItems.map((item) {
              double current = item["current"] as double;
              double max = item["max"] as double;
              double value = (max > 0) ? (current / max) : 0.0;

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 标题 + 数值在同一行
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          item["title"],
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "${current.toInt()}/${max.toInt()}",
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: GradientProgressBar(
                        value: value,
                        height: 10,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}