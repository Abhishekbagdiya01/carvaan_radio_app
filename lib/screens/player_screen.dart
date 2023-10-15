import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:flutter_radio/utils/const.dart';
import 'package:flutter_radio/utils/shared_pref.dart';

import 'package:flutter_radio_player/flutter_radio_player.dart';
import 'package:flutter_radio_player/models/frp_source_modal.dart';
import 'package:lottie/lottie.dart';

class PlayerScreen extends StatefulWidget {
  PlayerScreen({
    required this.radioStation,
  });
  Map radioStation;

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  final FlutterRadioPlayer flutterRadioPlayer = FlutterRadioPlayer();
  bool isPlaying = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isMusicPlaying();
  }

  void isMusicPlaying() async {
    final title = await SharedPref().getTitle();
    if (title == widget.radioStation["title"]) {
      isPlaying = true;
      setState(() {});
      log("yep song is playing /n isMusicPlaying $isPlaying");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "Now playing ${widget.radioStation["title"]}",
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(10),
              height: 250,
              width: MediaQuery.sizeOf(context).width * .8,
              child: widget.radioStation["imageUrl"] != ""
                  ? Image.network(widget.radioStation["imageUrl"])
                  : Image.asset(APPLOGO),
            ),
            Container(
              child: Column(
                children: [
                  Text(
                    "${widget.radioStation["title"]}",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                      width: MediaQuery.sizeOf(context).width * .8,
                      height: 150,
                      child: isPlaying
                          ? LottieBuilder.asset(lottieEffect)
                          : SizedBox(
                              height: 150,
                            )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.skip_previous,
                        size: 100,
                      ),
                      IconButton(
                        onPressed: () {
                          FRPSource newFRPSource = frpSource();
                          flutterRadioPlayer.initPlayer();
                          flutterRadioPlayer.addMediaSources(newFRPSource);
                          if (isPlaying == false) {
                            flutterRadioPlayer.play();
                            SharedPref().setTitle(widget.radioStation["title"]);
                            setState(() {
                              isPlaying = true;
                            });
                            log("$isPlaying");
                          } else {
                            flutterRadioPlayer.pause();
                            SharedPref().setTitle("");

                            setState(() {
                              isPlaying = false;
                            });
                            log("$isPlaying");
                          }
                        },
                        icon: Icon(
                          isPlaying ? Icons.pause_circle : Icons.play_circle,
                          color: Colors.white,
                          size: 100,
                        ),
                      ),
                      Icon(
                        Icons.skip_next,
                        size: 100,
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  FRPSource frpSource() {
    Map radio = widget.radioStation;
    log("url:${radio["url"]} || title : ${radio["title"]}");
    FRPSource newFRP = FRPSource(mediaSources: [
      MediaSources(
          url: radio["url"],
          description: "",
          isPrimary: true,
          title: radio["title"],
          isAac: false),
    ]);
    return newFRP;
  }
}
