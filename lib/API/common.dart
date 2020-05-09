import 'dart:convert';

import 'package:http/http.dart' as http;

class Common {
  var admobAppId = "ca-app-pub-4800441463353851~8464656374";
  var interstitialAdId = "ca-app-pub-4800441463353851/1707676339";
  var response, apiSendURL;
  var resultError;
  var wallpapersApiURL =
      'https://pixabay.com/api/?key=16402264-6e8cb40f8aa9a97d301faa2a9';
  var videosApiURL =
      'https://pixabay.com/api/videos/?key=16402264-6e8cb40f8aa9a97d301faa2a9&pretty=true';
  var limit = 30;
  var limitVideos = 15;

  getCategoryWiseWallpaper(category, page, color) async {
    var cat = "";
    if (category != "all categories") {
      cat = "&category=$category";
    }
    apiSendURL =
        '$wallpapersApiURL$cat&per_page=$limit&page=$page&colors=$color';
    try {
      response = await http.get(apiSendURL);
      return jsonDecode(response.body);
    } catch (e) {
      return 'error';
    }
  }

  getSearchWallpaper(search, page, color) async {
    search.replaceAll(" ", "+");
    apiSendURL =
        '$wallpapersApiURL&q=$search&per_page=$limit&page=$page&colors=$color';
    try {
      response = await http.get(apiSendURL);
      return jsonDecode(response.body);
    } catch (e) {
      return 'error';
    }
  }

  getCategoryWiseVideos(category, page) async {
    var cat = "";
    if (category != "all categories") {
      cat = "&category=$category";
    }
    apiSendURL = '$videosApiURL$cat&per_page=$limitVideos&page=$page';
    try {
      response = await http.get(apiSendURL);
      return jsonDecode(response.body);
    } catch (e) {
      return 'error';
    }
  }

  getSearchVideo(search, page) async {
    search.replaceAll(" ", "+");
    apiSendURL = '$videosApiURL&q=$search&per_page=$limit&page=$page';
    try {
      response = await http.get(apiSendURL);
      return jsonDecode(response.body);
    } catch (e) {
      return 'error';
    }
  }
}
