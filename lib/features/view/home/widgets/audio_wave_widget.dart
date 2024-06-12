import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whistler/features/viewmodel/record/cubit/record_cubit.dart';

class AudioWaveWidget extends StatelessWidget {
  const AudioWaveWidget({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      child: context.read<RecordCubit>().isRecording
          ? AudioWaveforms(
              enableGesture: true,
              size: Size(size.width / 2, 50),
              recorderController:
                  context.read<RecordCubit>().recorderController,
              waveStyle: const WaveStyle(
                  waveColor: Colors.white70,
                  extendWaveform: true,
                  showMiddleLine: false,
                  middleLineColor: Colors.red,
                  durationLinesColor: Colors.yellow),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: Colors.transparent,
              ),
              padding: const EdgeInsets.only(left: 18),
              margin: const EdgeInsets.symmetric(horizontal: 15),
            )
          : Container(
              width: MediaQuery.of(context).size.width / 1.7,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(12.0),
              ),
              padding: const EdgeInsets.only(left: 18),
              margin: const EdgeInsets.symmetric(horizontal: 15),
              child: const TextField(
                readOnly: true,
                decoration: InputDecoration(border: InputBorder.none),
              ),
            ),
    );
  }
}
