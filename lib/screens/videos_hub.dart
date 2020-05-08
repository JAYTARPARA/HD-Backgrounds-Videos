import 'package:backdrop/backdrop.dart';
import 'package:flutter/material.dart';
import 'package:photopixa/screens/sidebar.dart';

class VideosHub extends StatefulWidget {
  @override
  _VideosHubState createState() => _VideosHubState();
}

class _VideosHubState extends State<VideosHub> {
  @override
  Widget build(BuildContext context) {
    return BackdropScaffold(
      backLayer: Sidebar(),
      title: Center(
        child: Text(
          'HD Video Hub',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      frontLayer: Container(
        child: Center(
          child: Text("Video Hub"),
        ),
      ),
    );
  }
}
