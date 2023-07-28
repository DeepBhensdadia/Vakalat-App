import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:vakalat_flutter/New%20UI/login.dart';

import '../../../Sharedpref/shared_pref.dart';
import '../../../api/postapi.dart';
import '../../../model/Bar Associate List.dart';
import '../../../model/DeleteServicesModel.dart';
import '../../../model/GetAllCategory.dart';
import '../../../model/GetDashboard.dart';
import '../../../model/GetHandlerList.dart';
import '../../../model/Get_Profile.dart';
import '../../../model/clsCitiesResponseModel.dart';
import '../../../model/clsCountriesResponseModel.dart';
import '../../../model/clsLoginResponseModel.dart';
import '../../../model/clsStateResponseModel.dart';
import '../../../model/getAchivements.dart';
import '../../../model/getParticipation.dart';
import '../../../model/getallLanguage.dart';
import '../../../model/getbar_councilModel.dart';
import '../../../model/getdocumentdetails.dart';
import '../../../model/getdrawermenu.dart';
import '../../../model/viewcartmodel.dart';
import '../../../pages/dashboard.dart';
import '../../../utils/ToastMessage.dart';
import '../../../utils/constant.dart';
import '../../Dashboard_screens/Dashboard_Screen.dart';
import '../../handler_search/Cart.dart';
import '../../handler_search/payment.dart';
import '../Achivement/Achivement.dart';
import '../Participation/Participation.dart';

class ProfileControl extends GetxController {
  ClsLoginResponseModel? logindetails =
      SharedPref.get(prefKey: PrefKey.loginDetails) != null
          ? clsLoginResponseModelFromJson(
              SharedPref.get(prefKey: PrefKey.loginDetails)!)
          : null;
  GetProfileModel? getprofile =SharedPref.get(prefKey: PrefKey.getProfile)!=null?
      getProfileModelFromJson(SharedPref.get(prefKey: PrefKey.getProfile)!):null;

  late GetProfileModel detail;
  late Getdrawermenu getmenu;
  late GetAllCategory allcategori;
  late Getalllanguage language;
  late Viewcartmodel cartdetails;
  late ClsCountriesResponseModel getcountries;
  late GetHandlerList list;
  late Getdocumentdetails doctype;

  // late GetAchivements achivement;
  RxList<Achievement> achievements = <Achievement>[].obs;
  RxList<Participation> participations = <Participation>[].obs;



  ValueNotifier<List<Rajya>> rajyaBuilder = ValueNotifier([]);
  ValueNotifier<List<Rajya>> rajyaBuilder_office = ValueNotifier([]);
  ValueNotifier<List<City>> citiesBuilder = ValueNotifier([]);
  ValueNotifier<List<City>> citiesBuilder_office = ValueNotifier([]);
  ValueNotifier<List<BarCouncil>> council_builder = ValueNotifier([]);
  ValueNotifier<List<BarAssoc>> association_builder = ValueNotifier([]);

  countrypostapi() async {
    Map<String, dynamic> parameters = {
      "apiKey": apikey,
      'device': '2',
      "user_id": logindetails!.userData.userId
    };
    EasyLoading.show(status: 'Loading...');
    await get_profile(body: parameters).then((value) async {
      await SharedPref.deleteSpecific(prefKey: PrefKey.getProfile);
      await SharedPref.save(
          value: jsonEncode(value.toJson()), prefKey: PrefKey.getProfile);
      detail = value;
      //
      // setState(() {
      //
      //   // show = true;
      //   // print(jsonEncode(value));
      // });
      EasyLoading.dismiss();
    }).onError((error, stackTrace) {
      print(error);
      EasyLoading.dismiss();
    });
  }

  countryp() async {
    Map<String, dynamic> parameters = {
      "apiKey": apikey,
      'device': '2',
    };
    EasyLoading.show(status: 'Loading...');
    await userCountries(body: parameters).then((value) async {
      getcountries = value;

      // setState(() {
      //   show = true;
      // });
      EasyLoading.dismiss();
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
    });
  }

  stateApi({String? value = ''}) async {
    EasyLoading.show(status: 'Loading...');

    Map<String, dynamic> parameters = {
      "apiKey": apikey,
      'device': '2',
      "country_id": value ?? '',
    };
    await userStates(body: parameters).then((value) {
      EasyLoading.dismiss();
      rajyaBuilder.value = value.states;
      // setState(() {});
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
    });
  }

  void stateApi_office({String? value = ''}) async {
    EasyLoading.show(status: 'Loading...');

    Map<String, dynamic> parameters = {
      "apiKey": apikey,
      'device': '2',
      "country_id": value ?? '',
    };
    await userStates(body: parameters).then((value) {
      EasyLoading.dismiss();
      rajyaBuilder_office.value = value.states;
      // setState(() {});
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
      // ToastMessage().showmessage(value.message);

      EasyLoading.dismiss();
      citiesBuilder.value = value.cities;
      // setState(() {});
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
    });
  }

  void cityApi_office({String? value = ''}) async {
    EasyLoading.show(status: 'Loading...');

    Map<String, dynamic> parameters = {
      "apiKey": apikey,
      'device': '2',
      "state_id": value ?? "",
    };

    await userCities(body: parameters).then((value) {
      EasyLoading.dismiss();
      citiesBuilder_office.value = value.cities;
      // ToastMessage().showmessage(value.message);
      // setState(() {});
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
    });
  }

  void bar_council() async {
    EasyLoading.show(status: 'Loading...');

    Map<String, dynamic> parameters = {
      "apiKey": apikey,
      'device': '2',
    };
    await get_bar_council(body: parameters).then((value) {
      EasyLoading.dismiss();
      // ToastMessage().showmessage(value.message);
      council_builder.value = value.barCouncils;
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
    });
  }

  void bar_associasion() async {
    EasyLoading.show(status: 'Loading...');
    Map<String, dynamic> parameters = {
      "apiKey": apikey,
      'device': '2',
    };
    await get_bar_Association(body: parameters).then((value) {
      EasyLoading.dismiss();
      // ToastMessage().showmessage(value.message);

      association_builder.value = value.barAssoc;
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
    });
  }

  void categorypostapi() async {
    Map<String, dynamic> parameters = {
      "apiKey": apikey,
      'device': '2',
    };
    EasyLoading.show(status: 'Loading...');
    await All_Categories(body: parameters).then((value) {
      allcategori = value;

      // setState(() {
      //   show = true;
      // });
      // ToastMessage().showmessage(value.message);

      EasyLoading.dismiss();
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
    });
  }

  void languages() async {
    Map<String, dynamic> parameters = {
      "apiKey": apikey,
      'device': '2',
    };
    EasyLoading.show(status: 'Loading...');
    await Getalllanguages(body: parameters).then((value) {
      language = value;

      // setState(() {
      //   show = true;
      // });
      ToastMessage().showmessage(value.message);

      EasyLoading.dismiss();
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
    });
  }

  viewcart(String code, String cashcode, context) async {
    Map<String, dynamic> parameters = {
      "apiKey": apikey,
      'device': '2',
      "accessToken": logindetails!.accessToken,
      "user_id": logindetails!.userData.userId,
      "csrf_token": "",
      "code": code,
      "cash_code": cashcode,
      // "page_no": "1",
    };
    EasyLoading.show(status: 'Loading...');
    await View_cart(body: parameters).then((value) {
      cartdetails = value;
      Navigator.pop(
          context,
          MaterialPageRoute(
            builder: (context) => Payment_Screen(),
          ));
      ToastMessage().showmessage(value.total.first.cashcodemessage);
      EasyLoading.dismiss();
    }).onError((error, stackTrace) {
      print(error);
      EasyLoading.dismiss();
    });
  }

  deletediscount(String code, String cashcode, context) async {
    Map<String, dynamic> parameters = {
      "apiKey": apikey,
      'device': '2',
      "accessToken": logindetails!.accessToken,
      "user_id": logindetails!.userData.userId,
      "csrf_token": "",
      "code": code,
      "cash_code": cashcode,
      // "page_no": "1",
    };
    EasyLoading.show(status: 'Loading...');
    await View_cart(body: parameters).then((value) {
      cartdetails = value;
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Payment_Screen(),
          ));
      EasyLoading.dismiss();
    }).onError((error, stackTrace) {
      print(error);
      EasyLoading.dismiss();
    });
  }

  viewcartfor1(context) async {
    Map<String, dynamic> parameters = {
      "apiKey": apikey,
      'device': '2',
      "accessToken": logindetails!.accessToken,
      "user_id": logindetails!.userData.userId,
      "csrf_token": "",
      "code": '',
      "cash_code": '',
    };
    EasyLoading.show(status: 'Loading...');
    await View_cart(body: parameters).then((value) {
      cartdetails = value;
      Get.to(Payment_Screen());
      EasyLoading.dismiss();
    }).onError((error, stackTrace) {
      print(error);
      EasyLoading.dismiss();
    });
  }

  get_drawer_menu(String value) async {
    if (logindetails!.userData.userId.isNotEmpty) {
      Map<String, dynamic> parameters = {
        "apiKey": apikey,
        'device': '2',
        'accessToken': logindetails!.accessToken,
        'csrf_token': '',
        'user_id': logindetails!.userData.userId,
        'user_type': logindetails!.userData.userType,
        'current_pkg_id': value,
      };
      EasyLoading.show(status: 'Loading...');
      await getdrawermenu(body: parameters).then((value) async {
        getmenu = value;

        EasyLoading.dismiss();
      }).onError((error, stackTrace) {
        ToastMessage().showmessage(error.toString());
        print(error);
        EasyLoading.dismiss();
      });
    }
  }

  get_doc_type() async {
    if (logindetails!.userData.userId.isNotEmpty) {
      Map<String, dynamic> parameters = {
        "apiKey": apikey,
        'device': '2',
        'accessToken': logindetails!.accessToken,
        'csrf_token': '',
      };
      EasyLoading.show(status: 'Loading...');
      await getdoctype(body: parameters).then((value) async {
        doctype = value;
        log(jsonEncode(value.toString()));
        EasyLoading.dismiss();
      }).onError((error, stackTrace) {
        ToastMessage().showmessage(error.toString());
        print(error);
        EasyLoading.dismiss();
      });
    }
  }

  hand_list(context) async {
    print('mmmmmmmmmmmmmmmmmmmmmmmmmm');
    EasyLoading.show(status: "Loading...");
    Map<String, dynamic> parameters = {
      "apiKey": apikey,
      'device': '2',
      "city_id": getprofile!.profile.cityId,
      "first_name": getprofile!.profile.firstName,
      "last_name": getprofile!.profile.lastName,
      "customname": getprofile!.profile.firstName + getprofile!.profile.lastName
    };

    await get_handler_list(body: parameters).then((value) async {
      print(jsonEncode(value));
      list = value;
      Map<String, dynamic> parameters = {
        "apiKey": apikey,
        'device': '2',
        "user_type_id": logindetails!.userData.userType,
      };
      await GetUserpackages(body: parameters).then((value) {
        if (value.packages.isNotEmpty) {
          Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => Cart_Screen(
                    name: list.customhandler.first.name, packages: value),
              ));
        } else {
          ToastMessage().showmessage('Do Not Have Any Packages');
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
      EasyLoading.dismiss();
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
    });
  }

  Future<void> get_Achivement_dep(context) async {
    Map<String, dynamic> parameters = {
      "apiKey": apikey,
      'device': '2',
      "accessToken": logindetails!.accessToken,
      "user_id": logindetails!.userData.userId,
      "csrf_token": "",
      "page_no": "1",
    };
    EasyLoading.show(status: 'Loading...');
    await get_Achivement(body: parameters).then((value) {
      achievements.value = value.achievements;
      EasyLoading.dismiss();
      Get.to(() => Achivement_Screen());
      log(value.toString());
    }).onError((error, stackTrace) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => DashboardPage(title: ''),
          ));
      Const().deleteprofilelofinandmenu();
      msgexpire;
      print(error);
      EasyLoading.dismiss();
    });
  }

  Future<void> get_Achivement_dep2(context) async {
    Map<String, dynamic> parameters = {
      "apiKey": apikey,
      'device': '2',
      "accessToken": logindetails!.accessToken,
      "user_id": logindetails!.userData.userId,
      "csrf_token": "",
      "page_no": "1",
    };
    EasyLoading.show(status: 'Loading...');
    await get_Achivement(body: parameters).then((value) {
      achievements.value = value.achievements;
      EasyLoading.dismiss();
      Get.back();
     // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Achivement_Screen(),));
      log(value.toString());
    }).onError((error, stackTrace) {
      Const().deleteprofilelofinandmenu();
      msgexpire;
      print(error);
      EasyLoading.dismiss();
    });
  }
  Future<void> get_Participation_dep() async {
    Map<String, dynamic> parameters = {
      "apiKey": apikey,
      'device': '2',
      "accessToken": logindetails!.accessToken,
      "user_id": logindetails!.userData.userId,
      "csrf_token": "",
      "page_no": "1",
    };
    EasyLoading.show(status: 'Loading...');
    await get_Participation(body: parameters).then((value) {
      participations.value = value.participations;
      Get.to(() => Partocipation_myacc());
      EasyLoading.dismiss();
      log(value.toString());
    }).onError((error, stackTrace) {
      Get.off(DashboardPage(title: ''));
      msgexpire;
      Const().deleteprofilelofinandmenu();
      print(error);
      EasyLoading.dismiss();
    });
  }
  Future<void> get_Participation_dep2() async {
    Map<String, dynamic> parameters = {
      "apiKey": apikey,
      'device': '2',
      "accessToken": logindetails!.accessToken,
      "user_id": logindetails!.userData.userId,
      "csrf_token": "",
      "page_no": "1",
    };
    EasyLoading.show(status: 'Loading...');
    await get_Participation(body: parameters).then((value) {
      participations.value = value.participations;
      Get.back();
      EasyLoading.dismiss();

      log(value.toString());
    }).onError((error, stackTrace) {
      Get.off(DashboardPage(title: ''));
      msgexpire;
      Const().deleteprofilelofinandmenu();
      print(error);
      EasyLoading.dismiss();
    });
  }


  @override
  void dispose() {
    super.dispose();
    rajyaBuilder.dispose();
    rajyaBuilder_office.dispose();
    citiesBuilder.dispose();
    citiesBuilder_office.dispose();
    council_builder.dispose();
    association_builder.dispose();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
