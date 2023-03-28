import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
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

class Contact_Details extends StatefulWidget {
  const Contact_Details({Key? key, required this.detail}) : super(key: key);
  final GetProfileModel detail;

  @override
  State<Contact_Details> createState() => _Contact_DetailsState();
}

class _Contact_DetailsState extends State<Contact_Details> {
  TextEditingController mobilecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController homeadresscontroller = TextEditingController();
  TextEditingController homepincodecontroller = TextEditingController();
  TextEditingController officephonenocotoller = TextEditingController();
  TextEditingController officepincodecontroller = TextEditingController();
  TextEditingController officeaddresscontroller = TextEditingController();
  late ClsCountriesResponseModel getcountries;
  bool show = false;
  bool _isLoading = false;
  String countriecode_home = '';
  String rajyacode_home = '';
  String citicode_home = '';
  String countriecode_office = '';
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
    countrypostapi();
    if (widget.detail.profile.cityId.isNotEmpty &&
        widget.detail.profile.stateId.isNotEmpty) {
      stateApi(value: widget.detail.profile.countryId);
      stateApi_office(value: widget.detail.profile.officeCountryId);
      cityApi(value: widget.detail.profile.stateId);
      cityApi_office(value: widget.detail.profile.officeStateId);

    }
    super.initState();
  }


  void countrypostapi() async {
    Map<String, dynamic> parameters = {
      "apiKey": apikey,
      'device': '2',
    };
    EasyLoading.show(status: 'loading...');
    await userCountries(body: parameters).then((value) {
      setState(() {
        getcountries = value;
        show = true;
      });
      EasyLoading.dismiss();
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
    });
  }

  void stateApi({String? value = ''}) async {
    EasyLoading.show(status: 'loading...');

    Map<String, dynamic> parameters = {
      "apiKey": apikey,
      'device': '2',
      "country_id": value ?? '',
    };
    await userStates(body: parameters).then((value) {
      EasyLoading.dismiss();
      rajyaBuilder.value = value.states;
      setState(() {});
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
    });
  }
  void stateApi_office({String? value = ''}) async {
    EasyLoading.show(status: 'loading...');

    Map<String, dynamic> parameters = {
      "apiKey": apikey,
      'device': '2',
      "country_id": value ?? '',
    };
    await userStates(body: parameters).then((value) {
      EasyLoading.dismiss();
      rajyaBuilder_office.value = value.states;
      setState(() {});
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
    });
  }

  void cityApi({String? value = ''}) async {
    EasyLoading.show(status: 'loading...');

    Map<String, dynamic> parameters = {
      "apiKey": apikey,
      'device': '2',
      "state_id": value ?? "",
    };

    await userCities(body: parameters).then((value) {

      EasyLoading.dismiss();
      citiesBuilder.value = value.cities;
      setState(() {});
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
    });
  }
  void cityApi_office({String? value = ''}) async {
    EasyLoading.show(status: 'loading...');

    Map<String, dynamic> parameters = {
      "apiKey": apikey,
      'device': '2',
      "state_id": value ?? "",
    };

    await userCities(body: parameters).then((value) {
      EasyLoading.dismiss();
      citiesBuilder_office.value = value.cities;
      setState(() {});
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
    });
  }

  ValueNotifier<List<Rajya>> rajyaBuilder = ValueNotifier([]);
  ValueNotifier<List<Rajya>> rajyaBuilder_office = ValueNotifier([]);
  ValueNotifier<List<City>> citiesBuilder = ValueNotifier([]);
  ValueNotifier<List<City>> citiesBuilder_office = ValueNotifier([]);
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
              labelname: 'Enter Email',
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
              labelname: 'Enter Home Address',
              validator: (p0) {
                if (p0!.isEmpty) {
                  return 'Plz Enter Home Address';
                }
                return null;
              },
              Controller: homeadresscontroller,
            ),
            show == false
                ? const SizedBox()
                : Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 10),
                    child: Column(
                      children: [
                        CustomDropDownCountry(
                          onSelection: (var value) async {
                            log(value.toString());
                            countriecode_home = value.toString();
                            rajyaBuilder.value = [];
                            citiesBuilder.value = [];
                            EasyLoading.show(status: "Loading...");
                            stateApi(value: value);
                          },
                          initialValue: widget.detail.profile.countryId,
                          country: getcountries.countries,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ValueListenableBuilder(
                            valueListenable: rajyaBuilder,
                            builder: (context, value, child) => value
                                        .isNotEmpty ||
                                    widget.detail.profile.stateId.isNotEmpty
                                ? CustomDropDownState(
                                    raja: value,
                                    initialValue: widget.detail.profile.stateId,
                                    onSelection: (p0) async {
                                      rajyacode_home = p0.toString();
                                      citiesBuilder.value = [];
                                      cityApi(value: p0);
                                    },
                                  )
                                : SizedBox.shrink()),
                        const SizedBox(
                          height: 20,
                        ),
                        ValueListenableBuilder(
                          valueListenable: citiesBuilder,
                          builder: (context, value, child) =>
                              value.isNotEmpty ||
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
                    return 'Plz Enter Contact No';
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
            show == false
                ? const SizedBox()
                : Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 10),
                    child: Column(
                      children: [
                        CustomDropDownCountry(
                          initialValue: widget.detail.profile.officeCountryId,
                          onSelection: (var value) async {
                            log(value.toString());
                            countriecode_office = value.toString();
                            rajyaBuilder_office.value = [];
                            citiesBuilder_office.value = [];
                            stateApi_office(value: value);
                          },
                          country: getcountries.countries,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ValueListenableBuilder(
                          valueListenable: rajyaBuilder_office,
                          builder: (context, value, child) => value
                                      .isNotEmpty ||
                                  widget.detail.profile.officeStateId.isNotEmpty
                              ? CustomDropDownState(
                                  initialValue:
                                      widget.detail.profile.officeStateId,
                                  raja: value,
                                  onSelection: (p0) async {
                                    rajyacode_office = p0.toString();
                                    citiesBuilder_office.value = [];
                                    cityApi_office(value: p0);
                                  },
                                )
                              : const SizedBox.shrink(),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ValueListenableBuilder(
                          valueListenable: citiesBuilder_office,
                          builder: (context, value, child) => value
                                      .isNotEmpty ||
                                  widget.detail.profile.officeCityId.isNotEmpty
                              ? CustomDropCities(
                                  initialValue:
                                      widget.detail.profile.officeCityId,
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
                if (_formKey.currentState!.validate()) {
                  APICALL_Update_Contect_Details.call();
                }
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
      EasyLoading.show(status: 'loading...');

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

          "is_display_web": ""
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
