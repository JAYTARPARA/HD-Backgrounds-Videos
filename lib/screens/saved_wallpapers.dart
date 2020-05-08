import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photopixa/screens/saved_image_view.dart';

class SavedWallpapers extends StatefulWidget {
  @override
  _SavedWallpapersState createState() => _SavedWallpapersState();
}

class _SavedWallpapersState extends State<SavedWallpapers> {
  bool _isPermissionGranted = false;
  Directory _wallpaperDir;

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
        _wallpaperDir = _appDocDirFolder;
      });
    } else {
      final Directory _appDocDirNewFolder = await _appDocDirFolder.create(
        recursive: true,
      );
      setState(() {
        _wallpaperDir = _appDocDirNewFolder;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var wallpaperList = [];
    if (_isPermissionGranted) {
      _wallpaperDir = Directory(
        '/storage/emulated/0/HD Wallpaper/',
      );
      wallpaperList = _wallpaperDir
          .listSync()
          .map((item) => item.path)
          .where((item) => item.endsWith(".jpg"))
          .toList(growable: false);
    }

    wallpaperList = wallpaperList.reversed.toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Downloaded Wallpapers",
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
          : wallpaperList.length == 0
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
                            "You have not downloaded any wallpaper yet.",
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
                          Column(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Click wallpaper to see how it will look on your device.",
                                  style: TextStyle(
                                    fontSize: 16.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Flexible(
                            child: StaggeredGridView.countBuilder(
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              itemCount: wallpaperList.length,
                              crossAxisCount: 4,
                              itemBuilder: (context, index) {
                                String wallpaperPath = wallpaperList[index];
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      new MaterialPageRoute(
                                        builder: (context) => SavedImageView(
                                          wallpaperPath,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Hero(
                                    tag: wallpaperPath,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10.0),
                                      ),
                                      child: Image.file(
                                        File(wallpaperPath),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                );
                              },
                              staggeredTileBuilder: (i) =>
                                  StaggeredTile.count(2, i.isEven ? 2 : 3),
                              mainAxisSpacing: 8.0,
                              crossAxisSpacing: 8.0,
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
