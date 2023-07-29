import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:page_transition/page_transition.dart';
import 'package:vakalat_flutter/New%20UI/login.dart';
import 'package:vakalat_flutter/color/customcolor.dart';
import 'package:vakalat_flutter/model/clsCategory.dart';
import 'package:vakalat_flutter/pages/collegespage.dart';
import 'package:vakalat_flutter/pages/jobspage.dart';
import 'package:vakalat_flutter/pages/profilepage.dart';
import 'package:vakalat_flutter/utils/ToastMessage.dart';
import 'package:vakalat_flutter/utils/keyboardHiderMixin.dart';

import '../New UI/Drawer/Drawer_screen.dart';
import '../New UI/Drawer/without_login_drawer.dart';
import '../New UI/My Account/Profile/getxcontroller.dart';
import '../Sharedpref/shared_pref.dart';
import '../api/postapi.dart';
import '../model/Get_Profile.dart';
import '../model/clsLoginResponseModel.dart';
import '../model/getdrawermenu.dart';
import '../utils/constant.dart';
import 'barassociationpage.dart';
import 'homepage.dart';
import 'lawyerpage.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key, required this.title}) : super(key: key);

  final String title;
  @override
  DashboardPageState createState() => DashboardPageState();
}

class DashboardPageState extends State<DashboardPage> with KeyboardHiderMixin {
  // ClsLoginResponseModel logindetails = clsLoginResponseModelFromJson(
  //     SharedPref.get(prefKey: PrefKey.loginDetails)!);
  ClsLoginResponseModel? loginDetails = SharedPref.get(prefKey: PrefKey.loginDetails) != null
      ? clsLoginResponseModelFromJson(SharedPref.get(prefKey: PrefKey.loginDetails)!)
      : null;

  // final ProfileControl getxController = Get.put(ProfileControl());

  DateTime pre_backpress = DateTime.now();

  String titlePage = "";

  int counter_notification = 14;

  int _selectedIndex = 0;

  clsCategory? objCategoryToSearch;
  void onSelectItem(String param) {
    print(param);
  }
  Future<void> get_services() async {
    Map<String, dynamic> parameters = {
      "apiKey": apikey,
      'device': '2',
      "accessToken": loginDetails!.accessToken,
      "user_id": loginDetails!.userData.userId,
      "offset": "0",
    };
    EasyLoading.show(status: 'Loading...');
    await Get_Services(body: parameters).then((value) {

      EasyLoading.dismiss();
    }).onError((error, stackTrace) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DashboardPage(title: ''),));
      msgexpire;
      Const().deleteprofilelofinandmenu();
      EasyLoading.dismiss();
    });
  }
  get_profile_forsave() async {
    if(loginDetails!.userData.userId.isNotEmpty){
      get_services();
      Map<String, dynamic> parameters = {
        "apiKey": apikey,
        'device': '2',
        "user_id":loginDetails!.userData.userId
      };
      EasyLoading.show(status: 'Loading...');
      await get_profile(body: parameters).then((value) async {
        await SharedPref.save(
            value: jsonEncode(value.toJson()),
            prefKey: PrefKey.getProfile);
        EasyLoading.dismiss();
      }).onError((error, stackTrace) {
        // ToastMessage().showmessage(error.toString());
        print(error);
        EasyLoading.dismiss();
      });
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _onItemTapped(0);
    get_profile_forsave();
    // print(SharedPref.get(prefKey: PrefKey.loginDetails));
  }



  void setLaywerCategory(clsCategory objCategory) {
    objCategoryToSearch = objCategory;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;

      print("_selectedIndex $_selectedIndex");

      switch (_selectedIndex) {
        case 0:
          setState(() {
            titlePage = "Vakalat";
          });
          break;

        case 1:
          setState(() {
            titlePage = "Jobs";
          });

          break;
        case 2:
          setState(() {
            titlePage = "Lawyers";
          });
          break;

        case 3:
          setState(() {
            titlePage = "Colleges";
          });
          break;

        case 4:
          setState(() {
            titlePage = "Bar Association / Council";
          });
          break;

        default:
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final timegap = DateTime.now().difference(pre_backpress);
        final cantExit = timegap >= const Duration(seconds: 2);
        pre_backpress = DateTime.now();
        if (cantExit) {
          const snack = SnackBar(
            content: Text('Press Back button again to Exit'),
            duration: Duration(seconds: 2),
          );
          ScaffoldMessenger.of(context).showSnackBar(snack);
          return false;
        } else {
          return true;
        }
      },
      child: SafeArea(
        child: Scaffold(
          drawer: Drawer(
            child: SharedPref.get(prefKey: PrefKey.loginDetails) != null
                ? const Drawer_Screen()
                : const Without_login_Drawer(),
          ),

          appBar: AppBar(
            title: Text(
              titlePage,
              style: const TextStyle(
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            centerTitle: true,
            backgroundColor: CustomColor().colorPrimary,
            leading: Builder(
              builder: (context) => IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () {
                    // gotoProfilePage();
                    Scaffold.of(context).openDrawer();
                  }),
            ),
            automaticallyImplyLeading: false,
            // actions: [
            //   // Live session blink icon
            //
            //   IconButton(
            //       onPressed: () {
            //         gotoProfilePage();
            //       },
            //       icon: Icon(Icons.person))
            // ],
          ),
          // drawer: navigationDrawer(),
          body: loadPage_AS_index(_selectedIndex),
          bottomNavigationBar: BottomNavigationBar(
            // <-- This works for fixed
            selectedItemColor: CustomColor().colorPrimary,
            unselectedItemColor: CustomColor().colorLightGray,
            type: BottomNavigationBarType.fixed,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.work),
                label: 'Jobs',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.people),
                label: 'Lawyer',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.school),
                label: 'Colleges',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.business_center),
                label: 'Bar Asso..',
              ),
            ],
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }

  Widget loadPage_AS_index(int index) {
    _onItemTapped(index);
    setState(() {
      _selectedIndex = index;
    });

    print(objCategoryToSearch?.cat_id!);

    switch (index) {
      case 0:
        return HomePage(
          title: "",
          selectedPage: 0,
          dashboardPageState: this,
        );
      case 1:
        return const JobsPage(title: "");
      case 2:
        return LawyerPage(
          title: "",
          objCategory: objCategoryToSearch,
        );
      case 3:
        return const CollegesPage(title: "");
      case 4:
        return const BarAssociationPage(title: "");
      default:
        return Container();
    }
  }

  void gotoProfilePage() {
    Navigator.push(
      context,
      PageTransition(
        type: PageTransitionType.rightToLeftWithFade,
        duration: const Duration(milliseconds: 300),
        child: const ProfilePage(title: "Vakalat"),
      ),
    );
  }

}
