import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:github_blog/global/videoWidget/videoCard.dart';
import 'package:responsive_builder/responsive_builder.dart';


class IndexVideo extends StatefulWidget {
  const IndexVideo({Key? key}) : super(key: key);

  @override
  _IndexVideoState createState() => _IndexVideoState();
}

class _IndexVideoState extends State<IndexVideo> {
  List<String> videoTitles = [];
  List<String> titles = [];

  int crossAxisCount = 5;

  void titleProcess() {
    titles.clear();
    for (var element in videoTitles) {
      titles.add(element.substring(0, element.lastIndexOf('.')));
    }
    setState(() {
      titles;
    });
  }

  @override
  void initState() {
    super.initState();
    rootBundle.loadString('assets/videoIndex/videoIndex.txt').then((value) => {
          videoTitles = value.split('\n'),
          videoTitles.removeLast(),
          titleProcess(),
        });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: theme.canvasColor,
          boxShadow: const [BoxShadow()],
        ),
        margin: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
        padding: const EdgeInsets.all(5.0),
        child: ResponsiveBuilder(
        builder: (context, sizingInformation){
          if (sizingInformation.deviceScreenType == DeviceScreenType.mobile){
            crossAxisCount = 1;
          }else if(sizingInformation.deviceScreenType == DeviceScreenType.tablet){
            crossAxisCount = 3;
          }
            return GridView.builder(
              itemCount: videoTitles.length,
              //SliverGridDelegateWithFixedCrossAxisCount 构建一个横轴固定数量Widget
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                //横轴元素个数
                  crossAxisCount: crossAxisCount,
                  //纵轴间距
                  mainAxisSpacing: 5.0,
                  //横轴间距
                  crossAxisSpacing: 10.0,
                  //子组件宽高长度比例
                  childAspectRatio: 0.9),
              itemBuilder: (BuildContext context, int index) {
                //Widget Function(BuildContext context, int index)
                return VideoCard(
                  imageUrl: 'assets/image/video/${titles[index]}.png',
                  videoName: titles[index],
                  videoDescription: 'click to watch',
                );

              });
        }));
  }
}
