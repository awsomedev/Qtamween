import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:qtameen/Model/featuredDetails.dart';
import 'package:qtameen/Widgets/widgets.dart';
import 'package:qtameen/api/api.dart';
import 'package:qtameen/main.dart';
import 'package:easy_localization/easy_localization.dart';
import 'HomeScreen.dart';
import 'featured.dart';

class SearchProductScreen extends StatefulWidget {
  @override
  _SearchProductScreenState createState() => _SearchProductScreenState();
}

class _SearchProductScreenState extends State<SearchProductScreen> {
  bool data = false;
  var productsData;

  List<bool> addCart = [], addWishlist = [];
  List<int> cartItems = [];

  List<Product> products = [];
  String keyword = '';
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
            title: TextField(
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.0,
                fontWeight: FontWeight.w400,
              ),
              autofocus: true,
              onChanged: (product) async {
                setState(() {
                  keyword = product;
                });
                // FeaturedProductDetailClass data = await searchProductApi(product);

                // setState(() {
                //   products = data.products;
                // });
                // print(products.length);
              },
              decoration: InputDecoration(
                hintText: 'search.search_text'.tr(),
                hintStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              Background(),
              FutureBuilder<FeaturedProductDetailClass>(
                  future: searchProductApi(keyword),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<Widget> wids = [];
                      for (var item in snapshot.data.products) {
                        wids.add(ProductView(
                          data: item,
                          height: height,
                          widhData: item.wishlistStatus == 1,
                          wishtoggle: () async {
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
                          width: width,
                          cartPressed: () async {
                            setState(() {
                              spin = true;
                            });

                            String msg = await addToCart(item.productId, '1');
                            showMytoast('msg.added_to_cart'.tr(),
                                color: Colors.blue[900]);
                            setState(() {
                              spin = false;
                            });
                            String count = await cartCount();
                            setState(() {
                              cart_count = int.parse(count);
                            });
                            print(msg);
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
                                children: wids,
                              ),
                            ),
                          ],
                        ),
                      ));
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  })
            ],
          )),
    );
  }
}
