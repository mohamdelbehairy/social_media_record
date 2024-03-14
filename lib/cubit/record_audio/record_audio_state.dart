part of 'record_audio_cubit.dart';

@immutable
sealed class RecordAudioState {}

final class RecordAudioInitial extends RecordAudioState {}

final class PutRecordToDataBaseLoading extends RecordAudioState {}

final class PutRecordToDataBaseSuccess extends RecordAudioState {}

final class PutRecordToDataBaseFailure extends RecordAudioState {
  final String errorMessage;

  PutRecordToDataBaseFailure({required this.errorMessage});
}

final class GetRecordSuccess extends RecordAudioState {}

final class GetRecordFailure extends RecordAudioState {
  final String errorMessage;

  GetRecordFailure({required this.errorMessage});
}
