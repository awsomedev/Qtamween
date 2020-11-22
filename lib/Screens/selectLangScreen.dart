import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:qtameen/Screens/HomeScreen.dart';
import 'package:qtameen/Widgets/widgets.dart';
import 'package:qtameen/api/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectLangScreen extends StatefulWidget {
  String name, email;
  SelectLangScreen({this.name, this.email});
  @override
  _SelectLangScreenState createState() => _SelectLangScreenState();
}

class _SelectLangScreenState extends State<SelectLangScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: width * 0.2),
          height: height,
          width: width,
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RaisedButton(
                color: Color(0xff2196f3),
                onPressed: () async {
                  var data = await loginApi(widget.email, widget.name);
                  var pref = await SharedPreferences.getInstance();
                  EasyLocalization.of(context).locale = Locale('en', 'US');
                  pref.setString('language', '');
                  pref.setString('uid', data.customerDetails.customersId);
                  pref.setString('uname', data.customerDetails.customersName);
                  navigateRemove(context, HomeScreen());
                },
                child: Text(
                  'ENGLISH',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              RaisedButton(
                color: Color(0xff2196f3),
                onPressed: () async {
                  var pref = await SharedPreferences.getInstance();
                  EasyLocalization.of(context).locale = Locale('ar', 'DZ');
                  pref.setString('language', 'ar');
                  var data = await loginApi(widget.email, widget.name);
                  pref.setString('uid', data.customerDetails.customersId);
                  pref.setString('uname', data.customerDetails.customersName);
                  navigateRemove(context, HomeScreen());
                },
                child: Text(
                  'عربى',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
