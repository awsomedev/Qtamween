import 'package:flutter/material.dart';
import 'package:qtameen/Model/viewAdressModel.dart';
import 'package:qtameen/Screens/detailAddress.dart';
import 'package:qtameen/Widgets/widgets.dart';
import 'package:qtameen/api/api.dart';
import 'package:easy_localization/easy_localization.dart';

class AddAddressScreen extends StatefulWidget {
  @override
  _AddAddressScreenState createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('address.my_address').tr(),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
                child: FutureBuilder<ViewAddressClass>(
              future: viewAddressApi(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Container(
                    // height: height * 0.8,
                    child: ListView.builder(
                      itemCount: snapshot.data.customerAddress.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        CustomerAddress data =
                            snapshot.data.customerAddress[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailAddress(
                                          addressid: data.customersAddressId,
                                        ))).then((value) {
                              setState(() {});
                            });
                          },
                          child: Container(
                            // height: height * 0.16,
                            margin: EdgeInsets.all(10.0),
                            padding: EdgeInsets.all(12.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.33),
                                  blurRadius: 2.0,
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(data.addressType ?? ''),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  data.address,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14.0,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  '${data.building} , ${data.street} , ${data.zone} , ${data.areaName}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14.0,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                // Container(
                                //   height: 35,
                                //   width: 80,
                                //   // padding: EdgeInsets.all(12.0),
                                //   decoration: BoxDecoration(
                                //     borderRadius: BorderRadius.circular(10.0),
                                //     // color: primaryColor,
                                //     // boxShadow: [
                                //     //   BoxShadow(
                                //     //     color: Colors.black.withOpacity(0.33),
                                //     //     blurRadius: 2.0,
                                //     //   ),
                                //     // ],
                                //   ),
                                //   // alignment: Alignment.center,
                                //   child: RaisedButton(
                                //     shape: RoundedRectangleBorder(
                                //         borderRadius:
                                //             BorderRadius.circular(10)),
                                //     padding: EdgeInsets.all(0),
                                //     color: Colors.blue[500],
                                //     onPressed: () async {
                                //       String msg = await removeAddressApi(
                                //           addId: data.customersAddressId);
                                //       print(msg + 'removeeeeeeeeee');
                                //       showMytoast(msg);
                                //     },
                                //     child: Text(
                                //       'other.remove'.tr(),
                                //       style: TextStyle(
                                //         fontWeight: FontWeight.w400,
                                //         fontSize: 12.0,
                                //         color: Colors.white,
                                //       ),
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              },
            )),
            Container(
              height: 35,
              width: 80,
              // padding: EdgeInsets.all(12.0),
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
              ),
              // alignment: Alignment.center,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                padding: EdgeInsets.all(0),
                color: Colors.blue[500],
                onPressed: () {
                  // navigate(context, DetailAddress());
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetailAddress())).then((value) {
                    setState(() {});
                  });
                },
                child: Text(
                  'new.add'.tr(),
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 15.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
