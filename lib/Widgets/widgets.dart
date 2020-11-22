import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qtameen/Screens/addAddress.dart';
import 'package:qtameen/Screens/changeLanguageScreen.dart';
import 'package:qtameen/Screens/contactus.dart';
import 'package:qtameen/Screens/login.dart';
import 'package:qtameen/Screens/myOrders.dart';
import 'package:qtameen/Screens/profileScreen.dart';
import 'package:qtameen/Screens/wishlistScreen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SideDrawer extends StatelessWidget {
  SideDrawer({this.name, this.context});
  String name;
  BuildContext context;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Drawer(
      child: Container(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // SizedBox(height: 35),
              Container(
                color: Color(0xff44afdc),
                height: height * 0.2,
                width: width,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    // SizedBox(height: 8),
                    CircleAvatar(
                      backgroundColor: Colors.grey,
                      radius: width * 0.1,
                      child: Center(
                        child: Icon(
                          Icons.person,
                          size: 46,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    // SizedBox(height: 8),
                    Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: FutureBuilder<SharedPreferences>(
                          future: SharedPreferences.getInstance(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return snapshot.data
                                          .getString('uname')
                                          .toLowerCase() ==
                                      'null'
                                  ? Container(
                                      height: 0,
                                      width: 0,
                                    )
                                  : Row(
                                      children: [
                                        Text(
                                          'account.name'.tr() + ' : ',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        Text(
                                          snapshot.data.getString('uname') ??
                                              '',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    );
                            } else {
                              return Text(
                                '',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w400,
                                ),
                              );
                            }
                          }),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  child: Column(
                    children: [
                      buildTile('account.my_account'.tr(), Icons.person, () {
                        Navigator.of(context).pop();
                        navigate(context, ProfileScreen());
                      }),
                      buildTile('address.my_address'.tr(), Icons.account_circle,
                          () {
                        Navigator.of(context).pop();
                        navigate(context, AddAddressScreen());
                      }),
                      buildTile('orders.my_orders'.tr(), Icons.local_shipping,
                          () {
                        Navigator.of(context).pop();
                        navigate(context, MyOrders());
                      }),
                      buildTile('wishlist.wishlist'.tr(), Icons.favorite, () {
                        Navigator.of(context).pop();
                        navigate(context, WhislsiScreen());
                      }),
                      // Divider(
                      //   height: 10.0,
                      //   thickness: 2.0,
                      //   color: Color(0xff44afdc),
                      // ),
                      // buildTile('About Us', Icons.info, () {
                      //   Navigator.of(context).pop();
                      //   navigate(context, AboutUs());
                      // }),
                      // buildTile('Contact Us', Icons.call, () async {
                      //   Navigator.of(context).pop();
                      //   var number = 'tel:+91 85909 56663';
                      //   if (await canLaunch(number)) {
                      //     launch(number);
                      //   }
                      // }),
                      // buildTile('Policies', Icons.security, () {
                      //   Navigator.of(context).pop();
                      //   navigate(context, Policies());
                      // }),
                      buildTile(
                          'language.language'.tr() + ' EN/AR', Icons.language,
                          () {
                        Navigator.of(context).pop();
                        navigate(context, ChangeLanguageScreen());
                      }),
                      buildTile('other.support'.tr(), Icons.language, () {
                        Navigator.of(context).pop();
                        navigate(context, Contactus());
                      }),
                      buildTile('menu.share'.tr(), Icons.language, () async {
                        Navigator.of(context).pop();
                        await Share.share(
                            'Download Qtamween Application https://play.google.com/store/apps/details?id=com.qweb.qtamween');
                        // navigate(context, ChangeLanguageScreen());
                      }),
                      buildTile('login.logout'.tr(), Icons.exit_to_app,
                          () async {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('other.confirm'.tr()),
                            content: Text('other.logout_msg'.tr() + ' ?'),
                            actions: [
                              FlatButton(
                                  onPressed: () async {
                                    await FirebaseAuth.instance.signOut();
                                    var pref =
                                        await SharedPreferences.getInstance();
                                    EasyLocalization.of(context).locale =
                                        Locale('en', 'US');
                                    pref.clear();
                                    navigateRemove(context, LoginNew());
                                  },
                                  child: Text('other.yes'.tr())),
                              FlatButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('other.no'.tr())),
                            ],
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InkWell buildTile(text, icon, onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
        child: Row(
          children: <Widget>[
            // Icon(
            //   icon,
            // ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                text,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: missing_return
Navigator navigate(context, page) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => page,
    ),
  );
}

navigateRemove(context, page) {
  Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => page,
      ),
      (route) => false);
}

// ignore: missing_return
Navigator navigateReplace(context, page) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => page,
    ),
  );
}

double height(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

double width(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

AppBar appBar1(String text, BuildContext context) {
  var width = MediaQuery.of(context).size.width;
  return AppBar(
    leading: InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Padding(
        padding: EdgeInsets.all(12.0),
        child: Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
      ),
    ),
    title: Text(
      text,
      style: TextStyle(
        fontSize: 20.0,
        color: Colors.white,
        fontWeight: FontWeight.w300,
      ),
    ),
    actions: [
      // appBarCart(width, context),
      SizedBox(width: 10),
      InkWell(
        // onTap: () {
        //   navigate(context, WhislsiScreen());
        // },
        child: Icon(
          Icons.favorite_border,
          color: Colors.white,
        ),
      ),
      SizedBox(width: 10),
    ],
  );
}

class CommonLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Material(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          width: width(context) * .8,
          padding: EdgeInsets.all(20),
          height: 100,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Row(
            children: [
              Image.asset('images/load.gif'),
              SizedBox(
                width: 20,
              ),
              Text(
                'orders.please_wait',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.bold),
              ).tr()
            ],
          ),
        ),
      ),
    );
  }
}
