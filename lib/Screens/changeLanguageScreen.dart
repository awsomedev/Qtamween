import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:qtameen/Screens/HomeScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangeLanguageScreen extends StatefulWidget {
  @override
  _ChangeLanguageScreenState createState() => _ChangeLanguageScreenState();
}

class _ChangeLanguageScreenState extends State<ChangeLanguageScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('language.language').tr(),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                'other.change_language'.tr() + '? ',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              height: 35,
              width: 80,
              child: RaisedButton(
                padding: EdgeInsets.all(0),
                color: Colors.blue[500],
                onPressed: () async {
                  if (EasyLocalization.of(context).locale.toString() ==
                      'en_US') {
                    // EasyLocalization.of(context).locale = Locale('ar', 'DZ');
                    var pref = await SharedPreferences.getInstance();
                    EasyLocalization.of(context).locale = Locale('ar', 'DZ');
                    pref.setString('language', 'ar');
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                        (route) => false);
                  } else {
                    var pref = await SharedPreferences.getInstance();
                    EasyLocalization.of(context).locale = Locale('en', 'US');
                    pref.setString('language', '');

                    print(EasyLocalization.of(context).locale.toString());
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                        (route) => false);
                  }
                },
                child: Text(
                  EasyLocalization.of(context).locale.toString() == 'en_US'
                      ? 'عربى'
                      : 'ENGLISH',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
