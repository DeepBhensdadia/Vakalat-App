import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:vakalat_flutter/color/customcolor.dart';
import 'package:vakalat_flutter/pages/dashboard.dart';

import '../../Sharedpref/shared_pref.dart';
import '../../api/postapi.dart';
import '../../model/GetDashboard.dart';
import '../../model/clsLoginResponseModel.dart';
import '../../utils/constant.dart';
import '../../utils/design.dart';
import '../Dashboard_screens/Dashboard_Screen.dart';

class PaymentDone extends StatefulWidget {
  const PaymentDone({Key? key}) : super(key: key);
  @override
  State<PaymentDone> createState() => _PaymentDoneState();
}

class _PaymentDoneState extends State<PaymentDone> {
  ClsLoginResponseModel logindetails = clsLoginResponseModelFromJson(
      SharedPref.get(prefKey: PrefKey.loginDetails)!);
  @override
  void initState() {
    navigateToOtherScreen();
    // TODO: implement initState
    super.initState();
  }
  bool show =  false;
  late Getdashboard datas;
  void navigateToOtherScreen() {
    Future.delayed(Duration(seconds: 5), () async {
      Map<String, dynamic> parameters = {
        "apiKey": apikey,
        'device': '2',
        "accessToken": logindetails.accessToken,
        "user_id": logindetails.userData.userId,
        "csrf_token": ""
      };
      EasyLoading.show(status: 'Loading...');
      await get_Deshboard(body: parameters).then((value) {
        setState(() {
          show = true;
        });
        EasyLoading.dismiss();
datas = value;
        log(value.toString());
        Navigator.pushReplacement(
            context,
            CupertinoPageRoute(
              builder: (context) => DashBoard_Screen(data: value),
            ));
      }).onError((error, stackTrace) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) =>
              const DashboardPage(title: ''),
            ));
        msgexpire;
        Const().deleteprofilelofinandmenu();
        print(error);
        // ToastMessage().showmessage(error.toString());
        EasyLoading.dismiss();
      });

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Icon(FontAwesomeIcons.checkCircle,size: 100,color: CustomColor().colorPrimary,),
            SizedBox(height: 20,),
            Text('Success!!',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: CustomColor().colorPrimary),),
            SizedBox(height: 20,),
           show == true? Button_For_Update_Save(
              text: 'Dashboard',
              onpressed: () {
                Get.offAll(DashBoard_Screen(data: datas,));
              },
            ):SizedBox()
          ],
        ),
      ),
    );
  }
}
