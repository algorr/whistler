import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whistler/features/view/home/mixin/date_time_formatter_mixin.dart';
import 'package:whistler/features/view/home/mixin/date_time_picker_mixin.dart';
import 'package:whistler/features/viewmodel/service/whistler/whistler_cubit.dart';
import 'package:whistler/features/view/home/widgets/widgets.dart';

class NewHomeView extends StatelessWidget
    with DateTimeFormatterMixin, DateTimePickerMixin {
  const NewHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: const AppBarWidget(),
      floatingActionButton: RecordButtonWidget(size: size),
      body: BlocBuilder<WhistlerCubit, WhistlerState>(
        builder: (context, state) {
          if (state is WhistlerLoadingState ||
              state is WhistlerWaitingForDataComesState) {
            return LoadingContainerWidget(size: size);
          } else if (state is WhistlerLoadedState) {
            return Container(
              height: size.height,
              width: size.width,
              decoration: const BoxDecoration(color: Colors.black),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: _chatsListViewWidget(state),
                    ),
                  ),
                  SafeArea(
                    child: Row(
                      children: [
                        AudioWaveWidget(size: size),
                        const SizedBox(width: 16),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }

          return Container(
            color: Colors.black,
          );
        },
      ),
    );
  }

  ListView _chatsListViewWidget(WhistlerLoadedState state) {
    return ListView.builder(
      itemCount: state.chatList?.length,
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return state.chatList != null
            ? Column(
                children: [
                  AudioPlayerWidget(
                    audioPath: state.chatList?[index].audioFilePath ?? '',
                    time: state.chatList?[index].time ?? '',
                  ),
                  ChatBubblesWidget(
                    text: state.chatList?[index].transcribedText ?? '',
                    time: pickDateTime(state.chatList?[index].time ?? ''),
                    index: index,
                    //height: size.height * 0.05,
                  ),
                ],
              )
            : Container();
      },
    );
  }
}
