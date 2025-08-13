// ignore_for_file: file_names

import 'dart:ui';
import 'package:flutter/material.dart';

class BlurGlass extends StatefulWidget {
  Widget child;
  double? marginValue;
  double? paddingValue;

  BlurGlass({Key? key,
             required this.child,
             this.marginValue,
             this.paddingValue}) : super(key: key);

@override
_BlurGlassState createState() => _BlurGlassState();
}

class _BlurGlassState extends State<BlurGlass> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        //背景滤镜器
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        //图片模糊过滤，横向竖向都设置5.0
        child: Container(
          margin: EdgeInsets.all(widget.marginValue??20.0),
          padding: EdgeInsets.all(widget.paddingValue??20.0),
          decoration: BoxDecoration(
            color: Colors.transparent.withOpacity(0.2),
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: widget.child,
        ),
      ),
    );
  }

}