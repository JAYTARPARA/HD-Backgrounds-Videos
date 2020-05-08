import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:photopixa/API/common.dart';
import 'package:photopixa/screens/image_view.dart';
import 'package:photopixa/widgets/loading.dart';

class SearchScreen extends StatefulWidget {
  final String search;
  SearchScreen(this.search);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool _loadingData = true;
  List wallpaperList = [];
  int page = 1;
  String color = "";
  bool showLoadMore = false;
  bool loadingRunning = false;
  bool _selectedAll = true;
  bool _selectedgrayscale = false;
  bool _selectedtransparent = false;
  bool _selectedred = false;
  bool _selectedorange = false;
  bool _selectedyellow = false;
  bool _selectedgreen = false;
  bool _selectedturquoise = false;
  bool _selectedblue = false;
  bool _selectedlilac = false;
  bool _selectedpink = false;
  bool _selectedwhite = false;
  bool _selectedgray = false;
  bool _selectedblack = false;
  bool _selectedbrown = false;

  @override
  void initState() {
    super.initState();
    getWallpaperBySearch(widget.search.toLowerCase(), color);
  }

  getWallpaperBySearch(search, _color) async {
    setState(() {
      loadingRunning = true;
      color = _color;
    });
    var wallpapers = await Common().getSearchWallpaper(search, page, color);
    for (var i = 0; i < wallpapers["hits"].length; i++) {
      wallpaperList.add(wallpapers["hits"][i]);
    }
    // print(wallpapers["hits"]);
    if (wallpapers != null) {
      setState(() {
        _loadingData = false;
        loadingRunning = false;
        page++;
        if (wallpapers["hits"].length >= Common().limit) {
          showLoadMore = true;
        } else if (wallpapers["hits"].length == 0) {
          showLoadMore = false;
        } else if (wallpapers["hits"].length < Common().limit) {
          showLoadMore = false;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.search.toUpperCase(),
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w800,
          ),
        ),
        centerTitle: true,
      ),
      body: _loadingData
          ? Loading(50.0)
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
                              "You can filter wallpaper based on below colors",
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
                      Wrap(
                        spacing: 6.0,
                        runSpacing: 6.0,
                        children: <Widget>[
                          InputChip(
                            label: Text("all"),
                            backgroundColor: Colors.lightBlueAccent,
                            elevation: 10.0,
                            onPressed: () {
                              setState(() {
                                _loadingData = true;
                                page = 1;
                                _selectedAll = true;
                                wallpaperList = [];
                                _selectedgrayscale = _selectedtransparent =
                                    _selectedred = _selectedorange =
                                        _selectedyellow = _selectedgreen =
                                            _selectedturquoise = _selectedblue =
                                                _selectedlilac = _selectedpink =
                                                    _selectedwhite =
                                                        _selectedgray =
                                                            _selectedblack =
                                                                _selectedbrown =
                                                                    false;
                              });
                              getWallpaperBySearch(
                                widget.search.toLowerCase(),
                                "",
                              );
                            },
                            selected: _selectedAll,
                          ),
                          InputChip(
                            label: Text("grayscale"),
                            backgroundColor: Colors.blueGrey,
                            elevation: 10.0,
                            onPressed: () {
                              setState(() {
                                _loadingData = true;
                                page = 1;
                                _selectedgrayscale = true;
                                wallpaperList = [];
                                _selectedAll = _selectedtransparent =
                                    _selectedred = _selectedorange =
                                        _selectedyellow = _selectedgreen =
                                            _selectedturquoise = _selectedblue =
                                                _selectedlilac = _selectedpink =
                                                    _selectedwhite =
                                                        _selectedgray =
                                                            _selectedblack =
                                                                _selectedbrown =
                                                                    false;
                              });
                              getWallpaperBySearch(
                                widget.search.toLowerCase(),
                                "grayscale",
                              );
                            },
                            selected: _selectedgrayscale,
                          ),
                          InputChip(
                            label: Text("transparent"),
                            backgroundColor: Colors.transparent,
                            elevation: 10.0,
                            onPressed: () {
                              setState(() {
                                _loadingData = true;
                                page = 1;
                                _selectedtransparent = true;
                                wallpaperList = [];
                                _selectedAll = _selectedgrayscale =
                                    _selectedred = _selectedorange =
                                        _selectedyellow = _selectedgreen =
                                            _selectedturquoise = _selectedblue =
                                                _selectedlilac = _selectedpink =
                                                    _selectedwhite =
                                                        _selectedgray =
                                                            _selectedblack =
                                                                _selectedbrown =
                                                                    false;
                              });
                              getWallpaperBySearch(
                                widget.search.toLowerCase(),
                                "transparent",
                              );
                            },
                            selected: _selectedtransparent,
                          ),
                          InputChip(
                            label: Text("red"),
                            backgroundColor: Colors.red,
                            elevation: 10.0,
                            onPressed: () {
                              setState(() {
                                _loadingData = true;
                                page = 1;
                                _selectedred = true;
                                wallpaperList = [];
                                _selectedAll = _selectedgrayscale =
                                    _selectedtransparent = _selectedorange =
                                        _selectedyellow = _selectedgreen =
                                            _selectedturquoise = _selectedblue =
                                                _selectedlilac = _selectedpink =
                                                    _selectedwhite =
                                                        _selectedgray =
                                                            _selectedblack =
                                                                _selectedbrown =
                                                                    false;
                              });
                              getWallpaperBySearch(
                                widget.search.toLowerCase(),
                                "red",
                              );
                            },
                            selected: _selectedred,
                          ),
                          InputChip(
                            label: Text("orange"),
                            backgroundColor: Colors.orange,
                            elevation: 10.0,
                            onPressed: () {
                              setState(() {
                                _loadingData = true;
                                page = 1;
                                _selectedorange = true;
                                wallpaperList = [];
                                _selectedAll = _selectedgrayscale =
                                    _selectedtransparent = _selectedred =
                                        _selectedyellow = _selectedgreen =
                                            _selectedturquoise = _selectedblue =
                                                _selectedlilac = _selectedpink =
                                                    _selectedwhite =
                                                        _selectedgray =
                                                            _selectedblack =
                                                                _selectedbrown =
                                                                    false;
                              });
                              getWallpaperBySearch(
                                widget.search.toLowerCase(),
                                "orange",
                              );
                            },
                            selected: _selectedorange,
                          ),
                          InputChip(
                            label: Text(
                              "yellow",
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            backgroundColor: Colors.yellow,
                            elevation: 10.0,
                            onPressed: () {
                              setState(() {
                                _loadingData = true;
                                page = 1;
                                _selectedyellow = true;
                                wallpaperList = [];
                                _selectedAll = _selectedgrayscale =
                                    _selectedtransparent = _selectedred =
                                        _selectedorange = _selectedgreen =
                                            _selectedturquoise = _selectedblue =
                                                _selectedlilac = _selectedpink =
                                                    _selectedwhite =
                                                        _selectedgray =
                                                            _selectedblack =
                                                                _selectedbrown =
                                                                    false;
                              });
                              getWallpaperBySearch(
                                widget.search.toLowerCase(),
                                "yellow",
                              );
                            },
                            selected: _selectedyellow,
                          ),
                          InputChip(
                            label: Text("green"),
                            backgroundColor: Colors.green,
                            elevation: 10.0,
                            onPressed: () {
                              setState(() {
                                _loadingData = true;
                                page = 1;
                                _selectedgreen = true;
                                wallpaperList = [];
                                _selectedAll = _selectedgrayscale =
                                    _selectedtransparent = _selectedred =
                                        _selectedorange = _selectedyellow =
                                            _selectedturquoise = _selectedblue =
                                                _selectedlilac = _selectedpink =
                                                    _selectedwhite =
                                                        _selectedgray =
                                                            _selectedblack =
                                                                _selectedbrown =
                                                                    false;
                              });
                              getWallpaperBySearch(
                                widget.search.toLowerCase(),
                                "green",
                              );
                            },
                            selected: _selectedgreen,
                          ),
                          InputChip(
                            label: Text("turquoise"),
                            backgroundColor: Colors.cyan,
                            elevation: 10.0,
                            onPressed: () {
                              setState(() {
                                _loadingData = true;
                                page = 1;
                                _selectedturquoise = true;
                                wallpaperList = [];
                                _selectedAll = _selectedgrayscale =
                                    _selectedtransparent = _selectedred =
                                        _selectedorange = _selectedyellow =
                                            _selectedgreen = _selectedblue =
                                                _selectedlilac = _selectedpink =
                                                    _selectedwhite =
                                                        _selectedgray =
                                                            _selectedblack =
                                                                _selectedbrown =
                                                                    false;
                              });
                              getWallpaperBySearch(
                                widget.search.toLowerCase(),
                                "turquoise",
                              );
                            },
                            selected: _selectedturquoise,
                          ),
                          InputChip(
                            label: Text("blue"),
                            backgroundColor: Colors.blue,
                            elevation: 10.0,
                            onPressed: () {
                              setState(() {
                                _loadingData = true;
                                page = 1;
                                _selectedblue = true;
                                wallpaperList = [];
                                _selectedAll = _selectedgrayscale =
                                    _selectedtransparent = _selectedred =
                                        _selectedorange = _selectedyellow =
                                            _selectedgreen = _selectedturquoise =
                                                _selectedlilac = _selectedpink =
                                                    _selectedwhite =
                                                        _selectedgray =
                                                            _selectedblack =
                                                                _selectedbrown =
                                                                    false;
                              });
                              getWallpaperBySearch(
                                widget.search.toLowerCase(),
                                "blue",
                              );
                            },
                            selected: _selectedblue,
                          ),
                          InputChip(
                            label: Text("lilac"),
                            backgroundColor: Colors.purple[200],
                            elevation: 10.0,
                            onPressed: () {
                              setState(() {
                                _loadingData = true;
                                page = 1;
                                _selectedlilac = true;
                                wallpaperList = [];
                                _selectedAll = _selectedgrayscale =
                                    _selectedtransparent = _selectedred =
                                        _selectedorange = _selectedyellow =
                                            _selectedgreen = _selectedturquoise =
                                                _selectedblue = _selectedpink =
                                                    _selectedwhite =
                                                        _selectedgray =
                                                            _selectedblack =
                                                                _selectedbrown =
                                                                    false;
                              });
                              getWallpaperBySearch(
                                widget.search.toLowerCase(),
                                "lilac",
                              );
                            },
                            selected: _selectedlilac,
                          ),
                          InputChip(
                            label: Text("pink"),
                            backgroundColor: Colors.pink,
                            elevation: 10.0,
                            onPressed: () {
                              setState(() {
                                _loadingData = true;
                                page = 1;
                                _selectedpink = true;
                                wallpaperList = [];
                                _selectedAll = _selectedgrayscale =
                                    _selectedtransparent = _selectedred =
                                        _selectedorange = _selectedyellow =
                                            _selectedgreen = _selectedturquoise =
                                                _selectedblue = _selectedlilac =
                                                    _selectedwhite =
                                                        _selectedgray =
                                                            _selectedblack =
                                                                _selectedbrown =
                                                                    false;
                              });
                              getWallpaperBySearch(
                                widget.search.toLowerCase(),
                                "pink",
                              );
                            },
                            selected: _selectedpink,
                          ),
                          InputChip(
                            label: Text(
                              "white",
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            backgroundColor: Colors.white,
                            elevation: 10.0,
                            onPressed: () {
                              setState(() {
                                _loadingData = true;
                                page = 1;
                                _selectedwhite = true;
                                wallpaperList = [];
                                _selectedAll = _selectedgrayscale =
                                    _selectedtransparent = _selectedred =
                                        _selectedorange = _selectedyellow =
                                            _selectedgreen = _selectedturquoise =
                                                _selectedblue = _selectedlilac =
                                                    _selectedpink =
                                                        _selectedgray =
                                                            _selectedblack =
                                                                _selectedbrown =
                                                                    false;
                              });
                              getWallpaperBySearch(
                                widget.search.toLowerCase(),
                                "white",
                              );
                            },
                            selected: _selectedwhite,
                          ),
                          InputChip(
                            label: Text("gray"),
                            backgroundColor: Colors.grey,
                            elevation: 10.0,
                            onPressed: () {
                              setState(() {
                                _loadingData = true;
                                page = 1;
                                _selectedgray = true;
                                wallpaperList = [];
                                _selectedAll = _selectedgrayscale =
                                    _selectedtransparent = _selectedred =
                                        _selectedorange = _selectedyellow =
                                            _selectedgreen = _selectedturquoise =
                                                _selectedblue = _selectedlilac =
                                                    _selectedpink =
                                                        _selectedwhite =
                                                            _selectedblack =
                                                                _selectedbrown =
                                                                    false;
                              });
                              getWallpaperBySearch(
                                widget.search.toLowerCase(),
                                "gray",
                              );
                            },
                            selected: _selectedgray,
                          ),
                          InputChip(
                            label: Text("black"),
                            backgroundColor: Colors.black,
                            elevation: 10.0,
                            onPressed: () {
                              setState(() {
                                _loadingData = true;
                                page = 1;
                                _selectedblack = true;
                                wallpaperList = [];
                                _selectedAll = _selectedgrayscale =
                                    _selectedtransparent = _selectedred =
                                        _selectedorange = _selectedyellow =
                                            _selectedgreen = _selectedturquoise =
                                                _selectedblue = _selectedlilac =
                                                    _selectedpink =
                                                        _selectedwhite =
                                                            _selectedgray =
                                                                _selectedbrown =
                                                                    false;
                              });
                              getWallpaperBySearch(
                                widget.search.toLowerCase(),
                                "black",
                              );
                            },
                            selected: _selectedblack,
                          ),
                          InputChip(
                            label: Text("brown"),
                            backgroundColor: Colors.brown,
                            elevation: 10.0,
                            onPressed: () {
                              setState(() {
                                _loadingData = true;
                                page = 1;
                                _selectedbrown = true;
                                wallpaperList = [];
                                _selectedAll = _selectedgrayscale =
                                    _selectedtransparent = _selectedred =
                                        _selectedorange = _selectedyellow =
                                            _selectedgreen = _selectedturquoise =
                                                _selectedblue = _selectedlilac =
                                                    _selectedpink =
                                                        _selectedwhite =
                                                            _selectedgray =
                                                                _selectedblack =
                                                                    false;
                              });
                              getWallpaperBySearch(
                                widget.search.toLowerCase(),
                                "brown",
                              );
                            },
                            selected: _selectedbrown,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      wallpaperList.length == 0
                          ? Container(
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    SizedBox(
                                      height: 150.0,
                                    ),
                                    Text(
                                      "Sorry! No wallpaper found",
                                      style: TextStyle(
                                        fontSize: 20.0,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Text(
                                      "Try another category, color or keyword",
                                      style: TextStyle(
                                        fontSize: 20.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : Flexible(
                              child: StaggeredGridView.countBuilder(
                                shrinkWrap: true,
                                // scrollDirection: Axis.vertical,
                                physics: ScrollPhysics(),
                                itemCount: wallpaperList.length,
                                crossAxisCount: 4,
                                itemBuilder: (context, index) {
                                  var wallpaper = wallpaperList[index];
                                  return InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        new MaterialPageRoute(
                                          builder: (context) => ImageView(
                                            wallpaper["largeImageURL"],
                                            wallpaper["tags"],
                                          ),
                                        ),
                                      );
                                    },
                                    child: Hero(
                                      tag: wallpaper["largeImageURL"],
                                      child: Stack(
                                        children: <Widget>[
                                          ClipRRect(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10.0),
                                            ),
                                            child: ShaderMask(
                                              shaderCallback: (Rect bounds) {
                                                return LinearGradient(
                                                  begin: Alignment.center,
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
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(10.0),
                                                  ),
                                                ),
                                                child: CachedNetworkImage(
                                                  imageUrl: wallpaper[
                                                      "largeImageURL"],
                                                  imageBuilder: (context,
                                                          imageProvider) =>
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
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: <Widget>[
                                              Padding(
                                                padding: EdgeInsets.only(
                                                  right: 10.0,
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: <Widget>[
                                                    FaIcon(
                                                      FontAwesomeIcons
                                                          .cloudDownloadAlt,
                                                      size: 15.0,
                                                      color: Colors.white,
                                                    ),
                                                    SizedBox(
                                                      width: 5.0,
                                                    ),
                                                    Text(
                                                      wallpaper["downloads"]
                                                          .toString(),
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 5.0,
                                                    ),
                                                    FaIcon(
                                                      FontAwesomeIcons.eye,
                                                      size: 15.0,
                                                      color: Colors.white,
                                                    ),
                                                    SizedBox(
                                                      width: 5.0,
                                                    ),
                                                    Text(
                                                      wallpaper["views"]
                                                          .toString(),
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                  bottom: 10.0,
                                                  right: 10.0,
                                                ),
                                                child: Align(
                                                  alignment:
                                                      Alignment.bottomRight,
                                                  child: Text(
                                                    "By " + wallpaper["user"],
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
                                    ),
                                  );
                                },
                                staggeredTileBuilder: (i) =>
                                    StaggeredTile.count(2, i.isEven ? 2 : 3),
                                mainAxisSpacing: 8.0,
                                crossAxisSpacing: 8.0,
                              ),
                            ),
                      showLoadMore
                          ? Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 50.0,
                                vertical: 10.0,
                              ),
                              child: SizedBox(
                                width: double.infinity,
                                child: RaisedButton(
                                  child: loadingRunning
                                      ? Center(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Loading(20.0),
                                            ],
                                          ),
                                        )
                                      : Text(
                                          "Load More",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                  padding: const EdgeInsets.all(15.0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(10.0),
                                  ),
                                  color: Theme.of(context).primaryColor,
                                  onPressed: loadingRunning
                                      ? null
                                      : () {
                                          getWallpaperBySearch(
                                            widget.search.toLowerCase(),
                                            color,
                                          );
                                        },
                                ),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
