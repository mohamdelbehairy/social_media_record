import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:test50505050/model/record_model.dart';

class CustomListViewItem extends StatefulWidget {
  const CustomListViewItem({super.key, required this.recordModel});
  final RecordModel recordModel;

  @override
  State<CustomListViewItem> createState() => _CustomListViewItemState();
}

class _CustomListViewItemState extends State<CustomListViewItem> {
  bool isPlaying = false;
  AudioPlayer audioPlayer = AudioPlayer();
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  String formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  void initState() {
    super.initState();
    audioPlayerStateChanged();

    audioPlayerDurationChanged();

    audioPlayerPositionChanged();

    audioPlayerComplete();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        height: size.height * .1,
        width: size.width * .75,
        margin: EdgeInsets.only(top: size.width * .02),
        decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(size.width * .03)),
        child: Padding(
          padding: EdgeInsets.only(left: size.width * .02),
          child: Stack(
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () async {
                      if (isPlaying) {
                        await audioPlayer.pause();
                        setState(() {
                          isPlaying = false;
                        });
                      } else {
                        audioPlayer.onPlayerComplete.listen((event) {
                          setState(() {
                            isPlaying = false;
                          });
                        });
                        await audioPlayer
                            .play(UrlSource(widget.recordModel.audioUrl));
                        setState(() {
                          isPlaying = true;
                        });
                      }
                    },
                    child: Icon(
                        isPlaying ? FontAwesomeIcons.pause : Icons.play_arrow,
                        color: Colors.white,
                        size: isPlaying
                            ? size.height * .045
                            : size.height * .045),
                  ),
                  Slider(
                      min: 0,
                      max: duration.inSeconds.toDouble(),
                      value: position.inSeconds.toDouble(),
                      activeColor: Colors.red,
                      onChanged: (value) {
                        final position = Duration(seconds: value.toInt());
                        audioPlayer.seek(position);
                        audioPlayer.resume();
                      }),
                ],
              ),
              Positioned(
                bottom: size.width * .01,
                left: size.width * .04,
                child: Text(
                    isPlaying
                        ? formatTime(position.inSeconds)
                        : widget.recordModel.audioTime,
                    style: const TextStyle(color: Colors.white)),
              )
            ],
          ),
        ),
      ),
    );
  }

  StreamSubscription<PlayerState> audioPlayerStateChanged() {
    return audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.playing;
      });
    });
  }

  void audioPlayerDurationChanged() {
    audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });
  }

  void audioPlayerPositionChanged() {
    audioPlayer.onPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });
  }

  StreamSubscription<void> audioPlayerComplete() {
    return audioPlayer.onPlayerComplete.listen((event) {
      setState(() {
        isPlaying = false;
        position = Duration.zero;
      });
    });
  }
}
