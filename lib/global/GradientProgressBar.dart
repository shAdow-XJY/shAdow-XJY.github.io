// 渐变色进度条组件
import 'package:flutter/material.dart';

class GradientProgressBar extends StatelessWidget {
  final double value; // 0.0 ~ 1.0
  final double height;
  final BorderRadius borderRadius;

  const GradientProgressBar({
    Key? key,
    required this.value,
    this.height = 10,
    this.borderRadius = const BorderRadius.all(Radius.circular(5)),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double clampedValue = value.clamp(0.0, 1.0);

    return ClipRRect(
      borderRadius: borderRadius,
      child: Stack(
        children: [
          // 背景（灰色未填充部分）
          Container(
            height: height,
            color: Colors.grey.shade800,
          ),
          // 前景（渐变色已填充部分）
          FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: clampedValue,
            child: Container(
              height: height,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.red,
                    Colors.orange,
                    Colors.yellow,
                    Colors.green,
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}