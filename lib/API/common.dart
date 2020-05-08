import 'dart:convert';

import 'package:http/http.dart' as http;

class Common {
  var admobAppId = "ca-app-pub-4800441463353851~8464656374";
  var interstitialAdId = "ca-app-pub-4800441463353851/1707676339";
  var response, apiSendURL;
  var resultError;
  var apiURL =
      'https://pixabay.com/api/?key=16402264-6e8cb40f8aa9a97d301faa2a9';
  var limit = 30;

  getCategoryWiseWallpaper(category, page, color) async {
    var cat = "";
    if (category != "all categories") {
      cat = "&category=$category";
    }
    apiSendURL = '$apiURL$cat&per_page=$limit&page=$page&colors=$color';
    try {
      response = await http.get(apiSendURL);
      return jsonDecode(response.body);
    } catch (e) {
      return 'error';
    }
  }

  getSearchWallpaper(search, page, color) async {
    search.replaceAll(" ", "+");
    apiSendURL = '$apiURL&q=$search&per_page=$limit&page=$page&colors=$color';
    try {
      response = await http.get(apiSendURL);
      return jsonDecode(response.body);
    } catch (e) {
      return 'error';
    }
  }
}
