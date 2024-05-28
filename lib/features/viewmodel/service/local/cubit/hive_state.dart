part of 'hive_cubit.dart';

sealed class HiveState extends Equatable {
  const HiveState();

  @override
  List<Object> get props => [];
}

final class HiveInitial extends HiveState {
  final List<ChatModel>? chatList;

  const HiveInitial({required this.chatList});

  @override
  List<Object> get props => [chatList!];
}

final class HiveLoadingState extends HiveState {}

final class HiveFetchSuccessState extends HiveState {
  final List<ChatModel> chatList;

  const HiveFetchSuccessState({required this.chatList});

  @override
  List<Object> get props => [chatList];
}
