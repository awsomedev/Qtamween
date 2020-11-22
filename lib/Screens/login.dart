import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_platform_interface/firebase_auth_platform_interface.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:qtameen/Widgets/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'enterDetailsScreen.dart';

class LoginNew extends StatefulWidget {
  @override
  _LoginNewState createState() => _LoginNewState();
}

class _LoginNewState extends State<LoginNew> {
  TextEditingController codeController = TextEditingController();
  String smsCode;
  void varificationPopup(
      BuildContext context, String verificationId, String mobile,
      [int forceResendingToken]) {
    showGeneralDialog(
        context: context,
        barrierDismissible: false,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.black.withOpacity(.7),
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext buildContext, Animation animation,
            Animation secondaryAnimation) {
          return Center(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * .05),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * .3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Material(
                        borderRadius: BorderRadius.circular(100),
                        elevation: 2,
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.white),
                          child: TextField(
                            keyboardType: TextInputType.number,
                            controller: codeController,
                            maxLength: 6,
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.black, fontSize: 18),
                            decoration: InputDecoration(
                              counterText: '',
                              hintStyle: TextStyle(
                                  color: Colors.black54,
                                  fontSize: width(context) * .04),
                              hintText: 'Verification Code / شيفرة التأكيد',
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          FirebaseAuth auth = FirebaseAuth.instance;

                          smsCode = codeController.text.trim();

                          // print(smsCode + 'codedeee');
                          // print(verificationId + 'cvariiii');

                          var _credential = PhoneAuthProvider.getCredential(
                              verificationId: verificationId, smsCode: smsCode);
                          auth
                              .signInWithCredential(_credential)
                              .then((result) async {
                            print(mobile);
                            Navigator.pop(context);
                            var pref = await SharedPreferences.getInstance();
                            pref.setString('mobile', mobile.substring(4));
                            print(mobile.substring(4));

                            navigate(context, EnterDetailsScreen());
                          }).catchError((e) {
                            print(e);
                          });
                        },
                        child: Material(
                          borderRadius: BorderRadius.circular(100),
                          elevation: 3,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 10),
                            decoration: BoxDecoration(
                              color: Colors.blue[500],
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Text(
                              'Verify / التحقق',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  void varify(String mobile, BuildContext context) {
    FirebaseAuth _auth = FirebaseAuth.instance;
    setState(() {
      spin = true;
    });

    _auth.verifyPhoneNumber(
        phoneNumber: mobile,
        // phoneNumber: '+919544072094',
        timeout: Duration(seconds: 60),
        verificationCompleted: (AuthCredential authCredential) {
          _auth.signInWithCredential(authCredential).then((result) async {
            setState(() {
              spin = false;
            });
            var pref = await SharedPreferences.getInstance();
            print(mobile.substring(4));
            pref.setString('mobile', mobile.substring(4));
            navigate(context, EnterDetailsScreen());
          }).catchError((e) {
            print(e);
          });
        },
        verificationFailed: (authException) {
          setState(() {
            spin = false;
          });
          print(authException.message);
        },
        codeSent: (String verificationId, [int forceResendingToken]) {
          setState(() {
            spin = false;
          });
          varificationPopup(context, verificationId, mobile);
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          setState(() {
            spin = false;
          });
          verificationId = verificationId;
          print("Timout");
        });
  }

  bool spin = false;
  String number = '';
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return ModalProgressHUD(
      inAsyncCall: spin,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
              height: height,
              padding: EdgeInsets.symmetric(horizontal: 35),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // SizedBox(
                  //   height: height * .3,
                  // ),
                  Image.asset(
                    'images/logo.png',
                    height: 150,
                  ),
                  // SizedBox(
                  //   height: height * 0.3,
                  // ),
                  Text(
                    'Login / دخول',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 40),
                  Container(
                    // decoration: BoxDecoration(
                    //   borderRadius: BorderRadius.circular(30),
                    //   border: Border.all(color: Colors.black.withOpacity(0.5)),
                    // ),
                    child: TextFormField(
                      onChanged: (val) {
                        number = val;
                      },
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      cursorColor: Colors.black,
                      maxLength: 8,
                      keyboardType: TextInputType.phone,
                      decoration: new InputDecoration(
                        labelText: 'Enter Your Number / أدخل رقمك',
                        counterText: '',
                        hintStyle: TextStyle(
                            color: Colors.black.withOpacity(.5), fontSize: 18),
                        border: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        contentPadding: EdgeInsets.all(20),
                        hintText: 'Enter Your Number /أدخل رقمك',
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
                  SizedBox(
                    height: 40,
                  ),

                  Container(
                    // width: 100,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: RaisedButton(
                      onPressed: () {
                        if (number.isNotEmpty && number.length == 8) {
                          varify('+974' + number, context);
                        }
                        // navigateRemove(context, EnterDetailsScreen());
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      color: Colors.blue,
                      child: Text(
                        'Login /دخول',
                        style: TextStyle(
                          color: Colors.white,
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
