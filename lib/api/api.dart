import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:place_picker/place_picker.dart';
import 'package:qtameen/Model/AddressDetailModel.dart';
import 'package:qtameen/Model/OfferProductModel.dart';
import 'package:http/http.dart' as http;
import 'package:qtameen/Model/OfferProductModel.dart';
import 'package:qtameen/Model/cartModel.dart';
import 'package:qtameen/Model/confirmModel.dart';
import 'package:qtameen/Model/customerdetailModel.dart';
import 'package:qtameen/Model/featuredDetails.dart';
import 'package:qtameen/Model/orderDetailModel.dart';
import 'package:qtameen/Model/subcategoryModel.dart' as sub;
import 'package:qtameen/Model/userLogin.dart';
import 'package:qtameen/Model/viewAdressModel.dart';
import 'package:qtameen/Model/viewCartModel.dart';
import 'package:qtameen/Model/wishlistModel.dart';
import 'package:qtameen/Screens/subcategorypage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'homeScreenapi.dart';

String url = 'https://qtamween.com/app/';
String token = 'ab319577de502c22df5045db4b7e2e8d';
Map header = {"Content-Type": "application/json"};

Future<FeaturedProductDetailClass> offerDetailProductApi() async {
  String lang = await getLanguage();
  String uid = await getUserId();
  String body = json
      .encode({"customers_id": "$uid", "language": "$lang", "token": "$token"});

  var res = await http.post(
    url + 'offer-products',
    headers: {"Content-Type": "application/json"},
    body: body,
  );
  return featuredProductDetailClassFromJson(res.body);
}

Future<FeaturedProductDetailClass> featureDetailProductApi() async {
  String lang = await getLanguage();
  String uid = await getUserId();
  String body = json
      .encode({"customers_id": "$uid", "language": "$lang", "token": "$token"});

  var res = await http.post(
    url + 'featured-products',
    headers: {"Content-Type": "application/json"},
    body: body,
  );
  return featuredProductDetailClassFromJson(res.body);
}

Future<sub.CategoryDetailsClass> categoryDetailApi(
    String categoryid, String subcategory) async {
  String lang = await getLanguage();
  String uid = await getUserId();
  String body = json.encode({
    "language": "$lang",
    "customers_id": "$uid",
    "category_id": "$categoryid",
    "sub_category_id": "$subcategory",
    "start": "0",
    "limit": "100",
    "token": "$token"
  });

  var res = await http.post(
    url + 'category-page',
    headers: {"Content-Type": "application/json"},
    body: body,
  );
  return sub.categoryDetailsClassFromJson(res.body);
}

Future<List<sub.Product>> categoryproductApi(
    String categoryid, String subcategory, int start, int end) async {
  String lang = await getLanguage();
  String uid = await getUserId();
  print(start);
  print(end);
  print('keyarunnuuu');
  String body = json.encode({
    "language": "$lang",
    "customers_id": "$uid",
    "category_id": "$categoryid",
    "sub_category_id": "$subcategory",
    "start": "$start",
    "limit": "$end",
    "token": "$token"
  });

  var res = await http.post(
    url + 'category-page',
    headers: {"Content-Type": "application/json"},
    body: body,
  );
  return sub.categoryDetailsClassFromJson(res.body).products;
}

Future<sub.CategoryDetailsClass> firstLoad(
    String categoryid, String subcategory) async {
  String lang = await getLanguage();
  String uid = await getUserId();
  String body = json.encode({
    "language": "$lang",
    "customers_id": "$uid",
    "category_id": "$categoryid",
    "sub_category_id": "$subcategory",
    "start": "0",
    "limit": "0",
    "token": "$token"
  });
  var res = await http.post(
    url + 'category-page',
    headers: {"Content-Type": "application/json"},
    body: body,
  );
  print('goti');
  return sub.categoryDetailsClassFromJson(res.body);
}

Future<FeaturedProductDetailClass> searchProductApi(String keyword) async {
  String lang = await getLanguage();
  String uid = await getUserId();
  String body = json.encode({
    "language": "$lang",
    "customers_id": "$uid",
    "search_key": "$keyword",
    "start": "0",
    "limit": "80",
    "token": "$token"
  });

  var res = await http.post(
    url + 'search-page',
    headers: {"Content-Type": "application/json"},
    body: body,
  );
  return featuredProductDetailClassFromJson(res.body);
}

Future<WishlistClass> wishListViewApi() async {
  String lang = await getLanguage();
  String uid = await getUserId();
  String body = json
      .encode({"customers_id": "$uid", "language": "$lang", "token": "$token"});

  var res = await http.post(
    url + 'view-wishlist',
    headers: {"Content-Type": "application/json"},
    body: body,
  );
  return wishlistClassFromJson(res.body);
}

Future<MyCartClass> myOrdersApi() async {
  String lang = await getLanguage();
  String uid = await getUserId();
  String body = json
      .encode({"customers_id": "$uid", "language": "$lang", "token": "$token"});

  var res = await http.post(
    url + 'my-orders',
    headers: {"Content-Type": "application/json"},
    body: body,
  );
  return myCartClassFromJson(res.body);
}

Future<OrderDetailClass> myOrdersDetailsApi(String orderid) async {
  String lang = await getLanguage();
  String uid = await getUserId();
  String body = json.encode({
    "customers_id": "$uid",
    "language": "$lang",
    "orders_id": "$orderid",
    "token": "$token"
  });

  var res = await http.post(
    url + 'my-order-items',
    headers: {"Content-Type": "application/json"},
    body: body,
  );
  return orderDetailClassFromJson(res.body);
}

Future<String> cartCount() async {
  String lang = await getLanguage();
  String uid = await getUserId();
  String body = json
      .encode({"customers_id": "$uid", "language": "$lang", "token": "$token"});

  var res = await http.post(
    url + 'cart-count',
    headers: {"Content-Type": "application/json"},
    body: body,
  );
  return jsonDecode(res.body)['cart_count'];
}

Future<ViewCartClass> viewCartApi() async {
  String lang = await getLanguage();
  String uid = await getUserId();
  String body = json
      .encode({"customers_id": "$uid", "language": "$lang", "token": "$token"});

  var res = await http.post(
    url + 'view-cart',
    headers: {"Content-Type": "application/json"},
    body: body,
  );
  return viewCartClassFromJson(res.body);
}

Future<ViewAddressClass> viewAddressApi() async {
  String lang = await getLanguage();
  String uid = await getUserId();
  String body = json
      .encode({"customers_id": "$uid", "language": "$lang", "token": "$token"});

  var res = await http.post(
    url + 'my-address',
    headers: {"Content-Type": "application/json"},
    body: body,
  );
  return viewAddressClassFromJson(res.body);
}

Future addToCart(String productid, String count) async {
  String lang = await getLanguage();
  String uid = await getUserId();
  String body = json.encode({
    "customers_id": "$uid",
    "language": "$lang",
    "product_id": "$productid",
    "quantity": "$count",
    "token": "$token"
  });

  var res = await http.post(
    url + 'add-to-cart',
    headers: {"Content-Type": "application/json"},
    body: body,
  );
  return jsonDecode(res.body)['message'];
}

Future removefromCart(String productid) async {
  String uid = await getUserId();
  String body = json.encode(
      {"customers_id": "$uid", "product_id": "$productid", "token": "$token"});

  var res = await http.post(
    url + 'remove-cart-product',
    headers: {"Content-Type": "application/json"},
    body: body,
  );
  return jsonDecode(res.body)['message'];
}

Future<String> addtoWishlist(String productid) async {
  String uid = await getUserId();
  String body = json.encode(
      {"customers_id": "$uid", "product_id": "$productid", "token": "$token"});

  var res = await http.post(
    url + 'add-to-wishlist',
    headers: {"Content-Type": "application/json"},
    body: body,
  );
  return jsonDecode(res.body)['message'];
}

Future<String> removefromWishlist(String productid) async {
  String uid = await getUserId();
  String body = json.encode(
      {"customers_id": "$uid", "product_id": "$productid", "token": "$token"});

  var res = await http.post(
    url + 'remove-wishlist-product',
    headers: {"Content-Type": "application/json"},
    body: body,
  );
  return jsonDecode(res.body)['message'];
}

Future<ConfirmOrderClass> confirmOrderApi(String date) async {
  String uid = await getUserId();
  String lang = await getLanguage();
  String body = json.encode({
    "language": "$lang",
    "customers_id": "$uid",
    "date": "$date",
    "token": "$token"
  });
  print(date);
  var res = await http.post(
    url + 'confirm-order',
    headers: {"Content-Type": "application/json"},
    body: body,
  );
  return confirmOrderClassFromJson(res.body);
}

Future<OrderSuccessClass> placeOrderApi(
    String date, String timeslotid, String addressId, String comment) async {
  String uid = await getUserId();
  String lang = await getLanguage();
  String body = json.encode({
    "language": "$lang",
    "customers_id": "$uid",
    "time_slot_id": "$timeslotid",
    "customers_address_id": "$addressId",
    "scheduled_date": "$date",
    "order_comments": "$comment",
    "token": "$token"
  });

  var res = await http.post(
    url + 'place-order',
    headers: {"Content-Type": "application/json"},
    body: body,
  );
  return orderSuccessClassFromJson(res.body);
}

Future<AccoundDetailClass> accountDetailApi() async {
  String uid = await getUserId();
  String lang = await getLanguage();

  String body = json
      .encode({"customers_id": "$uid", "language": "$lang", "token": "$token"});

  var res = await http.post(
    url + 'my-account',
    headers: {"Content-Type": "application/json"},
    body: body,
  );
  return accoundDetailClassFromJson(res.body);
}

Future<String> updateProfileApi(
    String mobile, String email, String name) async {
  String uid = await getUserId();
  String lang = await getLanguage();
  String body = json.encode({
    "language": "$lang",
    "customers_mobile": "$mobile",
    "customers_email": "$email",
    "customers_name": "$name",
    "customers_id": "$uid",
    "token": "$token"
  });

  var res = await http.post(
    url + 'update-my-account',
    headers: {"Content-Type": "application/json"},
    body: body,
  );
  return jsonDecode(res.body)['message'];
}

Future<UserLoginClass> loginApi(String email, String name) async {
  String lang = await getLanguage();
  String uniqueId = FirebaseAuth.instance.currentUser.uid;
  var pref = await SharedPreferences.getInstance();
  String mobile = pref.getString('mobile');
  String body = json.encode({
    "language": "$lang",
    "customers_mobile": "$mobile",
    "customers_email": "$email",
    "customers_name": "$name",
    "unique_id": "$uniqueId",
    "token": "$token"
  });

  var res = await http.post(
    url + 'customer-login',
    headers: {"Content-Type": "application/json"},
    body: body,
  );
  print(res.body);
  return userLoginClassFromJson(res.body);
}

Future<String> clearCartApi() async {
  String uid = await getUserId();
  String lang = await getLanguage();

  String body = json
      .encode({"customers_id": "$uid", "language": "$lang", "token": "$token"});

  var res = await http.post(
    url + 'remove-all-cart',
    headers: {"Content-Type": "application/json"},
    body: body,
  );
  return jsonDecode(res.body)['message'];
}

showMytoast(String msg, {Color color = Colors.black}) {
  showToast(msg,
      textPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      backgroundColor: color.withOpacity(.8),
      position: ToastPosition.bottom);
}

Future<AddressDetailClass> getAddressDetailsApi({String addId}) async {
  String uid = await getUserId();
  String lang = await getLanguage();

  String body = json.encode({
    "customers_id": "$uid",
    "language": "$lang",
    "customers_address_id": "$addId",
    "token": "$token"
  });

  var res = await http.post(
    url + 'get-address-details',
    headers: {"Content-Type": "application/json"},
    body: body,
  );
  return addressDetailClassFromJson(res.body);
}

Future<String> addAddressApi({
  String addId,
  String areaid,
  int addresstype,
  String zone,
  String street,
  String building,
  String address,
  String location,
  LatLng position,
}) async {
  String uid = await getUserId();
  String lang = await getLanguage();

  String body = json.encode({
    "customers_id": "$uid",
    "language": "$lang",
    "customers_address_id": "$addId",
    "area_id": "$areaid",
    "address_type_id": "$addresstype",
    "zone": "$zone",
    "street": "$street",
    "building": "$building",
    "address": "$address",
    "location": "$location",
    "latitude": "${position.latitude}",
    "longitude": "${position.longitude}",
    "token": "$token"
  });

  print(body);

  var res = await http.post(
    url + 'add-address',
    headers: {"Content-Type": "application/json"},
    body: body,
  );
  return jsonDecode(res.body)['message'];
}

Future<String> removeAddressApi({String addId}) async {
  String uid = await getUserId();
  String lang = await getLanguage();

  String body = json.encode({
    "customers_id": "$uid",
    "language": "$lang",
    "customers_address_id": "$addId",
    "token": "$token"
  });

  var res = await http.post(
    url + 'get-address-details',
    headers: {"Content-Type": "application/json"},
    body: body,
  );
  return jsonDecode(res.body)['message'];
}

Future<String> privacyApi({String addId}) async {
  String uid = await getUserId();
  String lang = await getLanguage();

  String body = json
      .encode({"customers_id": "$uid", "language": "$lang", "token": "$token"});

  var res = await http.post(
    url + 'privacy-policy',
    headers: {"Content-Type": "application/json"},
    body: body,
  );
  return jsonDecode(res.body)['content'];
}

Future<String> aboutApi({String addId}) async {
  String uid = await getUserId();
  String lang = await getLanguage();

  String body = json
      .encode({"customers_id": "$uid", "language": "$lang", "token": "$token"});

  var res = await http.post(
    url + 'about-us',
    headers: {"Content-Type": "application/json"},
    body: body,
  );
  return jsonDecode(res.body)['content'];
}

Future<String> termsApi({String addId}) async {
  String uid = await getUserId();
  String lang = await getLanguage();

  String body = json
      .encode({"customers_id": "$uid", "language": "$lang", "token": "$token"});

  var res = await http.post(
    url + 'terms-and-conditions',
    headers: {"Content-Type": "application/json"},
    body: body,
  );
  return jsonDecode(res.body)['content'];
}

Future<String> updatecheck({String addId}) async {
  String uid = await getUserId();
  String lang = await getLanguage();

  String body = json
      .encode({"customers_id": "$uid", "language": "$lang", "token": "$token"});

  var res = await http.post(
    url + 'check-updates',
    headers: {"Content-Type": "application/json"},
    body: body,
  );
  print(res.body);
  return jsonDecode(res.body)['status'];
}
