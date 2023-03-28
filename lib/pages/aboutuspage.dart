
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_html/flutter_html.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:vakalat_flutter/api/postapi.dart';
import 'package:vakalat_flutter/color/customcolor.dart';
import 'package:vakalat_flutter/model/clsAboutUsResponseModel.dart';
import 'package:vakalat_flutter/utils/keyboardHiderMixin.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> with KeyboardHiderMixin {
  clsAboutUsResponseModel? objAboutUsResponseModel;

  @override
  void initState() {
    // TODO: implement initState
    APICALL_get_about_us(true);
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
        body: (objAboutUsResponseModel == null)
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
              data: objAboutUsResponseModel!.about_us!,
            ),
          ),
        ));
  }

  Future APICALL_get_about_us(bool showLoader) async {
    clsAboutUsResponseModel objResponse = clsAboutUsResponseModel();
    try {
      Map<String, dynamic> parameters = {};

      if (showLoader == true) EasyLoading.show(status: "Loading...");

      objResponse = await get_about_us(body: parameters);
      if (objResponse.status == 1) {
        setState(() {
          objAboutUsResponseModel = objResponse;
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
