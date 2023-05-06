import 'dart:convert';
import 'dart:developer';

import 'package:cc_avenue/cc_avenue.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:vakalat_flutter/model/GetPackageModel.dart';

import '../../Sharedpref/shared_pref.dart';
import '../../api/postapi.dart';
import '../../color/customcolor.dart';
import '../../helper.dart';
import '../../model/clsLoginResponseModel.dart';
import '../../model/getdiscountModel.dart';
import '../../utils/ToastMessage.dart';
import '../../utils/constant.dart';
import '../../utils/design.dart';

class Payment_Screen extends StatefulWidget {
  final String name;
  final Package packages;

  const Payment_Screen({super.key, required this.name, required this.packages});

  @override
  State<Payment_Screen> createState() => _Payment_ScreenState();
}

class _Payment_ScreenState extends State<Payment_Screen> {
  TextEditingController discountcontroller = TextEditingController();
  TextEditingController cashcodecontroller = TextEditingController();
  ClsLoginResponseModel logindetails = clsLoginResponseModelFromJson(
      SharedPref.get(prefKey: PrefKey.loginDetails)!);

  late Getdiscountmodel discountdet;
  bool discount = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Payment',
          style: TextStyle(
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        backgroundColor: CustomColor().colorPrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                    ],
                  ),
                ),
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
                      Const().cartscreen('Item', 'PACAKGE', context),
                      Const().cartscreen('Name', widget.name, context),
                      Const().cartscreen('Price',
                          '₹${widget.packages.packagePrice}/Year', context),
                    ],
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  'Discount Code',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.blue,
                      fontWeight: FontWeight.w600),
                ),
              ),
              InkWell(
                onTap: () => show_dialogbox(
                    'Enter Discount code', discountcontroller, 'Apply', () {
                  discapi();
                }),
                child: Card(
                  child: Container(
                    height: 50,
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      
                      borderRadius: BorderRadius.circular(5),
                      // border: Border.all(width: 1),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Click to Applied Discount....',style: TextStyle(fontSize: 14)),
                          Icon(Icons.check_circle,color: Colors.grey,)
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
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
                    'Package ${widget.packages.packageName}',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    '₹ ${widget.packages.packagePrice}',
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey),
                  ),
                ],
              ),
              discount == true
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Discount',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          '₹ ${discountdet.amount}',
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey),
                        ),
                      ],
                    )
                  : SizedBox(),
              const Divider(
                thickness: 1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Amount Payable',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    '₹ ${widget.packages.packagePrice}',
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      // height: 65,
                      width: screenwidth(context, dividedby: 2),
                      padding: const EdgeInsets.all(10),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: CustomColor().colorPrimary,
                              textStyle: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold)),
                          onPressed: () {},
                          child: Text('Chackout with \ncash code'))),
                  Container(
                      height: 65,
                      // width: screenwidth(context, dividedby: 1),
                      padding: const EdgeInsets.all(10),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: CustomColor().colorPrimary,
                              textStyle: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          onPressed: () {},
                          child: Text('payment'))),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  show_dialogbox(title, controller, buttonname, Function() ontap) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
          title: Column(
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 40,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(width: 1)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TextField(
                controller: controller,
                // textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black,
                  letterSpacing: 1,
                ),
                decoration: const InputDecoration(
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    // disabledBorder: InputBorder.none,
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    // prefixIcon: Icon(Icons.search),
// suffixIcon: Icon(Icons.mic),
                    fillColor: Colors.purple,
                    contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                    border: InputBorder.none,
                    hintText: 'Enter'),
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Button_For_Update_Save(
            text: buttonname,
            onpressed: ontap,
          )
        ],
      )),
    );
  }

  discapi() async {
    EasyLoading.show(status: "Loading...");
    try {
      Map<String, dynamic> parameters = {
        "apiKey": apikey,
        'device': '2',
        "accessToken": logindetails.accessToken,
        "user_id": logindetails.userData.userId,
        "csrf_tocken": "",
        "code": discountcontroller.text,
        "package_id": widget.packages.packageId
      };
      await discountapi(body: parameters).then((value) {
        // Navigator.push(
        //     context,
        //     CupertinoPageRoute(
        //       builder: (context) => Cart_Screen(
        //           name:
        //           list.handlers.first.name,
        //           packages: value),
        //     ));

        discountdet = value;
        setState(() {
          discount = true;
        });
        ToastMessage().showmessage(value.message);
        Navigator.pop(context);
        EasyLoading.dismiss();
        log(jsonEncode(value));
      }).onError((error, stackTrace) {
        ToastMessage().showmessage(error.toString());

        EasyLoading.dismiss();
      });
    } catch (e) {
      print(e);
    }
  }

  apply_withcashcode() async {
    EasyLoading.show(status: "Loading...");
    try {
      Map<String, dynamic> parameters = {
        "apiKey": apikey,
        'device': '2',
        "accessToken": logindetails.accessToken,
        "user_id": logindetails.userData.userId,
        "csrf_tocken": "",
        "cash_code": cashcodecontroller.text,
        "package_id": widget.packages.packageId,
        "entered_amount": widget.packages.packagePrice,
        "amount": widget.packages.packagePrice,
        "gst": '',
        "totalAmount": "",
        "handler": widget.name,
        "discount": "",
        "d_code_id": "",
        "gst_no": "",
        "user_type": "8",
        "pm_handler_id": "",
        "organization_name": ""
      };
      await discountapi(body: parameters).then((value) {
        // Navigator.push(
        //     context,
        //     CupertinoPageRoute(
        //       builder: (context) => Cart_Screen(
        //           name:
        //           list.handlers.first.name,
        //           packages: value),
        //     ));

        discountdet = value;
        setState(() {
          discount = true;
        });
        ToastMessage().showmessage(value.message);
        EasyLoading.dismiss();
        log(jsonEncode(value));
      }).onError((error, stackTrace) {
        ToastMessage().showmessage(error.toString());

        EasyLoading.dismiss();
      });
    } catch (e) {
      print(e);
    }
  }
}
