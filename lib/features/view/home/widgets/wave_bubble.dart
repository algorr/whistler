import 'dart:async';
import 'dart:io';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';

class WaveBubble extends StatefulWidget {
  final bool isSender;
  final int index;
  final String? path;
  final double? width;

  const WaveBubble({
    super.key,
    this.width,
    required this.index,
    this.isSender = false,
    this.path,
  });

  @override
  State<WaveBubble> createState() => _WaveBubbleState();
}

class _WaveBubbleState extends State<WaveBubble> {
  File? file;

  late PlayerController controller;
  late StreamSubscription<PlayerState> playerStateSubscription;

  final playerWaveStyle = const PlayerWaveStyle(
    fixedWaveColor: Colors.white54,
    liveWaveColor: Colors.white,
    spacing: 6,
  );

  @override
  void initState() {
    super.initState();
    controller = PlayerController();
    _preparePlayer();
    playerStateSubscription = controller.onPlayerStateChanged.listen((_) {
      setState(() {});
    });
  }

  void _preparePlayer() async {
    // Opening file from assets folder

    file = File(widget.path ?? '');
    print('File in path : ${file?.path}');

    // Prepare player with extracting waveform if index is even.
    controller.preparePlayer(
      path: widget.path ?? '',
      shouldExtractWaveform: true,
    );
    // Extracting waveform separately if index is odd.

    controller
        .extractWaveformData(
          path: widget.path!,
          noOfSamples: playerWaveStyle.getSamplesForWidth(widget.width ?? 300),
        )
        .then((waveformData) => debugPrint(waveformData.toString()));
  }

  @override
  void dispose() {
    playerStateSubscription.cancel();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.path != null || file?.path != null
        ? Align(
            alignment: widget.index.isOdd
                ? Alignment.centerRight
                : Alignment.centerLeft,
            child: Container(
              padding: EdgeInsets.only(
                bottom: 6,
                right: widget.isSender ? 0 : 10,
                top: 6,
              ),
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: widget.isSender
                    ? const Color(0xFF276bfd)
                    : const Color(0xFF343145),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!controller.playerState.isStopped)
                    IconButton(
                      onPressed: () async {
                        controller.playerState.isPlaying
                            ? await controller.pausePlayer()
                            : await controller.startPlayer(
                                finishMode: FinishMode.loop,
                              );
                      },
                      icon: Icon(
                        controller.playerState.isPlaying
                            ? Icons.stop
                            : Icons.play_arrow,
                        size: 30,
                      ),
                      color: Colors.white,
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                    ),
                  AudioFileWaveforms(
                    size: Size(MediaQuery.of(context).size.width / 2, 70),
                    playerController: controller,
                    waveformType: WaveformType.long,
                    playerWaveStyle: playerWaveStyle,
                  ),
                  if (widget.isSender) const SizedBox(width: 10),
                ],
              ),
            ),
          )
        : const SizedBox.shrink();
  }
}

/* class WaveBubble extends StatefulWidget {
  final bool isSender;
  final int index;
  final String? path;
  final double? width;

  const WaveBubble({
    super.key,
    this.width,
    required this.index,
    this.isSender = false,
    this.path,
  });

  @override
  State<WaveBubble> createState() => _WaveBubbleState();
}

class _WaveBubbleState extends State<WaveBubble> {
  File? file;

  late PlayerController controller;
  late StreamSubscription<PlayerState> playerStateSubscription;

  final playerWaveStyle = const PlayerWaveStyle(
    fixedWaveColor: Colors.white54,
    liveWaveColor: Colors.white,
    spacing: 6,
  );

  @override
  void initState() {
    super.initState();
    controller = PlayerController();
    _preparePlayer();
    playerStateSubscription = controller.onPlayerStateChanged.listen((_) {
      setState(() {});
    });
  }

  void _preparePlayer() async {
    // Opening file from assets folder

    file = File(widget.path ?? '');
    print('File in path : ${file?.path}');

    /* controller
        .extractWaveformData(
          path: widget.path!,
          noOfSamples: playerWaveStyle.getSamplesForWidth(widget.width ?? 300),
        )
        .then((waveformData) => debugPrint('waveform data : $waveformData')); */

    // Prepare player with extracting waveform if index is even.
    controller.preparePlayer(
      path: widget.path ?? '',
      shouldExtractWaveform: false,
    );

    print('Initalize da playerstate: ${controller.playerState}');
    // Extracting waveform separately if index is odd.
  }

  @override
  void dispose() {
    playerStateSubscription.cancel();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.path != null || file?.path != null
        ? IconButton(
            iconSize: 100,
            onPressed: () async {
              print('Basıldı');
              controller.playerState.isPlaying
                  ? await controller.pausePlayer()
                  : await controller.startPlayer(
                      finishMode: FinishMode.loop,
                    );
            },
            icon: Icon(
              controller.playerState.isPlaying ? Icons.stop : Icons.play_arrow,
              size: 30,
            ),
            color: Colors.white,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          )
        : const SizedBox.shrink();
  }
} */