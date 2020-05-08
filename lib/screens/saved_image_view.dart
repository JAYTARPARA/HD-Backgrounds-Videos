import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:photo_view/photo_view.dart';
import 'package:wallpaperplugin/wallpaperplugin.dart';

class SavedImageView extends StatefulWidget {
  final String imgURL;
  SavedImageView(
    this.imgURL,
  );

  @override
  _SavedImageViewState createState() => _SavedImageViewState();
}

class _SavedImageViewState extends State<SavedImageView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: Padding(
        padding: EdgeInsets.only(
          top: 150.0,
        ),
        child: FloatingActionButton(
          backgroundColor: Colors.green,
          child: FaIcon(
            FontAwesomeIcons.image,
            color: Colors.white,
          ),
          onPressed: () {
            Wallpaperplugin.setAutoWallpaper(localFile: widget.imgURL);
          },
        ),
      ),
      body: Container(
        child: SafeArea(
          child: Stack(
            children: <Widget>[
              PhotoView.customChild(
                child: Image.file(
                  File(widget.imgURL),
                  fit: BoxFit.cover,
                ),
                minScale: PhotoViewComputedScale.contained * 1.0,
                initialScale: PhotoViewComputedScale.covered * 1.1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
