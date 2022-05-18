import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:url_launcher/url_launcher.dart';

class MdWidget extends StatefulWidget {
  String title;
  String path;
  MdWidget({Key? key,
    required this.title,
    required this.path,
  }) : super(key: key);

  @override
  _MdWidgetState createState() => _MdWidgetState();
}

class _MdWidgetState extends State<MdWidget> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Container(
        margin: const EdgeInsets.all(0.0),
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: theme.canvasColor,
          boxShadow: const [BoxShadow()],
        ),
        child: FutureBuilder<String>(
            future: rootBundle.loadString(widget.path),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return SingleChildScrollView(
                  controller: ScrollController(),
                  child: Column(
                    children: [
                      Text(
                        widget.title,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 35,
                            fontWeight: FontWeight.w900,
                            shadows: [
                              BoxShadow(
                                  blurRadius: 5,
                                  color: Colors.white.withOpacity(0.54)),
                            ]
                        ),
                        textAlign: TextAlign.center,
                      ),
                      MarkdownBody(
                        data: snapshot.data!,
                        selectable: true,
                        softLineBreak:true,
                        extensionSet:md.ExtensionSet(
                          md.ExtensionSet.gitHubWeb.blockSyntaxes,
                          md.ExtensionSet.gitHubWeb.inlineSyntaxes,
                        ),
                        onTapLink: (String linkPath, String? href, String title) {
                          launchUrl(Uri.parse(href!));
                        },
                        styleSheet: MarkdownStyleSheet(
                          h1Padding: const EdgeInsets.symmetric(vertical: 4.0),
                          h2Padding: const EdgeInsets.symmetric(vertical: 3.0),
                          h3Padding: const EdgeInsets.symmetric(vertical: 2.0),
                          h4Padding: const EdgeInsets.symmetric(vertical: 1.5),
                          h5Padding: const EdgeInsets.symmetric(vertical: 1.0),
                          h6Padding: const EdgeInsets.symmetric(vertical: 0.5),
                          h1: const TextStyle(fontSize: 45, fontWeight: FontWeight.w900,),
                          h2: const TextStyle(fontSize: 35, fontWeight: FontWeight.w700,),
                          h3: const TextStyle(fontSize: 25, fontWeight: FontWeight.w500,),

                          blockquote: const TextStyle(color: Colors.white),
                          blockquotePadding: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 20.0),
                          blockquoteDecoration: BoxDecoration(
                            color: Colors.white70.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(50),
                          ),

                          code: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            //backgroundColor: Color(0xFF2B2B2C),
                          ),
                          //codeblockPadding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 20.0),
                          //codeblockDecoration: const BoxDecoration(color: Color(0xFF2B2B2C),),

                        ),
                      ),
                    ],
                  ),
                );
              }
              else{
                return const Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.purple,
                  ),
                );
              }
            }
        )

    );


  }
  
}