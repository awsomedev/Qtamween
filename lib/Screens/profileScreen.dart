import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:qtameen/Model/customerdetailModel.dart';
import 'package:qtameen/api/api.dart';
import 'package:easy_localization/easy_localization.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<String> userData = [];
  var id;
  TextEditingController name = TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController email = TextEditingController();
  bool spin = false;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return ModalProgressHUD(
      inAsyncCall: spin,
      color: Colors.black54,
      child: Scaffold(
          appBar: AppBar(
            title: Text('account.my_account').tr(),
          ),
          body: FutureBuilder<AccoundDetailClass>(
            future: accountDetailApi(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (name.text == '') {
                  name.text = snapshot.data.accountDetails.customersName;
                  email.text = snapshot.data.accountDetails.customersEmail;
                  number.text = snapshot.data.accountDetails.customersMobile;
                }
                return SingleChildScrollView(
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    child: Container(
                      margin: EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          CircleAvatar(
                            radius: width * 0.24,
                            backgroundColor: Colors.grey,
                            child: Icon(
                              Icons.person,
                              color: Colors.white,
                              size: width * 0.4,
                            ),
                          ),
                          SizedBox(height: 30),
                          profileField('account.name'.tr(), true, name),
                          profileField('account.email'.tr(), true, email),
                          profileField('account.number'.tr(), true, number),
                          SizedBox(height: height * 0.05),
                          RaisedButton(
                            color: Colors.blue[500],
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            padding: EdgeInsets.all(0),
                            onPressed: () async {
                              if (number.text.isNotEmpty &&
                                  email.text.isNotEmpty &&
                                  name.text.isNotEmpty) {
                                String msg = await updateProfileApi(
                                    number.text, email.text, name.text);

                                print(msg);
                                showMytoast(msg);
                              } else {}
                            },
                            child: Container(
                              width: 120,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: Text(
                                    'other.save'.tr(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: height * 0.05),
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          )),
    );
  }
}

Padding profileField(String text, bool enable,
    [TextEditingController controller]) {
  return Padding(
    padding: EdgeInsets.all(8.0),
    child: TextFormField(
      cursorColor: Colors.blue,
      enabled: enable,
      // textAlign: TextAlign.center,
      style: TextStyle(color: Colors.black),
      controller: controller,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        // hintText: text,
        labelText: text,
        hintStyle: TextStyle(
            color: Colors.black.withOpacity(.5),
            fontWeight: FontWeight.w300,
            fontSize: 13),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide(
            color: Colors.black.withOpacity(.5),
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide(
            color: Colors.black.withOpacity(.5),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide(color: Colors.blueAccent, width: 1.5),
        ),
      ),
    ),
  );
}
