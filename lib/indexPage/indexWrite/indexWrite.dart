import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:github_blog/global/mdWidget.dart';
import 'package:github_blog/model/indexData.dart';
import '../../global/blurGlass.dart';
import 'package:list_twolevel/list_A.dart';
import 'package:list_twolevel/list_B.dart';
class IndexWrite extends StatefulWidget {
  const IndexWrite({Key? key}) : super(key: key);

  @override
  _IndexWriteState createState() => _IndexWriteState();
}

class _IndexWriteState extends State<IndexWrite> {
  List<Map<String, String>> oneLevelObj = [];
  List<String> oneLevelTitles = [];

  List<Map<String, String>> twoLevelObj = [];
  List<String> twoLevelTitles = [];

  bool _oneLevel = true;
  bool _twoLevel = false;
  bool _thrLevel = false;
  String _selectedCategory = '';
  String _selectedTitle = '';


  void oneLevelInit(List<String> titles) {
    for (var element in titles) {
      oneLevelObj
          .add({'title': element, 'image': 'assets/icon/write/$element.png'});
    }
    setState(() {
      oneLevelObj;
    });
  }

  void twoLevelInit(String selectCategory) {
    twoLevelObj.clear();
    rootBundle
        .loadString('assets/writeIndex/$selectCategory.txt')
        .then((value) => {
              twoLevelTitles = value.split('\n'),
              twoLevelTitles.removeLast(),
              for (var element in twoLevelTitles)
                {
                  twoLevelObj.add({
                    'title': element,
                  })
                },
              setState(() {
                twoLevelObj;
              })
            });
  }


  @override
  void initState() {
    super.initState();
    // rootBundle
    //     .loadString('assets/writeIndex/writeCategory.txt')
    //     .then((value) => {
    //           print(value.split('\n')),
    //           oneLevelTitles = value.split('\n'),
    //           oneLevelTitles.removeLast(),
    //           oneLevelInit(oneLevelTitles),
    //         });
    oneLevelTitles = IndexData.writeData.keys.toList();
    oneLevelInit(oneLevelTitles);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: _oneLevel
          ? AListBuilder(
        levelObj: oneLevelObj,
        onPressed: (selectedCategory) {
          _oneLevel = false;
          _twoLevel = true;
          _selectedCategory = selectedCategory;
          twoLevelInit(_selectedCategory);
          setState(() {
            _oneLevel;
          });
        },
      )
          : Stack(
        children: [
          !_thrLevel
              ? BListBuilder(
            levelObj: twoLevelObj,
            itemHeight: 50,
            onPressed: (selectedTitle) {
              _selectedTitle = selectedTitle;
              _twoLevel = false;
              _thrLevel = true;
              setState(() {
                _thrLevel;
              });
            },
          )
              : MdWidget(
            title: _selectedTitle.substring(
                0, _selectedTitle.lastIndexOf('.')),
            path: 'assets/write/$_selectedCategory/$_selectedTitle',
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
                      if (_twoLevel) {
                        setState(() {
                          _oneLevel = true;
                        });
                        _twoLevel = false;
                      } else if (_thrLevel) {
                        setState(() {
                          _thrLevel = false;
                        });
                        _twoLevel = true;
                      }
                    },
                  )))
        ],
      ),
    );

  }
}
