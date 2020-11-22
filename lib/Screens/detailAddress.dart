import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:place_picker/place_picker.dart';
import 'package:place_picker/widgets/place_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:qtameen/Model/AddressDetailModel.dart';
import 'package:qtameen/Screens/newPlacePicker.dart';
import 'package:qtameen/api/api.dart';

class DetailAddress extends StatefulWidget {
  String addressid;
  DetailAddress({this.addressid = '0'});
  @override
  _DetailAddressState createState() => _DetailAddressState();
}

class _DetailAddressState extends State<DetailAddress> {
  // String areaName = 'Select Area';
  String selectedAddress = '';
  LatLng selectedLocation;
  int grpval = 1;
  LocationResult result;

  String getAreaname(List<AreaDatum> areas, String id) {
    String name = '';
    for (var item in areas) {
      if (item.areaId == id) {
        name = item.areaName;
      }
    }
    return name;
  }

  TextEditingController address = TextEditingController();
  TextEditingController house = TextEditingController();
  TextEditingController street = TextEditingController();
  TextEditingController zone = TextEditingController();

  AreaDatum selectedArea;
  bool spin = false;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return ModalProgressHUD(
      inAsyncCall: spin,
      color: Colors.black54,
      child: Scaffold(
          appBar: AppBar(
            title: Text('address.address').tr(),
          ),
          body: FutureBuilder<AddressDetailClass>(
            future: getAddressDetailsApi(addId: widget.addressid),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                AddressDetailClass data = snapshot.data;
                List<DropdownMenuItem<AreaDatum>> drops = [];
                for (var item = 1; item < data.areaData.length; item++) {
                  drops.add(DropdownMenuItem<AreaDatum>(
                    child: Text(
                      data.areaData[item].areaName,
                      style: TextStyle(color: Colors.black),
                    ),
                    value: data.areaData[item],
                  ));
                }
                print(data.editAddress.addressTypeId);

                if (widget.addressid != '0') {
                  if (address.text == '') {
                    address.text = data.editAddress.address;
                    selectedAddress = data.editAddress.location;
                    zone.text = data.editAddress.zone;
                    house.text = data.editAddress.building;
                    street.text = data.editAddress.street;
                    selectedLocation = LatLng(
                        double.parse(data.editAddress.latitude),
                        double.parse(data.editAddress.longitude));
                    grpval = int.parse(data.editAddress.addressTypeId);
                    selectedArea = AreaDatum(
                        areaId: data.editAddress.areaId,
                        areaName: getAreaname(
                            data.areaData, data.editAddress.areaId));
                  }
                }
                return SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Radio(
                                    value: 1,
                                    groupValue: grpval,
                                    onChanged: (val) {
                                      setState(() {
                                        grpval = val;
                                      });
                                    }),
                                Text('address.home').tr(),
                              ],
                            ),
                            Row(
                              children: [
                                Radio(
                                    value: 2,
                                    groupValue: grpval,
                                    onChanged: (val) {
                                      setState(() {
                                        grpval = val;
                                      });
                                    }),
                                Text('address.office').tr(),
                              ],
                            ),
                            Row(
                              children: [
                                Radio(
                                    value: 0,
                                    groupValue: grpval,
                                    onChanged: (val) {
                                      setState(() {
                                        grpval = val;
                                      });
                                    }),
                                Text('address.other').tr(),
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: 20),
                        Container(
                          width: double.maxFinite,
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: Colors.black.withOpacity(.4), width: 1),
                          ),
                          child: DropdownButton<AreaDatum>(
                              hint: Text(
                                selectedArea != null
                                    ? selectedArea.areaName
                                    : 'Select area',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14.0,
                                ),
                              ),
                              isExpanded: true,
                              icon: Icon(
                                Icons.arrow_drop_down,
                                color: Colors.black,
                              ),
                              style: TextStyle(
                                color: Colors.white,
                              ),
                              underline: Container(
                                height: 2,
                                color: Colors.transparent,
                              ),
                              onChanged: (d) {
                                setState(() {
                                  selectedArea = d;
                                });
                              },
                              items: drops),
                        ),
                        SizedBox(height: 20),
                        Container(
                          height: 40,
                          width: double.infinity,
                          // padding: EdgeInsets.all(12.0),
                          margin: EdgeInsets.only(top: 8.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: Colors.blue[500],
                            // boxShadow: [
                            //   BoxShadow(
                            //     color: Colors.black.withOpacity(0.33),
                            //     blurRadius: 2.0,
                            //   ),
                            // ],
                          ),
                          // alignment: Alignment.center,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)),
                            onPressed: () async {
                              if (widget.addressid == '0') {
                                Position position =
                                    await Geolocator.getCurrentPosition(
                                        desiredAccuracy: LocationAccuracy.high);

                                result = await Navigator.of(context)
                                    .push(MaterialPageRoute(
                                        builder: (context) => PlacePickerNew(
                                              "AIzaSyA4599wnts0dny1-zzy3e6oEegfTxd_I_Q",
                                              displayLocation: LatLng(
                                                  position.latitude,
                                                  position.longitude),
                                            )));
                              } else {
                                // Position position =
                                //   await Geolocator.getCurrentPosition(
                                //       desiredAccuracy: LocationAccuracy.high);

                                result = await Navigator.of(context)
                                    .push(MaterialPageRoute(
                                        builder: (context) => PlacePickerNew(
                                              "AIzaSyA4599wnts0dny1-zzy3e6oEegfTxd_I_Q",
                                              displayLocation: LatLng(
                                                  double.parse(data
                                                      .editAddress.latitude),
                                                  double.parse(data
                                                      .editAddress.longitude)),
                                            )));
                              }

                              // Handle the result in your way
                              if (result != null) {
                                setState(() {
                                  selectedAddress = result.formattedAddress;
                                });
                                print(result);
                              }
                            },
                            color: Colors.blue[500],
                            padding: EdgeInsets.all(0),
                            child: Text(
                              'address.select_location',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 15.0,
                                color: Colors.white,
                              ),
                            ).tr(),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          selectedAddress ?? '',
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 10),
                        addressField('address.address'.tr(), address),
                        SizedBox(height: 15),
                        addressField('address.house'.tr(), house),
                        SizedBox(height: 15),
                        addressField('address.street'.tr(), street),
                        SizedBox(height: 15),
                        addressField('address.zone'.tr(), zone),
                        SizedBox(height: 25),
                        Container(
                          height: 50,
                          width: 120,
                          // padding: EdgeInsets.all(12.0),
                          margin: EdgeInsets.only(top: 8.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: Colors.blue[500],
                            // boxShadow: [
                            //   BoxShadow(
                            //     color: Colors.black.withOpacity(0.33),
                            //     blurRadius: 2.0,
                            //   ),
                            // ],
                          ),
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            color: Colors.blue[500],
                            onPressed: () async {
                              if (selectedArea != null) {
                                if (selectedAddress == '') {
                                  showMytoast('new.location'.tr(),
                                      color: Colors.red);
                                  // setState(() {
                                  //   selectedAddress = 'Select Area';
                                  // });
                                } else {
                                  setState(() {
                                    spin = true;
                                  });
                                  String msg = await addAddressApi(
                                      addId: widget.addressid,
                                      areaid: selectedArea.areaId,
                                      addresstype: grpval,
                                      zone: zone.text,
                                      building: house.text,
                                      street: street.text,
                                      address: address.text,
                                      location: selectedAddress,
                                      position: result == null
                                          ? selectedLocation
                                          : result.latLng);
                                  setState(() {
                                    spin = false;
                                  });
                                  print(msg);
                                  showMytoast(msg);
                                  Future.delayed(Duration(milliseconds: 1500))
                                      .then((value) {
                                    Navigator.pop(context);
                                  });
                                }
                              } else {
                                showMytoast('new.region'.tr(),
                                    color: Colors.red);
                              }
                            },
                            child: Text(
                              'other.save',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 15.0,
                                color: Colors.white,
                              ),
                            ).tr(),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          )),
    );
  }
}

addressField(text, TextEditingController controller) {
  return Container(
    // margin: EdgeInsets.only(bottom: 20),
    child: TextFormField(
      // cursorColor: Colors.white,
      controller: controller,
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        hintText: text,
        labelText: text,
        alignLabelWithHint: true,
        // labelStyle: TextStyle(color: Colors.blue[500]),
        // hintStyle: TextStyle(
        //   color: Colors.black.withOpacity(.5),
        //   fontSize: 14,
        //   fontWeight: FontWeight.w300,
        // ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: Colors.black.withOpacity(0.33),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            width: 2,
            color: Colors.blue[500],
          ),
        ),
      ),
    ),
  );
}

typeOfAddress(text, selected, onTap) {
  return Row(
    children: [
      InkWell(
        onTap: onTap,
        child: Container(
          height: 20,
          width: 30,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.blue[500],
              width: 2.0,
            ),
          ),
          child: Container(
            height: 10,
            width: 15,
            margin: EdgeInsets.all(3.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: selected ? Colors.blue[500] : Colors.white,
            ),
          ),
        ),
      ),
      Text(text),
    ],
  );
}
