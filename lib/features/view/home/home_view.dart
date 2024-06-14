import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whistler/core/resources/index.dart';
import 'package:whistler/features/view/home/widgets/chats_list_view_widget.dart';
import 'package:whistler/features/view/home/widgets/index.dart';
import 'package:whistler/features/viewmodel/service/whistler/whistler_cubit.dart';

final class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
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
              height: size.height * .8,
              width: size.width,
              decoration: BoxDecoration(color: ColorManager.primary),
              child: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(size.width * 0.04),
                      child: ChatListViewWidget(state: state, size: size),
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
}
