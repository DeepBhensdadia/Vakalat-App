import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:vakalat_flutter/utils/design.dart';

import '../../api/postapi.dart';
import '../../color/customcolor.dart';
import '../../model/clsCitiesResponseModel.dart';
import '../../model/clsCountriesResponseModel.dart';
import '../../model/clsStateResponseModel.dart';
import '../../utils/constant.dart';

enum Gender { Male, Female }

class Add_Client_Management extends StatefulWidget {
  const Add_Client_Management({Key? key}) : super(key: key);

  @override
  State<Add_Client_Management> createState() => _Add_Client_ManagementState();
}

class _Add_Client_ManagementState extends State<Add_Client_Management> {
  Gender _selectedGender = Gender.Male;
  late ClsCountriesResponseModel getcountries;
  ValueNotifier<List<Rajya>> rajyaBuilder = ValueNotifier([]);
  ValueNotifier<List<City>> citiesBuilder = ValueNotifier([]);
  bool show = false;
  String countriecode_home = '';
  String rajyacode_home = '';
  String citicode_home = '';

  void countrypostapi() async {
    Map<String, dynamic> parameters = {
      "apiKey": apikey,
      'device': '2',
    };
    EasyLoading.show(status: 'Loading...');
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
    EasyLoading.show(status: 'Loading...');

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

  void cityApi({String? value = ''}) async {
    EasyLoading.show(status: 'Loading...');

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

  @override
  void initState() {
    // TODO: implement initState
    countrypostapi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Client Management',
          style: TextStyle(
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        backgroundColor: CustomColor().colorPrimary,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomTextfield(labelname: 'User Type'),
            CustomTextfield(labelname: 'First Name'),
            CustomTextfield(labelname: 'Last Name'),
            CustomTextfield(labelname: 'Email'),
            CustomTextfield(labelname: 'Mobile'),
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
                          // initialValue: widget.detail.profile.countryId,
                          country: getcountries.countries,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ValueListenableBuilder(
                            valueListenable: rajyaBuilder,
                            builder: (context, value, child) =>
                                CustomDropDownState(
                                  raja: value,
                                  // initialValue: widget.detail.profile.stateId,
                                  onSelection: (p0) async {
                                    rajyacode_home = p0.toString();
                                    citiesBuilder.value = [];
                                    cityApi(value: p0);
                                  },
                                )
                            //     value
                            //         .isNotEmpty
                            //         ?
                            //         : SizedBox.shrink()
                            ),
                        const SizedBox(
                          height: 20,
                        ),
                        ValueListenableBuilder(
                            valueListenable: citiesBuilder,
                            builder: (context, value, child) =>
                                CustomDropCities(
                                  citi: value,
                                  // initialValue: widget.detail.profile.cityId,
                                  onSelection: (p0) {
                                    citicode_home = p0.toString();
                                  },
                                )
                            // value.isNotEmpty
                            //
                            //     ?
                            //     : SizedBox.shrink(),

                            ),
                      ],
                    ),
                  ),
            Button_For_Update_Save(
              text: 'Update',
              onpressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
