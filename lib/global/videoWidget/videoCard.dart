import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:github_blog/global/videoWidget/mobileVideoWidget.dart';
import 'package:github_blog/global/videoWidget/videoWidget.dart';
import 'package:github_blog/global/videoWidget/webviewWidget.dart';
import 'package:responsive_builder/responsive_builder.dart';

class VideoCard extends StatefulWidget {
  final String imageUrl;
  final String videoName;
  final String videoDescription;

  const VideoCard({
    Key? key,
    required this.imageUrl,
    required this.videoName,
    required this.videoDescription,
  }) : super(key: key);

  @override
  _VideoCardState createState() => _VideoCardState();
}

class _VideoCardState extends State<VideoCard>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    animation = CurvedAnimation(
      parent: Tween<double>(begin: 0, end: 1).animate(controller),
      curve: Curves.easeInOutQuad,
    );
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      hoverColor: Colors.transparent,
      focusColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        showDialog(
            context: context,
            builder: (context) => //VideoWidget(title: widget.videoName,)
                Dialog(
                  backgroundColor: const Color(0xFF2E2E48),
                  insetPadding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ResponsiveBuilder(
                        builder: (context, sizingInformation) {
                          final isMobile = sizingInformation.deviceScreenType ==
                              DeviceScreenType.mobile;

                          return TextButton(
                            child: const Text(
                              'Github source',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                              showDialog(
                                  context: context,
                                  builder: (context) => isMobile
                                      ? MobileVideoWidget(
                                          title: widget.videoName,
                                        )
                                      : VideoWidget(
                                          title: widget.videoName,
                                        ));
                            },
                          );
                        },
                      ),
                      TextButton(
                        child: const Text(
                          'Youtube source',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          showDialog(
                              context: context,
                              builder: (context) => WebviewWidget(
                                    title: widget.videoName,
                                    source: 1,
                                  ));
                        },
                      ),
                      TextButton(
                        child: const Text(
                          'Bilibili source',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          showDialog(
                              context: context,
                              builder: (context) => WebviewWidget(
                                    title: widget.videoName,
                                    source: 2,
                                  ));
                        },
                      ),
                    ],
                  ),
                ));
      },
      onHover: (e) {
        if (e) {
          controller.forward();
        } else {
          controller.reverse();
        }
      },
      child: AnimatedBuilder(
          animation: animation,
          builder: (context, _) {
            return Transform.scale(
              scale: 1 + (0.2 * animation.value),
              child: Container(
                // width: 240,
                // height: 350,
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  image: DecorationImage(
                    image: AssetImage(widget.imageUrl),
                    fit: BoxFit.cover,
                  ),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 50 * animation.value,
                        spreadRadius: -10,
                        offset: const Offset(0, 10))
                  ],
                ),
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.bottomLeft,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black,
                            Colors.black12,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AutoSizeText(
                            widget.videoName,
                            minFontSize: 0,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                            maxLines: 2,
                          ),
                          AutoSizeText(
                            widget.videoDescription,
                            maxLines: 3,
                            minFontSize: 0,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
