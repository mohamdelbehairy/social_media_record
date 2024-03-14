part of 'upload_record_audio_cubit.dart';

@immutable
sealed class UploadRecordAudioState {}

final class UploadRecordAudioInitial extends UploadRecordAudioState {}

final class UploadRecordAudioLoading extends UploadRecordAudioState {}

final class UploadRecordAudioSuccess extends UploadRecordAudioState {}

final class UploadRecordAudioFailure extends UploadRecordAudioState {
  final String errorMessage;

  UploadRecordAudioFailure({required this.errorMessage});
}
