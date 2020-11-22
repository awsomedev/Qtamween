import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:qtameen/Model/subcategoryModel.dart';
import 'package:qtameen/Screens/HomeScreen.dart';
import 'package:qtameen/Screens/cartScreen.dart';
import 'package:qtameen/Screens/productDescription.dart';
import 'package:qtameen/Screens/searchProduct.dart';
import 'package:qtameen/Widgets/widgets.dart';
import 'package:qtameen/api/api.dart';
import 'package:easy_localization/easy_localization.dart';

class CategoryDetails extends StatefulWidget {
  String id;
  String name;
  CategoryDetails({this.id, this.name});
  @override
  _CategoryDetailsState createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  bool spin = false;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<CategoryDetailsClass>(
      future: firstLoad(widget.id, '0'),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Tab> tabs = [];
          List<Widget> bodys = [];
          for (var item in snapshot.data.subCategory) {
            ScrollController sc = ScrollController();
            tabs.add(Tab(
              text: item.subCategory,
            ));
            // bodys.add(FutureBuilder<CategoryDetailsClass>(
            //   future: categoryDetailApi(widget.id, item.subCategoryId),
            //   builder: (context, snap) {
            //     List<Widget> wids = [];
            //     if (snap.hasData) {
            //       for (var item in snap.data.products) {
            //         wids.add(ProductView(
            //           height: height(context),
            //           width: width(context),
            //           widhData: item.wishlistStatus == 1,
            //           wishtoggle: () async {
            //             if (item.wishlistStatus == 1) {
            //               //remove from wish
            //               String msg = await removefromWishlist(item.productId);
            //               print(msg);
            //               setState(() {
            //                 item.wishlistStatus = 0;
            //               });
            //               showMytoast('msg.remover-wishlist'.tr());
            //             } else {
            //               //addd to wish
            //               String msg = await addtoWishlist(item.productId);
            //               print(msg);
            //               showMytoast('msg.added-wishlist'.tr());
            //               setState(() {
            //                 item.wishlistStatus = 1;
            //               });
            //             }
            //           },
            //           data: item,
            //           cartPressed: () async {
            //             showMytoast(
            //               'msg.added_to_cart'.tr(),
            //             );

            //             String msg = await addToCart(item.productId, '1');
            //             String count = await cartCount();
            //             setState(() {
            //               cart_count = int.parse(count);
            //             });

            //             print(msg);
            //           },
            //         ));
            //       }
            //       return SingleChildScrollView(
            //         controller: sc,
            //         child: Padding(
            //           padding: EdgeInsets.symmetric(horizontal: 10),
            //           child: Wrap(
            //             spacing: 10,
            //             runSpacing: 10,
            //             children: wids,
            //           ),
            //         ),
            //       );
            //     } else {
            //       return Center(
            //         child: CircularProgressIndicator(),
            //       );
            //     }
            //   },
            // ));
            bodys.add(PagewiseGridView<Product>.count(
                pageSize: 1000,
                crossAxisCount: 2,
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
                childAspectRatio: .57,
                padding: EdgeInsets.all(15.0),
                itemBuilder: (context, data, i) {
                  return ProductView(
                    height: height(context),
                    width: width(context),
                    widhData: data.wishlistStatus == 1,
                    wishtoggle: () async {
                      if (data.wishlistStatus == 1) {
                        //remove from wish
                        String msg = await removefromWishlist(data.productId);
                        print(msg);
                        setState(() {
                          data.wishlistStatus = 0;
                        });
                        showMytoast('msg.remover-wishlist'.tr());
                      } else {
                        //addd to wish
                        String msg = await addtoWishlist(data.productId);
                        print(msg);
                        showMytoast('msg.added-wishlist'.tr());
                        setState(() {
                          data.wishlistStatus = 1;
                        });
                      }
                    },
                    data: data,
                    cartPressed: () async {
                      setState(() {
                        spin = true;
                      });
                      String msg = await addToCart(data.productId, '1');
                      setState(() {
                        spin = false;
                      });
                      showMytoast(
                        'msg.added_to_cart'.tr(),
                      );
                      String count = await cartCount();
                      setState(() {
                        cart_count = int.parse(count);
                      });

                      print(msg);
                    },
                  );
                },
                pageFuture: (pageIndex) {
                  return categoryproductApi(
                      widget.id, item.subCategoryId, 0, 200);
                }));
          }

          return DefaultTabController(
            length: snapshot.data.subCategory.length,
            child: ModalProgressHUD(
              inAsyncCall: spin,
              progressIndicator: CommonLoading(),
              child: Scaffold(
                appBar: AppBar(
                  title: Text(widget.name),
                  actions: [
                    InkWell(
                      onTap: () {
                        navigate(context, SearchProductScreen());
                      },
                      child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Icon(
                            Icons.search,
                          )),
                    ),
                    InkWell(
                      onTap: () {
                        // navigate(context, CartScreen());
                        Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CartScreen()))
                            .then((value) {
                          setState(() {});
                        });
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Badge(
                          position: BadgePosition(top: 10, start: 10),
                          badgeContent: Text(cart_count.toString(),
                              style:
                                  TextStyle(color: Colors.white, fontSize: 10)),
                          child: Icon(Icons.shopping_cart),
                        ),
                      ),
                    ),
                  ],
                  bottom: TabBar(
                    isScrollable: true,
                    onTap: (index) {
                      // Tab index when user select it, it start from zero
                    },
                    tabs: tabs,
                  ),
                ),
                body: TabBarView(
                  children: bodys,
                ),
              ),
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              title: Text(widget.name),
              actions: [
                InkWell(
                  onTap: () {
                    navigate(context, CartScreen());
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Badge(
                      position: BadgePosition(top: 10, start: 10),
                      badgeContent: Text(cart_count.toString(),
                          style: TextStyle(color: Colors.white, fontSize: 10)),
                      child: Icon(Icons.shopping_cart),
                    ),
                  ),
                ),
              ],
            ),
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}

class ProductView extends StatefulWidget {
  ProductView({
    Key key,
    @required this.height,
    @required this.width,
    @required this.data,
    @required this.cartPressed,
    @required this.widhData,
    @required this.wishtoggle,
  }) : super(key: key);

  final double height;
  final double width;
  final bool widhData;

  final Function cartPressed;
  final Function wishtoggle;
  var data;

  @override
  _ProductViewState createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  int cartItems = 0;
  bool addCart = false, addWishlist = false;
  bool spin = false;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Container(
      // margin: EdgeInsets.only(right: 10),
      child: InkWell(
        onTap: () {
          navigate(
            context,
            ProductDescription(
              id: widget.data.productId,
              name: widget.data.productName,
            ),
          );
        },
        child: Material(
          borderRadius: BorderRadius.circular(20.0),
          elevation: 2,
          color: Colors.white,
          child: Stack(
            children: [
              Container(
                // height:
                //     EasyLocalization.of(context).locale == Locale('ar', 'DZ')
                //         ? 280
                //         : 260,
                // height: widget.height * 0.3,
                // width: widget.width * .5 - 15,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      children: [
                        SizedBox(height: height * .01),
                        Align(
                          alignment: Alignment.centerRight,
                          child: InkWell(
                            onTap: widget.wishtoggle,
                            child: Padding(
                              padding: EdgeInsets.only(
                                top: 4.0,
                                right: 10.0,
                              ),
                              child: Icon(
                                widget.widhData
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: Color(0xffF2C557),
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: height * .13,
                          child: Image.network(
                            widget.data.productImage,
                            width: widget.width * .25,
                          ),
                        ),
                        SizedBox(height: height * .012),
                        Container(
                          // height: height * 0.05,
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Text(
                              widget.data.productName,
                              textAlign: TextAlign.center,
                              maxLines: 2,
                            ),
                          ),
                        ),
                        SizedBox(height: height * .015),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Text(
                            widget.data.productQuantity,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.orange[700],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                //   height:
                //       EasyLocalization.of(context).locale == Locale('ar', 'DZ')
                //           ? 280
                //           : 260,
                // height: widget.height * 0.3,
                width: widget.width * .5 - 15,
                alignment: Alignment.bottomCenter,
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.data.productPrice,
                              style: TextStyle(
                                color: Color(0xff44afdc),
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 40,
                      width: 65,
                      child: RaisedButton(
                        splashColor: Colors.blue,
                        elevation: 3,
                        disabledElevation: 0,
                        focusElevation: 3,
                        highlightElevation: 0,
                        hoverElevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: EasyLocalization.of(context).locale ==
                                  Locale('ar', 'DZ')
                              ? BorderRadius.only(
                                  topRight: Radius.circular(20),
                                  bottomLeft: Radius.circular(14.0),
                                )
                              : BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(14.0),
                                ),
                        ),
                        onPressed: widget.cartPressed,
                        color: Color(0xffF2C557),
                        padding: EdgeInsets.all(0),
                        child: Center(
                          child: Icon(
                            Icons.add_shopping_cart,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
