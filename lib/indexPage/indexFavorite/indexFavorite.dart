import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:vertical_card_pager/vertical_card_pager.dart';

class IndexFavorite extends StatefulWidget {
  const IndexFavorite({Key? key}) : super(key: key);

  @override
  _IndexFavoriteState createState() => _IndexFavoriteState();
}

class _IndexFavoriteState extends State<IndexFavorite> {
  final List<String> titles = [
    "Wlop",
    "迅哥儿",
  ];

  final List<Widget> images = [
    ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: Image.asset(
        "assets/image/favorite/wlop.jpg",
        fit: BoxFit.cover,
      ),
    ),
    ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: Image.asset(
        "assets/image/favorite/run.jpg",
        fit: BoxFit.cover,
      ),
    ),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
        margin: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: theme.canvasColor,
        ),
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
          dragDevices: {
            PointerDeviceKind.touch,
            PointerDeviceKind.mouse,
          },
        ),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10.0),
                child: VerticalCardPager(
                  textStyle:
                  const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  titles: titles,
                  images: images,
                  initialPage: 0,
                  onPageChanged: (page) {
                    // print(page);
                  },
                  onSelectedItem: (index) {},
                ),
              ),
            ),
          ],
        ),
      ),
    );

  }
}

