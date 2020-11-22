import 'dart:async';

import 'package:flutter/material.dart';
import 'package:qtameen/Model/cartModel.dart';
import 'package:qtameen/Widgets/widgets.dart';
import 'package:qtameen/api/api.dart';
import 'package:qtameen/api/homeScreenapi.dart';
import 'package:easy_localization/easy_localization.dart';
import 'orderDetails.dart';

class MyOrders extends StatefulWidget {
  @override
  _MyOrdersState createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('orders.my_orders').tr(),
      ),
      body: Container(
        height: height,
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: <Widget>[
            SizedBox(height: 10),
            FutureBuilder<MyCartClass>(
              future: myOrdersApi(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemCount: snapshot.data.orders.length,
                      itemBuilder: (context, index) {
                        Order order = snapshot.data.orders[index];
                        return Column(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.all(10.0),
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                padding: EdgeInsets.all(0),
                                onPressed: () {
                                  navigate(
                                      context,
                                      OrderDetails(
                                        orderId: order.ordersId,
                                      ));
                                },
                                child: Container(
                                  padding: EdgeInsets.all(14.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(order.billNumber),
                                          Text(order.date)
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Row(
                                            children: [
                                              Text(
                                                'orders.total'.tr() + ' :',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              SizedBox(width: 5),
                                              Text(
                                                order.total,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  color: Color(0xffDC0D0D),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                'orders.status'.tr() + ' :',
                                                // style: TextStyle(
                                                //   fontWeight: FontWeight.w600,
                                                // ),
                                              ),
                                              SizedBox(width: 5),
                                              Text(
                                                order.status,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  color: Color(0xffDC0D0D),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      });
                } else {
                  return Container(
                    height: height * .8,
                    width: width,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              },
            ),
            SizedBox(height: height * 0.02),
          ],
        ),
      ),
    );
  }

  Container deliveredOrder(
      double height, BuildContext context, String id, date, time) {
    return Container(
      padding: EdgeInsets.all(14.0),
      margin: EdgeInsets.all(6.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        children: <Widget>[
          orderId(id),
          orderDetails(date, time),
          SizedBox(height: height * 0.03),
          CircleAvatar(
            backgroundColor: Color(0xfff5d23a),
            child: Icon(
              Icons.done,
              size: 30.0,
            ),
          ),
          Text(
            'Completed',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w300,
            ),
          ),
          SizedBox(height: height * 0.03),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              InkWell(
                onTap: () {
                  // showFeedbackDialog(context);
                },
                // child: buildContainer(Icons.thumb_up, 'Feedback'),
              ),
              InkWell(
                onTap: () {
                  // navigate(
                  //   context,
                  //   OrderDetails(
                  //     orderId: id,
                  //   ),
                  // );
                },
                // child: buildContainer(Icons.remove_red_eye, 'View Invoice'),
              ),
            ],
          )
        ],
      ),
    );
  }

  Text orderId(String id) {
    return Text(
      'ORDER ID : $id',
      style: TextStyle(
        fontSize: 17.0,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Text orderDetails(String date, String time) {
    return Text(
      'Placed on $date at $time',
      style: TextStyle(
        fontSize: 17.0,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Container buildContainer(text) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(4.0),
        child: Row(
          children: <Widget>[
            Text(
              'Status',
              style: TextStyle(
                fontSize: 9.0,
                fontWeight: FontWeight.w300,
                color: Color(0xff2D2D2D),
              ),
            ),
            SizedBox(width: 4.0),
            Text(
              text,
              style: TextStyle(
                fontSize: 9.0,
                fontWeight: FontWeight.w700,
                color: Color(0xff2D2D2D),
              ),
            )
          ],
        ),
      ),
    );
  }
}
