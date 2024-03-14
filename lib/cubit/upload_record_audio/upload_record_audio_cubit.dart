import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'upload_record_audio_state.dart';

class UploadRecordAudioCubit extends Cubit<UploadRecordAudioState> {
  UploadRecordAudioCubit() : super(UploadRecordAudioInitial());

  Future<String> uploadRecordAudio({required File audioFile}) async {
    emit(UploadRecordAudioLoading());
    try {
      String audioName = 'audio_${DateTime.now().microsecondsSinceEpoch}.acc';
      Reference reference =
          FirebaseStorage.instance.ref().child('audio/$audioName');
     await reference.putFile(audioFile);
      String downloadUrl = await reference.getDownloadURL();
      emit(UploadRecordAudioSuccess());
      return downloadUrl;
    } catch (e) {
      debugPrint('error from upload record audio cubit: ${e.toString()}');
      emit(UploadRecordAudioFailure(errorMessage: e.toString()));
      return '';
    }
  }
}
