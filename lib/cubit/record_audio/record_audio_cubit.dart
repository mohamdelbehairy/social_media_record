import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test50505050/model/record_model.dart';
import 'package:uuid/uuid.dart';

part 'record_audio_state.dart';

class RecordAudioCubit extends Cubit<RecordAudioState> {
  RecordAudioCubit() : super(RecordAudioInitial());

  Future<void> putRecordToDataBase(
      {required String audioUrl, required String audioTime}) async {
    emit(PutRecordToDataBaseLoading());
    try {
      String docID = const Uuid().v1();
      RecordModel recordModel = RecordModel.fromJson({
        'audioUrl': audioUrl,
        'audioTime': audioTime,
      });
      await FirebaseFirestore.instance
          .collection('audio')
          .doc(docID)
          .set(recordModel.toMap());
      emit(PutRecordToDataBaseSuccess());
    } catch (e) {
      emit(PutRecordToDataBaseFailure(errorMessage: e.toString()));
      debugPrint('error from put record tot data base method: ${e.toString()}');
    }
  }

  List<RecordModel> recordList = [];
  void getRecord() {
    try {
      FirebaseFirestore.instance
          .collection('audio')
          .snapshots()
          .listen((snapshot) {
        recordList = [];
        for (var record in snapshot.docs) {
          recordList.add(RecordModel.fromJson(record));
        }

        emit(GetRecordSuccess());
      });
    } catch (e) {
      emit(GetRecordFailure(errorMessage: e.toString()));
      debugPrint('error from get record method: ${e.toString()}');
    }
  }
}
