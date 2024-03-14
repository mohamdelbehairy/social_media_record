import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test50505050/cubit/record_audio/record_audio_cubit.dart';
import 'package:test50505050/page/widget/custom_list_view_item.dart';

class CustomListView extends StatelessWidget {
  const CustomListView({super.key});

  @override
  Widget build(BuildContext context) {
    var recordAudio = context.read<RecordAudioCubit>();
    recordAudio.getRecord();
    return Expanded(child: BlocBuilder<RecordAudioCubit, RecordAudioState>(
      builder: (context, state) {
        return ListView.builder(
            itemCount: recordAudio.recordList.length,
            itemBuilder: (context, index) {
              return CustomListViewItem(
                  recordModel: recordAudio.recordList[index]);
            });
      },
    ));
  }
}
