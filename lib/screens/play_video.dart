import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photopixa/screens/search_video_screen.dart';
import 'package:video_player/video_player.dart';

class PlayVideo extends StatefulWidget {
  final String videoURL;
  final String mvideoURL;
  final String svideoURL;
  final String tvideoURL;
  final String tags;
  final String fileName;
  PlayVideo(
    this.videoURL,
    this.mvideoURL,
    this.svideoURL,
    this.tvideoURL,
    this.fileName,
    this.tags,
  );

  @override
  _PlayVideoState createState() => _PlayVideoState();
}

class _PlayVideoState extends State<PlayVideo> {
  VideoPlayerController _controller;
  var progress = "";
  bool downloading = false;
  bool _isPermissionGranted = false;

  checkPermission() async {
    var status = await Permission.storage.status;
    if (status.isUndetermined) {
      // We didn't ask for permission yet.
      Permission.storage.request();
      setState(() {});
    } else if (status == PermissionStatus.denied) {
      Permission.storage.request();
    } else if (status == PermissionStatus.granted) {
      setState(() {
        _isPermissionGranted = true;
      });
    }
  }

  Future<void> _download(downloadURL) async {
    Dio dio = Dio();

    //App Document Directory + folder name
    final Directory _appDocDirFolder = Directory(
      '/storage/emulated/0/HD Wallpaper/',
    );

    if (await _appDocDirFolder.exists()) {
      //if folder already exists return path
      print(_appDocDirFolder.path);
    } else {
      //if folder not exists create folder and then return its path
      final Directory _appDocDirNewFolder =
          await _appDocDirFolder.create(recursive: true);
      print(_appDocDirNewFolder.path);
    }

    await dio.download(
        downloadURL, "/storage/emulated/0/HD Wallpaper/${widget.fileName}.mp4",
        onReceiveProgress: (rec, total) {
      setState(() {
        downloading = true;
        progress = ((rec / total) * 100).toStringAsFixed(0) + "%";
      });
    });

    try {} catch (e) {
      throw e;
    }
    setState(() {
      downloading = false;
      progress = "Complete";
    });
  }

  @override
  void initState() {
    super.initState();
    checkPermission();
    _controller = VideoPlayerController.network(widget.videoURL);

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
    List showTags = widget.tags.split(",");
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
      body: !_isPermissionGranted
          ? Container(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.0,
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      RaisedButton(
                        onPressed: () {
                          checkPermission();
                        },
                        child: Text(
                          "Allow Permission",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        padding: const EdgeInsets.all(15.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10.0),
                        ),
                        color: Theme.of(context).primaryColor,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 18.0,
                        ),
                        child: Text(
                          "If you have already allowed permission, just click on button again.",
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          : Center(
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
                                          playedColor:
                                              Theme.of(context).primaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(
                              10.0,
                              15.0,
                              10.0,
                              10.0,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Text(
                                  "Tags used in video",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                ListView(
                                  primary: true,
                                  shrinkWrap: true,
                                  children: <Widget>[
                                    Wrap(
                                      spacing: 4.0,
                                      runSpacing: 0.0,
                                      children: List<Widget>.generate(
                                          showTags.length, (int index) {
                                        return InputChip(
                                          label: Text(
                                            showTags[index].trim(),
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          backgroundColor: Colors.green,
                                          elevation: 10.0,
                                          onPressed: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) {
                                                  return SearchVideoScreen(
                                                    showTags[index].trim(),
                                                  );
                                                },
                                              ),
                                            );
                                          },
                                        );
                                      }).toList(),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  "Download video",
                                ),
                                Visibility(
                                  visible:
                                      progress == "Complete" || progress == ""
                                          ? false
                                          : true,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 10.0,
                                    ),
                                    child: Text(
                                      "Downloading video - $progress",
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Visibility(
                                  visible:
                                      progress == "Complete" || progress == ""
                                          ? true
                                          : false,
                                  child: Wrap(
                                    spacing: 10.0,
                                    runSpacing: 0.0,
                                    children: <Widget>[
                                      CircleAvatar(
                                        radius: 25,
                                        backgroundColor:
                                            Theme.of(context).primaryColor,
                                        child: FlatButton(
                                          onPressed: () {
                                            _download(
                                              widget.videoURL,
                                            );
                                          },
                                          child: Text(
                                            "L",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontSize: 20.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                      CircleAvatar(
                                        radius: 25,
                                        backgroundColor:
                                            Theme.of(context).primaryColor,
                                        child: FlatButton(
                                          onPressed: () {
                                            _download(
                                              widget.mvideoURL,
                                            );
                                          },
                                          child: Text(
                                            "M",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontSize: 20.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                      CircleAvatar(
                                        radius: 25,
                                        backgroundColor:
                                            Theme.of(context).primaryColor,
                                        child: FlatButton(
                                          onPressed: () {
                                            _download(
                                              widget.svideoURL,
                                            );
                                          },
                                          child: Text(
                                            "S",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontSize: 20.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                      CircleAvatar(
                                        radius: 25,
                                        backgroundColor:
                                            Theme.of(context).primaryColor,
                                        child: FlatButton(
                                          onPressed: () {
                                            _download(
                                              widget.tvideoURL,
                                            );
                                          },
                                          child: Text(
                                            "T",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontSize: 20.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 15.0,
                                ),
                                Text(
                                  "*L - Large",
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  "*M - Medium",
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  "*S - Small",
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  "*T - Tiny",
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(),
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
              ? FontAwesomeIcons.pauseCircle
              : FontAwesomeIcons.playCircle,
          color: Colors.white,
        ),
      ),
    );
  }
}
