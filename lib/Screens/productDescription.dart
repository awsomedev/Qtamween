import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:photo_view/photo_view.dart';
import 'package:qtameen/Model/ProductDetailsModel.dart';
import 'package:qtameen/Widgets/widgets.dart';
import 'package:qtameen/api/api.dart';
import 'package:qtameen/api/homeScreenapi.dart';
import 'HomeScreen.dart';
import '../Widgets/widgets.dart';
import 'package:easy_localization/easy_localization.dart';

class ProductDescription extends StatefulWidget {
  ProductDescription({
    this.id,
    this.name,
  });
  final String id, name;
  @override
  _ProductDescriptionState createState() => _ProductDescriptionState();
}

class _ProductDescriptionState extends State<ProductDescription> {
  bool addCart = false;
  int cartItems = 1;
  double zoomval = 1;

  @override
  void initState() {
    super.initState();
  }

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
            widget.name,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
              fontWeight: FontWeight.w300,
            ),
          ),
          // actions: [
          //   // appBarCart(width, context),
          //   SizedBox(width: 10),
          //   InkWell(
          //     onTap: () {
          //       // navigate(context, WhislsiScreen());

          //     },
          //     child: Icon(
          //       Icons.favorite_border,
          //       color: Colors.white,
          //     ),
          //   ),
          //   SizedBox(width: 10),
          // ],
        ),
        backgroundColor: Colors.white,
        body: Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: FutureBuilder<ProductDetailsClass>(
              future: productDetailsApi(widget.id),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  ProductDetailsClass data = snapshot.data;
                  List<Widget> images = [];
                  for (var item in data.productImages) {
                    images.add(Container(
                      height: 200,
                      child: PhotoView(
                        backgroundDecoration:
                            BoxDecoration(color: Colors.white),
                        imageProvider: NetworkImage(item.productImages),
                      ),
                    ));
                    // images.add(Container(
                    //     height: 200,
                    // child: PhotoView(
                    //   imageProvider: NetworkImage(item.productImages),
                    // ),
                    // margin: EdgeInsets.symmetric(horizontal: 10),
                    // decoration: BoxDecoration(
                    //     color: Colors.transparent,
                    //     image: DecorationImage(
                    //         image: NetworkImage(item.productImages))),
                    // color: Colors.red,
                    // child: GestureDetector(
                    //     onDoubleTap: () {
                    //       if (zoomval < 3) {
                    //         setState(() {
                    //           zoomval++;
                    //         });
                    //       } else {
                    //         setState(() {
                    //           zoomval = 1;
                    //         });
                    //       }
                    //     },
                    //     child: Transform.scale(
                    //         scale: zoomval,
                    //         child: Image.network(item.productImages)))));
                  }

                  List<Widget> wids = [
                    SizedBox(
                      width: 10,
                    )
                  ];

                  for (var item in snapshot.data.relatedProducts) {
                    wids.add(Column(
                      children: [
                        NewBestSeller(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          wishlistData: item.wishlistStatus == 1,
                          wishToggle: () async {
                            if (item.wishlistStatus == 1) {
                              //remove from wish
                              String msg =
                                  await removefromWishlist(item.productId);
                              print(msg);
                              setState(() {
                                item.wishlistStatus = 0;
                              });
                            } else {
                              //addd to wish
                              String msg = await addtoWishlist(item.productId);
                              print(msg);
                              setState(() {
                                item.wishlistStatus = 1;
                              });
                            }
                          },
                          addtoCart: () async {
                            setState(() {
                              spin = true;
                            });
                            // showMytoast('msg.added_to_cart'.tr());
                            String msg = await addToCart(item.productId, '1');
                            showMytoast('msg.added_to_cart'.tr(),
                                color: Colors.blue[700]);
                            setState(() {
                              spin = false;
                            });

                            String count = await cartCount();
                            setState(() {
                              cart_count = int.parse(count);
                            });
                            print(msg);
                          },
                          data: item,
                          type: 'feature',
                        ),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    ));
                  }

                  return SingleChildScrollView(
                    child: Container(
                      // height: height,
                      // width: width,
                      child: Column(
                        children: <Widget>[
                          // SizedBox(height: 20),
                          Container(
                            height: 200,
                            width: width,
                            child: PageView(
                              children: images,
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
                            padding: EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  widget.name,
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'product.size'.tr() +
                                      ':  ${data.productDetails.productTypeQuantity}',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    // color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Row(
                                  children: [
                                    Text(
                                      '${data.productDetails.productOfferPrice}',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        color: Color(0xffc65a53),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      '${data.productDetails.productPrice}',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        decoration: TextDecoration.lineThrough,
                                        fontSize: 14.0,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        InkWell(
                                          onTap: () {
                                            if (cartItems > 1) {
                                              setState(() {
                                                cartItems -= 1;
                                              });
                                            } else {
                                              setState(() {
                                                cartItems = 1;
                                              });
                                            }
                                          },
                                          child: Container(
                                            height: 35,
                                            width: 35,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                color: Color(0xffebb55e),
                                                width: 1.0,
                                              ),
                                            ),
                                            alignment: Alignment.center,
                                            child: Icon(
                                              Icons.remove,
                                              size: 13.0,
                                              color: Color(0xffebb55e),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          width: 50,
                                          child: Text(
                                            '$cartItems',
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Color(0xffc65a53),
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            print(snapshot.data.productDetails
                                                .productMaxStock);
                                            if (cartItems <
                                                int.parse(snapshot
                                                    .data
                                                    .productDetails
                                                    .productMaxStock)) {
                                              setState(() {
                                                cartItems += 1;
                                              });
                                            }
                                          },
                                          child: Container(
                                            height: 35,
                                            width: 35,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                color: Color(0xffebb55e),
                                                width: 1.0,
                                              ),
                                            ),
                                            alignment: Alignment.center,
                                            child: Icon(
                                              Icons.add,
                                              size: 13.0,
                                              color: Color(0xffebb55e),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    RaisedButton(
                                      padding: EdgeInsets.all(0),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      onPressed: () async {
                                        setState(() {
                                          spin = true;
                                        });

                                        String msg = await addToCart(
                                            widget.id, '$cartItems');
                                        // showMytoast('msg.added_to_cart'.tr(),
                                        //     color: Colors.blue[700]);
                                        showMytoast(msg,
                                            color: Colors.blue[700]);
                                        setState(() {
                                          spin = false;
                                        });
                                        // showMytoast('msg.added_to_cart'.tr());

                                        String count = await cartCount();
                                        setState(() {
                                          cart_count = int.parse(count);
                                        });
                                        // print(msg);

                                        setState(() {
                                          spin = false;
                                        });
                                      },
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        child: Container(
                                          padding: EdgeInsets.only(
                                            left: 4.0,
                                            right: 4.0,
                                          ),
                                          width: width * 0.4,
                                          // height: height * 0.05,
                                          height: 40,
                                          color: Colors.blue[600],
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.shopping_cart,
                                                color: Colors.white,
                                                size: 20,
                                              ),
                                              Text(
                                                'product.add_to_cart',
                                                style: TextStyle(
                                                  fontSize: 17,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ).tr(),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 20),
                                Text(snapshot
                                    .data.productDetails.productDescription),
                                // SizedBox(
                                //   height: 20,
                                // ),
                              ],
                            ),
                          ),
                          snapshot.data.relatedProducts.length == 0
                              ? Container(
                                  height: 0,
                                  width: 0,
                                )
                              : Container(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        'product.related_products',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ).tr(),
                                    ],
                                  ),
                                ),
                          SizedBox(
                            height: 20,
                          ),
                          snapshot.data.relatedProducts.length == 0
                              ? Container(
                                  height: 0,
                                  width: 0,
                                )
                              : SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: wids,
                                  ),
                                ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            )),
      ),
    );
  }
}
