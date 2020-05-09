import 'package:backdrop/backdrop.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photopixa/models/category.dart';
import 'package:photopixa/screens/search_video_screen.dart';
import 'package:photopixa/screens/sidebar.dart';
import 'package:photopixa/screens/video_category_screen.dart';
import 'package:photopixa/widgets/saved.dart';

class VideosHub extends StatefulWidget {
  @override
  _VideosHubState createState() => _VideosHubState();
}

class _VideosHubState extends State<VideosHub> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController _floatingSearchBar = TextEditingController();

  @override
  void initState() {
    super.initState();
    checkPermission();
  }

  @override
  void dispose() {
    super.dispose();
    _floatingSearchBar.dispose();
  }

  checkPermission() async {
    var status = await Permission.storage.status;
    if (status.isUndetermined) {
      // We didn't ask for permission yet.
      Permission.storage.request();
      setState(() {});
    } else if (status == PermissionStatus.denied) {
      Permission.storage.request();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: BackdropScaffold(
        backLayer: Sidebar("videos"),
        title: Center(
          child: Text(
            'HD Video Hub',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        actions: <Widget>[
          Saved("video"),
        ],
        frontLayer: Padding(
          padding: EdgeInsets.fromLTRB(
            12.0,
            18.0,
            12.0,
            10.0,
          ),
          child: Center(
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
                          "Search videos",
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Container(
                        height: 60.0,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 10.0, //extend the shadow
                              offset: Offset(
                                0.0,
                                0.75,
                              ),
                            ),
                          ],
                        ),
                        child: TextField(
                          cursorColor: Theme.of(context).primaryColor,
                          controller: _floatingSearchBar,
                          decoration: InputDecoration(
                            suffixIcon: GestureDetector(
                              onTap: () {
                                if (_floatingSearchBar.text == "") {
                                  SnackBar snackBar = SnackBar(
                                    backgroundColor: Colors.red,
                                    duration: Duration(seconds: 2),
                                    behavior: SnackBarBehavior.floating,
                                    content: Text(
                                      "Please enter search text",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  );

                                  _scaffoldKey.currentState
                                      .showSnackBar(snackBar);
                                } else {
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                  _scaffoldKey.currentState
                                      .hideCurrentSnackBar();
                                  var searchText = _floatingSearchBar.text;
                                  // _floatingSearchBar.clear();
                                  WidgetsBinding.instance.addPostFrameCallback(
                                    (_) => _floatingSearchBar.clear(),
                                  );
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (BuildContext context) {
                                        return SearchVideoScreen(
                                          searchText,
                                        );
                                      },
                                    ),
                                  );
                                }
                              },
                              child: Padding(
                                padding: EdgeInsets.only(
                                  right: 5.0,
                                ),
                                child: Container(
                                  height: 50.0,
                                  width: 50.0,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.circular(
                                      50.0,
                                    ),
                                    border: Border.all(color: Colors.black12),
                                  ),
                                  child: Center(
                                    child: FaIcon(
                                      FontAwesomeIcons.search,
                                      size: 17.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(5.0),
                              ),
                              borderSide: BorderSide(
                                color: Colors.black12,
                                width: 1.0,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(5.0),
                              ),
                              borderSide: BorderSide(
                                color: Colors.black12,
                                width: 1.0,
                              ),
                            ),
                            hintText: "beaches...",
                            hintStyle: TextStyle(
                              color: Colors.grey[400],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Search video by Categories",
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 18.0,
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    primary: false,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 30.0,
                      mainAxisSpacing: 12.0,
                    ),
                    itemCount: categories.length,
                    itemBuilder: (BuildContext context, int index) {
                      Category category = categories[index];
                      return GestureDetector(
                        onTap: () {
                          FocusScope.of(context).requestFocus(FocusNode());
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) {
                                return VideoCategoryScreen(category.name);
                              },
                            ),
                          );
                        },
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                              child: ShaderMask(
                                shaderCallback: (Rect bounds) {
                                  return LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.transparent,
                                      Colors.black87,
                                    ],
                                  ).createShader(bounds);
                                },
                                blendMode: BlendMode.darken,
                                child: Container(
                                  width: 400,
                                  height: 500,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10.0),
                                    ),
                                    image: DecorationImage(
                                      image: AssetImage(
                                        "assets/images/${category.image}",
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(
                                    bottom: 10.0,
                                  ),
                                  child: Center(
                                    child: Text(
                                      category.name,
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
