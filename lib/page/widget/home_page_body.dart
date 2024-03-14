import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social_media_recorder/audio_encoder_type.dart';
import 'package:social_media_recorder/screen/social_media_recorder.dart';
import 'package:test50505050/cubit/record_audio/record_audio_cubit.dart';
import 'package:test50505050/cubit/upload_record_audio/upload_record_audio_cubit.dart';
import 'package:test50505050/page/widget/list_view.dart';

class HomePageBody extends StatefulWidget {
  const HomePageBody({super.key});

  @override
  State<HomePageBody> createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody> {
  @override
  Widget build(BuildContext context) {
    var uploadRecordAudio = context.read<UploadRecordAudioCubit>();
    var recordAudio = context.read<RecordAudioCubit>();
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Column(
        children: [
          const CustomListView(),
          Align(
            alignment: Alignment.centerRight,
            child: SocialMediaRecorder(
              backGroundColor: Colors.blue,
              initRecordPackageWidth: 60,
              fullRecordPackageHeight: 60,
              radius: BorderRadius.circular(50),
              recordIcon: const Icon(FontAwesomeIcons.microphone,
                  color: Colors.white, size: 25),
              startRecording: () {},
              stopRecording: (time) {},
              sendRequestFunction: (soudFile, time) async {
                String sound = await uploadRecordAudio.uploadRecordAudio(
                    audioFile: soudFile);
                await recordAudio.putRecordToDataBase(
                    audioUrl: sound, audioTime: time);
              },
              encode: AudioEncoderType.AAC,
            ),
          ),
        ],
      ),
    );
  }
}
