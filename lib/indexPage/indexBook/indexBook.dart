import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../global/siteStyle.dart';

class WebsiteProject {
  const WebsiteProject(
      this.title, this.subtitle, this.description, this.art, this.url);
  final String title, subtitle, description, art, url;
  String get image => 'assets/image/book/redesign/$art.webp';
  bool get isRepository => Uri.parse(url).host == 'github.com';
}

const websiteProjects = [
  WebsiteProject(
      'Custom Search Page',
      'A personal search start page.',
      'A clean and minimal search start page, designed for a calmer and more focused browsing experience. It helps me get to what matters, faster.',
      'search',
      'https://shadowplusing.website/custom_search_page/'),
  WebsiteProject(
      'SubFont Package',
      'Font subsetting utility.',
      'Keep the characters you need in a smaller font package. A small utility for making custom type more practical on the web.',
      'font',
      'https://github.com/shAdow-XJY/subFontPackage'),
  WebsiteProject(
      'Writing Writer',
      'A local writing app.',
      'A personal writing application with local storage. A quiet space for drafts, notes and the next idea.',
      'writing',
      'https://github.com/shAdow-XJY/writing_wirter'),
  WebsiteProject(
      'Backend Service',
      'Local backend tools.',
      'A simple local backend service with a web interface for debugging. Built for trying things out and understanding how they work.',
      'backend',
      'https://github.com/shAdow-XJY/backend_service'),
  WebsiteProject(
      'Novel Read',
      'A reading app · in progress.',
      'A simple web reading page, still in progress. An ongoing experiment in making room for the story.',
      'reading',
      'https://shadowplusing.website/novel_read/'),
];

class IndexBook extends StatefulWidget {
  const IndexBook({Key? key}) : super(key: key);
  @override
  State<IndexBook> createState() => _IndexBookState();
}

class _IndexBookState extends State<IndexBook> {
  int _selected = 0;
  bool _expanded = true;
  bool _restored = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_restored) {
      _selected = (PageStorage.maybeOf(context)
              ?.readState(context, identifier: 'project') as int?) ??
          0;
      _restored = true;
    }
  }

  void _select(int index, bool compact) {
    setState(() {
      _expanded = !compact || index != _selected || !_expanded;
      _selected = index;
    });
    PageStorage.maybeOf(context)
        ?.writeState(context, index, identifier: 'project');
  }

  Future<void> _open(WebsiteProject project) async {
    try {
      if (await launchUrl(Uri.parse(project.url),
          webOnlyWindowName: '_blank')) {
        return;
      }
    } catch (_) {
      // Keep the selection available when the browser refuses a new tab.
    }
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Could not open the link. Please try again.'),
        action:
            SnackBarAction(label: 'Retry', onPressed: () => _open(project))));
  }

  Widget _art(WebsiteProject project,
          {bool thumbnail = false, bool panorama = false}) =>
      ClipRRect(
          borderRadius: BorderRadius.circular(thumbnail ? 6 : 8),
          child: Image.asset(project.image,
              fit: BoxFit.cover,
              alignment: panorama && project.art == 'search'
                  ? Alignment.topCenter
                  : Alignment.center,
              width: thumbnail ? 72 : double.infinity,
              height: thumbnail ? 72 : null,
              cacheWidth: thumbnail ? 192 : 1280,
              excludeFromSemantics: true,
              errorBuilder: (_, __, ___) => SizedBox(
                  height: thumbnail ? 72 : 180,
                  child: const Center(
                      child: Icon(Icons.image_not_supported_outlined,
                          color: siteMuted)))));

  Widget _detail(WebsiteProject project, {required bool compact}) =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        AspectRatio(
            aspectRatio: compact ? 2.6 : 1.92,
            child: _art(project, panorama: compact)),
        if (!compact) ...[
          const SizedBox(height: 20),
          Text(project.title, style: siteHeading.copyWith(fontSize: 40)),
          const SizedBox(height: 4),
          Text(project.subtitle, style: siteBody.copyWith(fontSize: 18)),
        ],
        SizedBox(height: compact ? 12 : 24),
        Text(project.description, style: siteBody.copyWith(fontSize: 16)),
        const SizedBox(height: 18),
        FilledButton.icon(
            key: const ValueKey('open-project'),
            onPressed: () => _open(project),
            style: FilledButton.styleFrom(
                backgroundColor: siteAccent,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 22, vertical: 17),
                minimumSize: const Size(0, 48),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(9)),
                textStyle: siteHeading.copyWith(fontSize: 19)),
            label: Text(project.isRepository ? 'View source' : 'Open website'),
            icon: const Icon(Icons.north_east, size: 19),
            iconAlignment: IconAlignment.end),
        if (!compact) ...[
          const SizedBox(height: 30),
          const Divider(color: siteDivider),
          const SizedBox(height: 20),
          Text('Small apps, made with curiosity.',
              style: siteBody.copyWith(fontStyle: FontStyle.italic)),
        ],
      ]);

  Widget _row(int index, bool compact) {
    final project = websiteProjects[index];
    final active = index == _selected && (!compact || _expanded);
    return Material(
        color: active ? siteSelected : Colors.transparent,
        borderRadius: BorderRadius.circular(compact ? 6 : 0),
        clipBehavior: Clip.antiAlias,
        child: Column(children: [
          Semantics(
              key: ValueKey('project-semantics-$index'),
              container: true,
              button: true,
              excludeSemantics: true,
              label: '${project.title}. ${project.subtitle}',
              onTap: () => _select(index, compact),
              selected: active,
              expanded: compact ? active : null,
              child: InkWell(
                  key: ValueKey('project-$index'),
                  onTap: () => _select(index, compact),
                  focusColor: siteAccent.withValues(alpha: .3),
                  child: Container(
                      decoration: BoxDecoration(
                          border: Border(
                              left: BorderSide(
                                  width: 4,
                                  color: active
                                      ? siteAccent
                                      : Colors.transparent))),
                      padding: EdgeInsets.fromLTRB(compact ? 10 : 16,
                          compact ? 12 : 20, 12, compact ? 12 : 20),
                      child: Row(children: [
                        _art(project, thumbnail: true),
                        const SizedBox(width: 16),
                        Expanded(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                              Text(project.title,
                                  style: siteHeading.copyWith(fontSize: 19)),
                              const SizedBox(height: 4),
                              Text(project.subtitle,
                                  style: siteBody.copyWith(
                                      fontSize: compact ? 14 : 13)),
                            ])),
                        if (compact) ...[
                          const SizedBox(width: 6),
                          Icon(
                              active
                                  ? Icons.keyboard_arrow_up
                                  : Icons.chevron_right,
                              color: siteMuted,
                              size: 21)
                        ],
                      ])))),
          if (compact && active)
            Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 12, 18),
                child: _detail(project, compact: true)),
        ]));
  }

  @override
  Widget build(BuildContext context) =>
      LayoutBuilder(builder: (context, constraints) {
        // Break on actual content width; a sidebar must not squeeze the detail view.
        final compact = constraints.maxWidth < 820;
        if (compact) {
          return ListView(
              key: const PageStorageKey('projects-compact-scroll'),
              padding: const EdgeInsets.fromLTRB(8, 20, 8, 24),
              children: [
                const Text('Personal web projects, built with curiosity.',
                    style: siteBody),
                const SizedBox(height: 20),
                for (var i = 0; i < websiteProjects.length; i++) ...[
                  _row(i, true),
                  const Divider(height: 12, color: siteDivider),
                ],
                const SizedBox(height: 8),
                Text('Ideas live longer here.',
                    style: siteBody.copyWith(
                        fontStyle: FontStyle.italic, fontSize: 14)),
              ]);
        }
        return Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          SizedBox(
              width: 304,
              child: ColoredBox(
                  color: siteSurface,
                  child: ListView(
                      key: const PageStorageKey('projects-desktop-scroll'),
                      children: [
                        Padding(
                            padding: const EdgeInsets.fromLTRB(24, 28, 20, 20),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Websites',
                                      style:
                                          siteHeading.copyWith(fontSize: 26)),
                                  const SizedBox(height: 4),
                                  Text(
                                      'Personal projects, built with curiosity.',
                                      style: siteBody.copyWith(fontSize: 13)),
                                ])),
                        for (var i = 0; i < websiteProjects.length; i++) ...[
                          _row(i, false),
                          const Divider(height: 1, color: siteDivider),
                        ],
                      ]))),
          Expanded(
              child: SingleChildScrollView(
                  key: ValueKey('detail-$_selected'),
                  padding: const EdgeInsets.all(24),
                  child: _detail(websiteProjects[_selected], compact: false))),
        ]);
      });
}
