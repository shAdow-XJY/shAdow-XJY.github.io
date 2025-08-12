import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'dart:js' as js;

class VideoWidget extends StatefulWidget {
  String title;

  VideoWidget({Key? key, required this.title}) : super(key: key);

  @override
  _VideoWidgetState createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  //asset VideoPlayer
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  bool showBar = true;
  bool isFullScreen = false; // full screen
  bool isSetVolumn = false; // volumn
  double volumnNum = 0.0;

  //mobile\pc inset
  var padding = const EdgeInsets.symmetric(vertical: 50.0, horizontal: 100.0);

  void jsFullScreen({
    bool onlyCancel = false,
  }) {
    if (js.context.callMethod("isfullScreen")) {
      js.context.callMethod("cancelfullScreen");
      isFullScreen = false;
    } else {
      if (!onlyCancel) {
        js.context.callMethod("enterfullScreen");
        isFullScreen = true;
      }
    }
    setState(() {
      isFullScreen;
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(
        'assets/video/${Uri.encodeComponent('${widget.title}.mp4')}');
    // Initialize the controller and store the Future for later use.
    _initializeVideoPlayerFuture = _controller.initialize();
    // Use the controller to loop the video.
    _controller.setLooping(false);
    volumnNum = _controller.value.volume;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    isFullScreen =
        js.context.callMethod("isfullScreen"); //实时监听，每次context改变，解决esc，f11
    return Dialog(
      backgroundColor: Colors.black,
      // 背景色
      insetPadding: isFullScreen ? const EdgeInsets.all(0.0) : padding,
      // 弹框距离屏幕边缘距离
      child: Container(
          color: Colors.transparent,
          height: size.height,
          width: size.width,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              FutureBuilder(
                future: _initializeVideoPlayerFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    // If the VideoPlayerController has finished initialization, use
                    // the data it provides to limit the aspect ratio of the video.
                    return Center(
                      child: AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        // Use the VideoPlayer widget to display the video.
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            VideoPlayer(_controller),
                            InkWell(
                              mouseCursor: showBar
                                  ? SystemMouseCursors.click
                                  : SystemMouseCursors.none,
                              onTap: () {
                                setState(() {
                                  showBar = !showBar;
                                });
                              },
                              child: showBar
                                  ? Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0, vertical: 10.0),
                                      child: Column(
                                        verticalDirection: VerticalDirection.up,
                                        children: [
                                          Flex(
                                            direction: Axis.horizontal,
                                            children: [
                                              Expanded(
                                                flex: 1,
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    IconButton(
                                                        icon: volumnNum == 0
                                                            ? const Icon(Icons
                                                                .volume_off)
                                                            : const Icon(Icons
                                                                .volume_up),
                                                        onPressed: () {
                                                          setState(() {
                                                            isSetVolumn =
                                                                !isSetVolumn;
                                                          });
                                                        }),
                                                    isSetVolumn
                                                        ? Slider(
                                                            value: volumnNum,
                                                            onChanged: (value) {
                                                              setState(() {
                                                                volumnNum =
                                                                    value;
                                                              });
                                                              _controller
                                                                  .setVolume(
                                                                      value);
                                                            })
                                                        : const SizedBox()
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: IconButton(
                                                    icon: Icon(
                                                      _controller
                                                              .value.isPlaying
                                                          ? Icons.pause
                                                          : Icons.play_arrow,
                                                    ),
                                                    onPressed: () {
                                                      setState(() {
                                                        // If the video is playing, pause it.
                                                        if (_controller
                                                            .value.isPlaying) {
                                                          _controller.pause();
                                                        } else {
                                                          // If the video is paused, play it.
                                                          _controller.play();
                                                        }
                                                      });
                                                    }),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      IconButton(
                                                          icon: ImageIcon(isFullScreen
                                                              ? const AssetImage(
                                                                  'assets/icon/screenBack.png')
                                                              : const AssetImage(
                                                                  'assets/icon/screenFull.png')),
                                                          onPressed: () {
                                                            jsFullScreen();
                                                          })
                                                    ]),
                                              )
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 20.0,
                                          ),
                                          VideoProgressIndicator(
                                            _controller,
                                            allowScrubbing: false,
                                            colors: const VideoProgressColors(
                                                playedColor: Colors.blueAccent,
                                                backgroundColor: Colors.grey,
                                                bufferedColor:
                                                    Colors.deepPurple),
                                          ),
                                        ],
                                      ),
                                    )
                                  : Container(),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.purple,
                      ),
                    );
                  }
                },
              ),
            ],
          )),
    );
  }
}
