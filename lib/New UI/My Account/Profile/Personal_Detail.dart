import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart'as a;
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:vakalat_flutter/New%20UI/My%20Account/Profile/playingvideo.dart';
import 'package:vakalat_flutter/Sharedpref/shared_pref.dart';
import 'package:vakalat_flutter/color/customcolor.dart';
import 'package:vakalat_flutter/model/Get_Profile.dart';
import 'package:vakalat_flutter/model/clsLoginResponseModel.dart';
import 'package:vakalat_flutter/utils/design.dart';
import '../../../api/postapi.dart';
import '../../../api/web_service.dart';
import '../../../helper.dart';
import '../../../model/GetHandlerList.dart';
import '../../../model/UpdatePersonalDetails.dart';
import '../../../model/personal_DetailsModel.dart';
import '../../../utils/ToastMessage.dart';
import '../../../utils/constant.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../../handler_search/Cart.dart';
import '../../handler_search/handler_search.dart';

enum Gender { Male, Female }

// enum Phyicallychallanged {1,0 }

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
  ClsLoginResponseModel logindetails = clsLoginResponseModelFromJson(
      SharedPref.get(prefKey: PrefKey.loginDetails)!);
  File? video;

  DateTime? _selectedDate;

  File? imagepic;

  Future<void> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final pickedImageFile = File(pickedFile.path);

      final imageFileSize = await pickedImageFile.length();
      final imageFileSizeInKB = imageFileSize / 1024;

      if (imageFileSizeInKB <= 500) {
        setState(() {
          imagepic = pickedImageFile;
        });
        Get.back();

        Fluttertoast.showToast(msg: 'Image Selected Successfully');
      } else {
        Fluttertoast.showToast(msg: 'Image size exceeds the limit of 500 KB');
      }
    } else {
      Fluttertoast.showToast(msg: 'Image not selected');
    }
  }

  Future<void> pickImagecamera() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      final pickedImageFile = File(pickedFile.path);

      final imageFileSize = await pickedImageFile.length();
      final imageFileSizeInKB = imageFileSize / 1024;

      setState(() {
        imagepic = pickedImageFile;
      });
      Get.back();

      Fluttertoast.showToast(msg: 'Image Selected Successfully');
      // if (imageFileSizeInKB <= 500) {
      //
      // } else {
      //   Fluttertoast.showToast(msg: 'Image size exceeds the limit of 500 KB');
      // }
    } else {
      Fluttertoast.showToast(msg: 'Image not selected');
    }
  }

  Future<void> pickvideogallary() async {
    XFile? Selectedvideo = await ImagePicker().pickVideo(
      source: ImageSource.gallery,
    );

    if (Selectedvideo != null) {
      File convertedFile = File(Selectedvideo.path);
      setState(() {
        video = convertedFile;
      });
      Get.back();

      Fluttertoast.showToast(msg: "video Selected");
    } else {
      Fluttertoast.showToast(msg: "video Not Selected");
    }
  }

  Future<void> pickvideocamera() async {
    XFile? Selectedvideo = await ImagePicker().pickVideo(
      source: ImageSource.camera,
    );

    if (Selectedvideo != null) {
      File convertedFile = File(Selectedvideo.path);
      setState(() {
        video = convertedFile;
      });
      Get.back();

      Fluttertoast.showToast(msg: "video Selected");
    } else {
      Fluttertoast.showToast(msg: "video Not Selected");
    }
  }

  // Future<void> pickImage() async {
  //   XFile? SelectedImage = await ImagePicker().pickImage(
  //     source: ImageSource.gallery,
  //     imageQuality: 85,
  //     maxHeight: 100,
  //     maxWidth: 100
  //   );
  //
  //   if (SelectedImage != null) {
  //     File convertedFile = File(SelectedImage.path);
  //     setState(() {
  //       imagepic = convertedFile;
  //     });
  //
  //     Fluttertoast.showToast(msg: "pick Image Successfully");
  //   } else {
  //     Fluttertoast.showToast(msg: "Image Not Selected");
  //   }
  // }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _selectedDate ?? DateTime.now(),
        firstDate: DateTime(1900, 8),
        lastDate: DateTime.now());
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  bool show = false;
  late GetHandlerList list;
  hand_list() async {
    Map<String, dynamic> parameters = {
      "apiKey": apikey,
      'device': '2',
      "city_id": widget.detail.profile.cityId,
      "first_name": widget.detail.profile.firstName,
      "last_name": widget.detail.profile.lastName,
      "customname":
          widget.detail.profile.firstName + widget.detail.profile.lastName
    };

    await get_handler_list(body: parameters).then((value) {
      print(jsonEncode(value));
      list = value;
      setState(() {
        show = true;
      });

      EasyLoading.dismiss();
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
    });
  }

  @override
  void initState() {
    log(widget.detail.profile.bloodGroup);

    if (widget.detail.profile.currentPkgId == '0') {
      hand_list();
    }
    firstnamecontoller.text = widget.detail.profile.firstName;
    middlenamecontoller.text = widget.detail.profile.middleName;
    lastnamecontoller.text = widget.detail.profile.lastName;
    shortnamecontoller.text = widget.detail.profile.shortName;
    physicallydetailscontoller.text = widget.detail.profile.physicalDetail;
    _selectedGender =
        widget.detail.profile.gender == 'Male' ? Gender.Male : Gender.Female;
    _selectedphycally = widget.detail.profile.isPhysicalChal;
    birthdatecontoller.text = widget.detail.profile.dateOfBirth;
    _bloodGroups.forEach((key, value) {
      if (value == widget.detail.profile.bloodGroup) {
        setState(() {
          selectedBlood = key;
        });
      }
    });
    // imagepic = File(widget.detail.profile.profilePic);
    super.initState();
  }

  TextEditingController firstnamecontoller = TextEditingController();
  TextEditingController middlenamecontoller = TextEditingController();
  TextEditingController lastnamecontoller = TextEditingController();
  TextEditingController shortnamecontoller = TextEditingController();
  TextEditingController bloodgroupcontoller = TextEditingController();
  TextEditingController birthdatecontoller = TextEditingController();
  TextEditingController physicallydetailscontoller = TextEditingController();

  Gender _selectedGender = Gender.Male;
  String _selectedphycally = "0";
  String? selectedBlood;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Map<String, String> _bloodGroups = {
    "1": "A",
    "2": "B",
    "3": "O",
    "4": "AB",
    "5": "A+",
    "6": "A-",
    "7": "B+",
    "8": "B-",
    "9": "O+",
    "10": "O-",
    "11": "AB+",
    "12": "AB-",
  };
  @override
  Widget build(BuildContext context) {
    birthdatecontoller.text = _selectedDate != null
        ? DateFormat('dd/MM/yyyy').format(_selectedDate!)
        : birthdatecontoller.text == ""
            ? "Select date of Birth"
            : birthdatecontoller.text;
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            show == true
                ? Card(
                    child: Container(
                        alignment: Alignment.center,
                        // height: 100,
                        width: screenwidth(context, dividedby: 1),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Reverse your Username Now! ',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.blue,
                                    fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Hey ${widget.detail.profile.firstName} ${widget.detail.profile.lastName} following username is available, ',
                                style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  const Text(
                                    'www.vakalat.com/',
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    list.customhandler.first.name,
                                    style: TextStyle(
                                        fontSize: 17,
                                        color: Colors.green.shade700,
                                        fontWeight: FontWeight.w600),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                'Click "Book Now"to continue with this username. Or click on "Search" to find other availabilities. ',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateColor.resolveWith(
                                                (states) => CustomColor()
                                                    .colorPrimary)),
                                    child: const Text('Search'),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          CupertinoPageRoute(
                                            builder: (context) =>
                                                Handler_Search(
                                                    value: list,
                                                    name: widget.detail.profile
                                                            .firstName +
                                                        widget.detail.profile
                                                            .lastName),
                                          ));
                                    },
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateColor.resolveWith(
                                                (states) =>
                                                    Colors.green.shade700)),
                                    child: const Text('Book Now'),
                                    onPressed: () async {
                                      EasyLoading.show(status: "Loading...");
                                      Map<String, dynamic> parameters = {
                                        "apiKey": apikey,
                                        'device': '2',
                                        "user_type_id":
                                            logindetails.userData.userType,
                                      };
                                      await GetUserpackages(body: parameters)
                                          .then((value) {
                                        if (value.packages.isNotEmpty) {
                                          Navigator.push(
                                              context,
                                              CupertinoPageRoute(
                                                builder: (context) =>
                                                    Cart_Screen(
                                                        name: list.customhandler
                                                            .first.name,
                                                        packages: value),
                                              ));
                                        } else {
                                          ToastMessage().showmessage(
                                              'Do Not Have Any Packages');
                                        }

                                        // packages = value;
                                        // setState(() {
                                        //   show = true;
                                        // });
                                        EasyLoading.dismiss();
                                        log(jsonEncode(value));
                                      }).onError((error, stackTrace) {
                                        EasyLoading.dismiss();
                                      });
                                    },
                                  ),
                                ],
                              )
                            ],
                          ),
                        )),
                  )
                : SizedBox(),
            Padding(
              padding: const EdgeInsets.only(left: 10, bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      imagesheet(context, () {
                        pickImagecamera();
                      }, () {
                        pickImage();
                      });
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
            const Text("Image should not exceed 500KB."),
            CustomTextfield(
              labelname: 'First Name',
              Controller: firstnamecontoller,
              validator: (p0) {
                if (p0!.isEmpty) {
                  return 'Plz Enter First Name';
                }
                return null;
              },
            ),
            CustomTextfield(
              labelname: 'Middle Name',
              Controller: middlenamecontoller,
              validator: (p0) {
                if (p0!.isEmpty) {
                  return 'Plz Enter Middle Name';
                }
                return null;
              },
            ),
            CustomTextfield(
              labelname: 'Last Name',
              Controller: lastnamecontoller,
              validator: (p0) {
                if (p0!.isEmpty) {
                  return 'Plz Enter Last Name';
                }
                return null;
              },
            ),
            CustomTextfield(
              labelname: 'Short Name',
              Controller: shortnamecontoller,
              // validator: (p0) {
              //   if (p0!.isEmpty) {
              //     return 'Plz Enter Short Name';
              //   }
              //   return null;
              // },
            ),
            // Padding(
            //   padding:
            //       const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
            //   child: InkWell(
            //     onTap: () =>,
            //     child: Container(
            //       height: 50,
            //       width: screenwidth(context, dividedby: 1),
            //       decoration: Const().decorationfield,
            //       child: Padding(
            //         padding: const EdgeInsets.all(10.0),
            //         child: Row(
            //           crossAxisAlignment: CrossAxisAlignment.center,
            //           children: [
            //             Text(
            //               formattedDate.toString(),
            //               style: const TextStyle(
            //                   fontSize: 16, color: Colors.black54),
            //             ),
            //           ],
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            // CustomTextfield(labelname: 'Select D0B',),
            CustomTextfield(
              type: TextInputType.none,
              labelname: 'Date Of Birth',
              Controller: birthdatecontoller,
              ontap: () => _selectDate(context),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Blood Group",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: 50,
                    width: screenwidth(context, dividedby: 1),
                    decoration: Const().decorationfield,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButton<String>(
                        isDense: true,
                        underline: Container(
                          color: Colors.transparent,
                        ),
                        hint: Text("Select Blood Group"),
                        value: selectedBlood,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedBlood = newValue;
                          });
                        },
                        items: _bloodGroups.entries.map((entry) {
                          return DropdownMenuItem<String>(
                            value: entry.key,
                            child: Text(entry.value),
                          );
                        }).toList(),
                        isExpanded: true,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Video Profile",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: 50,
                    width: screenwidth(context, dividedby: 1),
                    decoration: Const().decorationfield,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: screenwidth(context, dividedby: 2),
                            child: Text(
                              widget.detail.profile.videoProfile.isNotEmpty
                                  ? widget.detail.profile.videoProfile
                                  : 'Upload Video/Watch Video ',
                              style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 16,
                                  color: Colors.black54),
                            ),
                          ),
                          Card(
                              color: Colors.blue,
                              child: Row(
                                children: [
                                  MaterialButton(
                                    onPressed: () {
                                      imagesheet(
                                        context,
                                        () {
                                          pickvideocamera();
                                        },
                                        () {
                                          pickvideogallary();
                                        },
                                      );
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
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (context) => Playing_Video(
                                            video: widget
                                                .detail.profile.videoProfile),
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
                ],
              ),
            ),
            // CustomTextfield(labelname: 'Video Profile',),

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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'IS Physically Challenged? :',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      Row(
                        children: [
                          Radio(
                            value: "1",
                            groupValue: _selectedphycally,
                            onChanged: (var value) {
                              setState(() {
                                _selectedphycally = value!;
                              });
                            },
                          ),
                          const Text('Yes'),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Radio(
                            value: "0",
                            groupValue: _selectedphycally,
                            onChanged: (var value) {
                              setState(() {
                                _selectedphycally = value!;
                                physicallydetailscontoller.clear();
                              });
                            },
                          ),
                          const Text('No'),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
            _selectedphycally != "0"
                ? CustomTextfield(
                    Controller: physicallydetailscontoller,
                    labelname: 'Physically Challange Details',
                  )
                : const SizedBox(),
            const SizedBox(
              height: 10,
            ),
            Button_For_Update_Save(
              text: 'Update',
              onpressed: () {
                if (_formKey.currentState!.validate()) {
                  if (birthdatecontoller.text.isNotEmpty) {
                    personal_details.call();
                  } else {
                    ToastMessage().showmessage('Please Select Date of Birth');
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
    if (_selectedDate != null) {
      birthdatecontoller.text = DateFormat('yyyy-MM-dd').format(_selectedDate!);
    }
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
      dateOfBirth: birthdatecontoller.text,
      gender: _selectedGender.name,
      bloodGroup: selectedBlood,
      isPhysicalChal: _selectedphycally,
      isPhysicaldet: physicallydetailscontoller.text,
      videoProfile: video?.path,
      organization: '',
      since: '',
      logo: '',
      profile: imagepic?.path,
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

  @override
  void dispose() {
    // TODO: implement dispose
    firstnamecontoller.dispose();
    middlenamecontoller.dispose();
    shortnamecontoller.dispose();
    lastnamecontoller.dispose();
    super.dispose();
  }
}
