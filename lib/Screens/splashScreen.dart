import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qtameen/Screens/HomeScreen.dart';
import 'package:qtameen/Screens/enterDetailsScreen.dart';
import 'package:qtameen/Widgets/widgets.dart';
import 'package:qtameen/api/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'login.dart';
import 'package:easy_localization/easy_localization.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // if (await Permission.location.isGranted) {
    //   Future.delayed(Duration(seconds: 3), () async {
    //     navigateReplace(context, LoginNew());

    //     //   navigateReplace(context, HomeScreen());

    //     //   navigateReplace(context, LoginNew());
    //   });
    // } else {
    //   Permission.location.request();
    // }

    Future.delayed(Duration(seconds: 3)).then((value) async {
      var d = await updatecheck();
      if (int.parse(d) > 13) {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('new.update_title').tr(),
                content: Text('new.update_content').tr(),
                actions: [
                  FlatButton(
                    child: Text("new.update").tr(),
                    onPressed: () async {
                      Navigator.pop(context);
                      launch(
                          'https://play.google.com/store/apps/details?id=com.qweb.qtamween');
                    },
                  ),
                  FlatButton(
                    child: Text("other.no").tr(),
                    onPressed: () async {
                      Navigator.pop(context);
                      if (FirebaseAuth.instance.currentUser == null) {
                        navigateReplace(context, LoginNew());
                      } else {
                        var pref = await SharedPreferences.getInstance();
                        if (pref.getString('uid') == null) {
                          navigateReplace(context, LoginNew());
                        } else {
                          navigateReplace(context, HomeScreen());
                        }
                      }
                    },
                  )
                ],
              );
            });
      } else {
        if (FirebaseAuth.instance.currentUser == null) {
          navigateReplace(context, LoginNew());
        } else {
          print(FirebaseAuth.instance.currentUser.uid);
          var pref = await SharedPreferences.getInstance();
          if (pref.getString('uid') == null) {
            navigateReplace(context, LoginNew());
          } else {
            navigateReplace(context, HomeScreen());
          }
        }
      }
      // print('updateeeeeeeeeeeeeeeeeee' + d);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage('images/splash.png'),
            ),
          ),
        ),
      ),
    );
  }
}

// class Background extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//           image: DecorationImage(image: AssetImage('images/bg.png'))),
//     );
//   }
// }
