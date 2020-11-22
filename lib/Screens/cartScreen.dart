import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:qtameen/Model/viewCartModel.dart';
import 'package:qtameen/Screens/HomeScreen.dart';
import 'package:qtameen/Screens/shipping_details.dart';
import 'package:qtameen/Widgets/widgets.dart';
import 'package:qtameen/api/api.dart';
import 'package:easy_localization/easy_localization.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int totalCost = 0, shippingCost = 0;
  Map<String, String> count = {};

  bool spin = false;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return ModalProgressHUD(
      inAsyncCall: spin,
      progressIndicator: CommonLoading(),
      color: Colors.black54,
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
            'cart.cart',
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ).tr(),
          actions: [
            InkWell(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('other.confirm').tr(),
                        content: Text('cart.clear_cart'.tr() + ' ?'),
                        actions: [
                          FlatButton(
                            child: Text("other.yes").tr(),
                            onPressed: () async {
                              Navigator.pop(context);
                              setState(() {
                                spin = true;
                              });
                              String msg = await clearCartApi();

                              setState(() {
                                spin = false;
                              });
                              setState(() {
                                cart_count = 0;
                              });
                            },
                          ),
                          FlatButton(
                            child: Text("other.no").tr(),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          )
                        ],
                      );
                    });
              },
              child: Padding(
                padding: EdgeInsets.only(
                  top: 17.0,
                  right: 20.0,
                ),
                child: Text(
                  'other.clear'.tr(),
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            SizedBox(width: 10),
            Badge(
              position: BadgePosition(top: 10, start: 10),
              badgeContent: Text(cart_count.toString(),
                  style: TextStyle(color: Colors.white, fontSize: 10)),
              child: Icon(Icons.shopping_cart),
            ),
            SizedBox(width: 10),
          ],
        ),
        body: Container(
          color: Colors.white,
          child: FutureBuilder<ViewCartClass>(
            future: viewCartApi(),
            builder: (context, snapshot) {
              List<int> cartItems = [];
              totalCost = 0;
              if (snapshot.hasData) {
                return snapshot.data.cartProducts.length == 0
                    ? Center(
                        child: Text(
                          'cart.empty_cart'.tr() + '!!',
                          style: TextStyle(
                              color: Colors.black.withOpacity(.5),
                              fontSize: 20),
                        ),
                      )
                    : Column(
                        children: [
                          Expanded(
                            child: Container(
                              child: ListView.builder(
                                  itemCount: snapshot.data.cartProducts.length,
                                  shrinkWrap: true,
                                  // physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    CartProduct product =
                                        snapshot.data.cartProducts[index];
                                    return Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: Material(
                                        elevation: 5,
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                            color: Colors.white,
                                          ),
                                          width: width,
                                          padding: EdgeInsets.all(10),
                                          child: Row(
                                            children: <Widget>[
                                              Container(
                                                height: 60,
                                                width: 60,
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        image: NetworkImage(
                                                            product
                                                                .productImage))),
                                              ),
                                              SizedBox(
                                                width: 20,
                                              ),
                                              Expanded(
                                                child: Container(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: <Widget>[
                                                      Container(
                                                        child: Text(
                                                          product.productName,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 2,
                                                          style: TextStyle(
                                                            fontSize: 15.0,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              product
                                                                  .productAmount,
                                                              style: TextStyle(
                                                                fontSize: 15.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                              ),
                                                            ),
                                                          ]),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: <Widget>[
                                                          CircleAvatar(
                                                            radius: 16.0,
                                                            backgroundColor:
                                                                Color(
                                                                    0xfffd9800),
                                                            child: IconButton(
                                                              icon: Icon(
                                                                Icons.remove,
                                                                size: 14.0,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                              onPressed:
                                                                  () async {
                                                                setState(() {
                                                                  spin = true;
                                                                });
                                                                String msg =
                                                                    await addToCart(
                                                                        product
                                                                            .productId,
                                                                        '-1');
                                                                setState(() {
                                                                  spin = false;
                                                                });
                                                                // showMytoast(
                                                                //     msg);
                                                                // print(msg);
                                                              },
                                                            ),
                                                          ),
                                                          Container(
                                                            width: width * 0.15,
                                                            alignment: Alignment
                                                                .center,
                                                            child: Text(
                                                              product.quantity,
                                                              style: TextStyle(
                                                                color: Color(
                                                                    0xffc65a53),
                                                              ),
                                                            ),
                                                          ),
                                                          CircleAvatar(
                                                            radius: 16.0,
                                                            backgroundColor:
                                                                Color(
                                                                    0xfffd9800),
                                                            child: IconButton(
                                                              icon: Icon(
                                                                Icons.add,
                                                                size: 14.0,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                              onPressed:
                                                                  () async {
                                                                setState(() {
                                                                  spin = true;
                                                                });
                                                                String msg =
                                                                    await addToCart(
                                                                        product
                                                                            .productId,
                                                                        '1');
                                                                setState(() {
                                                                  spin = false;
                                                                });
                                                                // showMytoast(
                                                                //     msg);
                                                              },
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  IconButton(
                                                    onPressed: () async {
                                                      setState(() {
                                                        spin = true;
                                                      });
                                                      String msg =
                                                          await removefromCart(
                                                              product
                                                                  .productId);
                                                      print(msg);
                                                      String count =
                                                          await cartCount();
                                                      setState(() {
                                                        cart_count =
                                                            int.parse(count);
                                                        spin = false;
                                                      });
                                                    },
                                                    padding: EdgeInsets.all(5),
                                                    icon: Icon(
                                                      Icons.close,
                                                      size: 30,
                                                      color: Colors.black87,
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                          ),
                          Divider(
                            thickness: 3,
                            color: Colors.blue[500],
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              children: [
                                // SizedBox(
                                //   height: 5,
                                // ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('cart.bill_amount'.tr() + '  : '),
                                    Text(snapshot.data.amountDetails.billAmount)
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('cart.delivery_charge'.tr() + ' : '),
                                    Text(snapshot
                                        .data.amountDetails.deliveryCharge)
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Divider(),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'cart.total_amount'.tr() + ' : ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15),
                                    ),
                                    Text(
                                      snapshot.data.amountDetails.grandTotal,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15),
                                    ),
                                  ],
                                ),

                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                    height: 40,
                                    width: 130,
                                    child: RaisedButton(
                                      color: Colors.blue[500],
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      onPressed: () {
                                        navigate(context, ShippingDetails());
                                      },
                                      child: Text(
                                        'cart.place_order',
                                        style: TextStyle(color: Colors.white),
                                      ).tr(),
                                    ))
                              ],
                            ),
                          )
                        ],
                      );
              } else
                return Container(
                  child: Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.white,
                    ),
                  ),
                );
            },
          ),
        ),
      ),
    );
  }
}
