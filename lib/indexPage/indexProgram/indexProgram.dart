import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class IndexProgram extends StatefulWidget {
  const IndexProgram({Key? key}) : super(key: key);

  @override
  _IndexProgramState createState() => _IndexProgramState();
}

class _IndexProgramState extends State<IndexProgram> {
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
          children:[
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
              'ShadowPlus \n 页面清空待重写',
              minFontSize: 10.0,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 50,
                  fontWeight: FontWeight.w900,
                  shadows: [
                    BoxShadow(
                        blurRadius: 5,
                        color: Colors.white.withOpacity(0.54)),
                  ]),
            ),

          ]
      ),
    );
  }
  // List<Map<String, String>> oneLevelObj = [];
  // List<String> oneLevelTitles = [];
  //
  // bool _oneLevel = true;
  // String _selectedTitle = '';
  //
  // void oneLevelInit(List<String> titles) {
  //   for (var element in titles) {
  //     oneLevelObj.add({
  //       'title': element,'image': 'assets/icon/repositories.png'
  //     }); // 'image': 'assets/icon/write/$element.png'
  //   }
  //   setState(() {
  //     oneLevelObj;
  //   });
  // }
  //
  //
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   rootBundle
  //       .loadString('assets/programIndex/programIndex.txt')
  //       .then((value) => {
  //             oneLevelTitles = value.split('\n'),
  //             oneLevelTitles.removeLast(),
  //             oneLevelInit(oneLevelTitles),
  //           });
  // }
  //
  // @override
  // Widget build(BuildContext context) {
  //   // TODO: implement build
  //   return _oneLevel
  //       ? AListBuilder(
  //           levelObj: oneLevelObj,
  //           onPressed: (selectedTitle) {
  //             _oneLevel = false;
  //             _selectedTitle = selectedTitle;
  //             setState(() {
  //               _oneLevel;
  //             });
  //           },
  //         )
  //       : Stack(
  //           children: [
  //             Container(
  //               margin: const EdgeInsets.all(10.0),
  //               child: MdWidget(
  //                   title: _selectedTitle.substring(
  //                       0, _selectedTitle.lastIndexOf('.')),
  //               path: 'assets/program/$_selectedTitle',),
  //             ),
  //             Positioned(
  //                 bottom: 10.0,
  //                 right: 10.0,
  //                 child: BlurGlass(
  //                     marginValue: 5.0,
  //                     paddingValue: 5.0,
  //                     child: IconButton(
  //                       icon: const Icon(Icons.arrow_back),
  //                       color: Colors.white,
  //                       splashColor: Colors.transparent,
  //                       highlightColor: Colors.transparent,
  //                       onPressed: () {
  //                         setState(() {
  //                           _oneLevel = true;
  //                         });
  //                       },
  //                     )))
  //           ],
  //         );
  // }
}
