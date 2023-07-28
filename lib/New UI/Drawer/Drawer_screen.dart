import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:vakalat_flutter/New%20UI/Services/services_screen.dart';
import 'package:vakalat_flutter/New%20UI/login.dart';
import 'package:vakalat_flutter/Sharedpref/shared_pref.dart';
import 'package:vakalat_flutter/helper.dart';
import '../../api/postapi.dart';
import '../../model/Get_Profile.dart';
import '../../model/clsLoginResponseModel.dart';
import '../../model/getdrawermenu.dart';
import '../../pages/dashboard.dart';
import '../../utils/constant.dart';
import '../../widgets/massage_page.dart';
import '../Dashboard_screens/Dashboard_Screen.dart';
import '../My Account/Achivement/Achivement.dart';
import '../My Account/Participation/Participation.dart';
import '../My Account/Profile/getxcontroller.dart';
import '../My Account/Profile/profile.dart';
import '../My Account/subscription.dart';
import '../Topic Video/Topic Video.dart';
import '../User_Inquries/Get_User_Inquries.dart';
import '../legale notice/legal_notice.dart';
import '../rating_review.dart';

class Drawer_Screen extends StatefulWidget {
  const Drawer_Screen({Key? key}) : super(key: key);

  @override
  State<Drawer_Screen> createState() => _Drawer_ScreenState();
}

class _Drawer_ScreenState extends State<Drawer_Screen> {
  ClsLoginResponseModel logindetails = clsLoginResponseModelFromJson(
      SharedPref.get(prefKey: PrefKey.loginDetails)!);
  GetProfileModel? getprofile = SharedPref.get(prefKey: PrefKey.getProfile) != null?
      getProfileModelFromJson(SharedPref.get(prefKey: PrefKey.getProfile)!):null;
  Getdrawermenu? getmenu = SharedPref.get(prefKey: PrefKey.getMenu) != null
      ? getdrawermenuFromJson(SharedPref.get(prefKey: PrefKey.getMenu)!)
      : null;

  final ProfileControl getxController = Get.put(ProfileControl());
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Container(
            height: 50,
            child: Row(
              children: [
                getprofile!.profile.profilePic.isEmpty
                    ? CircleAvatar(
                        backgroundImage: AssetImage("assets/images/logo.png"),
                      )
                    : CircleAvatar(
                        backgroundImage:
                            NetworkImage(getprofile!.profile.profilePic)),
                SizedBox(
                  width: 15,
                ),
                Text(
                  '${logindetails.userData.userFname} ${logindetails.userData.userLname}',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Expanded(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: ListView(
                children: [
                  button('Home', FontAwesomeIcons.home, () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DashboardPage(
                            title: '',
                          ),
                        ));
                    log(logindetails.accessToken);
                  }, true),
                  button('DashBoard', FontAwesomeIcons.dashboard, () async {
                    Map<String, dynamic> parameters = {
                      "apiKey": apikey,
                      'device': '2',
                      "accessToken": logindetails.accessToken,
                      "user_id": logindetails.userData.userId,
                      "csrf_token": ""
                    };
                    EasyLoading.show(status: 'Loading...');
                    await get_Deshboard(body: parameters).then((value) {
                      EasyLoading.dismiss();

                      log(value.toString());
                      Navigator.pushReplacement(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => DashBoard_Screen(data: value),
                          ));
                    }).onError((error, stackTrace) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const DashboardPage(title: ''),
                          ));
                      msgexpire;
                      Const().deleteprofilelofinandmenu();
                      print(error);
                      // ToastMessage().showmessage(error.toString());
                      EasyLoading.dismiss();
                    });
                  }, getmenu != null ? getmenu!.menu!.digitalProfile : false),
                  Visibility(
                    visible:
                        getmenu != null ? getmenu!.menu!.digitalProfile : false,
                    child: ExpansionTile(
                      // style: ButtonStyle(backgroundColor: MaterialStateColor.resolveWith((states) => Color(0xFF112d4e))),

                      title: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: const [
                                Icon(
                                  Icons.person_2_outlined,
                                  size: 25,
                                  color: Colors.black54,
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  'My Account',
                                  style: drawertextstyle,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      textColor: Colors.black,
                      iconColor: Colors.black,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Column(
                            children: [
                              button('Profile', Icons.arrow_forward, () async {
                                await getxController.countrypostapi();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const Profile_Tabs(),
                                    ));
                              },
                                  getmenu != null
                                      ? getmenu!.menu!.profile
                                      : false),
                              button('Subscription', Icons.arrow_forward,
                                  () async {
                                Map<String, dynamic> parameters = {
                                  "apiKey": apikey,
                                  'device': '2',
                                  "accessToken": logindetails.accessToken,
                                  "user_id": logindetails.userData.userId
                                  // "csrf_token": "",
                                  // "page_no": "1",
                                };
                                EasyLoading.show(status: 'Loading...');
                                await Get_subscription(body: parameters)
                                    .then((value) {
                                  EasyLoading.dismiss();

                                  log(value.toString());
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            subscrption_screen(data: value),
                                      ));
                                }).onError((error, stackTrace) {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const DashboardPage(title: ''),
                                      ));
                                  msgexpire;
                                  Const().deleteprofilelofinandmenu();
                                  print(error);
                                  EasyLoading.dismiss();
                                });
                              },
                                  getmenu != null
                                      ? getmenu!.menu!.subscription
                                      : false),
                              button('Achivement', Icons.arrow_forward, () {
                                getxController.get_Achivement_dep(context);

                              },
                                  getmenu != null
                                      ? getmenu!.menu!.achievement
                                      : false),
                              button('Participation', Icons.arrow_forward, () {
                                getxController.get_Participation_dep();

                              },
                                  getmenu != null
                                      ? getmenu!.menu!.participation
                                      : false),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Visibility(
                    visible: getmenu != null ? getmenu!.menu!.dms : false,
                    child: ExpansionTile(
                      textColor: Colors.black,
                      iconColor: Colors.black,
                      // style: ButtonStyle(backgroundColor: MaterialStateColor.resolveWith((states) => Color(0xFF112d4e))),
                      title: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: const [
                                Icon(
                                  FontAwesomeIcons.fileInvoice,
                                  size: 28,
                                  color: Colors.black54,
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  'DMS',
                                  style: drawertextstyle,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Column(
                            children: [
                              button('Document Type', Icons.arrow_forward, () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const Message_page(
                                          title: 'Document Type'),
                                    ));
                              },
                                  getmenu != null
                                      ? getmenu!.menu!.documentType
                                      : false),
                              button('Upload Document', Icons.arrow_forward,
                                  () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const Message_page(
                                          title: 'Upload Document'),
                                    ));
                              },
                                  getmenu != null
                                      ? getmenu!.menu!.uploadDoc
                                      : false),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  button('Services', FontAwesomeIcons.handHoldingHeart, () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Services_screen(),
                        ));
                  }, getmenu != null ? getmenu!.menu!.services : false),
                  button('User Inquiry', FontAwesomeIcons.headset, () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const User_Inquries_screen(),
                        ));
                  }, getmenu != null ? getmenu!.menu!.userInquiry : false),
                  button('Rating/Review', FontAwesomeIcons.balanceScale, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Rating_And_Review()),
                    );
                  }, getmenu!.menu!.ratingReview),
                  button('Client Management', FontAwesomeIcons.users, () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const Message_page(title: 'Client Management'),
                        ));
                  }, getmenu != null ? getmenu!.menu!.clientManagement : false),
                  button('Client ledger', FontAwesomeIcons.fileInvoiceDollar,
                      () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Message_page(
                            title: 'Client ledger',
                          ),
                        ));
                  }, getmenu != null ? getmenu!.menu!.clientLedger : false),
                  button('Topic Video', FontAwesomeIcons.video, () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const Topic_Video(title: 'Topic Video'),
                        ));
                  }, false),
                  button('Legel Notice', FontAwesomeIcons.noteSticky, () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const Legal_Notice(title: 'Legel Notice'),
                        ));
                  }, false),
                  const SizedBox(
                    height: 20,
                  ),
                  getprofile!.profile.currentPkgId == "0"
                      ? MaterialButton(
                          padding: EdgeInsets.zero,
                          onPressed: () async {
                            await getxController.hand_list(context);
                          },
                          child: Stack(
                            children: [
                              Container(
                                height: screenheight(context, dividedby: 3),
                                // width: screenwidth(context,dividedby: 2.5),
                                // color: Colors.red,
                                child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      button(
                                          'Dashboard',
                                          FontAwesomeIcons.balanceScale,
                                          () {},
                                          true),
                                      button(
                                          'Profile',
                                          FontAwesomeIcons.balanceScale,
                                          () {},
                                          true),
                                      button(
                                          'Services',
                                          FontAwesomeIcons.balanceScale,
                                          () {},
                                          true),
                                      button(
                                          'User Inquiry',
                                          FontAwesomeIcons.balanceScale,
                                          () {},
                                          true),
                                      button(
                                          'Rating/Review',
                                          FontAwesomeIcons.balanceScale,
                                          () {},
                                          true),
                                    ]),
                              ),
                              Container(
                                height: screenheight(context, dividedby: 3),
                                color: Colors.white.withOpacity(0.55),
                                child: Center(
                                  child: Column(
                                    // mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(
                                        FontAwesomeIcons.lock,
                                        size: 25,
                                        // color: Colors.cyan,
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        textAlign: TextAlign.center,
                                        'Something else',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      : const SizedBox()
                ],
              )),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: MaterialButton(
            // style: ButtonStyle(backgroundColor: MaterialStateColor.resolveWith((states) => Color(0xFF112d4e))),
            onPressed: () {
              Const().deleteprofilelofinandmenu();
              Const().deleteprofilelofinandmenu();
              Get.off(const LoginPage(title: ''));
              Get.deleteAll();
              setState(() {
                print('delete ');
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: const [
                      Icon(
                        Icons.logout,
                        color: Colors.red,
                        size: 28,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        'Log Out',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  button(String Name, IconData icons, Function() ontap, bool visi) {
    return Visibility(
      visible: visi,
      child: MaterialButton(
        height: 50,
        // style: ButtonStyle(backgroundColor: MaterialStateColor.resolveWith((states) => Color(0xFF112d4e))),
        onPressed: ontap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    icons,
                    size: 23,
                    color: Colors.black54,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    Name,
                    style: drawertextstyle,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
