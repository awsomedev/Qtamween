import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:qtameen/Model/wishlistModel.dart';
import 'package:qtameen/Screens/cartScreen.dart';
import 'package:qtameen/Screens/productDescription.dart';
import 'package:qtameen/Widgets/widgets.dart';
import 'package:qtameen/api/api.dart';
import 'package:qtameen/api/homeScreenapi.dart';
import 'package:easy_localization/easy_localization.dart';

import 'HomeScreen.dart';

class WhislsiScreen extends StatefulWidget {
  @override
  _WhislsiScreenState createState() => _WhislsiScreenState();
}

class _WhislsiScreenState extends State<WhislsiScreen> {
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
          title: Text('wishlist.wishlist').tr(),
          actions: [
            InkWell(
              onTap: () {
                Navigator.push(context,
                        MaterialPageRoute(builder: (context) => CartScreen()))
                    .then((value) {
                  setState(() {});
                });
              },
              child: Badge(
                position: BadgePosition(top: 10, start: 10),
                badgeContent: Text(cart_count.toString(),
                    style: TextStyle(color: Colors.white, fontSize: 10)),
                child: Icon(Icons.shopping_cart),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Icon(Icons.favorite),
            SizedBox(
              width: 10,
            ),
          ],
        ),
        body: Container(
            height: height,
            child: FutureBuilder<WishlistClass>(
              future: wishListViewApi(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  // print(snapshot.data);
                  return snapshot.data.wishlist.length == 0
                      ? Center(
                          child: Text(
                            'new.wishlistEmpty'.tr(),
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                      : ListView.builder(
                          itemCount: snapshot.data.wishlist.length,
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            var image =
                                snapshot.data.wishlist[index].productImage;
                            var name =
                                snapshot.data.wishlist[index].productName;
                            var price =
                                snapshot.data.wishlist[index].productAmount;
                            var id = snapshot.data.wishlist[index].productId;
                            var quantity = '';
                            return Padding(
                              padding: EdgeInsets.all(8),
                              child: InkWell(
                                onTap: () {
                                  navigate(
                                      context,
                                      ProductDescription(
                                        id: id,
                                        name: name,
                                      ));
                                },
                                child: Material(
                                  elevation: 3,
                                  borderRadius: BorderRadius.circular(5),
                                  child: Container(
                                    // height: height * 0.16,
                                    width: width,
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.0),
                                      color: Colors.white,
                                    ),
                                    child: Row(
                                      children: [
                                        Image(
                                          // height: height * 0.1,
                                          width: width * 0.28,
                                          image: NetworkImage(image),
                                          fit: BoxFit.fill,
                                        ),
                                        SizedBox(width: 8),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              alignment: Alignment.centerLeft,
                                              height: height * 0.05,
                                              width: width * 0.6,
                                              child: Text(
                                                name,
                                                textAlign: TextAlign.start,
                                                style: TextStyle(fontSize: 16),
                                                maxLines: 2,
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                            Text(
                                              price,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 14.0,
                                                // color: Colors.black,
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                            Row(
                                              children: [
                                                Container(
                                                  height: 35,
                                                  width: 80,
                                                  margin: EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                  ),
                                                  child: RaisedButton(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                    padding: EdgeInsets.all(0),
                                                    color: Colors.blue[500],
                                                    onPressed: () async {
                                                      setState(() {
                                                        spin = true;
                                                      });
                                                      String msg =
                                                          await addToCart(
                                                              id, '1');
                                                      String count =
                                                          await cartCount();
                                                      setState(() {
                                                        cart_count =
                                                            int.parse(count);
                                                      });
                                                      setState(() {
                                                        spin = false;
                                                      });
                                                      showMytoast(
                                                        'msg.added_to_cart'
                                                            .tr(),
                                                      );
                                                      print(msg);
                                                    },
                                                    child: Text(
                                                      'product.add_to_cart',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        fontSize: 13.0,
                                                        color: Colors.white,
                                                      ),
                                                    ).tr(),
                                                  ),
                                                ),
                                                SizedBox(width: width * 0.1),
                                                InkWell(
                                                  onTap: () async {
                                                    String msg =
                                                        await removefromWishlist(
                                                            id);
                                                    print(msg);
                                                    showMytoast(
                                                        'msg.remover-wishlist'
                                                            .tr());
                                                    setState(() {});
                                                  },
                                                  child: Icon(Icons.favorite,
                                                      size: 28.0,
                                                      color: Colors.blue[500]),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10,
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
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

class AddCartButton extends StatefulWidget {
  AddCartButton({
    this.id,
    this.product,
    this.image,
    this.quantity,
    this.price,
  });
  final String product, image, quantity, price;
  final String id;
  @override
  _AddCartButtonState createState() => _AddCartButtonState();
}

class _AddCartButtonState extends State<AddCartButton> {
  int cartItems = 0;
  bool addCart = false;
  bool spin = false;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      child: addCart
          ? Container(
              width: width * 0.3,
              height: height * 0.05,
              decoration: BoxDecoration(
                // color:primaryColor,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: CircleAvatar(
                      child: IconButton(
                        icon: Icon(
                          Icons.remove,
                          size: 20.0,
                          color: Colors.white,
                        ),
                        onPressed: () async {},
                      ),
                    ),
                  ),
                  Text(
                    '$cartItems',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(4.0),
                    child: CircleAvatar(
                      child: IconButton(
                        icon: Icon(
                          Icons.add,
                          size: 20.0,
                          color: Colors.white,
                        ),
                        onPressed: () async {
                          setState(() {
                            cartItems += 1;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            )
          : InkWell(
              onTap: () async {},
              child: Container(
                width: width * 0.3,
                height: height * 0.045,
                decoration: BoxDecoration(
                  // color: primaryColor,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      'product.add_to_cart',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: height * .016,
                      ),
                    ).tr(),
                  ),
                ),
              ),
            ),
    );
  }
}
