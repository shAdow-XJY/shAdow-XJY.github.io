## See

![twolevellist1](https://img-blog.csdnimg.cn/7a113b28d8124c0f9903008d44196596.jpeg#pic_center)

![twolevellist2](https://img-blog.csdnimg.cn/2c1c28c222f64d99a39acc40139fefb0.jpeg#pic_center)

## use

#### oneLevelList

```
List<Map<String, String>> oneLevelObj = [
    {'title': 'Vue', 'image': 'assets/Vue.png'},
    {'title': 'Web', 'image': 'assets/Web.png'},
    {'title': 'Flutter', 'image': 'assets/Flutter.png'},
    {'title': 'UnrealEngine', 'image': 'assets/UnrealEngine.png'}
  ];
ListBuilder(
          oneLevel: true,
          levelObj: oneLevelObj,
          backgroundColor: const Color(0xFF2E2E48),
          onPressed: (selectedCategory) {
            if (selectedCategory != 'default') {
              debugPrint('click $selectedCategory ');
            }
          },
        )
```

---

#### twoLevelList

```
List<Map<String, String>> twoLevelObj = [
    {'title': 'Vue'},
    {'title': 'Web'},
    {'title': 'Flutter'},
    {'title': 'UnrealEngine'}
  ];
ListBuilder(
          oneLevel: false,
          levelObj: twoLevelObj,
          backgroundColor: const Color(0xFF2E2E48),
          onPressed: (selectedTitle) {
            if (selectedTitle!= 'default') {
              debugPrint('click $selectedTitle');
            }
          },
        )
```

## Function creator

```
class ListBuilder extends StatefulWidget {
  bool oneLevel;
  List<Map<String, String>> levelObj;
  Function(String selectedTitle)? onPressed;   // return title String what you click
  double? itemHeight;
  Color? backgroundColor;
  TextStyle? textStyle;
  EdgeInsetsGeometry? listPadding;
  EdgeInsetsGeometry? itemMargin;
  MainAxisAlignment itemAlignment;            //
  }
```

## Link

### pub link

[https://pub.dev/packages/list_twolevel](https://pub.dev/packages/list_twolevel)

### use in my blog

click to see:[shAdowPlusing](https://shadowplusing.website/#/)

### code source

Github:[shAdow-XJY/list_twolevel: a two level list builder --- flutter component. (github.com)](https://github.com/shAdow-XJY/list_twolevel)

Gitee:[list_twolevel: a two level list builder --- flutter component. (gitee.com)](https://gitee.com/shAdowPlusing/list_twolevel)
