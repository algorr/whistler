import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:whistler/core/utils/mixins/connection/check_internet_connection_mixin.dart';
import 'package:whistler/features/view/home/widgets/index.dart';
import 'package:whistler/features/viewmodel/record/cubit/record_cubit.dart';
import 'package:whistler/features/viewmodel/service/whistler/whistler_cubit.dart';
import 'record_button_design_container.dart';

final class RecordButtonWidget extends StatelessWidget
    with CheckInternetConnectionMixin {
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
            Expanded(
              flex: 4,
              child: AudioWaveWidget(
                size: size,
              ),
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                onTap: () async {
                  bool connectionCheck =
                      await InternetConnection().hasInternetAccess;
                  if (connectionCheck == false) {
                    await showInternetConnectionBottomSheet(size);
                  } else {
                    context.read<WhistlerCubit>().filePath = await context
                            .read<RecordCubit>()
                            .startStopRecord(context, size) ??
                        '';
                    if (context.mounted) {
                      context.read<WhistlerCubit>().decideLanguage();
                    }
                  }
                },
                child: RecordButtonDesignContainer(
                  size: size,
                  state: state,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
