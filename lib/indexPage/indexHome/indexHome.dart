import 'package:flutter/material.dart';
import 'package:github_blog/global/blurGlass.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:url_launcher/url_launcher.dart';


class IndexHome extends StatefulWidget {
  const IndexHome({Key? key}) : super(key: key);

  @override
  _IndexHomeState createState() => _IndexHomeState();
}


class _IndexHomeState extends State<IndexHome> {

  IconButton _IconButton(String iconPath, String linkPath) {
    return IconButton(
      icon: ImageIcon(AssetImage(iconPath)),
      color: Colors.white,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onPressed: () {
        launchUrl(Uri.parse(linkPath));
      },
    );
  }


  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
        builder: (context, sizingInformation) {
          if (sizingInformation.deviceScreenType == DeviceScreenType.mobile) {
            return Container(
              margin: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color:  const Color(0xFF2E2E48),
              ),
              child: Center(
                child: BlurGlass(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '   WELCOME\nTO  MY  BLOG!',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w900,
                            shadows: [
                              BoxShadow(
                                  blurRadius: 5,
                                  color: Colors.white.withOpacity(0.54)),
                            ]),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        ' ShadowPlusing ',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          BlurGlass(
                              marginValue: 5.0,
                              paddingValue: 5.0,
                              child: Row(
                                children: [
                                  _IconButton('assets/icon/github.png',
                                      'https://github.com/shAdow-XJY'),
                                  _IconButton('assets/icon/gitee.png',
                                      'https://gitee.com/shAdowPlusing'),
                                  _IconButton('assets/icon/bilibili.png',
                                      'https://space.bilibili.com/437699902'),
                                ],
                              ))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          return Container(
              margin: const EdgeInsets.all(10.0), //.only(top: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: const DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage('assets/image/background.jpg'), //AssetImage('assets/image/background.jpg'),
                ),
              ),
              child: Flex(
                direction: Axis.vertical,
                children: [
                  Expanded(
                    flex: 9,
                    child: Center(
                      child: BlurGlass(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '   WELCOME\nTO  MY  BLOG!',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 70,
                                  fontWeight: FontWeight.w900,
                                  shadows: [
                                    BoxShadow(
                                        blurRadius: 5,
                                        color: Colors.white.withOpacity(0.54)),
                                  ]),
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              ' ShadowPlusing ',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 23,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        BlurGlass(
                            marginValue: 5.0,
                            paddingValue: 5.0,
                            child: Row(
                              children: [
                                _IconButton('assets/icon/github.png',
                                    'https://github.com/shAdow-XJY'),
                                _IconButton('assets/icon/gitee.png',
                                    'https://gitee.com/shAdowPlusing'),
                                _IconButton('assets/icon/bilibili.png',
                                    'https://space.bilibili.com/437699902'),
                              ],
                            ))
                      ],
                    ),
                  )
                ],
              ));
        }
    );

  }
}
