import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:qtameen/Model/HomeScreenSlider.dart';
import 'package:qtameen/Model/OfferProductModel.dart';
import 'package:qtameen/Model/ProductDetailsModel.dart';
import 'package:qtameen/Model/categoryModel.dart';
import 'package:qtameen/Model/homeScreenFeaturedModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

String url = 'https://qtamween.com/app/';
String token = 'ab319577de502c22df5045db4b7e2e8d';
Map header = {"Content-Type": "application/json"};

Future<String> getLanguage() async {
  var pref = await SharedPreferences.getInstance();
  return pref.getString('language') == 'ar' ? '1' : '0';
}

Future<String> getUserId() async {
  var pref = await SharedPreferences.getInstance();
  return pref.getString('uid2');
}

Future<HomeSliderClass> getSlider() async {
  String lang = await getLanguage();
  String uid = await getUserId();
  var body = jsonEncode(
      {"customers_id": "$uid", "language": "$lang", "token": "$token"});
  var res = await http.post('$url' + 'home-slider', body: body);
  print(res.body);
  if (res.statusCode == 200) {
    return homeSliderClassFromJson(res.body);
  } else {
    return null;
  }
}

Future<HomeCategoryClass> homeCategoryApi() async {
  String lang = await getLanguage();
  String uid = await getUserId();
  String body = json
      .encode({"customers_id": "$uid", "language": "$lang", "token": "$token"});

  var res = await http.post(
    url + 'home-category',
    headers: {"Content-Type": "application/json"},
    body: body,
  );

  return homeCategoryClassFromJson(res.body);
}

Future<String> promotionSliderApi() async {
  String lang = await getLanguage();
  String uid = await getUserId();
  String body = json
      .encode({"customers_id": "$uid", "language": "$lang", "token": "$token"});

  var res = await http.post(
    url + 'home-promotion-slider',
    headers: {"Content-Type": "application/json"},
    body: body,
  );

  return jsonDecode(res.body)['promotion_slider'];
}

Future<FeaturedProductClass> featuredApi() async {
  String lang = await getLanguage();
  String uid = await getUserId();
  String body = json
      .encode({"customers_id": "$uid", "language": "$lang", "token": "$token"});

  var res = await http.post(
    url + 'home-featured-products',
    headers: {"Content-Type": "application/json"},
    body: body,
  );

  return featuredProductClassFromJson(res.body);
}

Future<OfferProductClass> offerProductApi() async {
  String lang = await getLanguage();
  String uid = await getUserId();
  String body = json
      .encode({"customers_id": "$uid", "language": "$lang", "token": "$token"});

  var res = await http.post(
    url + 'home-offer-products',
    headers: {"Content-Type": "application/json"},
    body: body,
  );

  return offerProductClassFromJson(res.body);
}

Future<ProductDetailsClass> productDetailsApi(String id) async {
  String lang = await getLanguage();
  String uid = await getUserId();
  String body = json.encode({
    "customers_id": "$uid",
    "language": "$lang",
    "product_id": "$id",
    "token": "$token"
  });

  var res = await http.post(
    url + 'product-details',
    headers: {"Content-Type": "application/json"},
    body: body,
  );

  return productDetailsClassFromJson(res.body);
}
