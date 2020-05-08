import 'package:flutter/material.dart';
import 'package:photopixa/screens/home.dart';
import 'package:photopixa/screens/videos_hub.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "HD Wallpapers",
      theme: ThemeData(
        primarySwatch: Colors.green,
        brightness: Brightness.dark,
        appBarTheme: AppBarTheme(
          elevation: 10.0,
        ),
        fontFamily: 'Overpass',
        primaryColor: Colors.green,
      ),
      // darkTheme: ThemeData(
      //   brightness: Brightness.light,
      //   fontFamily: 'Overpass',
      // ),
      home: Home(),
      routes: <String, WidgetBuilder>{
        '/home': (BuildContext context) => new Home(),
        '/videohub': (BuildContext context) => new VideosHub(),
      },
    );
  }
}
