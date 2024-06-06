import 'dart:io';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:typewritertext/v3/typewriter.dart';
import 'package:whistler/features/view/home/widgets/chat_bubles.dart';
import 'package:whistler/features/view/home/widgets/wave_bubble.dart';
import 'package:whistler/features/viewmodel/service/whistler/whistler_cubit.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<WhistlerCubit, WhistlerState>(
      builder: (context, state) {
        if (state is WhistlerInitial) {
          print('Home View de state: $state');
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              centerTitle: true,
              title:
                  const Text('Whistler', style: TextStyle(color: Colors.white)),
              backgroundColor: Colors.black,
            ),
            body: Container(
              decoration: const BoxDecoration(color: Colors.black),
              child: Center(
                child: Lottie.asset('assets/lottie/loading.json'),
              ),
            ),
          );
        } else if (state is WhistlerWaitingForDataComesState) {
          return Scaffold(
            body: Container(
              color: Colors.black,
              child: Center(
                child: Lottie.asset('assets/lottie/loading.json',
                    width: size.width / 2, height: size.height / 2),
              ),
            ),
          );
        } else if (state is WhistlerLoadedState) {
          print('Home View de state: $state');
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              centerTitle: true,
              title:
                  const Text('Whistler', style: TextStyle(color: Colors.white)),
              backgroundColor: Colors.black,
            ),
            floatingActionButton: InkWell(
              onTap: () {
                context.read<WhistlerCubit>().startStopRecord();
              },
              child: ClayAnimatedContainer(
                duration: const Duration(seconds: 1),
                curve: Curves.bounceIn,
                color: Colors.black,
                height: 80,
                width: 80,
                borderRadius: 25,
                surfaceColor: Colors.black,
                parentColor: Colors.grey,
                depth: 30,
                spread: 2,
                curveType: CurveType.concave,
                child: Icon(
                  Icons.mic,
                  color: Colors.grey.shade800,
                  size: 28,
                ),
              ),
            ),
            body: Container(
              decoration: const BoxDecoration(color: Colors.black),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                        itemCount: state.chatList?.length,
                        controller:
                            context.read<WhistlerCubit>().scrollController,
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          print(
                              'Listview de path : ${state.chatList?[index].audioFilePath}');
                          return /* ListTile(
                            tileColor: Colors.black,
                            style: ListTileStyle.list,
                            title: SizedBox(
                                height: size.height * 0.05,
                                child: TypeWriter.text(
                                  state.chatList?[index].transcribedText ?? '',
                                  maxLines: 100,
                                  maintainSize: true,
                                  style: const TextStyle(color: Colors.white),
                                  duration: const Duration(milliseconds: 30),
                                )),
                            subtitle: Text(
                              state.chatList?[index].time ?? '',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ); */
                              Column(
                            children: [
                              WaveBubble(
                                  path: state.chatList?[index].audioFilePath ??
                                      '',
                                  index: index),
                              ChatBubblesWidget(
                                text: state.chatList?[index].transcribedText ??
                                    '',
                                time: state.chatList?[index].time ?? '',
                                //height: size.height * 0.05,
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                  SafeArea(
                    child: Row(
                      children: [
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 200),
                          child: context.read<WhistlerCubit>().isRecording
                              ? AudioWaveforms(
                                  enableGesture: true,
                                  size: Size(size.width / 2, 50),
                                  recorderController: context
                                      .read<WhistlerCubit>()
                                      .recorderController,
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
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                )
                              : Container(
                                  width:
                                      MediaQuery.of(context).size.width / 1.7,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  padding: const EdgeInsets.only(left: 18),
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: const TextField(
                                    readOnly: true,
                                    decoration: InputDecoration(
                                        border: InputBorder.none),
                                  ),
                                ),
                        ),
                        const SizedBox(width: 16),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        } else if (state is WhistlerStartedRecordState) {
          print('Home View de state: $state');

          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              centerTitle: true,
              title:
                  const Text('Whistler', style: TextStyle(color: Colors.white)),
              backgroundColor: Colors.black,
            ),
            floatingActionButton: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                context.read<WhistlerCubit>().isRecording
                    ? AudioWaveforms(
                        enableGesture: true,
                        size: Size(size.width * .6, 50),
                        recorderController:
                            context.read<WhistlerCubit>().recorderController,
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
                  onTap: () {
                    context.read<WhistlerCubit>().startStopRecord();
                  },
                  child: ClayAnimatedContainer(
                    duration: const Duration(seconds: 1),
                    curve: Curves.bounceIn,
                    color: Colors.black,
                    height: 80,
                    width: 80,
                    borderRadius: 25,
                    surfaceColor: Colors.black,
                    parentColor: state.isRecording ? Colors.blue : Colors.grey,
                    depth: 30,
                    spread: 2,
                    curveType: CurveType.concave,
                    child: const Icon(
                      Icons.stop,
                      color: Colors.red,
                      size: 28,
                    ),
                  ),
                ),
              ],
            ),
            body: Container(
              decoration: const BoxDecoration(color: Colors.black),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  SafeArea(
                    child: Center(
                      child: Lottie.asset('assets/lottie/loading.json',
                          height: 70, width: 70),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return Container(
          color: Colors.red,
        );
      },
    );
  }
}
