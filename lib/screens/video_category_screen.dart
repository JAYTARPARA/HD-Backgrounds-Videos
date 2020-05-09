import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:photopixa/API/common.dart';
import 'package:photopixa/screens/play_video.dart';
import 'package:photopixa/widgets/loading.dart';

class VideoCategoryScreen extends StatefulWidget {
  final String category;
  VideoCategoryScreen(this.category);

  @override
  _VideoCategoryScreenState createState() => _VideoCategoryScreenState();
}

class _VideoCategoryScreenState extends State<VideoCategoryScreen> {
  bool _loadingData = true;
  List videoList = [];
  int page = 1;
  bool showLoadMore = false;
  bool loadingRunning = false;
  InterstitialAd _interstitialAd;
  String asset = "assets/images/";
  String assetImg = "assets/images/all.jpg";

  @override
  void initState() {
    super.initState();
    getVideos(widget.category.toLowerCase());
    _loadInterstitialAds();
  }

  _loadInterstitialAds() {
    FirebaseAdMob.instance.initialize(
      appId: Common().admobAppId,
    );

    InterstitialAd createInterstitialAd() {
      return InterstitialAd(
        // adUnitId: InterstitialAd.testAdUnitId,
        adUnitId: Common().interstitialAdId,
        // targetingInfo: targetingInfo,
        listener: (MobileAdEvent event) {
          print("InterstitialAd event $event");
        },
      );
    }

    _interstitialAd = createInterstitialAd()..load();
    _interstitialAd?.show();
  }

  @override
  void dispose() {
    _interstitialAd?.dispose();
    // _controller.dispose();
    super.dispose();
  }

  getVideos(category) async {
    setState(() {
      loadingRunning = true;
    });
    var videos = await Common().getCategoryWiseVideos(category, page);
    for (var i = 0; i < videos["hits"].length; i++) {
      videoList.add(videos["hits"][i]);
    }
    // print(videos["hits"]);
    if (videos != null) {
      setState(() {
        _loadingData = false;
        loadingRunning = false;
        page++;
        if (videos["hits"].length >= Common().limitVideos) {
          showLoadMore = true;
        } else if (videos["hits"].length == 0) {
          showLoadMore = false;
        } else if (videos["hits"].length < Common().limitVideos) {
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
          widget.category,
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
                      videoList.length == 0
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
                              child: GridView.builder(
                                shrinkWrap: true,
                                physics: ScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                addAutomaticKeepAlives: true,
                                itemCount: videoList.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                ),
                                itemBuilder: (BuildContext context, int index) {
                                  var video = videoList[index];
                                  return InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        new MaterialPageRoute(
                                          builder: (context) => PlayVideo(
                                            video['videos']['large']['url'],
                                            video['videos']['medium']['url'],
                                            video['videos']['small']['url'],
                                            video['videos']['tiny']['url'],
                                            video['picture_id'].toString(),
                                            video['tags'],
                                          ),
                                        ),
                                      );
                                    },
                                    child: Card(
                                      child: GridTile(
                                        child: Stack(
                                          children: <Widget>[
                                            ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(5.0),
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
                                                    imageUrl:
                                                        "https://i.vimeocdn.com/video/" +
                                                            video[
                                                                "picture_id"] +
                                                            ".jpg",
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
                                                    placeholder:
                                                        (context, url) =>
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
                                                  // child: VideoPlayer(_controller),
                                                ),
                                              ),
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                IconButton(
                                                  icon: FaIcon(
                                                    FontAwesomeIcons.playCircle,
                                                    size: 40.0,
                                                    // color: Theme.of(context).primaryColor,
                                                  ),
                                                  onPressed: () {
                                                    Navigator.push(
                                                      context,
                                                      new MaterialPageRoute(
                                                        builder: (context) =>
                                                            PlayVideo(
                                                          video['videos']
                                                              ['large']['url'],
                                                          video['videos']
                                                              ['medium']['url'],
                                                          video['videos']
                                                              ['small']['url'],
                                                          video['videos']
                                                              ['tiny']['url'],
                                                          video['picture_id']
                                                              .toString(),
                                                          video['tags'],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ],
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
                                                        video["downloads"]
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
                                                        video["views"]
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
                                                      "By " + video["user"],
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
                                    ),
                                  );
                                },
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
                                          getVideos(
                                            widget.category.toLowerCase(),
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
