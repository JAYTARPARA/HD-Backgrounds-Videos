import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photopixa/screens/search_screen.dart';
import 'package:photopixa/widgets/loading.dart';
import 'package:random_string/random_string.dart';

class ImageView extends StatefulWidget {
  final String imgURL;
  final String tags;
  ImageView(
    this.imgURL,
    this.tags,
  );

  @override
  _ImageViewState createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  // var snackBar;
  var progress = "";
  bool downloading = false;
  // String tags = widget.tags;
  bool showChip = false;
  bool _isPermissionGranted = false;

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
  }

  Future<void> _download() async {
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

    await dio.download(widget.imgURL,
        "/storage/emulated/0/HD Wallpaper/${randomAlphaNumeric(20)}.jpg",
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
      _showSnackBar();
    });
  }

  _showSnackBar() {
    SnackBar snackBar = SnackBar(
      backgroundColor: Colors.green,
      duration: Duration(seconds: 3),
      behavior: SnackBarBehavior.floating,
      content: Text(
        "Wallpaper downloaded! Please check gallery/HD Wallpaper Folder.",
      ),
    );

    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    List showTags = widget.tags.split(",");
    return Scaffold(
      key: _scaffoldKey,
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: Padding(
        padding: EdgeInsets.only(
          top: 150.0,
        ),
        child: FloatingActionButton(
          backgroundColor: Colors.green,
          child: progress == "Complete" || progress == ""
              ? FaIcon(
                  FontAwesomeIcons.cloudDownloadAlt,
                  color: Colors.white,
                )
              : Text(
                  progress,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
          onPressed:
              progress == "Complete" || progress == "" ? _download : null,
        ),
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
          : Container(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    showChip = !showChip;
                  });
                },
                child: SafeArea(
                  child: Stack(
                    children: <Widget>[
                      PhotoView(
                        loadingBuilder: (context, event) => Loading(40.0),
                        // heroAttributes: PhotoViewHeroAttributes(
                        //   tag: widget.imgURL,
                        // ),
                        imageProvider: NetworkImage(
                          widget.imgURL,
                        ),
                        minScale: PhotoViewComputedScale.contained * 1.0,
                        initialScale: PhotoViewComputedScale.covered * 1.1,
                      ),
                      AnimatedOpacity(
                        opacity: showChip ? 1.0 : 0.0,
                        duration: Duration(milliseconds: 300),
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                "Tags used in wallpaper",
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
                                          print(showTags[index].trim());
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (BuildContext context) {
                                                return SearchScreen(
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
                            ],
                          ),
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
