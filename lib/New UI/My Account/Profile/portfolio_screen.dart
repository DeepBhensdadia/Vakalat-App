import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vakalat_flutter/New%20UI/My%20Account/Profile/custom_drop_down.dart';
import 'package:vakalat_flutter/model/Get_Profile.dart';

import '../../../Sharedpref/shared_pref.dart';
import '../../../api/postapi.dart';
import '../../../api/web_service.dart';
import '../../../helper.dart';
import '../../../model/GetAllCategory.dart';
import '../../../model/UpdatePersonalDetails.dart';
import '../../../model/clsLoginResponseModel.dart';
import '../../../model/updatePortfoliodetails.dart';
import '../../../utils/constant.dart';
import '../../../utils/design.dart';

class Portfolio_screen extends StatefulWidget {
  final GetProfileModel detail;
  const Portfolio_screen({Key? key, required this.detail}) : super(key: key);

  @override
  State<Portfolio_screen> createState() => _Portfolio_screenState();
}

class _Portfolio_screenState extends State<Portfolio_screen> {
  TextEditingController aboutyou = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late GetAllCategory allcategori;
  late List<String> selectedcategori = [];
  bool show = false;
  void categorypostapi() async {
    Map<String, dynamic> parameters = {
      "apiKey": apikey,
      'device': '2',
    };
    EasyLoading.show(status: 'loading...');
    await All_Categories(body: parameters).then((value) {
      setState(() {
        allcategori = value;
        show = true;
      });
      EasyLoading.dismiss();
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
    });
  }

  File? _selectedFile;

  void _openFileExplorer() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path!);
      setState(() {
        _selectedFile = file;
      });
      Fluttertoast.showToast(msg: 'Pick File Suceessfully');
    } else {
      Fluttertoast.showToast(msg: 'File not Pick');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    selectedcategori = widget.detail.profile.categoryId;
    // valueNotifier.value = widget.detail.profile.categoryId;
    aboutyou.text = widget.detail.profile.aboutUser;
    categorypostapi();
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
              maxline: 3,
              labelname: 'About You',
              Controller: aboutyou,
              validator: (p0) {
                if (p0!.isEmpty) {
                  return 'Enter About You';
                }
                return null;
              },
            ),
            show
                ? ValueListenableBuilder(
                    valueListenable: valueNotifier,
                    builder: (context, value, child) => CustomSelection(
                      controller: TextEditingController(text: value.join(",")),
                      // key: Key(Random().nextInt(10).toString()),
                      items: allcategori
                          .getAllCategory()
                          .map((e) => e.name)
                          .toList(),
                      selected: value,
                      onChanged: (onChanged) {
                        valueNotifier.value = onChanged;
                        List<String> ids = [];
                        for (String single in onChanged) {
                          ids.add(allcategori
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
                  )
                : SizedBox(),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
              child: InkWell(
                onTap: () {
                  _openFileExplorer();
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
                        SizedBox(
                          width: screenwidth(context, dividedby: 2),
                          child: Text(
                            _selectedFile != null
                                ? _selectedFile!.path
                                : 'Click to Upload BioData',
                            style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black54,
                                overflow: TextOverflow.ellipsis),
                          ),
                        ),
                        ElevatedButton(
                            onPressed: () {
                              // _openFileExplorer();
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
        category: selectedcategori);

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
