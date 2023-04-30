import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vakalat_flutter/utils/design.dart';

import '../../../Sharedpref/shared_pref.dart';
import '../../../api/web_service.dart';
import '../../../color/customcolor.dart';
import '../../../helper.dart';
import '../../../model/AddServicesResponceModel.dart';
import '../../../model/addAchivements.dart';
import '../../../model/clsLoginResponseModel.dart';
import '../../../model/editAchivement.dart';
import '../../../utils/constant.dart';
import 'Achivement.dart';

class Edit_Achivement extends StatefulWidget {
  final String title;
  final String month;
  final String year;
  final String image;
  final String detail;
  final String achievementId;
  const Edit_Achivement(
      {Key? key,
      required this.title,
      required this.month,
      required this.year,
      required this.image, required this.detail, required this.achievementId})
      : super(key: key);

  @override
  State<Edit_Achivement> createState() => _Edit_AchivementState();
}

class _Edit_AchivementState extends State<Edit_Achivement> {
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController monthcontroller = TextEditingController();
  TextEditingController yearcontroller = TextEditingController();
  TextEditingController detailscontoller = TextEditingController();
  File? coverpic;
  File? otherpic;

  Future<void> pickcoverimage() async {
    XFile? Selectedimage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (Selectedimage != null) {
      File convertedFile = File(Selectedimage.path);
      setState(() {
        coverpic = convertedFile;
      });

      Fluttertoast.showToast(msg: "Image Selected");
    } else {
      Fluttertoast.showToast(msg: "Image Not Selected");
    }
  }

  Future<void> pickotherimage() async {
    XFile? Selectedimage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (Selectedimage != null) {
      File convertedFile = File(Selectedimage.path);
      setState(() {
        otherpic = convertedFile;
      });

      Fluttertoast.showToast(msg: "Image Selected");
    } else {
      Fluttertoast.showToast(msg: "Image Not Selected");
    }
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
@override
  void initState() {
    // TODO: implement initState
  coverpic = File(widget.image);
  titlecontroller.text = widget.title;
  monthcontroller.text =widget.month;
  yearcontroller.text =widget.year;
  detailscontoller.text = widget.detail;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Achivement',
          style: TextStyle(
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        backgroundColor: CustomColor().colorPrimary,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextfield(
                labelname: 'Title',
                Controller: titlecontroller,
                validator: (p0) {
                  if (p0!.isEmpty) {
                    return "Please Enter Title";
                  }
                  return null;
                },
              ),
              CustomTextfield(
                labelname: 'Enter Month',
                type: TextInputType.number,
                Controller: monthcontroller,
                validator: (p0) {
                  if (p0!.isEmpty) {
                    return "Please Enter Month";
                  }
                  return null;
                },
              ),
              CustomTextfield(
                labelname: 'Enter Year',
                type: TextInputType.number,
                maxlength: 4,
                Controller: yearcontroller,
                validator: (p0) {
                  if (p0!.isEmpty) {
                    return "Please Enter Year";
                  }
                  return null;
                },
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                child: InkWell(
                  onTap: () {
                    pickcoverimage();
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
                          const Text(
                            'Cover Picture',
                            style:
                                TextStyle(fontSize: 16, color: Colors.black54),
                          ),
                          ElevatedButton(
                              onPressed: () {
                                pickcoverimage();
                              },
                              child: const Icon(FontAwesomeIcons.add, size: 16))
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                child: InkWell(
                  onTap: () {
                    pickotherimage();
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
                          const Text(
                            'Other Images',
                            style:
                                TextStyle(fontSize: 16, color: Colors.black54),
                          ),
                          ElevatedButton(
                              onPressed: () {
                                pickotherimage();
                              },
                              child: const Icon(FontAwesomeIcons.add, size: 16))
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              CustomTextfield(
                labelname: 'Details',
                Controller: detailscontoller,
                validator: (p0) {
                  if (p0!.isEmpty) {
                    return "Please Enter Details";
                  }
                  return null;
                },
              ),
              Button_For_Update_Save(
                text: 'Save',
                onpressed: () {
                  if (_formKey.currentState!.validate()){
                    add_Achivement.call();
                  }

                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  final WebService _webService = WebService();
  Future<void> add_Achivement() async {
    if (coverpic != null) {
      ClsLoginResponseModel logindetails = clsLoginResponseModelFromJson(
          SharedPref.get(prefKey: PrefKey.loginDetails)!);
      EasyLoading.show(status: 'Loading...');

      EditAchivementModel addAchivementDataModel = EditAchivementModel(
          userId: logindetails.userData.userId,
          apiKey: apikey,
          device: device,
          accessToken: logindetails.accessToken,
          achievementId: widget.achievementId,
          title: titlecontroller.text,
          coverPic: coverpic!.path,
          csrfToken: "",
          month: monthcontroller.text,
          year: yearcontroller.text,
          otherImages: otherpic!.path,
          detail: detailscontoller.text);

      String uri = ('https://www.vakalat.com/user_api//achivements_master_update');

      final Response response = await _webService.postFormRequest(
        url: uri,
        formData: await addAchivementDataModel.toFormData(),
      );
      AddServicesResponceModel servi =
          addServicesResponceModelFromJson(response.data);
      // AddServicesResponceModel jasondata = response.data;
      debugPrint(JsonEncoder.withIndent(" " * 4).convert(response.data),
          wrapWidth: 100000);
      // AddServicesResponceModel? addservices;
      if (response.statusCode == 200) {
        // late clsAddServicesResponseModel addservices;
        EasyLoading.dismiss();
        Fluttertoast.showToast(msg: servi.message);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Achivement_Screen(),
            ));
        print('image uploaded');
      } else {
        EasyLoading.dismiss();
        Fluttertoast.showToast(msg: servi.message);

        print('failed');
      }
    } else {
      Fluttertoast.showToast(msg: 'plz Select Image');
    }
  }
}
