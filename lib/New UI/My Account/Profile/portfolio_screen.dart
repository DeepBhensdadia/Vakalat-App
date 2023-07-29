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
import 'package:path_provider/path_provider.dart';
import 'package:vakalat_flutter/New%20UI/My%20Account/Profile/custom_drop_down.dart';
import 'package:vakalat_flutter/model/Get_Profile.dart';
import '../../../Sharedpref/shared_pref.dart';
import '../../../api/web_service.dart';
import '../../../helper.dart';
import '../../../model/UpdatePersonalDetails.dart';
import '../../../model/clsLoginResponseModel.dart';
import '../../../model/updatePortfoliodetails.dart';
import '../../../utils/constant.dart';
import '../../../utils/design.dart';
import 'getxcontroller.dart';

class Portfolio_screen extends StatefulWidget {
  final GetProfileModel detail;

  const Portfolio_screen({Key? key, required this.detail}) : super(key: key);

  @override
  State<Portfolio_screen> createState() => _Portfolio_screenState();
}

class _Portfolio_screenState extends State<Portfolio_screen> {
  final ProfileControl getxController = connect.Get.put(ProfileControl());
  TextEditingController aboutyou = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late List<String> selectedcategori = [];
  bool show = false;

  File? _selectedFile;

  void _openFileExplorer() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx'],
    );

    if (result != null) {
      File file = File(result.files.single.path!);

      final fileLength = await file.length();
      final fileLengthInKB = fileLength / 1024;

      if (fileLengthInKB <= 2000) {
        setState(() {
          _selectedFile = file;
        });
        Fluttertoast.showToast(msg: 'File picked successfully');
        // Proceed with file upload or further processing
      } else {
        Fluttertoast.showToast(msg: 'File size exceeds the limit of 2 MB');
      }
    } else {
      Fluttertoast.showToast(msg: 'File not picked');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    selectedcategori = widget.detail.profile.categoryId;
    // valueNotifier.value = widget.detail.profile.categoryId;
    aboutyou.text = widget.detail.profile.aboutUser;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<List<String>> valueNotifier =
        ValueNotifier(selectedcategori);

    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            CustomTextfield(
              maxline: 6,
              labelname: 'About You',
              Controller: aboutyou,
              validator: (p0) {
                if (p0!.isEmpty) {
                  return 'Enter About You';
                }
                return null;
              },
            ),
            ValueListenableBuilder(
              valueListenable: valueNotifier,
              builder: (context, value, child) => CustomSelection(
                controller: TextEditingController(
                    text: getxController.allcategori
                        .getCategoryFromID(value)
                        .join(",")),
                // key: Key(Random().nextInt(10).toString()),
                items: getxController.allcategori
                    .getAllCategory()
                    .map((e) => e.name)
                    .toList(),
                selected: getxController.allcategori.getCategoryFromID(value),
                onChanged: (onChanged) {
                  valueNotifier.value = onChanged;
                  List<String> ids = [];
                  for (String single in onChanged) {
                    ids.add(getxController.allcategori
                        .getAllCategory()
                        .firstWhere((element) => element.name == single)
                        .id);
                  }
                  setState(() {
                    selectedcategori = ids;
                  });
                },
                onDone: () {
                  Navigator.pop(context);
                  setState(() {});
                },
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Bio data",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600),),
                  SizedBox(height: 5,),
                  InkWell(
                    onTap: () {
                      _openFileExplorer();
                    },
                    child: Container(
                      height: 70,
                      width: screenwidth(context, dividedby: 1),
                      decoration: Const().decorationfield,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: screenwidth(context, dividedby: 2),
                              child: Text(
                                _selectedFile != null
                                    ? _selectedFile!.path
                                    : widget.detail.profile.biodata.isNotEmpty ?"File Already uploaded please download":'Upload Your Resume/Download Biodata',
                                style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.black54,
                                   ),
                              ),
                            ),
                            ElevatedButton(
                                onPressed: () async {
                                  Directory documentDir = await getApplicationDocumentsDirectory();
                                  String savePath = '${documentDir.path}/Vakalat-biodata.pdf';
                                  print(widget.detail.profile.biodata);
                                  await downloadFile(widget.detail.profile.biodata,savePath);
                                },
                                child: Row(
                                  children: const [
                                    Icon(
                                      FontAwesomeIcons.download,
                                      size: 16,
                                    ),
                                  ],
                                ))
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Button_For_Update_Save(
              text: 'Update',
              onpressed: () {
                print(selectedcategori);
                if (_formKey.currentState!.validate()) {
                  update_portfolio_details.call();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  final WebService _webService = WebService();

  Future<void> update_portfolio_details() async {
    List<int> intList = selectedcategori.map((s) => int.parse(s)).toList();
    ClsLoginResponseModel logindetails = clsLoginResponseModelFromJson(
        SharedPref.get(prefKey: PrefKey.loginDetails)!);
    EasyLoading.show(status: 'Loading...');

    Updateportfoliodetails updateportfolio = Updateportfoliodetails(
        apiKey: apikey,
        device: '2',
        accessToken: logindetails.accessToken,
        userId: logindetails.userData.userId,
        aboutUser: aboutyou.text,
        biodata: _selectedFile?.path,
        category: '$intList');

    String uri = ('https://www.vakalat.com/user_api/update_portfolio_detail');

    final Response response = await _webService.postFormRequest(
      url: uri,
      formData: await updateportfolio.toFormData(),
    );
    ClsUpdatePersonalResponseModel servi =
        clsUpdatePersonalResponseModelFromJson(response.data);

    debugPrint(JsonEncoder.withIndent(" " * 4).convert(response.data),
        wrapWidth: 100000);

    if (response.statusCode == 200) {
      // late clsAddServicesResponseModel addservices;
      EasyLoading.dismiss();
      log(selectedcategori.toString());
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
      Fluttertoast.showToast(msg: 'Download error: $error');
      EasyLoading.dismiss();
      print('Download error: $error');
    }
  }

}
