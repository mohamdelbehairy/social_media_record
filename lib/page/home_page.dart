import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test50505050/cubit/record_audio/record_audio_cubit.dart';
import 'package:test50505050/cubit/upload_record_audio/upload_record_audio_cubit.dart';
import 'package:test50505050/page/widget/home_page_body.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: const Text(
          'Social Recorder',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900),
        ),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => UploadRecordAudioCubit(),
          ),
          BlocProvider(
            create: (context) => RecordAudioCubit(),
          ),
        ],
        child: const HomePageBody(),
      ),
    );
  }
}
