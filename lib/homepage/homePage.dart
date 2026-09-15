import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';
import '../global/musicPlayer.dart';
import '../global/navigation/siteNavigation.dart';
import '../global/siteStyle.dart';
import '../indexPage/indexBook/indexBook.dart';
import '../indexPage/indexFavorite/indexFavorite.dart';
import '../indexPage/indexHome/indexHome.dart';
import '../indexPage/indexPeople/indexPeople.dart';
import '../indexPage/indexProgram/indexProgram.dart';
import '../indexPage/indexVideo/indexVideo.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final SidebarXController _controller;
  final _scaffold = GlobalKey<ScaffoldState>();
  final _pageStorage = PageStorageBucket();
  static const _pages = [
    IndexHome(),
    IndexVideo(),
    IndexBook(key: PageStorageKey('websites')),
    IndexProgram(),
    IndexPeople(),
    IndexFavorite()
  ];

  @override
  void initState() {
    super.initState();
    _controller = SidebarXController(selectedIndex: 0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _select(int index) {
    if (index != _controller.selectedIndex) {
      setState(() => _controller.selectIndex(index));
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final mobile = constraints.maxWidth < 700;
      final wide = constraints.maxWidth >= 1100;
      final index = _controller.selectedIndex;
      return Scaffold(
        key: _scaffold,
        backgroundColor: siteBackground,
        drawer: mobile
            ? Drawer(
                width: 248,
                backgroundColor: siteSurface,
                child: SafeArea(
                    child: SiteNavigation(
                        drawer: true,
                        selectedIndex: index,
                        onSelected: (value) {
                          _select(value);
                          _scaffold.currentState?.closeDrawer();
                        })))
            : null,
        body: SafeArea(
            child: Column(children: [
          Container(
              height: mobile ? 80 : 88,
              padding: EdgeInsets.symmetric(horizontal: mobile ? 8 : 28),
              decoration: const BoxDecoration(
                  color: siteSurface,
                  border: Border(bottom: BorderSide(color: siteDivider))),
              child: NavigationToolbar(
                centerMiddle: true,
                leading: SizedBox(
                    width: mobile ? 44 : 210,
                    child: mobile
                        ? IconButton(
                            tooltip: 'Open navigation menu',
                            icon: const Icon(Icons.menu),
                            onPressed: () =>
                                _scaffold.currentState?.openDrawer())
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                Text('ShadowPlusing',
                                    style: siteHeading.copyWith(fontSize: 25)),
                                Text('Write  Explore  Create',
                                    style: siteBody.copyWith(
                                        fontSize: 12, letterSpacing: 1)),
                              ])),
                middle: mobile
                    ? FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(siteSections[index],
                            maxLines: 1,
                            textAlign: TextAlign.center,
                            style: siteHeading.copyWith(fontSize: 24)))
                    : null,
                trailing: const MusicPlayer(),
              )),
          Expanded(
              child: Stack(children: [
            Positioned.fill(
                left: mobile ? 0 : (wide ? 152 : 72),
                child: RepaintBoundary(
                    key: const ValueKey('page-content'),
                    child: PageStorage(
                        bucket: _pageStorage, child: _pages[index]))),
            if (!mobile)
              Positioned(
                  top: 0,
                  bottom: 0,
                  left: 0,
                  width: wide ? 152 : 220,
                  child: SiteNavigation(
                      selectedIndex: index, onSelected: _select, wide: wide)),
          ])),
        ])),
      );
    });
  }
}
