import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whistler/core/resources/index.dart';
import 'package:whistler/features/view/home/mixin/date_time_formatter_mixin.dart';
import 'package:whistler/features/view/home/mixin/date_time_picker_mixin.dart';
import 'package:whistler/features/view/home/widgets/index.dart';
import 'package:whistler/features/viewmodel/service/whistler/whistler_cubit.dart';

final class HomeView extends StatelessWidget
    with DateTimeFormatterMixin, DateTimePickerMixin {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBarWidget(
        size: size,
      ),
      floatingActionButton: RecordButtonWidget(size: size),
      body: BlocBuilder<WhistlerCubit, WhistlerState>(
        builder: (context, state) {
          if (state is WhistlerLoadingState ||
              state is WhistlerWaitingForDataComesState) {
            return LoadingContainerWidget(size: size);
          } else if (state is WhistlerLoadedState) {
            return Container(
              height: size.height * .75,
              width: size.width,
              decoration: BoxDecoration(color: ColorManager.primary),
              child: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(size.width * 0.04),
                      child: _chatsListViewWidget(state, context, size),
                    ),
                  ),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  ListView _chatsListViewWidget(
      WhistlerLoadedState state, BuildContext context, Size size) {
    return ListView.builder(
      controller: context.read<WhistlerCubit>().scrollController,
      itemCount: state.chatList?.length,
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Column(
          children: [
            AudioPlayerWidget(
              audioPath: state.chatList?[index].audioFilePath ?? '',
              time: state.chatList?[index].time ?? '', index: index,
              //height: size.height * 0.05,
            ),
            ChatBubblesWidget(
              text: state.chatList?[index].transcribedText ?? '',
              time: pickDateTime(state.chatList?[index].time ?? ''),
              index: index,
              //height: size.height * 0.05,
            ),
            Text(pickDateTime(state.chatList?[index].time ?? ''),
                style: const TextStyle(fontSize: 12, color: Colors.grey))
          ],
        );
      },
    );
  }
}
