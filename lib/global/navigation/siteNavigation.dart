import 'package:flutter/material.dart';
import '../siteStyle.dart';

const siteSections = [
  'Home',
  'Videos',
  'Websites',
  'Collections',
  'People',
  'Favorite'
];
const _icons = [
  Icons.home_rounded,
  Icons.video_library_outlined,
  Icons.web_rounded,
  Icons.collections_outlined,
  Icons.people_outline,
  Icons.favorite_outline
];

/// Owns expansion independently of page selection. Its overlay never changes
/// the content constraints, so the page is not laid out on each animation frame.
class SiteNavigation extends StatefulWidget {
  const SiteNavigation(
      {Key? key,
      required this.selectedIndex,
      required this.onSelected,
      this.drawer = false,
      this.wide = true})
      : super(key: key);
  final int selectedIndex;
  final ValueChanged<int> onSelected;
  final bool drawer;
  final bool wide;

  @override
  State<SiteNavigation> createState() => _SiteNavigationState();
}

class _SiteNavigationState extends State<SiteNavigation> {
  bool? _expanded;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(const AssetImage('assets/image/avatar.jpg'), context);
  }

  @override
  Widget build(BuildContext context) {
    final expanded = widget.drawer || (_expanded ?? widget.wide);
    final width = widget.drawer ? 248.0 : (widget.wide ? 152.0 : 220.0);
    final reducedMotion = MediaQuery.of(context).disableAnimations;
    return Align(
      alignment: Alignment.topLeft,
      child: AnimatedContainer(
        key: const ValueKey('navigation-panel'),
        duration:
            reducedMotion ? Duration.zero : const Duration(milliseconds: 180),
        curve: Curves.easeOutCubic,
        width: expanded ? width : 72,
        clipBehavior: Clip.hardEdge,
        decoration: const BoxDecoration(
            color: siteSurface,
            border: Border(right: BorderSide(color: siteDivider))),
        child: Column(children: [
          if (widget.drawer)
            Padding(
                padding: const EdgeInsets.fromLTRB(24, 24, 12, 18),
                child: Row(children: [
                  const Expanded(
                      child: Text('ShadowPlusing', style: siteHeading)),
                  IconButton(
                      tooltip: 'Close navigation',
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.of(context).pop()),
                ])),
          Expanded(
              child: SingleChildScrollView(
            key: const PageStorageKey('navigation-scroll'),
            child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Column(children: [
                  Center(
                      child: AnimatedContainer(
                    key: const ValueKey('navigation-avatar'),
                    duration: reducedMotion
                        ? Duration.zero
                        : const Duration(milliseconds: 180),
                    curve: Curves.easeOutCubic,
                    width: expanded ? 88 : 40,
                    height: expanded ? 88 : 40,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(expanded ? 0 : 20)),
                    child: Image.asset('assets/image/avatar.jpg',
                        fit: BoxFit.cover,
                        semanticLabel: 'ShadowPlusing avatar'),
                  )),
                  const SizedBox(height: 20),
                  ...List.generate(siteSections.length, (index) {
                    final selected = index == widget.selectedIndex;
                    return Semantics(
                        selected: selected,
                        child: Tooltip(
                          message: expanded ? '' : siteSections[index],
                          child: Material(
                            color: selected ? siteSelected : Colors.transparent,
                            child: InkWell(
                              key: ValueKey('nav-$index'),
                              onTap: () => widget.onSelected(index),
                              focusColor: siteAccent.withValues(alpha: .3),
                              hoverColor: siteAccent.withValues(alpha: .12),
                              child: Container(
                                height: 64,
                                decoration: BoxDecoration(
                                    border: Border(
                                        left: BorderSide(
                                            color: selected
                                                ? siteAccent
                                                : Colors.transparent,
                                            width: 4))),
                                child: OverflowBox(
                                    alignment: Alignment.centerLeft,
                                    minWidth: width - 4,
                                    maxWidth: width - 4,
                                    child: Row(children: [
                                      SizedBox(
                                          width: 64,
                                          child: Icon(_icons[index],
                                              size: 24,
                                              color: selected
                                                  ? const Color(0xFFB69AFF)
                                                  : const Color(0xFFE7E2FA))),
                                      Expanded(
                                          child: ExcludeSemantics(
                                              excluding: !expanded,
                                              child: Opacity(
                                                  opacity: expanded ? 1 : 0,
                                                  child: Text(
                                                      siteSections[index],
                                                      style:
                                                          siteHeading.copyWith(
                                                              fontSize: 16))))),
                                    ])),
                              ),
                            ),
                          ),
                        ));
                  })
                ])),
          )),
          if (!widget.drawer)
            SizedBox(
                height: 60,
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      key: const ValueKey('navigation-toggle'),
                      padding: const EdgeInsets.all(14),
                      tooltip: expanded
                          ? 'Collapse navigation'
                          : 'Expand navigation',
                      onPressed: () => setState(() => _expanded = !expanded),
                      icon: Icon(
                          expanded ? Icons.chevron_left : Icons.chevron_right),
                    ))),
        ]),
      ),
    );
  }
}
