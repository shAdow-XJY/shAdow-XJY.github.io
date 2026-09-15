import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'siteStyle.dart';

class MusicPlayer extends StatefulWidget {
  const MusicPlayer({Key? key, this.enabled = true}) : super(key: key);
  final bool enabled;
  @override
  State<MusicPlayer> createState() => MusicPlayerState();
}

class MusicPlayerState extends State<MusicPlayer> {
  final _player = AssetsAudioPlayer();
  bool _busy = false;
  bool _opened = false;
  bool _suspended = false;
  int _suspendEpoch = 0;

  Future<void> suspend() async {
    _suspendEpoch++;
    setState(() => _suspended = true);
    // An in-flight open checks this flag before it is allowed to keep playing.
    if (_opened) await _player.pause();
  }

  void release() {
    if (mounted) setState(() => _suspended = false);
  }

  Future<void> _operate(int command) async {
    if (_busy || _suspended || !widget.enabled) return;
    final epoch = _suspendEpoch;
    setState(() => _busy = true);
    try {
      if (!_opened) {
        await _player.open(
          Playlist(
            startIndex: command == 1 ? 3 : (command == 2 ? 1 : 0),
            audios: [
              Audio('assets/music/KoheiTanaka_BeyondtheHappyEnd.mp3'),
              Audio('assets/music/KoheiTanaka_FleetingFragmentofMemory.mp3'),
              Audio('assets/music/KoheiTanaka_Ifyouarewithyou.mp3'),
              Audio('assets/music/KoheiTanaka_Smallguide.mp3'),
            ],
          ),
          loopMode: LoopMode.playlist,
          autoStart: true,
        );
        _opened = true;
        if (_suspended || epoch != _suspendEpoch || !mounted)
          await _player.pause();
      } else if (command == 0) {
        await _player.playOrPause();
      } else if (command == 1) {
        await _player.previous();
      } else {
        await _player.next();
      }
    } catch (_) {
      _opened = false;
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Music could not play. Please try again.'),
            action: SnackBarAction(
              label: 'Retry',
              onPressed: () => _operate(command),
            ),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => StreamBuilder<bool>(
    stream: _player.isPlaying,
    initialData: _player.isPlaying.value,
    builder: (context, snapshot) => SizedBox(
      width: 132,
      child: Row(
        children: [
          _button(
            snapshot.data == true ? 'Pause music' : 'Play music',
            snapshot.data == true ? Icons.pause : Icons.play_arrow,
            0,
            primary: true,
          ),
          _button('Previous track', Icons.skip_previous, 1),
          _button('Next track', Icons.skip_next, 2),
        ],
      ),
    ),
  );

  Widget _button(
    String label,
    IconData icon,
    int command, {
    bool primary = false,
  }) => SizedBox(
    width: 44,
    height: 44,
    child: IconButton(
      tooltip: label,
      onPressed: _busy || _suspended || !widget.enabled
          ? null
          : () => _operate(command),
      style: IconButton.styleFrom(
        foregroundColor: primary
            ? const Color(0xFFB69AFF)
            : const Color(0xFFE7E2FA),
      ),
      icon: _busy && primary
          ? const SizedBox(
              width: 18,
              height: 18,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: siteAccent,
                semanticsLabel: 'Loading music',
              ),
            )
          : Icon(icon, size: primary ? 26 : 21),
    ),
  );
}
