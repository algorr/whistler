import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:clay_containers/constants.dart';
import 'package:clay_containers/widgets/clay_animated_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whistler/features/viewmodel/record/cubit/record_cubit.dart';
import 'package:whistler/features/viewmodel/service/whistler/whistler_cubit.dart';

class RecordButtonWidget extends StatelessWidget {
  const RecordButtonWidget({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecordCubit, RecordState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            state is StartedRecordState
                ? AudioWaveforms(
                    enableGesture: true,
                    size: Size(size.width * .6, 50),
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
                    width: size.width * .4,
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
            InkWell(
              onTap: () async {
                context.read<WhistlerCubit>().filePath =
                    await context.read<RecordCubit>().startStopRecord() ?? '';

                context.read<WhistlerCubit>().decideLanguage();
              },
              child: ClayAnimatedContainer(
                duration: const Duration(seconds: 1),
                curve: Curves.bounceIn,
                color: Colors.black,
                height: 80,
                width: 80,
                borderRadius: 25,
                surfaceColor: Colors.black,
                parentColor:
                    state is StartedRecordState ? Colors.blue : Colors.grey,
                depth: 30,
                spread: 2,
                curveType: CurveType.concave,
                child: Icon(
                  state is StartedRecordState ? Icons.stop : Icons.mic,
                  color: state is StartedRecordState ? Colors.red : Colors.grey,
                  size: 28,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
