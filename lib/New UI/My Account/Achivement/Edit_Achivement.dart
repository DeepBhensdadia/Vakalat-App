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
      required this.image,
      required this.detail,
      required this.achievementId})
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
    // coverpic = File(widget.image);
    titlecontroller.text = widget.title;
   selectedMonth = widget.month;
    yearcontroller.text = widget.year;
    detailscontoller.text = widget.detail;
    super.initState();
  }
String? selectedMonth;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Achivement',
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
            crossAxisAlignment: CrossAxisAlignment.start,
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
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10),
                      child: Container(
                        height: 50,
                        width: screenwidth(context, dividedby: 1),
                        decoration: Const().decorationfield,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButton<String>(
                            underline: Container(color: Colors.transparent),
                            isExpanded: true,
                            value:  selectedMonth,
                            onChanged: (newValue) {
                              setState(() {
                                selectedMonth = newValue;
                              });
                            },
                            hint: const Text('Select Month'),
                            items:Const().month.map((option) {
                              return DropdownMenuItem<String>(
                                value: option,
                                child: Text(option),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: CustomTextfield(
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
                  ),
                ],
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
                          Text(
                            coverpic == null
                                ? 'Cover Picture'
                                : 'Image Selected Sucessfully',
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
              coverpic == null
                  ? SizedBox()
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Selected Cover image',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 80,
                            width: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: FileImage(coverpic!))),
                          )
                        ],
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
                          Text(
                            otherpic == null
                                ? 'Other Images'
                                : ' Image Selected sucessfully',
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
              otherpic == null
                  ? SizedBox()
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Selected other image',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 80,
                            width: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: FileImage(otherpic!))),
                          )
                        ],
                      ),
                    ),
              CustomTextfield(
                maxline: 4,
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
                  if (_formKey.currentState!.validate()) {
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
        coverPic: coverpic?.path,
        csrfToken: "",
        month:selectedMonth,
        year: yearcontroller.text,
        otherImages: otherpic?.path,
        detail: detailscontoller.text);

    String uri =
    ('https://www.vakalat.com/user_api//achivements_master_update');

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
    if (servi.status == 1) {
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
  }
}
