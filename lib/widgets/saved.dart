import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:photopixa/screens/saved_wallpapers.dart';

class Saved extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
          icon: FaIcon(
            FontAwesomeIcons.cloudDownloadAlt,
          ),
          onPressed: () {
            Navigator.push(
              context,
              new MaterialPageRoute(
                builder: (context) => SavedWallpapers(),
              ),
            );
          },
        ),
      ],
    );
  }
}
