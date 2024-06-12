part of 'record_cubit.dart';

sealed class RecordState extends Equatable {
  const RecordState();

  @override
  List<Object> get props => [];
}

final class RecordInitial extends RecordState {
  bool isRecording;

  RecordInitial({required this.isRecording});

  @override
  List<Object> get props => [isRecording];
}

final class StartedRecordState extends RecordState {
  bool isRecording;

  StartedRecordState({required this.isRecording});

  @override
  List<Object> get props => [isRecording];
}
