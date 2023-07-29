import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart'as connect;
import 'package:get/get_core/src/get_main.dart';

import 'package:image_picker/image_picker.dart';
import 'package:vakalat_flutter/model/getAchivements.dart';
import 'package:vakalat_flutter/utils/design.dart';

import '../../../Sharedpref/shared_pref.dart';
import '../../../api/postapi.dart';
import '../../../api/web_service.dart';
import '../../../color/customcolor.dart';
import '../../../helper.dart';
import '../../../model/AddServicesResponceModel.dart';
import '../../../model/addAchivements.dart';
import '../../../model/clsLoginResponseModel.dart';
import '../../../model/editAchivement.dart';
import '../../../pages/dashboard.dart';
import '../../../utils/constant.dart';
import '../Profile/getxcontroller.dart';
import 'Achivement.dart';

class Edit_Achivement extends StatefulWidget {
  final Achievement value;

  const Edit_Achivement(
      {Key? key, required  this.value,
      })
      : super(key: key);

  @override
  State<Edit_Achivement> createState() => _Edit_AchivementState();
}

class _Edit_AchivementState extends State<Edit_Achivement> {

  final ProfileControl getxController = Get.put(ProfileControl());

  TextEditingController titlecontroller = TextEditingController();
  TextEditingController monthcontroller = TextEditingController();
  TextEditingController yearcontroller = TextEditingController();
  TextEditingController detailscontoller = TextEditingController();
  File? coverpic;

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

  List<String> _imagePaths = [];

  Future<void> _pickotherimage() async {
    try {
      final pickedImages = await ImagePicker().pickMultiImage(imageQuality: 50);

      if (pickedImages != null && pickedImages.isNotEmpty) {
        List<File> images =
            pickedImages.map((pickedImage) => File(pickedImage.path)).toList();

        setState(() {
          _imagePaths.clear();
          _imagePaths.addAll(images.map((image) => image.path).toList());
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    // _imagePaths = widget.value.
    // coverpic = File(widget.value.achievementCoverImage);
    titlecontroller.text = widget.value.achievementBody;
    selectedMonth = widget.value.achievementMonth;
    yearcontroller.text = widget.value.achievementYear;
    detailscontoller.text = widget.value.achievementDetail;
    widget.value.otherimages.forEach((element) {
      _imagePaths.add(Const().URL_achivement_image+element.aiImages);
    });
    super.initState();
  }

  String? selectedMonth;
  ClsLoginResponseModel logindetails = clsLoginResponseModelFromJson(
      SharedPref.get(prefKey: PrefKey.loginDetails)!);
  Future<void> _removeImage(int index,String achivementid,String imageid) async {
    Map<String, dynamic> parameters = {
      "apiKey": apikey,
      'device': '2',
      "accessToken": logindetails.accessToken,
      "user_id": logindetails.userData.userId,
      "csrf_token": "",
      "achi_id": achivementid,
      "img_id": imageid
    };
    EasyLoading.show(status: 'Loading...');
    await achivement_iamgedelete(body: parameters).then((value) {
      EasyLoading.dismiss();
   if(value.status != 0){
     setState(() {
       _imagePaths.removeAt(index);
     });
   }

    }).onError((error, stackTrace) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DashboardPage(title: ''),));
      Const().deleteprofilelofinandmenu();
      msgexpire;
      print(error);
      EasyLoading.dismiss();
    });

  }
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
                          horizontal: 10.0, vertical: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Month",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600),),
                          SizedBox(height: 5,),
                          Container(
                            height: 50,
                            width: screenwidth(context, dividedby: 1),
                            decoration: Const().decorationfield,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DropdownButton<String>(
                                underline: Container(color: Colors.transparent),
                                isExpanded: true,
                                value: selectedMonth,
                                onChanged: (newValue) {
                                  setState(() {
                                    selectedMonth = newValue;
                                  });
                                },
                                hint: const Text('Select Month'),
                                items: Const().month.map((option) {
                                  return DropdownMenuItem<String>(
                                    value: option,
                                    child: Text(option),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ],
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Cover Image",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600),),
                    SizedBox(height: 5,),
                    InkWell(
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
                  ],
                ),
              ),
             Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        coverpic != null?  Container(
                            height: 80,
                            width: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: FileImage(coverpic!))),
                          ):Container(
                          height: 80,
                          width: 100,
                         child: CachedNetworkImage(
                           imageUrl: Const().URL_achivement_image +
                           widget.value.achievementCoverImage,
                           imageBuilder: (context, imageProvider) =>
                               Container(
                                 decoration: BoxDecoration(
                                   borderRadius:
                                   BorderRadius.circular(5),
                                   image: DecorationImage(
                                     image: imageProvider,
                                     fit: BoxFit.cover,
                                     // colorFilter:
                                     //     ColorFilter.mode(Colors.red, BlendMode.colorBurn),
                                   ),
                                 ),
                               ),
                           placeholder: (context, url) => Image.asset(
                               'assets/images/loading.gif'),
                           errorWidget: (context, url, error) =>
                               Image.asset(
                                   'assets/images/default.png'),
                           width: 100,
                           height: 100,
                         ),
                        )
                        ],
                      ),
                    ),
              SizedBox(height: 5,),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Other Images",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600),),
                    SizedBox(height: 5,),
                    InkWell(
                      onTap: () {
                        _pickotherimage();
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
                                _imagePaths.isEmpty
                                    ? 'Other Images'
                                    : ' Image Selected Successfully',
                                style:
                                    TextStyle(fontSize: 16, color: Colors.black54),
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    _pickotherimage();
                                  },
                                  child: const Icon(FontAwesomeIcons.add, size: 16))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              _imagePaths.length != 0?  Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  height: 100,

                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _imagePaths.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.only(bottom: 8.0,right: 8),
                      child: Card(
                        child: Container(
                          height: 80,
                          // width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),


                          ),
                          child:Row(
                            children: [
                              _imagePaths[index].startsWith('https') ?CachedNetworkImage(

                                placeholder: (context, url) =>
                                    Image.asset('assets/images/loading.gif'),
                                errorWidget: (context, url, error) =>
                                    Image.asset('assets/images/default.png'),
                                width: 100,
                                height: 100, imageUrl:  _imagePaths[index],
                              ):Image.file(
                                  fit: BoxFit.cover,
                                  File(_imagePaths[index])),
                              // SizedBox(width: 10 ,),
                              IconButton(onPressed: () {
                                _removeImage(index,widget.value.achievementId,widget.value.otherimages[index].aiId);
                              }, icon: Icon(Icons.delete))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ):SizedBox(),

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
                text: 'Update',
                onpressed: () {
                  if (_formKey.currentState!.validate()) {
                    Edit_Achivement.call();
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
  Future<void> Edit_Achivement() async {
    if(_imagePaths.first.startsWith("http")){
      _imagePaths.clear();
    }
    log(_imagePaths.toString());
    ClsLoginResponseModel logindetails = clsLoginResponseModelFromJson(
        SharedPref.get(prefKey: PrefKey.loginDetails)!);
    EasyLoading.show(status: 'Loading...');
    EditAchivementModel addAchivementDataModel = EditAchivementModel(
        userId: logindetails.userData.userId,
        apiKey: apikey,
        device: device,
        accessToken: logindetails.accessToken,
        achievementId: widget.value.achievementId,
        title: titlecontroller.text,
        coverPic: coverpic?.path,
        csrfToken: "",
        month: selectedMonth,
        year: yearcontroller.text,
        otherImages: _imagePaths,
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
      // Get.offAll(Achivement_Screen(),);

      getxController.get_Achivement_dep2(context);

      print('image uploaded');
    } else {
      EasyLoading.dismiss();
      Fluttertoast.showToast(msg: servi.message);

      print('failed');
    }
  }
}
