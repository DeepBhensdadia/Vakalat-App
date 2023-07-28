import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart' as connect;
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vakalat_flutter/color/customcolor.dart';
import 'package:vakalat_flutter/model/Get_Profile.dart';
import 'package:vakalat_flutter/model/updatePortfoliodetails.dart';
import 'package:http/http.dart' as http;
import '../../../Sharedpref/shared_pref.dart';
import '../../../api/postapi.dart';
import '../../../api/web_service.dart';
import '../../../helper.dart';
import '../../../model/Bar Associate List.dart';
import '../../../model/Get_doc_type.dart';
import '../../../model/UpdateContactDetails.dart';
import '../../../model/UpdatePersonalDetails.dart';
import '../../../model/clsLoginResponseModel.dart';
import '../../../model/getbar_councilModel.dart';
import '../../../model/getdocumentdetails.dart';
import '../../../model/updatepoffetionaldetail.dart';
import '../../../utils/ToastMessage.dart';
import '../../../utils/constant.dart';
import '../../../utils/design.dart';
import 'getxcontroller.dart';

class Professional_Detail extends StatefulWidget {
  final GetProfileModel detail;
  const Professional_Detail({Key? key, required this.detail}) : super(key: key);

  @override
  State<Professional_Detail> createState() => _Professional_DetailState();
}

class _Professional_DetailState extends State<Professional_Detail> {
  final ProfileControl getxController = Get.put(ProfileControl());

  // ValueNotifier<List<DocType>> doctypes = ValueNotifier([]);
  String barcouncil = '';
  String barassociation = '';
  String documenttype = '72';
  ClsLoginResponseModel logindetails = clsLoginResponseModelFromJson(
      SharedPref.get(prefKey: PrefKey.loginDetails)!);
  DateTime? registration_date;
  DateTime? welfareragidate;
  DateTime? dis_registartion_date;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: registration_date ?? DateTime.now(),
        firstDate: DateTime(1900, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != registration_date) {
      setState(() {
        registration_date = picked;
      });
    }
  }

  Future<void> welfarerdate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: welfareragidate ?? DateTime.now(),
        firstDate: DateTime(1900, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != welfareragidate) {
      setState(() {
        welfareragidate = picked;
      });
    }
  }

  Future<void> dis_court_registartion_date(BuildContext context) async {
    print('hello');
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: dis_registartion_date ?? DateTime.now(),
        firstDate: DateTime(1900, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != dis_registartion_date) {
      setState(() {
        dis_registartion_date = picked;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState

    sanadragino = TextEditingController(text: widget.detail.profile.sanadRegNo);
    sanadragiyear =
        TextEditingController(text: widget.detail.profile.sanadRegYear);
    welfareragiyear =
        TextEditingController(text: widget.detail.profile.welfareNo);
    dis_court_no =
        TextEditingController(text: widget.detail.profile.distCourtRegiNo);
    law_firm = TextEditingController(text: widget.detail.profile.lawFirmName);
    assetsmemno =
        TextEditingController(text: widget.detail.profile.assoMemberNo);
    qualification =
        TextEditingController(text: widget.detail.profile.qualification);
    expirianceinyear =
        TextEditingController(text: widget.detail.profile.experience);
    notoryno = TextEditingController(text: widget.detail.profile.notaryNo);
    ragidate = widget.detail.profile.sanadRegDate;
    welfareregid = widget.detail.profile.welfareDate;
    dis_ragi_date = widget.detail.profile.distCourtRegiDate;
    barassociation = widget.detail.profile.associationId;
    barcouncil = widget.detail.profile.councilId;
    super.initState();
  }

  String? ragidate = '';
  String? welfareregid = '';
  String? dis_ragi_date = '';
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController sanadragino = TextEditingController();
  TextEditingController sanadragiyear = TextEditingController();
  TextEditingController welfareragiyear = TextEditingController();
  TextEditingController dis_court_no = TextEditingController();
  TextEditingController law_firm = TextEditingController();
  TextEditingController assetsmemno = TextEditingController();
  TextEditingController qualification = TextEditingController();
  TextEditingController expirianceinyear = TextEditingController();
  TextEditingController notoryno = TextEditingController();

  File? sanadfile;

  void sanadcertificate() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg', 'png', 'jpeg'],
    );

    if (result != null) {
      File file = File(result.files.single.path!);

      final fileLength = await file.length();
      final fileLengthInKB = fileLength / 1024;

      if (fileLengthInKB <= 2000) {
        setState(() {
          sanadfile = file;
        });
        Get.back();

        Fluttertoast.showToast(msg: 'File picked successfully');
        // Proceed with file upload or further processing
      } else {
        Fluttertoast.showToast(msg: 'File size exceeds the limit of 2 MB');
      }
    } else {
      Fluttertoast.showToast(msg: 'File not selected');
    }
  }

  void sanadcertificatecamera() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      final pickedImageFile = File(pickedFile.path);

      final imageFileSize = await pickedImageFile.length();
      final imageFileSizeInKB = imageFileSize / 1024;

      setState(() {
        sanadfile = pickedImageFile;
      });        Get.back();

    Fluttertoast.showToast(msg: 'Image Selected Successfully');
    } else {
      Fluttertoast.showToast(msg: 'Image not selected');
    }
  }
  // void sanadcertificate() async {
  //   FilePickerResult? result = await FilePicker.platform.pickFiles(
  //     type: FileType.custom,
  //     allowedExtensions: ['pdf', "jpg", "png", "jpeg"],
  //   );
  //
  //   if (result != null) {
  //     File file = File(result.files.single.path!);
  //     setState(() {
  //       sanadfile = file;
  //     });
  //     Fluttertoast.showToast(msg: 'Pick File Suceessfully');
  //   } else {
  //     Fluttertoast.showToast(msg: 'Pick File Failed');
  //   }
  // }

  File? otherdoc;

  void otherdoctype() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', "jpg", "png", "jpeg"],
    );

    if (result != null) {
      File file = File(result.files.single.path!);
      final fileLength = await file.length();
      final fileLengthInKB = fileLength / 1024;
      // setState(() {
      //   otherdoc = file;
      // });
      if (fileLengthInKB <= 2000) {
        setState(() {
          otherdoc = file;
        });
        Fluttertoast.showToast(msg: 'File picked successfully');
        Get.back();
        // Proceed with file upload or further processing
      } else {
        Fluttertoast.showToast(msg: 'File size exceeds the limit of 2 MB');
      }
    } else {
      Fluttertoast.showToast(msg: 'Pick File Failed');
    }
  }

  void otherdoctypecamera() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      final pickedImageFile = File(pickedFile.path);

      final imageFileSize = await pickedImageFile.length();
      final imageFileSizeInKB = imageFileSize / 1024;

      setState(() {
        otherdoc = pickedImageFile;
      });
      Get.back();

      Fluttertoast.showToast(msg: 'Image Selected Successfully');
    } else {
      Fluttertoast.showToast(msg: 'Image not selected');
    }
  }

  @override
  Widget build(BuildContext context) {
    ragidate = registration_date != null
        ? DateFormat('dd/MM/yyyy').format(registration_date!)
        : ragidate == ""
            ? 'Select Sanad Registration date'
            : ragidate;
    welfareregid = welfareragidate != null
        ? DateFormat('dd/MM/yyyy').format(welfareragidate!)
        : welfareregid == ""
            ? 'Select Welfare Registration date'
            : welfareregid;
    dis_ragi_date = dis_registartion_date != null
        ? DateFormat('dd/MM/yyyy').format(dis_registartion_date!)
        : dis_ragi_date == ""
            ? 'Dis. court Registration date'
            : dis_ragi_date;
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      'Verification Document',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 60,
              // decoration: BoxDecoration(border: Border.all(width: 0.5)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    child: Text(
                      // textAlign: TextAlign.center,
                      '   Sanad Certificate',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    width: screenwidth(context, dividedby: 2.5),
                  ),
                  Container(
                    // width: screenwidth(context,dividedby: 3),
                    child: Text(
                      getxController.getprofile!.profile.doc.isNotEmpty
                          ?
                      // getxController.getprofile!.profile.doc[0].isNotEmpty
                      //         ?
                      " Uploaded"
                              // : " Not Uploaded"
                          : " Not Uploaded",
                      // "Uploaded",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color:
                          getxController.getprofile!.profile.doc.isNotEmpty
                          //     ?
                          // getxController.getprofile!.profile.doc[0].isNotEmpty
                              ?
                          Colors.green
                              // : Colors.orange
                              : Colors.orange, ),
                    ),
                  ),
                  Row(
                    children: [
                      MaterialButton(
                        minWidth: 40,
                        padding: EdgeInsets.zero,
                        color: Colors.blue,
                        onPressed: () {
                          imagesheet(context, () {
                            sanadcertificatecamera();
                          }, () {
                            sanadcertificate();
                          });
                        },
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                      MaterialButton(
                        minWidth: 40,
                        padding: EdgeInsets.zero,
                        color: CustomColor().colorPrimary,
                        onPressed: () async {
                          Directory documentDir = await getApplicationDocumentsDirectory();
                          String savePath = '${documentDir.path}/sanadcertificate.pdf';
                          if (getxController
                              .getprofile!.profile.doc[0].isNotEmpty) {
                            // _downloadFile();
                            await  downloadFile(getxController.getprofile!.profile.doc[0], savePath);

                          }
                        },
                        child: Icon(
                          Icons.download,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 60,
              // decoration: BoxDecoration(border: Border.all(width: 0.5)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    child: dropdowngetdoctype(
                      initialvalue: "72",
                      doctype: getxController.doctype.docTypes,
                      onSelection: (p0) {
                        documenttype = p0.toString();
                        print(p0);
                      },
                    ),
                    width: screenwidth(context, dividedby: 2.5),
                  ),
                  Container(
                    // width: screenwidth(context,dividedby: 3),
                    child: Text(
                      getxController.getprofile!.profile.doc.isNotEmpty
                          // ? getxController.getprofile!.profile.doc[1].isNotEmpty
                          ? " Uploaded"
                          // : " Not Uploaded"
                          : " Not Uploaded",
                      // "Uploaded",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color:
                          getxController.getprofile!.profile.doc.isNotEmpty
                              // ? getxController.getprofile!.profile.doc[1].isNotEmpty
                              ? Colors.green
                             // : Colors.orange
                              : Colors.orange,  ),
                    ),
                  ),
                  Row(
                    children: [
                      MaterialButton(
                        minWidth: 40,
                        padding: EdgeInsets.zero,
                        color: Colors.blue,
                        onPressed: () {
                          imagesheet(context, () {
                            otherdoctypecamera();
                          }, () {
                            otherdoctype();
                          });
                        },
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                      MaterialButton(
                        minWidth: 40,
                        padding: EdgeInsets.zero,
                        color: CustomColor().colorPrimary,
                        onPressed: () async {
                          Directory documentDir = await getApplicationDocumentsDirectory();
                          String savePath = '${documentDir.path}/otheruploadedoc.pdf';
                          if (getxController
                              .getprofile!.profile.doc[1].isNotEmpty) {
                            // otherdocfile();
                          await  downloadFile(getxController.getprofile!.profile.doc[1], savePath);
                          }
                        },
                        child: Icon(
                          Icons.download,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const Divider(
              thickness: 1,
            ),
            CustomTextfield(
              labelname: ' Sanad Registration No',
              type: TextInputType.number,
              Controller: sanadragino,
              validator: (p0) {
                if (p0!.isEmpty) {
                  return 'PLz Enter Registration No';
                }
                return null;
              },
            ),
            CustomTextfield(
              ontap: () => _selectDate(context),
              labelname: 'Sanad Registration Date',
              type: TextInputType.none,
              Controller: TextEditingController(text: ragidate),
            ),
            CustomTextfield(
              labelname: ' Sanad Registration year',
              type: TextInputType.number,
              Controller: sanadragiyear,
              validator: (p0) {
                if (p0!.isEmpty) {
                  return 'PLz Enter Registration Year';
                }
                return null;
              },
            ),
            // CustomTextfield(
            //   labelname: ' welfare Registration year',
            //   type: TextInputType.number,
            //   Controller: welfareragiyear,
            //   validator: (p0) {
            //     if (p0!.isEmpty) {
            //       return 'PLz Enter Welfare Registration Year';
            //     }
            //     return null;
            //   },
            // ),
            // CustomTextfield(
            //   ontap: () => welfarerdate(context),
            //   labelname: 'Welfare Registration Date',
            //   type: TextInputType.none,
            //   Controller: TextEditingController(
            //     text: welfareregid.toString(),
            //   ),
            // ),
            CustomTextfield(
              labelname: 'Dist. Court Registration No.',
              type: TextInputType.number,
              Controller: dis_court_no,
              validator: (p0) {
                if (p0!.isEmpty) {
                  return 'PLz Enter  Dis. Court Registration no';
                }
                return null;
              },
            ),
            CustomTextfield(
              labelname: 'Dist. Court Registration  Date.',
              Controller: TextEditingController(text: dis_ragi_date),
              type: TextInputType.none,
              ontap: () => dis_court_registartion_date(context),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
              child: drodownbar_council(
                  initialvalue: widget.detail.profile.councilId,
                  onSelection: (p0) {
                    barcouncil = p0.toString();
                    print(p0);
                  },
                  bar_council: getxController.council_builder.value),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
              child: dropdownbar_assoc(
                  initialvalue: widget.detail.profile.associationId,
                  onSelection: (p0) {
                    print(p0);
                    barassociation = p0.toString();
                  },
                  bar_assoc: getxController.association_builder.value),
            ),
            CustomTextfield(
              labelname: 'Law Firm',
              Controller: law_firm,
              validator: (p0) {
                if (p0!.isEmpty) {
                  return 'PLz Enter Law Firm';
                }
                return null;
              },
            ),
            // CustomTextfield(
            //   labelname: 'Assets Member Number',
            //   Controller: assetsmemno,
            //   validator: (p0) {
            //     if (p0!.isEmpty) {
            //       return 'PLz Enter Law Firm';
            //     }
            //     return null;
            //   },
            // ),
            CustomTextfield(
              labelname: 'Qualification',
              Controller: qualification,
              validator: (p0) {
                if (p0!.isEmpty) {
                  return 'PLz Enter Qualification';
                }
                return null;
              },
            ),
            CustomTextfield(
              labelname: 'Experience(In Year)',
              Controller: expirianceinyear,
              validator: (p0) {
                if (p0!.isEmpty) {
                  return 'PLz Enter Expirience';
                }
                return null;
              },
            ),
            CustomTextfield(
              labelname: 'Notory No.',
              // type: TextInputType.number,
              Controller: notoryno,
              validator: (p0) {
                if (p0!.isEmpty) {
                  return 'PLz Enter Notory No';
                }
                return null;
              },
            ),
            Button_For_Update_Save(
              text: 'Update',
              onpressed: () {
                // if (formKey.currentState!.validate()) {
                // }
                update_portfolio_details.call();
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> downloadFile(String fileUrl, String savePath) async {
    EasyLoading.show(status: "Loading...");
    Dio dio = Dio();
    try {
      final response = await dio.download(
        fileUrl,
        savePath,
        onReceiveProgress: (receivedBytes, totalBytes) {
          if (totalBytes != -1) {
            double progress = (receivedBytes / totalBytes) * 100;
            print('Download progress: $progress%');
          }
        },
      );
      EasyLoading.dismiss();
      Fluttertoast.showToast(msg:'File downloaded to: $savePath' );
      print('File downloaded to: $savePath');
    } catch (error) {
      EasyLoading.dismiss();
      Fluttertoast.showToast(msg: 'Download error: $error');

      print('Download error: $error');
    }
  }


  final WebService _webService = WebService();

  Future<void> update_portfolio_details() async {
    ClsLoginResponseModel logindetails = clsLoginResponseModelFromJson(
        SharedPref.get(prefKey: PrefKey.loginDetails)!);
    EasyLoading.show(status: 'Loading...');

    Updateproffetional proffe = Updateproffetional(
        apiKey: apikey,
        device: '2',
        accessToken: logindetails.accessToken,
        userId: logindetails.userData.userId,
        sanadRegNo: sanadragino.text,
        sanadRegYear: sanadragiyear.text,
        sanadRegDate: ragidate!,
        welfareNo: welfareragiyear.text,
        welfareDate: welfareregid!,
        distCourtRegiNo: dis_court_no.text,
        distCourtRegiDate: dis_ragi_date!,
        councilId: barcouncil,
        associationId: barassociation,
        lawFirmName: law_firm.text,
        assoMemberNo: assetsmemno.text,
        qualification: qualification.text,
        experience: expirianceinyear.text,
        notaryNo: notoryno.text,
        docTypeId: documenttype,
        document1: sanadfile?.path,
        document2: otherdoc?.path);

    String uri =
        ('https://www.vakalat.com/user_api/update_professional_detail_app');

    final Response response = (await _webService.postFormRequest(
      url: uri,
      formData: await proffe.toFormData(),
    ));
    ClsUpdatePersonalResponseModel servi =
        clsUpdatePersonalResponseModelFromJson(response.data);

    debugPrint(JsonEncoder.withIndent(" " * 4).convert(response.data),
        wrapWidth: 100000);

    if (response.statusCode == 200) {
      // late clsAddServicesResponseModel addservices;
      EasyLoading.dismiss();
      Fluttertoast.showToast(msg: servi.message);
      setState(() {});
      // Navigator.pushReplacement(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => DashboardPage(
      //         title: '',
      //       ),
      //     ));
      // print('image uploaded');
    } else {
      EasyLoading.dismiss();
      Fluttertoast.showToast(msg: servi.message);

      print('failed');
    }
  }
}
