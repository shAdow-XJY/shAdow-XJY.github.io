import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'package:webviewx/webviewx.dart';

class WebviewWidget extends StatefulWidget {
  String title;
  int source;   // 1: youtobe; 2: bilibili;
  WebviewWidget({Key? key, required this.title,required this.source}) : super(key: key);

  @override
  _WebviewWidgetState createState() => _WebviewWidgetState();
}

class _WebviewWidgetState extends State<WebviewWidget> {
  //loading
  bool loading = true;
  late WebViewXController webviewController;

  String loadPath = "";
  String partContent = '';

  //mobile\pc inset
  var padding = const EdgeInsets.symmetric(vertical: 50.0, horizontal: 100.0);

  Future<String> readFile(path){
    return rootBundle.loadString(path);
  }

  @override
  void initState() {
    super.initState();
    switch(widget.source){
      case 1:
        {
          loadPath = 'assets/videoIndex/${widget.title}.youtube';
          readFile(loadPath).then((value) => {
            setState((){
              partContent = ' src="$value" scrolling="no" frameborder="0"  allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen';
            })
          });
        }
        break;
      case 2:
        {
          loadPath = 'assets/videoIndex/${widget.title}.bilibili';
          readFile(loadPath).then((value) => {
            setState((){
              partContent = ' src="$value&high_quality=1&danmaku=0" allowfullscreen="allowfullscreen" scrolling="no" frameborder="0" sandbox="allow-top-navigation allow-same-origin allow-forms allow-scripts"';
            })
          });
        }
        break;
      default: break;
    }


  }

  @override
  void dispose() {
    webviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ResponsiveBuilder(
        builder: (context, sizingInformation) {
          if (sizingInformation.deviceScreenType == DeviceScreenType.mobile) {
            padding = const EdgeInsets.symmetric(vertical: 100.0, horizontal: 5.0);
          }
          return Dialog(
            backgroundColor: Colors.black,
            // 背景色
            insetPadding: padding,
            // 弹框距离屏幕边缘距离
            child: Container(
                color: Colors.transparent,
                height: size.height,
                width: size.width,
                child:
                Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      WebViewX(
                        height: size.height,
                        width: size.width,
                        initialSourceType: SourceType.html,
                        initialContent: 'about:blank',
                        onWebViewCreated: (controller) => {
                          webviewController = controller,
                          webviewController.loadContent('<iframe width="100%" height="${size.height/1.3}" $partContent ></iframe>', SourceType.html,),
                        },
                        onPageFinished: (value){
                          setState((){loading = false;});
                        },
                      ),
                      loading
                          ?const Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.purple,
                        ),
                      )
                          :const SizedBox(),
                    ]
                )

            ),
          );
        }
    );

  }
}
