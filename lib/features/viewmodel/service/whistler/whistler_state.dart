part of 'whistler_cubit.dart';

sealed class WhistlerState extends Equatable {
  const WhistlerState();

  @override
  List<Object> get props => [];
}

final class WhistlerInitial extends WhistlerState {
  bool isRecording;

  WhistlerInitial({required this.isRecording});

  @override
  List<Object> get props => [isRecording];
}

final class WhistlerLoadingState extends WhistlerState {}

final class WhistlerWaitingForDataComesState extends WhistlerState {}

final class WhistlerStartedRecordState extends WhistlerState {
  final bool isRecording;

  const WhistlerStartedRecordState(this.isRecording);

  @override
  List<Object> get props => [isRecording];
}

final class LanguageChangedState extends WhistlerState {
  final bool isLanguageTurkish;

  const LanguageChangedState(this.isLanguageTurkish);

  @override
  List<Object> get props => [isLanguageTurkish];
}

final class WhistlerStopRecordState extends WhistlerState {
  final bool isRecording;

  const WhistlerStopRecordState(this.isRecording);

  @override
  List<Object> get props => [isRecording];
}

final class WhistlerLoadedState extends WhistlerState {
  final List<ChatModel>? chatList;

  const WhistlerLoadedState({
    required this.chatList,
  });

  @override
  List<Object> get props => [chatList!];
}
