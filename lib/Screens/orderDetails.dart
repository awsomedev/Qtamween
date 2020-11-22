import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:qtameen/Model/orderDetailModel.dart';
import 'package:qtameen/api/api.dart';
import 'package:easy_localization/easy_localization.dart';

class OrderDetails extends StatefulWidget {
  OrderDetails({this.orderId});

  final String orderId;
  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var style2 = TextStyle(
      // color: Colors.white,
      fontSize: 19.0,
      fontWeight: FontWeight.w400,
    );
    var style1 = TextStyle(
      // color: Colors.white,
      fontSize: 19.0,
      fontWeight: FontWeight.w600,
    );
    return Scaffold(
      appBar: AppBar(
          title: Text(
        widget.orderId,
      )),
      body: Container(
        // color: Color(0xff2b2020),
        height: height,
        decoration: BoxDecoration(
          // image: DecorationImage(
          //   image: AssetImage('images/bg.png'),
          //   fit: BoxFit.cover,
          // ),
          color: Colors.white,
        ),
        // padding: EdgeInsets.all(20.0),
        child: FutureBuilder<OrderDetailClass>(
          future: myOrdersDetailsApi(widget.orderId),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              OrderDetailClass data = snapshot.data;
              return Container(
                child: Column(
                  children: [
                    Expanded(
                        child: Container(
                      child: ListView.builder(
                        itemCount: data.orderItems.length,
                        itemBuilder: (context, index) => Padding(
                          padding: EdgeInsets.all(5),
                          child: Material(
                            elevation: 3,
                            borderRadius: BorderRadius.circular(5),
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5)),
                              child: ListTile(
                                leading: Image.network(
                                  data.orderItems[index].productImage,
                                  height: 60,
                                  width: 60,
                                ),
                                title: Text(
                                  data.orderItems[index].productName,
                                  style: TextStyle(fontSize: 14),
                                ),
                                subtitle: Row(
                                  children: [
                                    Text(
                                      'other.qty'.tr() + ' : ',
                                      style: TextStyle(
                                          color: Colors.black87, fontSize: 14),
                                    ),
                                    Text(data.orderItems[index].quantity,
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 14)),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(data.orderItems[index].productPrice,
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 14))
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )),
                    Container(
                      // height: 300,
                      child: Column(
                        children: [
                          Divider(
                            thickness: 2,
                            color: Colors.blue[500],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('my_orders.bill_number'.tr() + ' : '),
                              Text(data.orderDetails.billNumber)
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('my_orders.date'.tr() + ' : '),
                              Text(data.orderDetails.date)
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('orders.status'.tr() + ' : '),
                              Text(data.orderDetails.status)
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('cart.bill_amount'.tr() + ' : '),
                              Text(data.orderDetails.subTotal)
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('cart.delivery_charge'.tr() + ' : '),
                              Text(data.orderDetails.deliveryCharge)
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Divider(),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'cart.total_amount'.tr() + ' : ',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                              Text(
                                data.orderDetails.grandTotal,
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Container(
                width: width,
                height: height,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Divider buildDivider() {
    return Divider(
      height: 30.0,
      thickness: 1.0,
      color: Color(0xffD50606),
    );
  }
}
