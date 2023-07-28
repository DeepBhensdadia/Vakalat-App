import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../Sharedpref/shared_pref.dart';
import '../../../api/postapi.dart';
import '../../../color/customcolor.dart';
import '../../../helper.dart';
import '../../../model/Get_Profile.dart';
import '../../../model/clsLoginResponseModel.dart';
import '../../../utils/constant.dart';
import '../../../utils/design.dart';
import 'Contact_Details.dart';
import 'Personal_Detail.dart';
import 'Professional_Detail.dart';
import 'Social_Media.dart';
import 'change_password.dart';
import 'getxcontroller.dart';
import 'knownlanguage.dart';
import 'portfolio_screen.dart';

class Profile_Tabs extends StatefulWidget {
  const Profile_Tabs({Key? key}) : super(key: key);

  @override
  _MyTabbedPageState createState() => _MyTabbedPageState();
}

class _MyTabbedPageState extends State<Profile_Tabs>
    with SingleTickerProviderStateMixin {
  bool show = true;
  ClsLoginResponseModel logindetails = clsLoginResponseModelFromJson(
      SharedPref.get(prefKey: PrefKey.loginDetails)!);
  final ProfileControl getxController = Get.put(ProfileControl());

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    getxController.countryp();
    getxController.stateApi(value: getxController.detail.profile.countryId);
    getxController.stateApi_office(value: getxController.detail.profile.officeCountryId);
    getxController.cityApi(value: getxController.detail.profile.stateId  );
    getxController.cityApi_office(value: getxController.detail.profile.officeStateId);
    getxController.bar_council();
    getxController.bar_associasion();
    getxController.categorypostapi();
    getxController.languages();
    getxController.get_doc_type();

    // countrypostapi();
    // countrypost();
    _tabController =
        TabController(length: tabs.length, vsync: this, initialIndex: 0);
  }
  TextEditingController subject = TextEditingController();
  TextEditingController details = TextEditingController();

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
    const Tab(child: Text("Known Language")),
    const Tab(child: Text("Change Password")),
  ];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
          actions: [TextButton(onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                  title: Container(
                    height: screenheight(context, dividedby: 2),
                    width: double.maxFinite,
                    child: SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(textAlign: TextAlign.center,"Send Your Query To\nVakalat.com",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
                            SizedBox(height: 10,),
                            CustomTextfield(
                              maxline: 2,
                              labelname: 'Subject',
                              Controller: subject,
                              validator: (p0) {
                                if (p0!.isEmpty) {
                                  return 'Enter Subject';
                                }
                                return null;
                              },
                            ),
                            CustomTextfield(
                              maxline: 8,
                              labelname: 'Details',
                              Controller: details,
                              validator: (p0) {
                                if (p0!.isEmpty) {
                                  return ' Enter Details ';
                                }
                                return null;
                              },
                            ),
                            Button_For_Update_Save(text: "Send Email", onpressed: ()  {
                              if(_formKey.currentState!.validate())
                              sendEmail(subject.text, details.text);
                            },)
                          ],
                        ),
                      ),
                    ),
                  )),
            );
          }, child: Text('Help',style: TextStyle(color: Colors.white,fontSize: 18),))],
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
                          Personal_Detail(detail: getxController.detail),
                          Contact_Details(detail: getxController.detail),
                          Social_Media(detail: getxController.detail),
                           Professional_Detail(detail : getxController.detail),
                          Portfolio_screen(detail: getxController.detail),
                          KnownLanguage(detail: getxController.detail),
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
  void sendEmail(String subject, String details) async {
    final Email email = Email(
      body:'Name: ${getxController.detail.profile.firstName} ${getxController.detail.profile.lastName}\n\n$details ',
      subject: subject,
      recipients: ['info@vakalat.com'],
    );

    try {
      await FlutterEmailSender.send(email);
      // Email sent successfully
    } catch (error) {
      // Handle the error
      print('Error sending email: $error');
    }
  }
}
