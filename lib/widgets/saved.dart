import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:photopixa/screens/saved_videos.dart';
import 'package:photopixa/screens/saved_wallpapers.dart';

class Saved extends StatefulWidget {
  final String goto;
  Saved(this.goto);

  @override
  _SavedState createState() => _SavedState();
}

class _SavedState extends State<Saved> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
          icon: FaIcon(
            FontAwesomeIcons.cloudDownloadAlt,
          ),
          onPressed: widget.goto == "wallpaper"
              ? () {
                  Navigator.push(
                    context,
                    new MaterialPageRoute(
                      builder: (context) => SavedWallpapers(),
                    ),
                  );
                }
              : () {
                  Navigator.push(
                    context,
                    new MaterialPageRoute(
                      builder: (context) => SavedVideos(),
                    ),
                  );
                },
        ),
      ],
    );
  }
}
