import 'package:clay_containers/constants.dart';
import 'package:clay_containers/widgets/clay_animated_container.dart';
import 'package:flutter/material.dart';
import 'package:whistler/core/resources/index.dart';
import 'package:whistler/features/viewmodel/record/cubit/record_cubit.dart';

class RecordButtonDesignContainer extends StatelessWidget {
  const RecordButtonDesignContainer({
    super.key,
    required this.size,
    required this.state,
  });

  final Size size;
  final RecordState state;

  @override
  Widget build(BuildContext context) {
    return ClayAnimatedContainer(
      duration: const Duration(seconds: 1),
      curve: Curves.bounceIn,
      color: ColorManager.primary,
      height: size.height * 0.09,
      width: size.width * 0.19,
      borderRadius: AppSize.s25,
      surfaceColor: ColorManager.primary,
      parentColor:
          state is StartedRecordState ? ColorManager.blue : Colors.grey,
      depth: AppSize.s30.toInt(),
      spread: AppSize.s2,
      curveType: CurveType.concave,
      child: Icon(
        state is StartedRecordState
            ? AssetsManager.stopRecordButtonIcon
            : AssetsManager.startRecordButtonIcon,
        color: state is StartedRecordState ? ColorManager.red : Colors.grey,
        size: AppSize.s28,
      ),
    );
  }
}
