import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share/share.dart';
import 'package:store_redirect/store_redirect.dart';
import 'package:url_launcher/url_launcher.dart';

class Sidebar extends StatefulWidget {
  @override
  _SidebarState createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // ListTile(
          //   title: Text(
          //     'HD Wallpaper Hub',
          //     style: TextStyle(
          //       fontSize: 20,
          //       fontWeight: FontWeight.w300,
          //       color: Colors.white,
          //     ),
          //   ),
          //   leading: FaIcon(
          //     FontAwesomeIcons.images,
          //   ),
          //   onTap: () {
          //     print("HD Video");
          //     print(ModalRoute.of(context).settings.arguments);
          //   },
          // ),
          // ListTile(
          //   title: Text(
          //     'HD Video Hub',
          //     style: TextStyle(
          //       fontSize: 20,
          //       fontWeight: FontWeight.w300,
          //       color: Colors.white,
          //     ),
          //   ),
          //   leading: FaIcon(
          //     FontAwesomeIcons.playCircle,
          //   ),
          //   onTap: () {
          //     print("HD Video");
          //     Navigator.of(context).push(
          //       MaterialPageRoute(
          //         builder: (BuildContext context) => VideosHub(),
          //       ),
          //     );
          //   },
          // ),
          ListTile(
            title: Text(
              'Share App',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w300,
                color: Colors.white,
              ),
            ),
            leading: FaIcon(
              FontAwesomeIcons.shareAlt,
            ),
            onTap: () {
              Share.share(
                'Download HD Backgrounds & Videos Application \r\n https://bit.ly/HDWallpaperNVideos',
                subject: 'HD Backgrounds & Videos',
              );
            },
          ),
          ListTile(
            title: Text(
              'Rate App',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w300,
                color: Colors.white,
              ),
            ),
            leading: FaIcon(
              FontAwesomeIcons.star,
            ),
            onTap: () {
              StoreRedirect.redirect(
                androidAppId: "app.jaytarpara.pixabayhdwallpapers",
              );
            },
          ),
          ListTile(
            title: Text(
              'Other Apps',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w300,
                color: Colors.white,
              ),
            ),
            leading: FaIcon(
              FontAwesomeIcons.googlePlay,
            ),
            onTap: () async {
              const url =
                  'https://play.google.com/store/apps/dev?id=7435506917924983096';
              if (await canLaunch(url)) {
                await launch(url);
              } else {
                throw 'Could not launch $url';
              }
            },
          ),
        ],
      ),
    );
  }
}
