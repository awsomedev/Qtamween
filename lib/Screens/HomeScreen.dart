import 'dart:async';

import 'package:badges/badges.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:oktoast/oktoast.dart';
import 'package:qtameen/Model/HomeScreenSlider.dart';
import 'package:qtameen/Model/OfferProductModel.dart';
import 'package:qtameen/Model/categoryModel.dart';
import 'package:qtameen/Model/homeScreenFeaturedModel.dart';
import 'package:qtameen/Screens/aboutus.dart';
import 'package:qtameen/Screens/contactus.dart';
import 'package:qtameen/Screens/privacy.dart';
import 'package:qtameen/Screens/productDescription.dart';
import 'package:qtameen/Screens/searchProduct.dart';
import 'package:qtameen/Screens/subcategorypage.dart';
import 'package:qtameen/Screens/termsConditions.dart';
import 'package:qtameen/Screens/wishlistScreen.dart';
import 'package:qtameen/Widgets/widgets.dart';
import 'package:qtameen/api/api.dart';
import 'package:qtameen/api/homeScreenapi.dart';
import 'package:qtameen/main.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:url_launcher/url_launcher.dart';

import 'cartScreen.dart';
import 'changeLanguageScreen.dart';
import 'featured.dart';

int cart_count = 0;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  bool spin = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: spin,
      color: Colors.black54,
      child: Scaffold(
        appBar: AppBar(
          // leading: FlatButton(
          //   padding: EdgeInsets.all(0),
          //   onPressed: () {
          //     key.currentState.openDrawer();
          //   },
          //   child: Icon(
          //     Icons.menu,
          //     color: Colors.white,
          //   ),
          // ),
          title: Text(
            'appname.app_name',
            style: TextStyle(color: Colors.white),
          ).tr(),
          centerTitle: true,
          actions: <Widget>[
            Container(
              // width: width * 0.15,
              child: Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: IconButton(
                  icon: Icon(
                    Icons.favorite_border,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    navigate(context, WhislsiScreen());
                    setState(() {});
                  },
                ),
              ),
            ),
            InkWell(
              onTap: () {
                showMenu(
                  context: context,
                  position:
                      EasyLocalization.of(context).locale == Locale('ar', 'DZ')
                          ? RelativeRect.fromLTRB(0, 50, 1000, 0)
                          : RelativeRect.fromLTRB(1000, 50, 0, 0),
                  items: [
                    PopupMenuItem(
                      enabled: false,
                      child: InkWell(
                        onTap: () {
                          navigate(context, Contactus());
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            'other.support'.tr(),
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                    PopupMenuItem(
                      enabled: false,
                      child: InkWell(
                        onTap: () {
                          navigate(context, Terms());
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            'other.terms'.tr(),
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                    PopupMenuItem(
                      enabled: false,
                      child: InkWell(
                        onTap: () {
                          navigate(context, PrivacyPolicy());
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            'menu.privacy',
                            style: TextStyle(color: Colors.black),
                          ).tr(),
                        ),
                      ),
                    ),
                    PopupMenuItem(
                      enabled: false,
                      child: InkWell(
                        onTap: () {
                          navigate(context, About());
                        },
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            'menu.aboutus',
                            style: TextStyle(color: Colors.black),
                          ).tr(),
                        ),
                      ),
                    ),
                  ],
                );
              },
              child: Icon(
                Icons.more_vert,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 5),
          ],
        ),
        drawer: SideDrawer(
          name: '',
          context: context,
        ),
        body: HomeTabScreen(),
      ),
    );
  }
}

class HomeTabScreen extends StatefulWidget {
  @override
  _HomeTabScreenState createState() => _HomeTabScreenState();
}

class _HomeTabScreenState extends State<HomeTabScreen> {
  StreamController<String> _userController;

  loadDetails() async {
    cartCount().then((res) async {
      // print('LoadDetails of $res');
      _userController.add(res);
      return res;
    });
  }

  @override
  void initState() {
    // checkUpdate();
    _userController = new StreamController();
    Timer.periodic(Duration(seconds: 2), (_) => loadDetails());
    // Timer.periodic(Duration(seconds: 1), (_) => checkUpdate());
    super.initState();
  }

  @override
  void dispose() {
    // _userController.close();

    super.dispose();
  }

  bool spin = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: spin,
      progressIndicator: CommonLoading(),
      color: Colors.black54,
      child: Scaffold(
        floatingActionButton: StreamBuilder<String>(
          stream: _userController.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              cart_count = int.parse(snapshot.data);
              return Badge(
                badgeContent: Text(
                  cart_count.toString(),
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
                position: BadgePosition(bottom: 35, start: 40),
                child: FloatingActionButton(
                    backgroundColor: Color(0xff4fc2f8),
                    onPressed: () {
                      // navigate(context, CartScreen());
                      Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CartScreen()))
                          .then((value) {
                        // setState(() {
                        //   cart_count = int.parse(value);
                        // });
                        setState(() {});
                      });
                    },
                    child: Icon(
                      Icons.shopping_cart_rounded,
                      color: Colors.white,
                    )),
              );
            } else {
              return Container(
                height: 0,
                width: 0,
              );
            }
          },
        ),
        body: Stack(
          children: [
            Background(),
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  FutureBuilder<HomeSliderClass>(
                    future: getSlider(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return CarouselSlider.builder(
                          itemCount: snapshot.data.homeSlider.length,
                          itemBuilder: (context, index) {
                            String images =
                                snapshot.data.homeSlider[index].homeSliderImage;
                            return Container(
                              height: 150,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(images),
                                  fit: BoxFit.fill,
                                ),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            );
                          },
                          options: CarouselOptions(
                            height: 150,
                            autoPlay: true,
                            initialPage: 0,
                            enlargeCenterPage: true,
                          ),
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.0),
                    child: TextField(
                      readOnly: true,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SearchProductScreen(),
                          ),
                        ).then((value) {
                          setState(() {});
                        });
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.black.withOpacity(.5),
                        ),
                        hintText: 'search.search_text'.tr(),
                        hintStyle: TextStyle(
                          color: Colors.black.withOpacity(.5),
                          fontWeight: FontWeight.w300,
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(height: 20),
                  FutureBuilder<HomeCategoryClass>(
                    future: homeCategoryApi(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        print(snapshot.data.category.length);

                        return Container(
                          child: GridView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data.category.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                            ),
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(),
                                child: FlatButton(
                                  padding: EdgeInsets.all(0),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => CategoryDetails(
                                          id: snapshot
                                              .data.category[index].categoryId,
                                          name: snapshot.data.category[index]
                                              .categoryName,
                                        ),
                                      ),
                                    ).then((value) {
                                      setState(() {});
                                    });
                                  },
                                  child: Material(
                                    borderRadius: BorderRadius.circular(10.0),
                                    elevation: 5.0,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 8.0, horizontal: 4),
                                      child: Column(
                                        // mainAxisAlignment:
                                        //     MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Expanded(
                                            child: Container(
                                              child: Column(
                                                children: [
                                                  Image.network(
                                                    snapshot
                                                        .data
                                                        .category[index]
                                                        .categoryIcon,
                                                    height: 35,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              child: Center(
                                                child: Text(
                                                  snapshot.data.category[index]
                                                      .categoryName,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15.0,
                                                    // fontWeight: FontWeight.w600,
                                                  ),
                                                  textAlign: TextAlign.center,
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
                            },
                          ),
                        );
                      } else {
                        return Container(
                          height: height(context) * 0.16,
                        );
                      }
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  // SizedBox(
                  //   height: 150,
                  // ),
                  FutureBuilder<String>(
                    future: promotionSliderApi(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Container(
                          height: 150,
                          width: double.infinity,
                          child: Image.network(
                            snapshot.data,
                            fit: BoxFit.fill,
                          ),
                        );
                      } else {
                        return Container(
                          height: 100,
                        );
                      }
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'home.featured',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ).tr(),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => OfferProductScreen(
                                    title: 'home.featured'.tr()),
                              ),
                            ).then((value) {
                              setState(() {});
                            });
                          },
                          child: Row(
                            children: [
                              Text(
                                'home.more',
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w400,
                                ),
                              ).tr(),
                              Icon(
                                Icons.arrow_forward,
                                color: Colors.black,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  FutureBuilder<FeaturedProductClass>(
                    future: featuredApi(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<Widget> wids = [
                          SizedBox(
                            width: 10,
                          )
                        ];

                        for (var item in snapshot.data.featuredProducts) {
                          wids.add(Column(
                            children: [
                              NewBestSeller(
                                height: height(context),
                                width: width(context),
                                wishlistData: item.wishlistStatus == 1,
                                wishToggle: () async {
                                  if (item.wishlistStatus == 1) {
                                    //remove from wish
                                    String msg = await removefromWishlist(
                                        item.productId);
                                    print(msg);
                                    setState(() {
                                      item.wishlistStatus = 0;
                                    });

                                    showMytoast('msg.remover-wishlist'.tr());
                                  } else {
                                    //addd to wish
                                    String msg =
                                        await addtoWishlist(item.productId);
                                    print(msg);
                                    showMytoast('msg.added-wishlist'.tr());
                                    // added-wishlist
                                    setState(() {
                                      item.wishlistStatus = 1;
                                    });
                                  }
                                },
                                addtoCart: () async {
                                  setState(() {
                                    spin = true;
                                  });
                                  String msg =
                                      await addToCart(item.productId, '1');

                                  setState(() {
                                    spin = false;
                                  });

                                  showMytoast('msg.added_to_cart'.tr(),
                                      color: Colors.blue[700]);
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
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: wids,
                          ),
                        );
                      } else {
                        return Container(
                          height: height(context) * 0.24,
                        );
                      }
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'home.offer',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ).tr(),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => OfferProductScreen(
                                    title: 'home.offer'.tr()),
                              ),
                            ).then((value) {
                              setState(() {});
                            });
                          },
                          child: Row(
                            children: [
                              Text(
                                'home.more',
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w400,
                                ),
                              ).tr(),
                              Icon(
                                Icons.arrow_forward,
                                color: Colors.black,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  FutureBuilder<OfferProductClass>(
                    future: offerProductApi(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        // List<Widget> list = [];
                        // print(snapshot.data);

                        List<Widget> wids = [
                          SizedBox(
                            width: 10,
                          )
                        ];

                        for (var item in snapshot.data.offerProducts) {
                          wids.add(Column(
                            children: [
                              NewBestSeller(
                                height: height(context),
                                width: width(context),
                                data: item,
                                wishlistData: item.wishlistStatus == 1,
                                wishToggle: () async {
                                  if (item.wishlistStatus == 1) {
                                    //remove from wish
                                    String msg = await removefromWishlist(
                                        item.productId);
                                    print(msg);
                                    setState(() {
                                      item.wishlistStatus = 0;
                                    });
                                  } else {
                                    //addd to wish
                                    String msg =
                                        await addtoWishlist(item.productId);
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
                                  String msg =
                                      await addToCart(item.productId, '1');
                                  showMytoast('msg.added_to_cart'.tr(),
                                      color: Colors.blue[700]);

                                  setState(() {
                                    spin = false;
                                  });
                                  // print(msg);
                                  // showMytoast(msg);
                                  String count = await cartCount();
                                  setState(() {
                                    cart_count = int.parse(count);
                                  });
                                },
                                type: 'offer',
                              ),
                              SizedBox(
                                height: 10,
                              )
                            ],
                          ));
                        }
                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: wids,
                          ),
                        );

                        // return Container(
                        //   height: 300,
                        //   child: ListView.builder(
                        //     itemCount: snapshot.data.offerProducts.length,
                        //     shrinkWrap: true,
                        //     scrollDirection: Axis.horizontal,
                        //     itemBuilder: (context, index) {
                        //       return Column(
                        //         children: [
                        //           NewBestSeller(
                        //             height: height,
                        //             width: width,
                        //             id: snapshot.data.offerProducts[index],
                        //           ),
                        //           SizedBox(
                        //             height: 10,
                        //           )
                        //         ],
                        //       );
                        //     },
                        //   ),
                        // );
                      } else {
                        return Container(
                          height: height(context) * 0.24,
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NewBestSeller extends StatefulWidget {
  NewBestSeller({
    Key key,
    @required this.height,
    @required this.width,
    @required this.data,
    @required this.type,
    @required this.addtoCart,
    @required this.wishlistData,
    @required this.wishToggle,
  }) : super(key: key);

  final double height;
  final double width;
  bool wishlistData;
  String type;
  Function addtoCart;
  Function wishToggle;
  var data;

  @override
  _NewBestSellerState createState() => _NewBestSellerState();
}

class _NewBestSellerState extends State<NewBestSeller> {
  int cartItems = 0;
  bool addCart = false, addWishlist = false;
  bool spin = false;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.only(right: 10),
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
          elevation: 3,
          color: Colors.white,
          child: Stack(
            children: [
              Container(
                height: 290,
                // height: widget.height * 0.3,
                width: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      children: [
                        SizedBox(height: 7),
                        Align(
                          alignment: Alignment.centerRight,
                          child: InkWell(
                            onTap: widget.wishToggle,
                            child: Padding(
                              padding: EdgeInsets.only(
                                top: 4.0,
                                right: 10.0,
                              ),
                              child: Icon(
                                widget.wishlistData
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: Color(0xffF2C557),
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 100,
                          child: Image.network(
                            widget.data.productImage,
                            width: 100,
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
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
                        SizedBox(
                          height: 10,
                        ),
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
                height: 290,
                // height: widget.height * 0.3,
                width: 200,
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
                                fontSize: 17,
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
                        onPressed: widget.addtoCart,
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
