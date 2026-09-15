import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../global/siteStyle.dart';

class CollectionEntry {
  const CollectionEntry(this.title, this.category, this.description, this.image,
      this.url, this.action);
  final String title, category, description, image, url, action;
}

const collectionEntries = [
  CollectionEntry(
      'Game Center',
      'PLAY & EXPLORE',
      'A place for games and small adventures. Pick something to play and take a little break.',
      'assets/image/collections/game.webp',
      'https://shadowplusing.website/shadow_game_center/',
      'Explore games'),
  CollectionEntry(
      'Novel Center',
      'READ & UNWIND',
      'Step into a different story. A quiet reading space, still growing one page at a time.',
      'assets/image/collections/novel.webp',
      'https://shadowplusing.website/novel_read/',
      'Open reading space'),
];

class IndexProgram extends StatelessWidget {
  const IndexProgram({Key? key}) : super(key: key);

  Future<void> _open(BuildContext context, CollectionEntry entry) async {
    try {
      if (await launchUrl(Uri.parse(entry.url), webOnlyWindowName: '_blank')) {
        return;
      }
    } catch (_) {
      // Keep both destinations available when opening a tab fails.
    }
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content:
            const Text('Could not open this collection. Please try again.'),
        action: SnackBarAction(
            label: 'Retry', onPressed: () => _open(context, entry))));
  }

  Widget _card(BuildContext context, int index) {
    final entry = collectionEntries[index];
    return Container(
        key: ValueKey('collection-$index'),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
            color: siteSurface,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: siteDivider)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.asset(entry.image,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  cacheWidth: 1280,
                  excludeFromSemantics: true,
                  errorBuilder: (_, __, ___) => const Center(
                      child: Icon(Icons.image_not_supported_outlined,
                          color: siteMuted)))),
          Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(entry.category,
                        style: siteBody.copyWith(
                            fontSize: 11,
                            letterSpacing: 2,
                            color: const Color(0xFFC4AFFA))),
                    const SizedBox(height: 10),
                    Text(entry.title,
                        style: siteHeading.copyWith(fontSize: 32)),
                    const SizedBox(height: 10),
                    Text(entry.description,
                        style: siteBody.copyWith(fontSize: 15)),
                    const SizedBox(height: 24),
                    FilledButton.icon(
                        key: ValueKey('open-collection-$index'),
                        onPressed: () => _open(context, entry),
                        style: FilledButton.styleFrom(
                            backgroundColor: siteAccent,
                            foregroundColor: Colors.white,
                            minimumSize: const Size(0, 48),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 16),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            textStyle: siteHeading.copyWith(fontSize: 18)),
                        icon: const Icon(Icons.north_east, size: 18),
                        iconAlignment: IconAlignment.end,
                        label: Text(entry.action)),
                  ])),
        ]));
  }

  @override
  Widget build(BuildContext context) =>
      LayoutBuilder(builder: (context, constraints) {
        final compact = constraints.maxWidth < 760;
        return SingleChildScrollView(
            key: const PageStorageKey('collections-scroll'),
            padding: EdgeInsets.all(compact ? 16 : 32),
            child: Align(
                alignment: Alignment.topCenter,
                child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1120),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (MediaQuery.of(context).size.width >= 700) ...[
                            Text('Collections',
                                style: siteHeading.copyWith(fontSize: 36)),
                            const SizedBox(height: 8),
                          ],
                          Text(
                              'A little space for play. A little space for stories.',
                              style: siteBody.copyWith(fontSize: 16)),
                          const SizedBox(height: 28),
                          if (compact) ...[
                            _card(context, 0),
                            const SizedBox(height: 20),
                            _card(context, 1),
                          ] else
                            Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(child: _card(context, 0)),
                                  const SizedBox(width: 24),
                                  Expanded(child: _card(context, 1)),
                                ]),
                          const SizedBox(height: 28),
                          const Divider(color: siteDivider),
                          const SizedBox(height: 12),
                          Text('Made for the moments in between.',
                              style: siteBody.copyWith(
                                  fontSize: 13, fontStyle: FontStyle.italic)),
                        ]))));
      });
}
