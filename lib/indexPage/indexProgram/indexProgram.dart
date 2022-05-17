import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../global/blurGlass.dart';
import '../../global/listBuilder.dart';
import '../../global/mdWidget.dart';

class IndexProgram extends StatefulWidget {
  const IndexProgram({Key? key}) : super(key: key);

  @override
  _IndexProgramState createState() => _IndexProgramState();
}

class _IndexProgramState extends State<IndexProgram> {
  List<Map<String, String>> oneLevelObj = [];
  List<String> oneLevelTitles = [];

  bool _oneLevel = true;
  String _selectedTitle = '';

  void oneLevelInit(List<String> titles) {
    for (var element in titles) {
      oneLevelObj.add({
        'title': element,
      }); // 'image': 'assets/icon/write/$element.png'
    }
    setState(() {
      oneLevelObj;
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    rootBundle
        .loadString('assets/programIndex/programIndex.txt')
        .then((value) => {
              oneLevelTitles = value.split('\n'),
              oneLevelTitles.removeLast(),
              oneLevelInit(oneLevelTitles),
            });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _oneLevel
        ? ListBuilder(
            oneLevel: _oneLevel,
            levelObj: oneLevelObj,
            onPressed: (selectedTitle) {
              if (selectedTitle != 'default') {
                _oneLevel = false;
                _selectedTitle = selectedTitle;
                setState(() {
                  _oneLevel;
                });
              }
            },
          )
        : Stack(
            children: [
              Container(
                margin: const EdgeInsets.all(10.0),
                child: MdWidget(
                    title: _selectedTitle.substring(
                        0, _selectedTitle.lastIndexOf('.')),
                path: 'assets/program/$_selectedTitle',),
              ),
              Positioned(
                  bottom: 10.0,
                  right: 10.0,
                  child: BlurGlass(
                      marginValue: 5.0,
                      paddingValue: 5.0,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back),
                        color: Colors.white,
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onPressed: () {
                          setState(() {
                            _oneLevel = true;
                          });
                        },
                      )))
            ],
          );
  }
}
