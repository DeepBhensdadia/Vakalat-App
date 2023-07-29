import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:vakalat_flutter/New%20UI/handler_search/paymentdonepage.dart';
import 'package:vakalat_flutter/pages/homepage.dart';
import '../../Sharedpref/shared_pref.dart';
import '../../api/postapi.dart';
import '../../color/customcolor.dart';
import '../../model/UpdateContactDetails.dart';
import '../../model/clsLoginResponseModel.dart';
import '../../model/getdiscountModel.dart';
import '../../pages/dashboard.dart';
import '../../utils/ToastMessage.dart';
import '../../utils/constant.dart';
import '../../utils/design.dart';
import '../My Account/Profile/getxcontroller.dart';

class Payment_Screen extends StatefulWidget {
  const Payment_Screen({
    super.key,
  });

  @override
  State<Payment_Screen> createState() => _Payment_ScreenState();
}

class _Payment_ScreenState extends State<Payment_Screen> {
  TextEditingController discountcontroller = TextEditingController();
  TextEditingController cashcodecontroller = TextEditingController();
  ClsLoginResponseModel logindetails = clsLoginResponseModelFromJson(
      SharedPref.get(prefKey: PrefKey.loginDetails)!);
  final ProfileControl getxController = Get.put(ProfileControl());

  late Getdiscountmodel discountdet;
  // late ClsUpdateContactResponseModel cashcode;
  // late Getpaymentonline orderidpayment;
  // bool discount = false;
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
              // const SizedBox(
              //   height: 20,
              // ),
              // Container(
              //   // height: 170,
              //   decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(10),
              //       color: const Color(0xffF4F9FF)),
              //   width: double.infinity,
              //   child: Padding(
              //     padding: const EdgeInsets.symmetric(
              //         horizontal: 15.0, vertical: 10),
              //     child: Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       mainAxisAlignment: MainAxisAlignment.spaceAround,
              //       children: [
              //         Const().cartscreen('Item', 'Handler', context),
              //         Const().cartscreen('Name', 'MeghalShukla', context),
              //         Const().cartscreen(
              //             'Price', 'Yearly Web Handler Charges', context),
              //       ],
              //     ),
              //   ),
              // ),
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
                      Const().cartscreen(
                          'Name',
                          getxController.cartdetails.appcart.first.packageName,
                          context),
                      Const().cartscreen(
                          'Price',
                          '₹${getxController.cartdetails.appcart.first.packagePrice}/Year',
                          context),
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
                  getxController.viewcart(discountcontroller.text,
                      cashcodecontroller.text, context);
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
                          getxController.cartdetails.total.first.dapplied == 0
                              ? const Text('Click to Applied Discount....',
                                  style: TextStyle(fontSize: 14))
                              : Text(
                                  getxController
                                      .cartdetails.total.first.discountMessage,
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.green)),
                          getxController.cartdetails.total.first.dapplied == 0
                              ? const Icon(Icons.check_circle,
                                  color: Colors.grey)
                              : IconButton(
                                  onPressed: () {
                                    getxController.deletediscount(
                                        '', cashcodecontroller.text, context);
                                  },
                                  icon: const Icon(Icons.clear_rounded,
                                      color: Colors.grey))
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  'Do You Have a Cash Code',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.blue,
                      fontWeight: FontWeight.w600),
                ),
              ),
              InkWell(
                onTap: () => show_dialogbox(
                  "Enter Your Cash Code:",
                  cashcodecontroller,
                  "Continue With cashcode",
                  () {
                    getxController.viewcart(
                        getxController.cartdetails.total.first.dcode.toString(),
                        cashcodecontroller.text,
                        context);
                  },
                ),
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
                          getxController
                                      .cartdetails.total.first.cashcodestatus ==
                                  0
                              ? const Text('Click to Applied Cash Code....',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.black54))
                              : Text(
                                  getxController
                                      .cartdetails.total.first.cashcodemessage,
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.green)),

                          Icon(Icons.check_circle, color: Colors.grey)
                          // : IconButton(
                          //     onPressed: () {
                          //       setState(() {
                          //         discount = false;
                          //       });
                          //     },
                          //     icon: Icon(Icons.clear_rounded,
                          //         color: Colors.grey))
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
                    'Package ${getxController.cartdetails.appcart.first.packageName}',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    '₹ ${getxController.cartdetails.appcart.first.packagePrice}',
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey),
                  ),
                ],
              ),
              getxController.cartdetails.total.first.dapplied == 1
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Discount',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          '₹ ${getxController.cartdetails.total.first.discount}',
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey),
                        ),
                      ],
                    )
                  : const SizedBox(),
              getxController.cartdetails.total.first.gstapplied == 1
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Gst',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          '₹ ${getxController.cartdetails.total.first.gst}',
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey),
                        ),
                      ],
                    )
                  : const SizedBox(),
              getxController.cartdetails.total.first.cashcodestatus == 1
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Cash Code',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          '₹ ${getxController.cartdetails.total.first.cashcodeamt}',
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey),
                        ),
                      ],
                    )
                  : const SizedBox(),
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
                    '₹ ${getxController.cartdetails.total.first.total}',
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
                text:getxController.cartdetails.total.first.cashcodeamt.isNotEmpty?"Confirm With Cashcode": 'Payment',
                onpressed: () {
                  paymentwithccavenue();
                },
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
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(
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
          const SizedBox(
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

  // discapi() async {
  //   EasyLoading.show(status: "Loading...");
  //   try {
  //     Map<String, dynamic> parameters = {
  //       "apiKey": apikey,
  //       'device': '2',
  //       "accessToken": logindetails.accessToken,
  //       "user_id": logindetails.userData.userId,
  //       "csrf_tocken": "",
  //       "code": discountcontroller.text,
  //       "package_id": getxController.cartdetails.appcart.first.packageId
  //     };
  //     await discountapi(body: parameters).then((value) {
  //       // Navigator.push(
  //       //     context,
  //       //     CupertinoPageRoute(
  //       //       builder: (context) => Cart_Screen(
  //       //           name:
  //       //           list.handlers.first.name,
  //       //           packages: value),
  //       //     ));
  //       if (value.status != 0) {
  //         discountdet = value;
  //       }
  //
  //       ToastMessage().showmessage(value.message);
  //       Navigator.pop(context);
  //       EasyLoading.dismiss();
  //       log(jsonEncode(value));
  //     }).onError((error, stackTrace) {
  //       ToastMessage().showmessage(error.toString());
  //
  //       EasyLoading.dismiss();
  //     });
  //   } catch (e) {
  //     print(e);
  //   }
  // }

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
        "package_id": getxController.cartdetails.appcart.first.packageId
      };
      await paymentwithcashcode(body: parameters).then((value) {
        Navigator.pop(context);
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

  Future<void> paymentwithccavenue() async {
    EasyLoading.show(status: "Please wait...");
    try {
      Map<String, dynamic> parameters = {
        'apiKey': apikey,
        'device': '2',
        'accessToken': logindetails.accessToken,
        "user_id": logindetails.userData.userId,
        "csrf_token": "",
        "code": getxController.cartdetails.total.first.dcode,
        "cash_code": getxController.cartdetails.total.first.cashcode,
      };
      await paymentonlineccavenue(body: parameters).then((value) async {
        if (value.paymentUrl != "") {
          EasyLoading.dismiss();

          Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) =>
                    MyWebView(url: value.paymentUrl.toString()),
              ));
        } else {
          log('Success payment');
          paymentsucess();
        }
      }).onError((error, stackTrace) {
        ToastMessage().showmessage(error.toString());
        EasyLoading.dismiss();
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> paymentsucess() async {
    SharedPref.deleteSpecific(prefKey: PrefKey.getProfile);
    SharedPref.deleteSpecific(prefKey: PrefKey.getMenu);
    Map<String, dynamic> parameters = {
      "apiKey": apikey,
      'device': '2',
      "user_id": logindetails.userData.userId
    };

    await get_profile(body: parameters).then((value) async {
      await SharedPref.save(
          value: jsonEncode(value.toJson()), prefKey: PrefKey.getProfile);
      Map<String, dynamic> parameters = {
        "apiKey": apikey,
        'device': '2',
        'accessToken': logindetails.accessToken,
        'csrf_token': '',
        'user_id': logindetails.userData.userId,
        'user_type': logindetails.userData.userType,
        'current_pkg_id': value.profile.currentPkgId,
      };

      await getdrawermenu(body: parameters).then((value) async {
        log(jsonEncode(value));
        await SharedPref.save(
            value: jsonEncode(value.toJson()), prefKey: PrefKey.getMenu);
        EasyLoading.showToast('Congratulation! Payment Success. ');

        Get.offAll(const PaymentDone());
        EasyLoading.dismiss();
      }).onError((error, stackTrace) {
        // ToastMessage().showmessage(error.toString());
        print(error);
        print(stackTrace);
        EasyLoading.dismiss();
      });
    }).onError((error, stackTrace) {
      ToastMessage().showmessage(error.toString());
      print(error);
      EasyLoading.dismiss();
    });
  }
}

class MyWebView extends StatelessWidget {
  final String url;

  const MyWebView({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ClsLoginResponseModel logindetails = clsLoginResponseModelFromJson(
        SharedPref.get(prefKey: PrefKey.loginDetails)!);
    Future<void> paymentsucess() async {
      SharedPref.deleteSpecific(prefKey: PrefKey.getProfile);
      SharedPref.deleteSpecific(prefKey: PrefKey.getMenu);
      Map<String, dynamic> parameters = {
        "apiKey": apikey,
        'device': '2',
        "user_id": logindetails.userData.userId
      };

      await get_profile(body: parameters).then((value) async {
        await SharedPref.save(
            value: jsonEncode(value.toJson()), prefKey: PrefKey.getProfile);
        Map<String, dynamic> parameters = {
          "apiKey": apikey,
          'device': '2',
          'accessToken': logindetails.accessToken,
          'csrf_token': '',
          'user_id': logindetails.userData.userId,
          'user_type': logindetails.userData.userType,
          'current_pkg_id': value.profile.currentPkgId,
        };

        await getdrawermenu(body: parameters).then((value) async {
          log(jsonEncode(value));
          await SharedPref.save(
              value: jsonEncode(value.toJson()), prefKey: PrefKey.getMenu);
          EasyLoading.showToast('Congratulation! Payment Success. ');

          Get.offAll(const DashboardPage(
            title: '',
          ));
          EasyLoading.dismiss();
        }).onError((error, stackTrace) {
          // ToastMessage().showmessage(error.toString());
          print(error);
          print(stackTrace);
          EasyLoading.dismiss();
        });
      }).onError((error, stackTrace) {
        ToastMessage().showmessage(error.toString());
        print(error);
        EasyLoading.dismiss();
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Vakalat Payment',
          style: TextStyle(
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        backgroundColor: CustomColor().colorPrimary,
      ),
      body: InAppWebView(
          initialUrlRequest: URLRequest(url: Uri.parse(url)),
          //
          initialOptions: InAppWebViewGroupOptions(
            crossPlatform: InAppWebViewOptions(
              useOnDownloadStart: true,
            ),
          ),
          onWebViewCreated: (InAppWebViewController controller) {
            // Do something when WebView is created
          },
          onLoadStop: (controller, url) async {
            if (url.toString().toLowerCase().contains('ccfailure')) {
              EasyLoading.showToast('Payment fail. Please try again.');
              Navigator.pop(context);
              // ToastMessage().showmessage('Payment fail. Please try again.');
              log('failure');
            }
            // Payment succeeded
            // Do something here to handle the success response
            else if (url.toString().toLowerCase().contains('ccthankyou')) {
              EasyLoading.showToast('Congratulation! Payment Success. ');
              log('ccthankyou');
              paymentsucess();
            }
          }),
    );
  }
}
