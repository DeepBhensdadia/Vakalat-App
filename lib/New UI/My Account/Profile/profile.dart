import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../Sharedpref/shared_pref.dart';
import '../../../api/postapi.dart';
import '../../../color/customcolor.dart';
import '../../../model/Get_Profile.dart';
import '../../../model/clsLoginResponseModel.dart';
import '../../../utils/constant.dart';
import 'Contact_Details.dart';
import 'Personal_Detail.dart';
import 'Professional_Detail.dart';
import 'Social_Media.dart';
import 'change_password.dart';
import 'portfolio_screen.dart';

class Profile_Tabs extends StatefulWidget {
  const Profile_Tabs({Key? key}) : super(key: key);

  @override
  _MyTabbedPageState createState() => _MyTabbedPageState();
}

class _MyTabbedPageState extends State<Profile_Tabs>
    with SingleTickerProviderStateMixin {
  bool show = false;
  ClsLoginResponseModel logindetails = clsLoginResponseModelFromJson(
      SharedPref.get(prefKey: PrefKey.loginDetails)!);
  void countrypostapi() async {
    Map<String, dynamic> parameters = {
      "apiKey": apikey,
      'device': '2',
      "user_id": logindetails.userData.userId
    };
    EasyLoading.show(status: 'loading...');
    await get_profile(body: parameters).then((value) async {
      await SharedPref.deleteSpecific(prefKey: PrefKey.get_profile);
      await SharedPref.save(
          value: jsonEncode(value.toJson()),
          prefKey: PrefKey.get_profile);
      setState(() {

        detail = value;
        show = true;
        print(jsonEncode(value));
      });
      EasyLoading.dismiss();
    }).onError((error, stackTrace) {
      print(error);
      EasyLoading.dismiss();
    });
  }

  late GetProfileModel detail;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    countrypostapi();
    _tabController =
        TabController(length: tabs.length, vsync: this, initialIndex: 0);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  final List<Tab> tabs = <Tab>[
    const Tab(child: Text("Personal Detail")),
    const Tab(child: Text("Contact Detail")),
    const Tab(child: Text("Social Media Profile")),
    const Tab(child: Text("Professional Detail")),
    const Tab(child: Text("Professional Portfolio")),
    const Tab(child: Text("Change Password")),
  ];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: tabs.length,
      child: Scaffold(
        // appBar: AppBar(
        //   title: Text('My Tabbed Page'),
        //   bottom: TabBar(
        //     controller: _tabController,
        //     tabs:tabs,
        //   ),
        // ),
        appBar: AppBar(
          title: const Text('Profile'),
          centerTitle: true,
          backgroundColor: CustomColor().colorPrimary,
          elevation: 0,
        ),
        body: show == true
            ? Column(
                children: [
                  SizedBox(
                    height: 45,
                    child: TabBar(
                        controller: _tabController,
                        isScrollable: true,
                        indicator: BoxDecoration(
                            color: CustomColor().colorPrimary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(5)),
                        unselectedLabelColor: CustomColor().colorLightGray,
                        padding:
                            const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                        labelColor: CustomColor().colorPrimary,
                        tabs: tabs),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          Personal_Detail(detail: detail),
                          Contact_Details(detail: detail),
                          Social_Media(detail: detail),
                           Professional_Detail(detail : detail),
                           Portfolio_screen(detail: detail),
                          const Change_Password(),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            : const SizedBox(),
      ),
    );
  }
}
