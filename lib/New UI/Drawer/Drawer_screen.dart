import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vakalat_flutter/New%20UI/Services/services_screen.dart';
import 'package:vakalat_flutter/New%20UI/login.dart';
import 'package:vakalat_flutter/Sharedpref/shared_pref.dart';
import '../../model/Get_Profile.dart';
import '../../model/clsLoginResponseModel.dart';
import '../../pages/dashboard.dart';
import '../../utils/constant.dart';
import '../../widgets/massage_page.dart';
import '../Client Mnagemet/client mangement.dart';
import '../DMS/Document Type/Document Type.dart';
import '../DMS/Upload Document/Upload_Documnet.dart';
import '../Dashboard_screens/Dashboard_Screen.dart';
import '../My Account/Achivement/Achivement.dart';
import '../My Account/Participation/Participation.dart';
import '../My Account/Profile/profile.dart';
import '../Topic Video/Topic Video.dart';
import '../User_Inquries/Get_User_Inquries.dart';
import '../handler_search/handler_search.dart';
import '../legale notice/legal_notice.dart';

class Drawer_Screen extends StatefulWidget {
  const Drawer_Screen({Key? key}) : super(key: key);

  @override
  State<Drawer_Screen> createState() => _Drawer_ScreenState();
}

class _Drawer_ScreenState extends State<Drawer_Screen> {
  ClsLoginResponseModel logindetails = clsLoginResponseModelFromJson(
      SharedPref.get(prefKey: PrefKey.loginDetails)!);
  GetProfileModel getprofile =
      getProfileModelFromJson(SharedPref.get(prefKey: PrefKey.get_profile)!);

  @override
  void initState() {
    // TODO: implement initState
    // countrypostapi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Container(
            height: 50,
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                    getprofile.profile.profilePic,
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Text(
                  '${logindetails.userData.userFname} ${logindetails.userData.userLname}',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Expanded(
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: ListView(
                children: [
                  button('Home', FontAwesomeIcons.home, () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Handler_Search(),
                        ));
                    log(logindetails.accessToken);
                  }),
                  button('DashBoard', FontAwesomeIcons.dashboard, () {
                    Navigator.pushReplacement(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => DashBoard_Screen(),
                        ));
                  }),
                  ExpansionTile(
                    // style: ButtonStyle(backgroundColor: MaterialStateColor.resolveWith((states) => Color(0xFF112d4e))),

                    title: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
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
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Column(
                          children: [
                            button('Profile', Icons.arrow_forward, () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Profile_Tabs(),
                                  ));
                            }),
                            button('Subscription', Icons.arrow_forward, () {}),
                            button('Achivement', Icons.arrow_forward, () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Achivement_Screen(),
                                  ));
                            }),
                            button('Participation', Icons.arrow_forward, () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Participation(),
                                  ));
                            }),
                          ],
                        ),
                      )
                    ],
                  ),
                  ExpansionTile(
                    // style: ButtonStyle(backgroundColor: MaterialStateColor.resolveWith((states) => Color(0xFF112d4e))),
                    title: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
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
                            button('Document Type', Icons.arrow_forward, () {      Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Document_Type(title:'Document Type'),
                                ));}),
                            button(
                                'Upload Document', Icons.arrow_forward, () {      Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Upload_Document(title:'Upload Document'),
                                ));}),
                          ],
                        ),
                      )
                    ],
                  ),
                  button('Client Management', FontAwesomeIcons.users, () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Client_Management(title:'Client Management'),
                        ));
                  }),
                  button('Services', FontAwesomeIcons.balanceScale, () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Services_screen(),
                        ));
                  }),
                  button('Client Ledger', FontAwesomeIcons.handHoldingHeart,
                      () {     Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Message_page(title:'Client Ledger'),
                          ));}),
                  button('User Inquiry', FontAwesomeIcons.headset, () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => User_Inquries_screen(),
                        ));
                  }),
                  button('Topic Video', FontAwesomeIcons.video, () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Topic_Video(title:'Topic Video'),
                        ));
                  }),
                  button('Legel Notice', FontAwesomeIcons.noteSticky, () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Legal_Notice(title:'Legel Notice'),
                        ));
                  }),
                ],
              )),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: MaterialButton(
            // style: ButtonStyle(backgroundColor: MaterialStateColor.resolveWith((states) => Color(0xFF112d4e))),
            onPressed: () {
              SharedPref.deleteAll();
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(
                      title: '',
                    ),
                  ));
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
                    children: [
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

  button(String Name, IconData icons, Function() ontap) {
    return MaterialButton(
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
                SizedBox(
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
    );
  }
}
