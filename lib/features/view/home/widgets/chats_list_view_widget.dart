import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whistler/features/view/home/mixin/date_time_picker_mixin.dart';
import 'package:whistler/features/view/home/widgets/index.dart';
import 'package:whistler/features/viewmodel/service/whistler/whistler_cubit.dart';

import '../mixin/date_time_formatter_mixin.dart';

class ChatListViewWidget extends StatelessWidget
    with DateTimeFormatterMixin, DateTimePickerMixin {
  const ChatListViewWidget(
      {super.key, required this.state, required this.size});
  final WhistlerLoadedState state;
  final Size size;
  @override
  Widget build(BuildContext context) {
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
              time: state.chatList?[index].time ?? '', index: index, size: size,
              //height: size.height * 0.05,
            ),
            ChatBubblesWidget(
              text: state.chatList?[index].transcribedText ?? '',
              time: pickDateTime(state.chatList?[index].time ?? ''),
              index: index,
              //height: size.height * 0.05,
            ),
            SizedBox(height: size.height * 0.01),
            Text(pickDateTime(state.chatList?[index].time ?? ''),
                style: const TextStyle(fontSize: 12, color: Colors.grey))
          ],
        );
      },
    );
  }
}
