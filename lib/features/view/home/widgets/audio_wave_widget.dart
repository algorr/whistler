import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whistler/core/resources/index.dart';
import 'package:whistler/features/viewmodel/record/cubit/record_cubit.dart';

final class AudioWaveWidget extends StatelessWidget {
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
              size: Size(size.width / 2, size.height * .04),
              recorderController:
                  context.read<RecordCubit>().recorderController,
              waveStyle: WaveStyle(
                  waveColor: ColorManager.white70,
                  extendWaveform: true,
                  showMiddleLine: false,
                  middleLineColor: ColorManager.bezierColor1,
                  durationLinesColor: ColorManager.blue),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSize.s12),
                color: Colors.transparent,
              ),
              padding: const EdgeInsets.only(left: AppPadding.p18),
              margin: const EdgeInsets.symmetric(horizontal: AppMargin.m15),
            )
          : Container(
              width: MediaQuery.of(context).size.width / 1.7,
              height: size.height * .04,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(AppSize.s12),
              ),
              padding: const EdgeInsets.only(left: AppPadding.p18),
              margin: const EdgeInsets.symmetric(horizontal: AppMargin.m15),
              child: const TextField(
                readOnly: true,
                decoration: InputDecoration(border: InputBorder.none),
              ),
            ),
    );
  }
}
