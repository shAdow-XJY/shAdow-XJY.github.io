import 'package:flutter/material.dart';
import 'package:github_blog/global/musicPlayer.dart';
import 'package:github_blog/indexPage/indexFavorite/indexFavorite.dart';
import 'package:github_blog/indexPage/indexVideo/indexVideo.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:sidebarx/sidebarx.dart';
import '../indexPage/indexBook/indexBook.dart';
import '../indexPage/indexHome/indexHome.dart';
import '../indexPage/indexPeople/indexPeople.dart';
import '../indexPage/indexProgram/indexProgram.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool mobileFullscreen = false;

  SidebarXController _controller = SidebarXController(selectedIndex: 0);

  SidebarX getSidebarX(bool showToggle, canvasColor) {
    return SidebarX(
      showToggleButton: showToggle,
      controller: _controller,
      theme: SidebarXTheme(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: canvasColor,
          borderRadius: BorderRadius.circular(20),
        ),
        textStyle: const TextStyle(color: Colors.white),
        selectedTextStyle: const TextStyle(color: Colors.white),
        itemTextPadding: const EdgeInsets.only(left: 30),
        selectedItemTextPadding: const EdgeInsets.only(left: 30),
        itemDecoration: BoxDecoration(
          border: Border.all(color: canvasColor),
        ),
        selectedItemDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: actionColor.withOpacity(0.37),
          ),
          gradient: LinearGradient(
            colors: [accentCanvasColor, canvasColor],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.28),
              blurRadius: 30,
            )
          ],
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
          size: 20,
        ),
      ),
      extendedTheme: SidebarXTheme(
        width: 200,
        decoration: BoxDecoration(
          color: canvasColor,
        ),
        margin: const EdgeInsets.only(right: 10),
      ),
      footerDivider: divider,
      headerBuilder: (context, extended) {
        return SizedBox(
          height: 100,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.asset('assets/image/avatar.jpg'),
            ),
          ),
        );
      },
      items: [
        SidebarXItem(
          icon: Icons.home,
          label: 'Home',
          onTap: () {
            debugPrint('Hello');
          },
        ),
        const SidebarXItem(
          icon: Icons.video_library,
          label: 'Video',
        ),
        const SidebarXItem(
          icon: Icons.book,
          label: 'Book',
        ),
        const SidebarXItem(
          icon: Icons.category,
          label: 'Program',
        ),
        const SidebarXItem(
          icon: Icons.people,
          label: 'People',
        ),
        const SidebarXItem(
          icon: Icons.favorite,
          label: 'Favorite',
        ),
      ],
    );
  }

  Widget getMobilePage(){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: canvasColor,
        actions: const [
          MusicPlayer(),
        ],
      ),
      drawer: getSidebarX(false, canvasColor),
      body: Row(
        children: [
          Expanded(
            child: Center(
                child: _ScreensExample(controller: _controller),
            ),
          ),
        ],
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ResponsiveBuilder(builder: (context, sizingInformation) {
      if (sizingInformation.deviceScreenType == DeviceScreenType.mobile) {
        switch (_controller.selectedIndex) {
          case 0:
            _controller = SidebarXController(selectedIndex: 0,extended: true);
            return getMobilePage();
          case 1:
            _controller = SidebarXController(selectedIndex: 1,extended: true);
            return getMobilePage();
          case 2:
            _controller = SidebarXController(selectedIndex: 2,extended: true);
            return getMobilePage();
          case 3:
            _controller = SidebarXController(selectedIndex: 3,extended: true);
            return getMobilePage();
          case 4:
            _controller = SidebarXController(selectedIndex: 4,extended: true);
            return getMobilePage();
          case 5:
            _controller = SidebarXController(selectedIndex: 5,extended: true);
            return getMobilePage();
          default:
            return Text(
              'Not found page',
              style: theme.textTheme.headline5,
            );
        }
      }
      return Scaffold(
        body: Row(
          children: [
            getSidebarX(true, canvasColor),
            Expanded(
              child: Center(
                  child: Stack(
                children: [
                  _ScreensExample(controller: _controller),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      MusicPlayer(),
                    ],
                  ),
                ],
              )),
            ),
          ],
        ),
      );
    });
  }
}

class _ScreensExample extends StatelessWidget {
  const _ScreensExample({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final SidebarXController controller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        switch (controller.selectedIndex) {
          case 0:
            return const IndexHome();
          case 1:
            return const IndexVideo();
          case 2:
            return const IndexBook();
          case 3:
            return const IndexProgram();
          case 4:
            return const IndexPeople();
          case 5:
            return const IndexFavorite();
          default:
            return Text(
              'Not found page',
              style: theme.textTheme.headline5,
            );
        }
      },
    );
  }
}

const canvasColor = Color(0xFF2E2E48);
//内容渐变色配合的颜色
const accentCanvasColor = Color(0xFF3E3E61);
//border颜色
final actionColor = const Color(0xFF5F5FA7).withOpacity(0.6);

const white = Colors.white;
final divider = Divider(color: white.withOpacity(0.3), height: 1);
