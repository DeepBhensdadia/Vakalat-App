import 'dart:convert';
import 'dart:developer';
import 'dart:ffi';
import 'package:badges/badges.dart' as badges;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:vakalat_flutter/New%20UI/handler_search/payment.dart';
import 'package:vakalat_flutter/helper.dart';
import 'package:vakalat_flutter/utils/design.dart';

import '../../Sharedpref/shared_pref.dart';
import '../../api/postapi.dart';
import '../../color/customcolor.dart';
import '../../model/GetPackageModel.dart';
import '../../model/Get_Profile.dart';
import '../../model/clsLoginResponseModel.dart';
import '../../model/getdiscountModel.dart';
import '../../utils/ToastMessage.dart';
import '../../utils/constant.dart';
import '../My Account/Profile/getxcontroller.dart';
import 'handler_search.dart';

class Cart_Screen extends StatefulWidget {
  final String name;
  final GetPackagesModel packages;

  const Cart_Screen({Key? key, required this.name, required this.packages})
      : super(key: key);

  @override
  State<Cart_Screen> createState() => _Cart_ScreenState();
}

class _Cart_ScreenState extends State<Cart_Screen> {
  int indexs = 0;
  ClsLoginResponseModel logindetails = clsLoginResponseModelFromJson(
      SharedPref.get(prefKey: PrefKey.loginDetails)!);
  GetProfileModel getprofile =
      getProfileModelFromJson(SharedPref.get(prefKey: PrefKey.getProfile)!);

  final ProfileControl getxController = Get.put(ProfileControl());

  @override
  void initState() {
    // TODO: implement initState
    if (widget.packages.packages.first.packageId.isNotEmpty) {
      _selectedpackage = widget.packages.packages.first.packageId;
    }

    super.initState();
  }

  String? _selectedpackage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Subscribe',
          style: TextStyle(
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        backgroundColor: CustomColor().colorPrimary,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Select a name for your web page',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        'www.vakalat.com/${widget.name}',
                        style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  MaterialButton(
                    color: CustomColor().colorPrimary,
                      onPressed: () async {
                        Map<String, dynamic> parameters = {
                          "apiKey": apikey,
                          'device': '2',
                          "city_id": getprofile.profile.cityId,
                          "first_name": getprofile.profile.firstName,
                          "last_name": getprofile.profile.lastName,
                          "customname": getprofile.profile.firstName +
                              getprofile.profile.lastName
                        };
EasyLoading.show(status: 'Loading...' );
                        await get_handler_list(body: parameters).then((value) {
                          print(jsonEncode(value));

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Handler_Search(
                                    value: value,
                                    name: getprofile.profile.firstName +
                                        getprofile.profile.lastName),
                              ));
                          EasyLoading.dismiss();
                        }).onError((error, stackTrace) {
                          EasyLoading.dismiss();
                        });
                      },
                      child: Text('Change',style: TextStyle(fontSize: 16,color: Colors.white),))
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
                child: InkWell(
                  onTap: () {},
                  child: SizedBox(
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'Packages',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.blue,
                              fontWeight: FontWeight.w600),
                        ),
                        Icon(
                          Icons.expand_more,
                          size: 30,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                // height: 300,
                child: ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  physics: const ClampingScrollPhysics(),
                  itemCount: widget.packages.packages.length,
                  itemBuilder: (context, index) => RadioListTile(
                    dense: true,
                    visualDensity: VisualDensity.compact,
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(widget.packages.packages[index].packageName,
                                style: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w600)),
                            const SizedBox(
                              width: 10,
                            ),
                            widget.packages.packages[index].packageName ==
                                    'Supreme'
                                ? badges.Badge(
                                    badgeContent: const Text('Popular',
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600)),
                                    badgeStyle: badges.BadgeStyle(
                                      shape: badges.BadgeShape.square,
                                      badgeColor: Colors.blue,
                                      padding: const EdgeInsets.all(5),
                                      borderRadius: BorderRadius.circular(4),
                                    ))
                                : const SizedBox(),
                          ],
                        ),
                        TextButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                        title: packageselection(
                                          widget.packages.packages[index]
                                              .packageName,
                                          widget.packages.packages[index]
                                              .packageDescription,
                                          widget.packages.packages[index]
                                              .packagePrice,
                                          Container(
                                            height: screenheight(context,
                                                dividedby: 2.5),
                                            width: double.maxFinite,
                                            child: ListView(
                                              shrinkWrap: true,
                                              primary: false,
                                              physics:
                                                  const ClampingScrollPhysics(),
                                              children: widget.packages
                                                  .packages[index].menus
                                                  .map<Widget>((e) =>
                                                      packagerow(e.menuTitle))
                                                  .toList(),
                                            ),
                                          ),
                                        ),
                                      ));
                            },
                            child: const Text('View'))
                      ],
                    ),
                    value: widget.packages.packages[index].packageId,
                    groupValue: _selectedpackage,
                    onChanged: (value) {
                      print(value);
                      setState(() {
                        indexs = index;
                        _selectedpackage = value!;
                      });
                    },
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0),
                child: Text(
                  'Order Summary',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.blue,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Package ${widget.packages.packages[indexs].packageName}',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    '₹ ${int.parse(widget.packages.packages[indexs].packagePrice)}',
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey),
                  ),
                ],
              ),
              const Divider(
                thickness: 1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total Amount',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    '₹ ${widget.packages.packages[indexs].packagePrice}',
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black54),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Button_For_Update_Save(
                  text: 'Continue',
                  onpressed: () async {
                    EasyLoading.show(status: "Loading...");
                    Map<String, dynamic> parameters = {
                      "apiKey": apikey,
                      'device': '2',
                      "accessToken": logindetails.accessToken,
                      "user_id": logindetails.userData.userId,
                      "csrf_tocken": "",
                      "handler_name": widget.name,
                      "package_id": _selectedpackage
                    };
                    await addtocart(body: parameters).then((value) async {
                      if (value.status == 1) {
                        getxController.viewcartfor1(context);
                      }

                      ToastMessage().showmessage(value.message);
                      EasyLoading.dismiss();
                      log(jsonEncode(value));
                    }).onError((error, stackTrace) {
                      ToastMessage().showmessage(error.toString());

                      EasyLoading.dismiss();
                    });
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => Payment_Screen(
                    //         name: widget.packages.packages[indexs].packageName,
                    //         amount: int.parse(
                    //             widget.packages.packages[indexs].packagePrice),
                    //         gst: int.parse(widget.packages
                    //             .packages[indexs].packagePrice) *
                    //             0.18,
                    //         totalamount: int.parse(widget.packages
                    //             .packages[indexs].packagePrice) +
                    //             int.parse(widget.packages
                    //                 .packages[indexs].packagePrice) *
                    //                 0.18,
                    //       ),
                    //     ));
                  })
            ],
          ),
        ),
      ),
    );
  }

  packageselection(
    String package,
    String kyc,
    String rupees,
    Widget child,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xffF4F9FF)),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        package,
                        style: const TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        kyc,
                        style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  Text(
                    '₹$rupees/Year',
                    style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                child: child,
              ),
            ),
          ],
        ),
      ),
    );
  }

  packagerow(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        children: [
          Container(
            height: 15,
            width: 15,
            decoration: BoxDecoration(
              border: Border.all(width: 1.5),
              shape: BoxShape.circle,
            ),
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Container(
                decoration: const BoxDecoration(
                  // border: Border.all(width: 2),
                  color: Colors.black,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            text,
            style: const TextStyle(
                fontSize: 15,
                color: Colors.black54,
                fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }
}
