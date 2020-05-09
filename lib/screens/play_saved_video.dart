import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:video_player/video_player.dart';

class PlaySavedVideo extends StatefulWidget {
  final String fileVideo;
  PlaySavedVideo(this.fileVideo);

  @override
  _PlaySavedVideoState createState() => _PlaySavedVideoState();
}

class _PlaySavedVideoState extends State<PlaySavedVideo> {
  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File(widget.fileVideo));

    _controller.addListener(() {
      setState(() {});
    });
    _controller.setLooping(true);
    _controller.initialize().then((_) => setState(() {}));
    _controller.play();
    print(_controller.value.isPlaying);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Play Video",
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w800,
          ),
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          setState(() {
            _controller.value.isPlaying
                ? _controller.pause()
                : _controller.play();
          });
        },
        child: FaIcon(
          _controller.value.isPlaying
              ? FontAwesomeIcons.pause
              : FontAwesomeIcons.play,
          color: Colors.white,
        ),
      ),
      body: Center(
        child: _controller.value.initialized
            ? Padding(
                padding: EdgeInsets.only(
                  top: 5.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: Stack(
                        children: <Widget>[
                          VideoPlayer(_controller),
                          Padding(
                            padding: EdgeInsets.only(
                              bottom: 5.0,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                VideoProgressIndicator(
                                  _controller,
                                  allowScrubbing: true,
                                  colors: VideoProgressColors(
                                    backgroundColor: Colors.green[100],
                                    bufferedColor: Colors.green[300],
                                    playedColor: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            : Container(),
      ),
    );
  }
}
