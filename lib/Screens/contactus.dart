import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:easy_localization/easy_localization.dart';

class Contactus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Text('For Customer Service and Support contact',
          //     textAlign: TextAlign.center, style: TextStyle(fontSize: 20)),
          // SizedBox(
          //   height: 5,
          // ),
          InkWell(
              onTap: () {
                launch("tel://33100044");
              },
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  'other.sdata'.tr(),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
              )),
        ],
      ),
    );
  }
}
