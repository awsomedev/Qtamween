import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:qtameen/Model/cartModel.dart';
import 'package:qtameen/Model/confirmModel.dart';
import 'package:qtameen/Screens/HomeScreen.dart';
import 'package:qtameen/Widgets/widgets.dart';
import 'package:qtameen/api/api.dart';
import 'package:qtameen/cool/src/widgets/CoolAlert.dart';
import 'package:url_launcher/url_launcher.dart';

import 'detailAddress.dart';

class ShippingDetails extends StatefulWidget {
  ShippingDetails({
    this.totalCost,
    this.items,
    this.shipping,
  });
  final List items;
  final String totalCost;
  final int shipping;
  @override
  _ShippingDetailsState createState() => _ShippingDetailsState();
}

class _ShippingDetailsState extends State<ShippingDetails> {
  String userId, name, phone, comments, timeSlotId = '';
  final formkey = GlobalKey<FormState>();
  String selectedDate = 'Today';

  Color primary = Colors.blue[500];
  String selectedTimeSlotID = '';

  bool loading = false;
  List<bool> timeSlotSelected = [];

  DateTime dateTime = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day + 2),
        firstDate: DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day + 2),
        lastDate: DateTime(2101));
    if (picked != null && picked != dateTime) {
      setState(() {
        selectedTimeSlotID = '';
        dateTime = picked;
        selectedDate = 'Other';
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  var textStyle = TextStyle(
    color: Colors.black,
    fontSize: 14.0,
    fontWeight: FontWeight.w400,
  );
  var textStyle1 = TextStyle(
    color: Colors.black,
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
  );
  bool spin = false;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return ModalProgressHUD(
      inAsyncCall: spin,
      progressIndicator: CommonLoading(),
      child: Scaffold(
        appBar: AppBar(
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
            'place_order.confirm_order'.tr(),
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
        body: ModalProgressHUD(
          inAsyncCall: loading,
          progressIndicator: CommonLoading(),
          child: SingleChildScrollView(
            child: Form(
              child: Container(
                  // height: height,
                  margin: EdgeInsets.all(10),
                  child: FutureBuilder<ConfirmOrderClass>(
                    future: confirmOrderApi((dateTime.day.toString().length == 1
                            ? '0${dateTime.day.toString()}'
                            : dateTime.day.toString()) +
                        '/' +
                        dateTime.month.toString() +
                        '/' +
                        dateTime.year.toString()),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<Timesloat> timeSlots = [];
                        List<String> areaData = [];
                        for (var item in snapshot.data.timesloat) {
                          timeSlots.add(item);
                        }
                        for (var item in snapshot.data.areaData) {
                          areaData.add(item.areaName.toString());
                        }
                        return Column(
                          children: [
                            Container(
                              // height: 80,
                              width: width,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.0),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 6.0,
                                    color: Colors.black.withOpacity(0.3),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                    child: Container(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 5),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'place_order.delivery_address'.tr(),
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          // Text(
                                          // //  snapshot.data.address.,
                                          //   style: TextStyle(
                                          //     color: Colors.black,

                                          //   ),
                                          // ),
                                          Text(
                                            '${snapshot.data.address.address} ${snapshot.data.address.building} ${snapshot.data.address.street} ${snapshot.data.address.zone} ${snapshot.data.address.areaName}',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      // print();
                                      if (snapshot.data.address
                                              .customersAddressId ==
                                          '') {
                                        Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        DetailAddress()))
                                            .then((value) {
                                          setState(() {});
                                        });
                                      } else {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DetailAddress(
                                                      addressid: snapshot
                                                          .data
                                                          .address
                                                          .customersAddressId,
                                                    ))).then((value) {
                                          setState(() {});
                                        });
                                      }
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) => DetailAddress(
                                      //               addressid: snapshot
                                      //                   .data
                                      //                   .address
                                      //                   .customersAddressId,
                                      //             ))).then((value) {
                                      //   setState(() {});
                                      // });
                                    },
                                    child: Icon(
                                      Icons.edit,
                                      color: Colors.black,
                                      size: 26.0,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: 60,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 15),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.0),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 6.0,
                                    color: Colors.black.withOpacity(0.3),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        selectedTimeSlotID = '';
                                        selectedDate = 'Today';
                                        dateTime = DateTime.now();
                                      });
                                    },
                                    child: Container(
                                      height: double.infinity,
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: selectedDate != 'Today'
                                            ? Colors.white
                                            : primary,
                                        boxShadow: [
                                          BoxShadow(
                                            blurRadius: .5,
                                            color:
                                                Colors.black.withOpacity(0.7),
                                          ),
                                        ],
                                      ),
                                      child: Center(
                                        child: Text(
                                          'place_order.today'.tr(),
                                          style: TextStyle(
                                            color: selectedDate == 'Today'
                                                ? Colors.white
                                                : primary,
                                            fontSize: 14.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        selectedTimeSlotID = '';
                                        selectedDate = 'Tommorow';
                                        dateTime = DateTime(
                                            DateTime.now().year,
                                            DateTime.now().month,
                                            DateTime.now().day + 1);
                                      });
                                    },
                                    child: Container(
                                      height: double.infinity,
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: selectedDate != 'Tommorow'
                                            ? Colors.white
                                            : primary,
                                        boxShadow: [
                                          BoxShadow(
                                            blurRadius: .5,
                                            color:
                                                Colors.black.withOpacity(0.7),
                                          ),
                                        ],
                                      ),
                                      child: Center(
                                        child: Text(
                                          'place_order.tomorrow'.tr(),
                                          style: TextStyle(
                                            color: selectedDate == 'Tommorow'
                                                ? Colors.white
                                                : primary,
                                            fontSize: 14.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  InkWell(
                                    onTap: () {
                                      _selectDate(context);
                                    },
                                    child: Container(
                                      height: double.infinity,
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: selectedDate != 'Other'
                                            ? Colors.white
                                            : primary,
                                        boxShadow: [
                                          BoxShadow(
                                            blurRadius: .5,
                                            color:
                                                Colors.black.withOpacity(0.7),
                                          ),
                                        ],
                                      ),
                                      child: Center(
                                        child: selectedDate == 'Other'
                                            ? Text(
                                                dateTime.day.toString() +
                                                    '/' +
                                                    dateTime.month.toString() +
                                                    '/' +
                                                    dateTime.year.toString(),
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )
                                            : Icon(
                                                Icons.calendar_today,
                                                color: selectedDate == 'Other'
                                                    ? Colors.white
                                                    : primary,
                                                size: 16.0,
                                              ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 14),
                            timeSlots.length == 0
                                ? Container(
                                    height: 60,
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10.0),
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 6.0,
                                          color: Colors.black.withOpacity(0.3),
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [Text('other.noslot').tr()],
                                    ),
                                  )
                                : Container(
                                    // height: height * 0.15,
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10.0),
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 6.0,
                                          color: Colors.black.withOpacity(0.3),
                                        ),
                                      ],
                                    ),
                                    child: GridView.builder(
                                      itemCount: timeSlots.length,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        childAspectRatio: 100 / 50,
                                      ),
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        // List.generate(timeSlots.length, (index) {
                                        //   timeSlotSelected.add(false);
                                        // });
                                        return InkWell(
                                          onTap: () {
                                            setState(() {
                                              selectedTimeSlotID =
                                                  timeSlots[index].timeSlotId;
                                            });
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 3.0, vertical: 10),
                                            // padding:
                                            //     EdgeInsets.only(left: 2.0, right: 2.0),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                              color: selectedTimeSlotID ==
                                                      timeSlots[index]
                                                          .timeSlotId
                                                  ? Colors.blue[500]
                                                  : Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                  blurRadius: .5,
                                                  color: Colors.black
                                                      .withOpacity(0.7),
                                                ),
                                              ],
                                            ),
                                            child: Text(
                                              timeSlots[index].timeSloat,
                                              style: TextStyle(
                                                color: selectedTimeSlotID ==
                                                        timeSlots[index]
                                                            .timeSlotId
                                                    ? Colors.white
                                                    : Colors.blue[500],
                                                fontSize: width * .03,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'cart.bill_amount'.tr() + ': ',
                                  style: textStyle,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  '${snapshot.data.amountArray.billAmount}',
                                  style: textStyle,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'cart.delivery_charge'.tr() + ': ',
                                  style: textStyle,
                                ),
                                // SizedBox(width: 10),
                                Text(
                                  '${snapshot.data.amountArray.deliveryCharge}',
                                  style: textStyle,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Divider(
                              thickness: 1.5,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'cart.total_amount'.tr() + ': ',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  '${snapshot.data.amountArray.totalAmount}',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            TextField(
                              // textAlign: TextAlign.left,
                              style: TextStyle(color: Colors.black),
                              cursorColor: Colors.black,
                              onChanged: (val) {
                                comments = val;
                              },
                              keyboardType: TextInputType.text,
                              decoration: new InputDecoration(
                                counterText: '',
                                hintStyle: TextStyle(color: Colors.grey[600]),
                                hintText: 'place_order.add_note'.tr(),
                              ),
                            ),
                            SizedBox(height: 40),
                            Container(
                              width: 120,
                              height: 50,
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                onPressed: () async {
                                  if (selectedTimeSlotID == '') {
                                    showGeneralDialog(
                                        context: context,
                                        barrierLabel: 'label',
                                        barrierDismissible: true,
                                        pageBuilder: (context, a, aa) {
                                          return Align(
                                            alignment: Alignment.center,
                                            child: Material(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15)),
                                                  height: 180,
                                                  width: width * .7,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        'place_order.select_time'
                                                            .tr(),
                                                        style: TextStyle(
                                                            fontSize: 17),
                                                      ),
                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                      Container(
                                                        height: 35,
                                                        width: 90,
                                                        color: primary,
                                                        child: RaisedButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          color: primary,
                                                          child: Text(
                                                            'other.continue'
                                                                .tr(),
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                )),
                                          );
                                        });
                                  } else {
                                    if (snapshot
                                        .data.address.areaName.isNotEmpty) {}
                                    setState(() {
                                      spin = true;
                                    });
                                    OrderSuccessClass msg = await placeOrderApi(
                                        dateTime.day.toString() +
                                            '/' +
                                            dateTime.month.toString() +
                                            '/' +
                                            dateTime.year.toString(),
                                        selectedTimeSlotID,
                                        snapshot
                                            .data.address.customersAddressId,
                                        comments);
                                    setState(() {
                                      spin = false;
                                    });
                                    if (msg.message.toLowerCase() ==
                                        'success') {
                                      // showGeneralDialog(
                                      //     context: context,
                                      //     barrierLabel: 'label2',
                                      //     barrierDismissible: true,
                                      //     pageBuilder: (context, a, aa) {
                                      //       return Align(
                                      //         alignment: Alignment.center,
                                      //         child: Material(
                                      //             borderRadius:
                                      //                 BorderRadius.circular(15),
                                      //             child: Container(
                                      //               decoration: BoxDecoration(
                                      //                   borderRadius:
                                      //                       BorderRadius.circular(
                                      //                           15)),
                                      //               height: 180,
                                      //               width: width * .7,
                                      //               child: Column(
                                      //                 mainAxisAlignment:
                                      //                     MainAxisAlignment
                                      //                         .center,
                                      //                 children: [
                                      //                   Text(
                                      //                     'new.order_placed'.tr(),
                                      //                     style: TextStyle(
                                      //                         fontSize: 16),
                                      //                   ),
                                      //                   SizedBox(
                                      //                     height: 20,
                                      //                   ),
                                      //                   Text(
                                      //                     'new.order_id'.tr() +
                                      //                         ' : ${msg.order}',
                                      //                     style: TextStyle(
                                      //                         color:
                                      //                             Colors.black),
                                      //                   )
                                      //                 ],
                                      //               ),
                                      //             )),
                                      //       );
                                      //     });hhhhh
                                      CoolAlert.show(
                                        context: context,
                                        type: CoolAlertType.success,
                                        confirmBtnText: 'new.ok'.tr(),
                                        callWid: InkWell(
                                          onTap: () {
                                            launch("tel://33100044");
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 5),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.call,
                                                  color: Colors.green,
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  '33100044',
                                                  style: TextStyle(
                                                      color: Colors.green),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        title: 'new.success'.tr(),
                                        text: 'new.order_placed'.tr() +
                                            '\n' +
                                            'new.order_id'.tr() +
                                            ' : ${msg.order}',
                                      ).then((value) {
                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    HomeScreen()),
                                            (route) => false);
                                      });
                                      // Navigator.pop(context);
                                      // Future.delayed(Duration(seconds: 5))
                                      //     .then((value) {
                                      //   Navigator.pushAndRemoveUntil(
                                      //       context,
                                      //       MaterialPageRoute(
                                      //           builder: (context) =>
                                      //               HomeScreen()),
                                      //       (route) => false);
                                      // });
                                    } else {
                                      showMytoast('new.addloc'.tr());
                                    }
                                  }
                                },
                                color: Colors.blue[500],
                                child: Text(
                                  'place_order.place_order'.tr(),
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            )
                          ],
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
