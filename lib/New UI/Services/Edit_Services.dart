import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vakalat_flutter/New%20UI/Services/services_screen.dart';
import 'package:vakalat_flutter/utils/design.dart';
import '../../Sharedpref/shared_pref.dart';
import '../../api/web_service.dart';
import '../../color/customcolor.dart';
import '../../helper.dart';
import '../../model/AddServicesResponceModel.dart';
import '../../model/EditServicesDataModel.dart';
import '../../model/clsLoginResponseModel.dart';
import '../../utils/constant.dart';

class Edit_Services extends StatefulWidget {
  final String service_id;
  final String title;
  final String amount;
  final String detail;
  const Edit_Services(
      {Key? key,
      required this.service_id,
      required this.title,
      required this.amount,
      required this.detail})
      : super(key: key);

  @override
  State<Edit_Services> createState() => _Edit_ServicesState();
}

class _Edit_ServicesState extends State<Edit_Services> {
  File? Image;

  Future<void> pickimage() async {
    XFile? Selectedimage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (Selectedimage != null) {
      File convertedFile = File(Selectedimage.path);
      setState(() {
        Image = convertedFile;
      });

      Fluttertoast.showToast(msg: "Image Selected");
    } else {
      Fluttertoast.showToast(msg: "Image Not Selected");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    titlecontroller.text = widget.title;
    Amountcontroller.text = widget.amount;
    Detailscontroller.text = widget.detail;
    super.initState();
  }

  TextEditingController titlecontroller = TextEditingController();
  TextEditingController Amountcontroller = TextEditingController();
  TextEditingController Detailscontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Services',
          style: TextStyle(
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        backgroundColor: CustomColor().colorPrimary,
      ),
      body: Column(children: [
        CustomTextfield(labelname: 'Enter Title', Controller: titlecontroller),
        CustomTextfield(
            labelname: 'Enter Amount', Controller: Amountcontroller),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
          child: InkWell(
            onTap: () {
              pickimage();
            },
            child: Container(
              height: 50,
              width: screenwidth(context, dividedby: 1),
              decoration: Const().decorationfield,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      Image != null ? 'Image Seleced' : 'Upload Image',
                      style: const TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          pickimage();
                        },
                        child: const Icon(FontAwesomeIcons.add, size: 16))
                  ],
                ),
              ),
            ),
          ),
        ),
        CustomTextfield(
          maxline: 5,
            labelname: 'Enter Details', Controller: Detailscontroller),
        Button_For_Update_Save(
          text: 'Update',
          onpressed: () {
            if (titlecontroller.text.isNotEmpty &&
                Amountcontroller.text.isNotEmpty &&
                Detailscontroller.text.isNotEmpty) {
              edit_services.call();
            } else {
              Fluttertoast.showToast(msg: 'Plz Fill All Details');
            }
          },
        ),
      ]),
    );
  }

  final WebService _webService = WebService();
  Future<void> edit_services() async {
    ClsLoginResponseModel logindetails = clsLoginResponseModelFromJson(
        SharedPref.get(prefKey: PrefKey.loginDetails)!);
    EasyLoading.show(status: 'Loading...');

    EditServicesDataModel editServicesDataModel = EditServicesDataModel(
        title: titlecontroller.text,
        accessToken: logindetails.accessToken,
        amount: Amountcontroller.text,
        apiKey: apikey,
        detail: Detailscontroller.text,
        device: device,
        smImage: Image?.path,
        userId: logindetails.userData.userId,
        service_id: widget.service_id);

    String uri = ('https://www.vakalat.com/user_api/Update_service');

    final Response response = await _webService.postFormRequest(
      url: uri,
      formData: await editServicesDataModel.toFormData(),
    );
    AddServicesResponceModel servi =
    addServicesResponceModelFromJson(response.data);

    debugPrint(JsonEncoder.withIndent(" " * 4).convert(response.data),
        wrapWidth: 100000);

    if (response.statusCode == 200) {
      // late clsAddServicesResponseModel addservices;
      EasyLoading.dismiss();
      Fluttertoast.showToast(msg: servi.message);

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const Services_screen(),
          ));
      print('image uploaded');
    } else {
      EasyLoading.dismiss();
      Fluttertoast.showToast(msg: servi.message);

      print('failed');
    }
  }
}
