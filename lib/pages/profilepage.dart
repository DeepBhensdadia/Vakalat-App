import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:vakalat_flutter/api/postapi.dart';
import 'package:vakalat_flutter/color/customcolor.dart';
import 'package:vakalat_flutter/model/clsMenu.dart';
import 'package:vakalat_flutter/model/clsMenuResponseModel.dart';
import 'package:vakalat_flutter/pages/aboutuspage.dart';
import 'package:vakalat_flutter/pages/contactuspage.dart';
import 'package:vakalat_flutter/pages/privacypolicypage.dart';
import 'package:vakalat_flutter/utils/keyboardHiderMixin.dart';

import '../New UI/login.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with KeyboardHiderMixin {
  List<clsMenu> arrMenu = [];

  @override
  void initState() {
    // TODO: implement initState
    APICALL_getmenu(true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return buildProfileBody(context);
  }

  Widget buildProfileBody(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: SizedBox(
            height: 50,
            child: Row(
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  height: 40,
                  width: 40,
                ),
                const SizedBox(
                  width: 15,
                ),
                const Text(
                  'Guest',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: SizedBox(
            height: 50,

            child: InkWell(
              onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage(title: '',),));
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Login',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: CustomColor().colorPrimary,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold),
                    ),
                    const Icon(Icons.keyboard_arrow_right)
                  ],
                ),
              ),
            ),
          ),
        ),
        // TextButton(onPressed: (){
        //
        // }, child: Text('Login')),
        // createBlock_Profile(),
        createMenuList(context)
      ],
    );
  }

  Widget createBlock_Profile() {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    return Container(
      height: 200,
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.symmetric(horizontal: 1.0, vertical: 0.0),
      width: double.infinity,
      child: Card(
        color: CustomColor().colorLightBlue,
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
        elevation: 4,
        child: InkWell(
          splashColor: CustomColor().colorPrimary.withOpacity(0.4),
          onTap: () {
            setState(() {
              // onTap

              print("onTap");
            });
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            verticalDirection: VerticalDirection.down,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                "Guest",
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: CustomColor().colorPrimary,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget createMenuList(BuildContext context) {
    return Expanded(
      child: ListView.separated(
          separatorBuilder: (context, index) =>
              const Divider(height: 0, color: Colors.transparent),
          itemCount: arrMenu.length,
          itemBuilder: (context, index) {
            return createBlock(index);
          }),
    );
  }

  Widget createBlock(int index) {
    var objMenu = arrMenu[index];

    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: SizedBox(
        height: 50,

        child: InkWell(
          // splashColor: CustomColor().colorPrimary.withOpacity(0.4),
          onTap: () {
            setState(() {
              // onTap



              goto_Menu(objMenu);
            });
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Row(

              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                Text(
                  objMenu.menu_title!,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: CustomColor().colorPrimary,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold),
                ),
                const Icon(Icons.keyboard_arrow_right)
              ],
            ),
          ),
        ),
      ),
    );
  }

  void goto_Menu(clsMenu objMenu) {
    print(objMenu.menu_id);

    switch (objMenu.menu_id) {
      case "52":
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.rightToLeftWithFade,
            duration: const Duration(milliseconds: 300),
            child: const ContactUsPage(title: "Contact Us"),
          ),
        );
        break;
      case "134":
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.rightToLeftWithFade,
            duration: const Duration(milliseconds: 300),
            child: const AboutUsPage(title: "About Us"),
          ),
        );
        break;
      case "135":
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.rightToLeftWithFade,
            duration: const Duration(milliseconds: 300),
            child: const PrivacyPolicyPage(title: "Privacy Policy"),
          ),
        );
        break;
      default:
        break;
    }
  }

  void updateData_Menu(List<clsMenu> Data) {
    setState(() {
      arrMenu.clear();
      arrMenu.addAll(Data);
    });
  }

  Future APICALL_getmenu(bool showLoader) async {
    clsMenuResponseModel objResponse = clsMenuResponseModel();
    try {
      Map<String, dynamic> parameters = {};

      if (showLoader == true) EasyLoading.show(status: "Loading...");

      objResponse = await get_menu(body: parameters);
      if (objResponse.status == 1) {
        if (objResponse.menus!.isNotEmpty) {
          updateData_Menu(objResponse.menus!);
        }

        if (showLoader == true) EasyLoading.dismiss(animation: true);
      } else {
        if (showLoader == true) EasyLoading.dismiss(animation: true);

        EasyLoading.showToast(objResponse.message!);
      }
    } catch (exception) {
      if (kDebugMode) {
        print(exception.toString());
      }
      //EasyLoading.showToast("" + exception.toString());
      if (showLoader == true) EasyLoading.dismiss(animation: true);
    }
  }
}
