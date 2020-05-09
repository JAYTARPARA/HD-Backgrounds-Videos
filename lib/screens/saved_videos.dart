import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photopixa/screens/play_saved_video.dart';
import 'package:photopixa/widgets/loading.dart';

class SavedVideos extends StatefulWidget {
  @override
  _SavedVideosState createState() => _SavedVideosState();
}

class _SavedVideosState extends State<SavedVideos> {
  bool _isPermissionGranted = false;
  Directory _videoDir;

  @override
  void initState() {
    super.initState();
    checkPermission();
  }

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

    if (_isPermissionGranted) {
      checkDirectory();
    }
  }

  checkDirectory() async {
    final Directory _appDocDirFolder = Directory(
      '/storage/emulated/0/HD Wallpaper/',
    );

    if (await _appDocDirFolder.exists()) {
      setState(() {
        _videoDir = _appDocDirFolder;
      });
    } else {
      final Directory _appDocDirNewFolder = await _appDocDirFolder.create(
        recursive: true,
      );
      setState(() {
        _videoDir = _appDocDirNewFolder;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var videoList = [];
    if (_isPermissionGranted) {
      _videoDir = Directory(
        '/storage/emulated/0/HD Wallpaper/',
      );
      videoList = _videoDir
          .listSync()
          .map((item) => item.path)
          .where((item) => item.endsWith(".mp4"))
          .toList(growable: false);
    }

    videoList = videoList.reversed.toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Downloaded Videos",
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
          : videoList.length == 0
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
                          Text(
                            "You have not downloaded any video yet.",
                            style: TextStyle(
                              fontSize: 18.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : Container(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                      8.0,
                      12.0,
                      8.0,
                      8.0,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Flexible(
                            child: GridView.builder(
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              addAutomaticKeepAlives: true,
                              itemCount: videoList.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                              ),
                              itemBuilder: (BuildContext context, int index) {
                                var video = videoList[index];
                                var imgName = video
                                    .toString()
                                    .split("/")
                                    .last
                                    .split(".")
                                    .first;
                                return InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (BuildContext context) {
                                          return PlaySavedVideo(
                                            video,
                                          );
                                        },
                                      ),
                                    );
                                  },
                                  child: Card(
                                    child: GridTile(
                                      child: Stack(
                                        children: <Widget>[
                                          ClipRRect(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(5.0),
                                            ),
                                            child: Container(
                                              width: 400,
                                              height: 500,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(10.0),
                                                ),
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    "https://i.vimeocdn.com/video/$imgName.jpg",
                                                imageBuilder:
                                                    (context, imageProvider) =>
                                                        Container(
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: imageProvider,
                                                      fit: BoxFit.cover,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(
                                                        10.0,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                placeholder: (context, url) =>
                                                    Center(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      Loading(30.0),
                                                    ],
                                                  ),
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: IconButton(
                                              icon: FaIcon(
                                                FontAwesomeIcons.playCircle,
                                                size: 40.0,
                                              ),
                                              onPressed: () {
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder:
                                                        (BuildContext context) {
                                                      return PlaySavedVideo(
                                                        video,
                                                      );
                                                    },
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
    );
  }
}
