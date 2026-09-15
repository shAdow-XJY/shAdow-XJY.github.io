import 'package:flutter/material.dart';
import '../global/musicPlayer.dart';
import '../global/navigation/siteNavigation.dart';
import '../global/siteStyle.dart';
import '../innerAssets/videoAsset/videoData.dart';
import '../indexPage/indexVideo/videoWatch.dart';
import '../indexPage/indexBook/indexBook.dart';
import '../indexPage/indexFavorite/indexFavorite.dart';
import '../indexPage/indexHome/indexHome.dart';
import '../indexPage/indexPeople/indexPeople.dart';
import '../indexPage/indexProgram/indexProgram.dart';
import '../indexPage/indexVideo/indexVideo.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
    this.video,
    this.initialSection = 0,
    this.onSectionSelected,
  }) : super(key: key);
  final VideoEntry? video;
  final int initialSection;
  final ValueChanged<int>? onSectionSelected;
  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  late int _selectedIndex;
  int? _pendingDrawerSection;
  final _music = GlobalKey<MusicPlayerState>();
  final _scaffold = GlobalKey<ScaffoldState>();
  final _pageStorage = PageStorageBucket();
  late final _pages = [
    const IndexHome(),
    IndexVideo(onOpen: _openVideo),
    const IndexBook(key: PageStorageKey('websites')),
    const IndexProgram(),
    const IndexPeople(),
    const IndexFavorite(),
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.video == null ? widget.initialSection : 1;
  }

  Future<void> _openVideo(VideoEntry video) async {
    await _music.currentState?.suspend();
    if (!mounted) return;
    final section = await Navigator.of(
      context,
    ).pushNamed('/videos/${video.id}');
    if (!mounted) return;
    _music.currentState?.release();
    if (section is int) _select(section);
  }

  void selectSection(int index) => _select(index);

  void _select(int index) {
    if (widget.video != null) {
      Navigator.of(context).pop(index);
      widget.onSectionSelected?.call(index);
    } else if (index != _selectedIndex) {
      setState(() => _selectedIndex = index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final mobile = constraints.maxWidth < 700;
        final wide = constraints.maxWidth >= 1100;
        final index = _selectedIndex;
        return Scaffold(
          key: _scaffold,
          backgroundColor: siteBackground,
          onDrawerChanged: (open) {
            if (!open && _pendingDrawerSection != null) {
              final section = _pendingDrawerSection!;
              _pendingDrawerSection = null;
              _select(section);
            }
          },
          drawer: mobile
              ? Drawer(
                  width: 248,
                  backgroundColor: siteSurface,
                  child: SafeArea(
                    child: SiteNavigation(
                      drawer: true,
                      selectedIndex: index,
                      onSelected: (value) {
                        _pendingDrawerSection = value;
                        _scaffold.currentState?.closeDrawer();
                      },
                    ),
                  ),
                )
              : null,
          body: SafeArea(
            child: Column(
              children: [
                Container(
                  height: mobile ? 80 : 88,
                  padding: EdgeInsets.symmetric(horizontal: mobile ? 8 : 28),
                  decoration: const BoxDecoration(
                    color: siteSurface,
                    border: Border(bottom: BorderSide(color: siteDivider)),
                  ),
                  child: NavigationToolbar(
                    centerMiddle: true,
                    leading: SizedBox(
                      width: mobile ? 44 : 210,
                      child: mobile
                          ? IconButton(
                              tooltip: 'Open navigation menu',
                              icon: const Icon(Icons.menu),
                              onPressed: () =>
                                  _scaffold.currentState?.openDrawer(),
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'ShadowPlusing',
                                  style: siteHeading.copyWith(fontSize: 25),
                                ),
                                Text(
                                  'Write  Explore  Create',
                                  style: siteBody.copyWith(
                                    fontSize: 12,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ],
                            ),
                    ),
                    middle: mobile
                        ? FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              siteSections[index],
                              maxLines: 1,
                              textAlign: TextAlign.center,
                              style: siteHeading.copyWith(fontSize: 24),
                            ),
                          )
                        : null,
                    trailing: MusicPlayer(
                      key: _music,
                      enabled: widget.video == null,
                    ),
                  ),
                ),
                Expanded(
                  child: Stack(
                    children: [
                      Positioned.fill(
                        left: mobile ? 0 : (wide ? 152 : 72),
                        child: RepaintBoundary(
                          key: const ValueKey('page-content'),
                          child: PageStorage(
                            bucket: _pageStorage,
                            child: widget.video == null
                                ? _pages[index]
                                : VideoWatch(video: widget.video!),
                          ),
                        ),
                      ),
                      if (!mobile)
                        Positioned(
                          top: 0,
                          bottom: 0,
                          left: 0,
                          width: wide ? 152 : 220,
                          child: SiteNavigation(
                            selectedIndex: index,
                            onSelected: _select,
                            wide: wide,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
