import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:vakalat_flutter/model/UpdateContactDetails.dart';
import '../../../Sharedpref/shared_pref.dart';
import '../../../api/postapi.dart';
import '../../../model/Get_Profile.dart';
import '../../../model/clsCitiesResponseModel.dart';
import '../../../model/clsCountriesResponseModel.dart';
import '../../../model/clsLoginResponseModel.dart';
import '../../../model/clsStateResponseModel.dart';
import '../../../utils/ToastMessage.dart';
import '../../../utils/constant.dart';
import '../../../utils/design.dart';
import 'getxcontroller.dart';

class Contact_Details extends StatefulWidget {
  const Contact_Details({Key? key, required this.detail}) : super(key: key);
  final GetProfileModel detail;

  @override
  State<Contact_Details> createState() => _Contact_DetailsState();
}

class _Contact_DetailsState extends State<Contact_Details> {
  final ProfileControl getxController = Get.put(ProfileControl());

  TextEditingController mobilecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController homeadresscontroller = TextEditingController();
  TextEditingController homepincodecontroller = TextEditingController();
  TextEditingController officephonenocotoller = TextEditingController();
  TextEditingController officepincodecontroller = TextEditingController();
  TextEditingController officeaddresscontroller = TextEditingController();

  bool isdisplayweb = true;
  bool show = false;
  bool _isLoading = false;
  String countriecode_home = '101';
  String rajyacode_home = '';
  String citicode_home = '';
  String countriecode_office = '101';
  String rajyacode_office = '';
  String citicode_office = '';
  @override
  void initState() {
    mobilecontroller.text = widget.detail.profile.mobile;
    emailcontroller.text = widget.detail.profile.email;
    homeadresscontroller.text = widget.detail.profile.address;
    homepincodecontroller.text = widget.detail.profile.pincode;
    officephonenocotoller.text = widget.detail.profile.companyMobile;
    officepincodecontroller.text = widget.detail.profile.officePincode;
    officeaddresscontroller.text = widget.detail.profile.officeAddress;
    countriecode_home = widget.detail.profile.countryId;
    rajyacode_home = widget.detail.profile.stateId;
    citicode_home = widget.detail.profile.cityId;
    countriecode_office = widget.detail.profile.officeCountryId;
    rajyacode_office = widget.detail.profile.officeStateId;
    citicode_office = widget.detail.profile.officeCityId;
    isdisplayweb = widget.detail.profile.isDisplayWeb == "1" ? true : false;
    // getxController.stateApi_office(value: widget.detail.profile.countryId);
    super.initState();
  }

  final RegExp _emailRegExp = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextfield(
              labelname: ' Email',
              Controller: emailcontroller,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your email address';
                } else if (!_emailRegExp.hasMatch(value)) {
                  return 'Please enter a valid email address';
                }
                return null;
              },
            ),
            CustomTextfield(
                Controller: mobilecontroller,
                labelname: 'Mobile',
                type: TextInputType.number,
                validator: (p0) {
                  if (p0!.isEmpty && p0.length == 10) {
                    return 'Plz Enter Phone Number';
                  }
                  return null;
                },
                maxlength: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Display Mobile No To Public Profile?",  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                  Switch(
                    value: isdisplayweb,
                    onChanged: (value) {
                      setState(() {
                        isdisplayweb = !isdisplayweb;
                      });
                    },
                  )
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                'Home Details',
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue),
              ),
            ),
            CustomTextfield(
              labelname: ' Home Address',
              validator: (p0) {
                if (p0!.isEmpty) {
                  return 'Plz Enter Home Address';
                }
                return null;
              },
              Controller: homeadresscontroller,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
              child: Column(
                children: [
                  CustomDropDownCountry(
                    onSelection: (var value) async {
                      log(value.toString());
                      countriecode_home = value.toString();
                      getxController.rajyaBuilder.value = [];
                      getxController.citiesBuilder.value = [];
                      EasyLoading.show(status: "Loading...");
                      getxController.stateApi(value: value);
                    },
                    initialValue: widget.detail.profile.countryId,
                    country: getxController.getcountries.countries,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ValueListenableBuilder(
                      valueListenable: getxController.rajyaBuilder,
                      builder: (context, value, child) => value.isNotEmpty ||
                              widget.detail.profile.stateId.isNotEmpty
                          ? CustomDropDownState(
                              raja: value,
                              initialValue: widget.detail.profile.stateId,
                              onSelection: (p0) async {
                                rajyacode_home = p0.toString();
                                getxController.citiesBuilder.value = [];
                                getxController.cityApi(value: p0);
                              },
                            )
                          : SizedBox.shrink()),
                  const SizedBox(
                    height: 10,
                  ),
                  ValueListenableBuilder(
                    valueListenable: getxController.citiesBuilder,
                    builder: (context, value, child) => value.isNotEmpty ||
                            widget.detail.profile.cityId.isNotEmpty
                        ? CustomDropCities(
                            citi: value,
                            initialValue: widget.detail.profile.cityId,
                            onSelection: (p0) {
                              citicode_home = p0.toString();
                            },
                          )
                        : SizedBox.shrink(),
                  ),
                ],
              ),
            ),
            // SelectState(
            //   onCountryChanged: (String value) {},
            //   onStateChanged: (String value) {},
            //   onCityChanged: (String value) {},
            // ),
            CustomTextfield(
              labelname: 'Pincode',
              type: TextInputType.number,
              validator: (p0) {
                if (p0!.isEmpty) {
                  return 'Plz Enter Pincode';
                }
                return null;
              },
              Controller: homepincodecontroller,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                'Office Details',
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue),
              ),
            ),
            CustomTextfield(
                labelname: 'Office Contact No',
                validator: (p0) {
                  if (p0!.isEmpty && p0.length == 10) {
                    return 'Plz  Contact No';
                  }
                  return null;
                },
                maxlength: 10,
                Controller: officephonenocotoller,
                type: TextInputType.number),
            CustomTextfield(
              labelname: 'Enter Office Address',
              validator: (p0) {
                if (p0!.isEmpty) {
                  return 'Plz Enter Office address';
                }
                return null;
              },
              Controller: officeaddresscontroller,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
              child: Column(
                children: [
                  CustomDropDownCountry(
                    initialValue: widget.detail.profile.officeCountryId == "0"
                        ? "101"
                        : widget.detail.profile.officeCountryId,
                    onSelection: (var value) async {
                      log(value.toString());
                      countriecode_office = value.toString();
                      getxController.rajyaBuilder_office.value = [];
                      getxController.citiesBuilder_office.value = [];
                      getxController.stateApi_office(value: value);
                    },
                    country: getxController.getcountries.countries,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ValueListenableBuilder(
                    valueListenable: getxController.rajyaBuilder_office,
                    builder: (context, value, child) => value.isNotEmpty ||
                            widget.detail.profile.officeStateId.isNotEmpty
                        ? CustomDropDownState(
                            initialValue: widget.detail.profile.officeStateId,
                            raja: value,
                            onSelection: (p0) async {
                              rajyacode_office = p0.toString();
                              getxController.citiesBuilder_office.value = [];
                              getxController.cityApi_office(value: p0);
                            },
                          )
                        : const SizedBox.shrink(),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ValueListenableBuilder(
                    valueListenable: getxController.citiesBuilder_office,
                    builder: (context, value, child) => value.isNotEmpty ||
                            widget.detail.profile.officeCityId.isNotEmpty
                        ? CustomDropCities(
                            initialValue: widget.detail.profile.officeCityId,
                            citi: value,
                            onSelection: (p0) {
                              citicode_office = p0.toString();
                            },
                          )
                        : const SizedBox.shrink(),
                  ),
                ],
              ),
            ),
            // SelectState(
            //   onCountryChanged: (String value) {},
            //   onStateChanged: (String value) {},
            //   onCityChanged: (String value) {},
            // ),
            CustomTextfield(
              labelname: 'Office pincode',
              validator: (p0) {
                if (p0!.isEmpty) {
                  return 'Plz Enter pincode';
                }
                return null;
              },
              type: TextInputType.number,
              Controller: officepincodecontroller,
            ),
            Button_For_Update_Save(
              text: 'Update',
              onpressed: () {
                APICALL_Update_Contect_Details.call();
              },
            ),
          ],
        ),
      ),
    );
  }

  Future APICALL_Update_Contect_Details() async {
    if (countriecode_home.isNotEmpty &&
        rajyacode_home.isNotEmpty &&
        citicode_home.isNotEmpty) {
      EasyLoading.show(status: 'Loading...');

      try {
        /*Retriving Parent Object*/
        ClsLoginResponseModel logindetails = clsLoginResponseModelFromJson(
            SharedPref.get(prefKey: PrefKey.loginDetails)!);

        Map<String, dynamic> parameters = {
          "apiKey": apikey,
          'device': '2',
          "accessToken": logindetails.accessToken,
          "user_id": logindetails.userData.userId,
          "mobile": mobilecontroller.text,
          "email": emailcontroller.text,
          "address": homeadresscontroller.text,
          "pincode": homepincodecontroller.text,
          "office_address": officeaddresscontroller.text,
          // "gender": _selectedGender.toString(),
          "company_mobile": officephonenocotoller.text,
          // "is_physical_chal": _selectedphycally.toString(),
          "country_id": countriecode_home,
          "state_id": rajyacode_home,
          "city_id": citicode_home,
          "ofc_country_id": countriecode_office,
          "ofc_state_id": rajyacode_office,
          "ofc_city_id": citicode_office,
          "ofc_pincode": officepincodecontroller.text,
          "is_display_web": isdisplayweb == true ? "1" : "0"
        };

        ClsUpdateContactResponseModel userResponseModel =
            await Update_Contect_Details(body: parameters);

        // Mounted is for disposing the calling of Api if User click back button
        if (!mounted) {
          return;
        }

        if (userResponseModel.status == 1) {
          ToastMessage().showmessage(userResponseModel.message);
          setState(() {});

          EasyLoading.dismiss();
          // Const.currentUser = userResponseModel.Data!;

          // APICALL_RegisterDevice(userResponseModel);
          // gotoHomePage();
          // await SharedPref.save(
          //     value: userResponseModel.toString(),
          //     prefKey: PrefKey.loginDetails);
        } else {
          setState(() {
            _isLoading = false;
          });
          EasyLoading.dismiss();
          ToastMessage().showmessage(userResponseModel.message);
        }
      } catch (exception) {
        EasyLoading.dismiss();
        setState(
          () {
            _isLoading = false;
          },
        );
        EasyLoading.dismiss();

        ToastMessage().showmessage(exception.toString());
      }
    } else {
      ToastMessage().showmessage('Plz Select Country,state And city');
    }
  }
}
