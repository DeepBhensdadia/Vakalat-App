import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:vakalat_flutter/New%20UI/My%20Account/Profile/playingvideo.dart';
import 'package:vakalat_flutter/Sharedpref/shared_pref.dart';
import 'package:vakalat_flutter/color/customcolor.dart';
import 'package:vakalat_flutter/model/Get_Profile.dart';
import 'package:vakalat_flutter/model/clsLoginResponseModel.dart';
import 'package:vakalat_flutter/utils/design.dart';
import '../../../api/web_service.dart';
import '../../../helper.dart';
import '../../../model/UpdatePersonalDetails.dart';
import '../../../model/personal_DetailsModel.dart';
import '../../../utils/ToastMessage.dart';
import '../../../utils/constant.dart';
import 'package:percent_indicator/percent_indicator.dart';

enum Gender { Male, Female }

enum Phyicallychallanged { Yes, No }

class Personal_Detail extends StatefulWidget {
  const Personal_Detail({
    Key? key,
    required this.detail,
  }) : super(key: key);

  final GetProfileModel detail;
  @override
  State<Personal_Detail> createState() => _Personal_DetailState();
}

class _Personal_DetailState extends State<Personal_Detail> {
  File? video;

  Future<void> pickvideo() async {
    XFile? Selectedvideo = await ImagePicker().pickVideo(
      source: ImageSource.gallery,
    );

    if (Selectedvideo != null) {
      File convertedFile = File(Selectedvideo.path);
      setState(() {
        video = convertedFile;
      });

      Fluttertoast.showToast(msg: "video Selected");
    } else {
      Fluttertoast.showToast(msg: "video Not Selected");
    }
  }

  File? imagepic;

  Future<void> pickImage() async {
    XFile? SelectedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (SelectedImage != null) {
      File convertedFile = File(SelectedImage.path);
      setState(() {
        imagepic = convertedFile;
      });

      Fluttertoast.showToast(msg: "Image Selected");
    } else {
      Fluttertoast.showToast(msg: "Image Not Selected");
    }
  }

  String? formattedDate = "";
  DateTime? _selectedDate;
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _selectedDate ?? DateTime.now(),
        firstDate: DateTime(1900, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  void initState() {
    firstnamecontoller.text = widget.detail.profile.firstName;
    middlenamecontoller.text = widget.detail.profile.middleName;
    lastnamecontoller.text = widget.detail.profile.lastName;
    shortnamecontoller.text = widget.detail.profile.shortName;
    if (widget.detail.profile.bloodGroup == null) {
      selectedBlood == null;
    } else {
      selectedBlood == widget.detail.profile.bloodGroup;
    }

    _selectedGender =
        widget.detail.profile.gender == 'Male' ? Gender.Male : Gender.Female;
    formattedDate = widget.detail.profile.dateOfBirth;
    super.initState();
  }

  TextEditingController firstnamecontoller = TextEditingController();
  TextEditingController middlenamecontoller = TextEditingController();
  TextEditingController lastnamecontoller = TextEditingController();
  TextEditingController shortnamecontoller = TextEditingController();
  TextEditingController bloodgroupcontoller = TextEditingController();
  final bool _isLoading = false;
  Gender _selectedGender = Gender.Male;
  Phyicallychallanged _selectedphycally = Phyicallychallanged.No;
  String? selectedBlood;
  List<String> bloodgroup = [
    'A',
    'B',
    'O',
    'AB',
    'A+',
    'A-',
    'B+',
    'B-',
    'O+',
    'O-',
    'AB+',
    'AB-'
  ];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    formattedDate = _selectedDate != null
        ? DateFormat('yyyy-MM-dd').format(_selectedDate!)
        : formattedDate == ""
            ? "Select date of Birth"
            : formattedDate;
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      pickImage();
                    },
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          // color: Colors.red,
                          child: Stack(
                            children: [
                              imagepic != null
                                  ? Container(
                                      decoration: BoxDecoration(
                                        // shape: BoxShape.circle,
                                        image: DecorationImage(
                                          image: FileImage(imagepic!),
                                          fit: BoxFit.cover,
                                          // colorFilter:
                                          //     ColorFilter.mode(Colors.red, BlendMode.colorBurn),
                                        ),
                                      ),
                                      height: 70,
                                      width: screenwidth(context, dividedby: 6),
                                    )
                                  : CachedNetworkImage(
                                      imageUrl:
                                          widget.detail.profile.profilePic,
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                        decoration: BoxDecoration(
                                          // shape: BoxShape.circle,
                                          image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover,
                                            // colorFilter:
                                            //     ColorFilter.mode(Colors.red, BlendMode.colorBurn),
                                          ),
                                        ),
                                      ),
                                      placeholder: (context, url) =>
                                          Image.asset(
                                              'assets/images/loading.gif'),
                                      errorWidget: (context, url, error) =>
                                          Image.asset(
                                              'assets/images/default.png'),
                                      height: 70,
                                      width: screenwidth(context, dividedby: 6),
                                    ),
                              Positioned(
                                top: 50,
                                left: screenwidth(context, dividedby: 9),
                                child: const CircleAvatar(
                                  radius: 14,
                                  backgroundColor: Colors.white,
                                  child: Icon(
                                    FontAwesomeIcons.edit,
                                    color: Colors.blue,
                                    size: 14,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    // color: Colors.red,
                    width: screenwidth(context, dividedby: 1.7),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0, bottom: 15),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Profile Completion',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: CustomColor().colorPrimary),
                              ),
                              Text(
                                '${widget.detail.profile.percentage}/100%',
                                style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          LinearPercentIndicator(
                            width: screenwidth(context, dividedby: 1.8),
                            animation: true,
                            lineHeight: 5.0,
                            padding: EdgeInsets.zero,
                            animationDuration: 250,
                            percent: double.parse(widget
                                    .detail.profile.percentage
                                    .toString()) /
                                100,
                            // center: Text("80.0%"),
                            linearStrokeCap: LinearStrokeCap.roundAll,
                            progressColor: Colors.green,
                          ),
                          const Text(
                            "Hooray, Your profile has sufficient data to show it to the public!",
                            style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.w600,
                                color: Colors.green),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            CustomTextfield(
              labelname: 'Enter First Name',
              Controller: firstnamecontoller,
              validator: (p0) {
                if (p0!.isEmpty) {
                  return 'Plz Enter First Name';
                }
                return null;
              },
            ),
            CustomTextfield(
              labelname: 'Enter Middle Name',
              Controller: middlenamecontoller,
              validator: (p0) {
                if (p0!.isEmpty) {
                  return 'Plz Enter Middle Name';
                }
                return null;
              },
            ),
            CustomTextfield(
              labelname: 'Enter Last Name',
              Controller: lastnamecontoller,
              validator: (p0) {
                if (p0!.isEmpty) {
                  return 'Plz Enter Last Name';
                }
                return null;
              },
            ),
            CustomTextfield(
              labelname: 'Enter Short Name',
              Controller: shortnamecontoller,
              validator: (p0) {
                if (p0!.isEmpty) {
                  return 'Plz Enter Short Name';
                }
                return null;
              },
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
              child: InkWell(
                onTap: () => _selectDate(context),
                child: Container(
                  height: 50,
                  width: screenwidth(context, dividedby: 1),
                  decoration: Const().decorationfield,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          formattedDate.toString(),
                          style: const TextStyle(
                              fontSize: 16, color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // CustomTextfield(labelname: 'Select D0B',),
            // CustomTextfield(
            //   labelname: 'Blood Group',
            //   Controller: bloodgroupcontoller,
            // ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
              child: InkWell(
                onTap: () {
                  pickvideo();
                },
                child: Container(
                  height: 50,
                  width: screenwidth(context, dividedby: 1),
                  decoration: Const().decorationfield,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButton<String>(
                      underline: Container(color: Colors.transparent),
                      isExpanded: true,
                      value: selectedBlood,
                      onChanged: (newValue) {
                        setState(() {
                          selectedBlood = newValue;
                        });
                      },
                      hint: const Text('Select an option'),
                      items: bloodgroup.map((option) {
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
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
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
                        'Video Select ',
                        style: TextStyle(fontSize: 16, color: Colors.black54),
                      ),
                      Card(
                          color: Colors.blue,
                          child: Row(
                            children: [
                              MaterialButton(
                                onPressed: () {
                                  pickvideo();
                                },
                                padding: EdgeInsets.zero,
                                minWidth: 15,
                                height: 20,
                                child: const Icon(
                                  FontAwesomeIcons.add,
                                  size: 16,
                                  color: Colors.white,
                                ),
                              ),
                              const VerticalDivider(
                                  thickness: 2,
                                  color: Colors.white,
                                  endIndent: 5,
                                  indent: 5),
                              MaterialButton(
                                padding: EdgeInsets.zero,
                                minWidth: 15,
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => Playing_Video(
                                        video:
                                            widget.detail.profile.videoProfile),
                                  );
                                },
                                child: const Icon(
                                  FontAwesomeIcons.video,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ],
                          ))
                    ],
                  ),
                ),
              ),
            ),
            // CustomTextfield(labelname: 'Video Profile',),
            _selectedphycally == Phyicallychallanged.Yes
                ? CustomTextfield(
                    labelname: 'Physically Challange Details',
                  )
                : const SizedBox(),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: Builder(builder: (context) {
                return Row(
                  children: [
                    const Text(
                      'Gender :',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: Gender.values
                          .map((e) => Row(
                                children: <Widget>[
                                  Radio<Gender>(
                                    value: e,
                                    groupValue: _selectedGender,
                                    onChanged: (Gender? value) {
                                      setState(() {
                                        _selectedGender = value!;
                                        print(_selectedGender);
                                      });
                                    },
                                  ),
                                  Text(e.name),
                                ],
                              ))
                          .toList(),
                    ),
                  ],
                );
              }),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: Row(
                children: [
                  const Text(
                    'IS Physically Challanged? :',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      Row(
                        children: [
                          Radio<Phyicallychallanged>(
                            value: Phyicallychallanged.Yes,
                            groupValue: _selectedphycally,
                            onChanged: (Phyicallychallanged? value) {
                              setState(() {
                                _selectedphycally = value!;
                              });
                            },
                          ),
                          const Text('Yes'),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Row(
                        children: <Widget>[
                          Radio<Phyicallychallanged>(
                            value: Phyicallychallanged.No,
                            groupValue: _selectedphycally,
                            onChanged: (Phyicallychallanged? value) {
                              setState(() {
                                _selectedphycally = value!;
                              });
                            },
                          ),
                          const Text('No'),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Button_For_Update_Save(
              text: 'Update',
              onpressed: () {
                if (_formKey.currentState!.validate()) {
                  if (formattedDate.toString().isNotEmpty) {
                    personal_details.call();
                  } else {
                    ToastMessage().showmessage('Plz Select Date of Birth');
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  final WebService _webService = WebService();
  Future<void> personal_details() async {
    ClsLoginResponseModel logindetails = clsLoginResponseModelFromJson(
        SharedPref.get(prefKey: PrefKey.loginDetails)!);
    EasyLoading.show(status: 'Loading...');

    PersonalDetailsModel personalDetailsModel = PersonalDetailsModel(
      apiKey: apikey,
      device: '2',
      accessToken: logindetails.accessToken,
      userId: logindetails.userData.userId,
      firstName: firstnamecontoller.text,
      middleName: middlenamecontoller.text,
      shortName: shortnamecontoller.text,
      lastName: lastnamecontoller.text,
      dateOfBirth: formattedDate.toString(),
      gender: _selectedGender.name,
      bloodGroup: selectedBlood,
      isPhysicalChal: _selectedphycally.name,
      videoProfile: video!.path ,
      organization: '',
      since: '',
      logo: '',
      profile: imagepic!.path
    );

    String uri = ('https://www.vakalat.com/user_api/update_personal_detail');

    final Response response = await _webService.postFormRequest(
      url: uri,
      formData: await personalDetailsModel.toFormData(),
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
      print('image uploaded');
    } else {
      EasyLoading.dismiss();
      Fluttertoast.showToast(msg: servi.message);

      print('failed');
    }
  }
}
