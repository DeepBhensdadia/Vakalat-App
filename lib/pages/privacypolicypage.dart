
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_html/flutter_html.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:vakalat_flutter/api/postapi.dart';
import 'package:vakalat_flutter/color/customcolor.dart';
import 'package:vakalat_flutter/model/clsPrivacyPolicyResponseModel.dart';
import 'package:vakalat_flutter/utils/keyboardHiderMixin.dart';

class PrivacyPolicyPage extends StatefulWidget {
  const PrivacyPolicyPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<PrivacyPolicyPage> createState() => _PrivacyPolicyPageState();
}

class _PrivacyPolicyPageState extends State<PrivacyPolicyPage> with KeyboardHiderMixin {

  clsPrivacyPolicyResponseModel? objPrivacyPolicyResponseModel;
  @override
  void initState() {
    // TODO: implement initState
    APICALL_get_privacy_policy(true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            widget.title,
            style: const TextStyle(
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          centerTitle: true,
          backgroundColor: CustomColor().colorPrimary,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: (objPrivacyPolicyResponseModel == null)
            ? Container()
            : buildBody(context));
  }

  Widget buildBody(BuildContext context) {

    return Container(
        height: double.infinity ,
        margin: const EdgeInsets.all(10.0),
        child: Card(
          color: CustomColor().colorLightBlue,
          clipBehavior: Clip.hardEdge,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
          elevation: 4,
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Html(
              data: objPrivacyPolicyResponseModel!.privacy_policy!,
            ),
          ),
        ));
  }

  Future APICALL_get_privacy_policy(bool showLoader) async {
    clsPrivacyPolicyResponseModel objResponse = clsPrivacyPolicyResponseModel();
    try {
      Map<String, dynamic> parameters = {};

      if (showLoader == true) EasyLoading.show(status: "Loading...");

      objResponse = await get_privacy_policy(body: parameters);
      if (objResponse.status == 1) {
        setState(() {
          objPrivacyPolicyResponseModel = objResponse;
        });

        if (showLoader == true) EasyLoading.dismiss(animation: true);
      } else {
        if (showLoader == true) EasyLoading.dismiss(animation: true);

        EasyLoading.showToast(objResponse.message!);
      }
    } catch (exception) {
      if (kDebugMode) {
        print(exception.toString());
      }
      //EasyLoading.showToast("" + exception.toString());
      if (showLoader == true) EasyLoading.dismiss(animation: true);
    }
  }
}
