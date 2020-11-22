// To parse this JSON data, do
//
//     final homeSliderClass = homeSliderClassFromJson(jsonString);

import 'dart:convert';

HomeSliderClass homeSliderClassFromJson(String str) =>
    HomeSliderClass.fromJson(json.decode(str));

String homeSliderClassToJson(HomeSliderClass data) =>
    json.encode(data.toJson());

class HomeSliderClass {
  HomeSliderClass({
    this.homeSlider,
  });

  List<HomeSlider> homeSlider;

  factory HomeSliderClass.fromJson(Map<String, dynamic> json) =>
      HomeSliderClass(
        homeSlider: List<HomeSlider>.from(
            json["home_slider"].map((x) => HomeSlider.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "home_slider": List<dynamic>.from(homeSlider.map((x) => x.toJson())),
      };
}

class HomeSlider {
  HomeSlider({
    this.homeSliderImage,
  });

  String homeSliderImage;

  factory HomeSlider.fromJson(Map<String, dynamic> json) => HomeSlider(
        homeSliderImage: json["home_slider_image"],
      );

  Map<String, dynamic> toJson() => {
        "home_slider_image": homeSliderImage,
      };
}
