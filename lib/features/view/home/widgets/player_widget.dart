import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whistler/core/resources/index.dart';
import 'package:whistler/features/view/home/mixin/date_time_formatter_mixin.dart';
import 'package:whistler/features/viewmodel/service/whistler/whistler_cubit.dart';

final class AudioPlayerWidget extends StatefulWidget {
  const AudioPlayerWidget(
      {super.key,
      required this.audioPath,
      required this.time,
      required this.index});

  final String audioPath;
  final String time;
  final int index;

  @override
  _AudioPlayerWidgetState createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget>
    with DateTimeFormatterMixin {
  late AudioPlayer _audioPlayer;
  bool isPlaying = false;
  bool isPaused = false;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void _playPauseAudio() async {
    if (isPlaying) {
      if (isPaused) {
        await _audioPlayer.resume();
      } else {
        await _audioPlayer.pause();
      }
      setState(() {
        isPaused = !isPaused;
      });
    } else {
      await _audioPlayer.play(DeviceFileSource(widget.audioPath));
      setState(() {
        isPlaying = true;
      });
    }
  }

  void _stopAudio() async {
    await _audioPlayer.stop();
    setState(() {
      isPlaying = false;
      isPaused = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final hour = formatDateTimeString(widget.time).split(' ').last;
    return Card(
      margin: const EdgeInsets.all(AppMargin.m8),
      child: ListTile(
        title: Text(hour),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(isPlaying
                  ? (isPaused ? Icons.play_arrow : Icons.pause)
                  : Icons.play_arrow),
              onPressed: _playPauseAudio,
            ),
            IconButton(
              icon: const Icon(Icons.stop),
              onPressed: _stopAudio,
            ),
            IconButton(
                onPressed: () =>
                    context.read<WhistlerCubit>().deleteItem(widget.index),
                icon: const Icon(Icons.delete_forever_outlined))
          ],
        ),
      ),
    );
  }
}
