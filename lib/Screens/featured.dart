import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:qtameen/Model/OfferProductModel.dart';
import 'package:qtameen/Model/featuredDetails.dart';
import 'package:qtameen/Screens/productDescription.dart';
import 'package:qtameen/Widgets/widgets.dart';
import 'package:qtameen/api/api.dart';
import 'package:easy_localization/easy_localization.dart';

import 'HomeScreen.dart';

class OfferProductScreen extends StatefulWidget {
  OfferProductScreen({@required this.title});
  final String title;
  @override
  _OfferProductScreenState createState() => _OfferProductScreenState();
}

class _OfferProductScreenState extends State<OfferProductScreen> {
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
          title: Text(widget.title),
        ),
        body: Container(
          child: FutureBuilder<FeaturedProductDetailClass>(
            future: widget.title == 'home.featured'.tr()
                ? featureDetailProductApi()
                : offerDetailProductApi(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Widget> list = [];
                for (var item in snapshot.data.products) {
                  list.add(ProductView(
                    height: height,
                    width: width,
                    data: item,
                    widhData: item.wishlistStatus == 1,
                    wishtoggle: () async {
                      if (item.wishlistStatus == 1) {
                        //remove from wish
                        String msg = await removefromWishlist(item.productId);
                        print(msg);
                        setState(() {
                          item.wishlistStatus = 0;
                        });
                        showMytoast('msg.remover-wishlist'.tr());
                      } else {
                        //addd to wish
                        String msg = await addtoWishlist(item.productId);
                        print(msg);
                        showMytoast('msg.added-wishlist'.tr());
                        setState(() {
                          item.wishlistStatus = 1;
                        });
                      }
                    },
                    cartPressed: () async {
                      setState(() {
                        spin = true;
                      });
                      String msg = await addToCart(item.productId, '1');
                      setState(() {
                        spin = false;
                      });
                      // showMytoast('msg.added_to_cart'.tr(),
                      //     color: Colors.blue[700]);
                      // print(msg);
                      showMytoast(msg, color: Colors.blue[700]);
                      String count = await cartCount();
                      setState(() {
                        cart_count = int.parse(count);
                      });
                    },
                  ));
                }
                return Container(
                  // margin: EdgeInsets.symmetric(horizontal: 8),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            children: list,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
                // print(snapshot.data);
                // return GridView.builder(
                //   itemCount: snapshot.data.offerProducts.length,
                //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                //     crossAxisCount: 2,
                //     childAspectRatio: 0.7,
                //   ),
                //   shrinkWrap: true,
                //   itemBuilder: (context, index) {
                //     return NewBestSeller(
                //       height: height,
                //       width: width,
                //       id: snapshot.data.offerProducts[index],
                //     );
                //   },
                // );
              } else {
                return Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            },
          ),
        ),
      ),
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
                height:
                    EasyLocalization.of(context).locale == Locale('ar', 'DZ')
                        ? 280
                        : 260,
                // height: widget.height * 0.3,
                width: widget.width * .5 - 15,
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
                          height: 100,
                          child: Image.network(
                            widget.data.productImage,
                            width: widget.width * .25,
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
                height:
                    EasyLocalization.of(context).locale == Locale('ar', 'DZ')
                        ? 280
                        : 260,
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
