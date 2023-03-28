import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vakalat_flutter/New%20UI/handler_search/payment.dart';
import 'package:vakalat_flutter/helper.dart';
import 'package:vakalat_flutter/utils/design.dart';

import '../../Sharedpref/shared_pref.dart';
import '../../api/postapi.dart';
import '../../color/customcolor.dart';
import '../../model/GetPackageModel.dart';
import '../../model/clsLoginResponseModel.dart';
import '../../utils/constant.dart';

class Cart_Screen extends StatefulWidget {
  const Cart_Screen({Key? key}) : super(key: key);

  @override
  State<Cart_Screen> createState() => _Cart_ScreenState();
}

class _Cart_ScreenState extends State<Cart_Screen> {
  int indexs =0;
  ClsLoginResponseModel logindetails = clsLoginResponseModelFromJson(
      SharedPref.get(prefKey: PrefKey.loginDetails)!);
  late GetPackagesModel packages;
  bool show = false;
  @override
  void initState() {
    // TODO: implement initState
    getpackages();
    super.initState();
  }

  Future<void> getpackages() async {
    EasyLoading.show(status: "Loading...");
    Map<String, dynamic> parameters = {
      "apiKey": apikey,
      'device': '2',
      "user_type_id": logindetails.userData.userType,
    };
    await GetUserpackages(body: parameters).then((value) {
      packages = value;
      setState(() {
        show = true;
      });
      EasyLoading.dismiss();
      log(jsonEncode(value));
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
    });
  }
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Handler Search',
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
          child: show == true
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      'Your web page can be',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text(
                      'www.vakalat.com/DeepkumarBhensdadia',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      // height: 170,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color(0xffF4F9FF)),
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Const().cartscreen('Item', 'Handler', context),
                            Const().cartscreen('Name', 'MeghalShukla', context),
                            Const().cartscreen(
                                'Price', 'Yearly Web Handler Charges', context),
                            Row(
                              children: [
                                SizedBox(
                                    width: screenwidth(context, dividedby: 7),
                                    child: const Text(
                                      'Action',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14),
                                    )),
                                Row(
                                  children: [
                                    MaterialButton(
                                      color: const Color(0xff448BE8),
                                      height: 25,
                                      minWidth: 25,
                                      padding: EdgeInsets.zero,
                                      onPressed: () {},
                                      child: const Icon(
                                        FontAwesomeIcons.edit,
                                        size: 12,
                                        color: Colors.white,
                                      ),
                                    ),
                                    MaterialButton(
                                      color: const Color(0xffAF3F3F),
                                      height: 25,
                                      minWidth: 25,
                                      padding: EdgeInsets.zero,
                                      onPressed: () {},
                                      child: const Icon(
                                        Icons.delete,
                                        size: 12,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      // height: 170,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color(0xffF4F9FF)),
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Const().cartscreen('Item', 'Package', context),
                            Const().cartscreen('Name', packages.packages[indexs].packageName, context),
                            Const().cartscreen('Price', '₹ ${packages.packages[indexs].packagePrice}', context),
                            Row(
                              children: [
                                SizedBox(
                                    width: screenwidth(context, dividedby: 7),
                                    child: const Text(
                                      'Action',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14),
                                    )),
                                Row(
                                  children: [
                                    // MaterialButton(
                                    //   color: Color(0xff448BE8),
                                    //   height: 25,
                                    //   minWidth: 25,
                                    //   padding: EdgeInsets.zero,
                                    //   onPressed: () {},
                                    //   child: Icon(
                                    //     FontAwesomeIcons.edit,
                                    //     size: 12,
                                    //     color: Colors.white,
                                    //   ),
                                    // ),
                                    MaterialButton(
                                      color: const Color(0xffAF3F3F),
                                      height: 25,
                                      minWidth: 25,
                                      padding: EdgeInsets.zero,
                                      onPressed: () {},
                                      child: const Icon(
                                        Icons.delete,
                                        size: 12,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    // SizedBox(height: 15,),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 20),
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
                    Column(
                        children: packages.packages
                            .asMap()
                            .entries
                            .map((packageItem) {
                      return Container(
                        child: packageselection(() {
                          setState(() {
                            indexs = packageItem.key;
                          });
                          print(packageItem.key);
                        },
                            packageItem.value.packageName,
                            packageItem.value.packageDescription,
                            packageItem.value.packagePrice,
                            ListView(
                              shrinkWrap: true,
                              primary: false,
                              physics: const ClampingScrollPhysics(),
                              children: packageItem.value.menus
                                  .map<Widget>((e) => packagerow(e.menuTitle))
                                  .toList(),
                            ),
                            indexs == packageItem.key?Colors.green: CustomColor().colorPrimary,
                            'Selected'),
                      );
                    }).toList()),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 15.0),
                      child: Text(
                        'Discount Code',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.blue,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(width: 1)),
                              child: const Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: 8.0),
                                child: TextField(
                                  // textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    letterSpacing: 1,
                                  ),
                                  decoration: InputDecoration(
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      // disabledBorder: InputBorder.none,
                                      hintStyle: TextStyle(
                                        color: Colors.grey,
                                      ),
                                      // prefixIcon: Icon(Icons.search),
// suffixIcon: Icon(Icons.mic),
                                      fillColor: Colors.purple,
                                      contentPadding:
                                          EdgeInsets.fromLTRB(0, 0, 0, 10),
                                      border: InputBorder.none,
                                      hintText: 'Search'),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          MaterialButton(
                            color: CustomColor().colorPrimary,
                            height: 40,
                            minWidth: 100,
                            padding: EdgeInsets.zero,
                            shape: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5)),
                            onPressed: () {},
                            child: const Text(
                              'Apply',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Colors.white),
                            ),
                          )
                        ],
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
                          'Package ${packages.packages[indexs].packageName}',
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          '₹ ${int.parse( packages.packages[indexs].packagePrice)}.0',
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        const Text(
                          'GST',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        Text(
                        '₹ ${int.parse( packages.packages[indexs].packagePrice)*18/100}' ,
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
                          'Amount Payable',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        Text(
                           '₹ ${ int.parse( packages.packages[indexs].packagePrice) + int.parse( packages.packages[indexs].packagePrice)*0.18}',
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
                        text: 'PAYMENT',
                        onpressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Payment_Screen(
                                  name:packages.packages[indexs].packageName,
                                  amount:int.parse( packages.packages[indexs].packagePrice) ,
                                  gst: int.parse( packages.packages[indexs].packagePrice)*0.18,
                                  totalamount:int.parse( packages.packages[indexs].packagePrice) + int.parse( packages.packages[indexs].packagePrice)*0.18,
                                ),
                              ));
                        })
                  ],
                )
              : Container(),
        ),
      ),
    );
  }

  packageselection(Function() ontap, String package, String kyc, String rupees,
      Widget child, Color buttoncolor, String buttonname) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: const Color(0xffF4F9FF)),
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
            GestureDetector(
              onTap: ontap,
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                    color: buttoncolor),
                child: Center(
                  child: Text(
                    buttonname,
                    style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            )
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
