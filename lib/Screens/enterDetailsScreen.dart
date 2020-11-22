import 'package:flutter/material.dart';
import 'package:qtameen/Screens/selectLangScreen.dart';
import 'package:qtameen/Widgets/widgets.dart';
import 'package:easy_localization/easy_localization.dart';

class EnterDetailsScreen extends StatefulWidget {
  @override
  _EnterDetailsScreenState createState() => _EnterDetailsScreenState();
}

class _EnterDetailsScreenState extends State<EnterDetailsScreen> {
  String name = '', email = '';
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: height,
          width: width,
          padding: EdgeInsets.only(
            left: 20.0,
            right: 20.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // SizedBox(
              //   height: height * .2,
              // ),
              Image.asset(
                'images/logo.png',
                height: 150,
              ),
              Container(
                // decoration: BoxDecoration(
                //   borderRadius: BorderRadius.circular(30),
                //   border: Border.all(color: Colors.black.withOpacity(0.5)),
                // ),
                child: TextFormField(
                  onChanged: (val) {
                    email = val;
                  },
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  cursorColor: Colors.black,
                  keyboardType: TextInputType.emailAddress,
                  decoration: new InputDecoration(
                    labelText:
                        'Your Email(Optional) / العنوان البريدي - اختياري',
                    counterText: '',
                    labelStyle: TextStyle(
                        color: Colors.black.withOpacity(.5),
                        fontSize: width * .04),
                    border: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    contentPadding: EdgeInsets.all(20),
                    // hintText: 'register.email'.tr(),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100.0),
                      borderSide: BorderSide(
                        color: Colors.black.withOpacity(0.33),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100.0),
                      borderSide: BorderSide(
                        width: 2,
                        color: Colors.blue[500],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Container(
                // decoration: BoxDecoration(
                //   borderRadius: BorderRadius.circular(30),
                //   border: Border.all(color: Colors.black.withOpacity(0.5)),
                // ),
                child: TextFormField(
                  onChanged: (val) {
                    name = val;
                  },
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  cursorColor: Colors.black,
                  keyboardType: TextInputType.emailAddress,
                  decoration: new InputDecoration(
                    labelText: "Your Name / الأسم",
                    counterText: '',
                    labelStyle: TextStyle(
                        color: Colors.black.withOpacity(.5),
                        fontSize: width * .04),
                    border: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    contentPadding: EdgeInsets.all(20),
                    // hintText: 'register.name'.tr(),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100.0),
                      borderSide: BorderSide(
                        color: Colors.black.withOpacity(0.33),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100.0),
                      borderSide: BorderSide(
                        width: 2,
                        color: Colors.blue[500],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: 120,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(40),
                ),
                child: RaisedButton(
                  onPressed: () {
                    if (name.isNotEmpty) {
                      navigateRemove(
                          context,
                          SelectLangScreen(
                            name: name,
                            email: email,
                          ));
                    }
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100)),
                  color: Colors.blue,
                  child: Text(
                    'Save / حفظ',
                    style: TextStyle(color: Colors.white, fontSize: 17
                        // fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
