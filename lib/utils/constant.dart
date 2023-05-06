import 'package:flutter/material.dart';
import 'package:vakalat_flutter/model/clsLoginResponseModel.dart';
import 'package:vakalat_flutter/model/clsUser.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../color/customcolor.dart';
import '../helper.dart';

const apikey = '5Xf!-VQ*Zjad>@Q-}Bwb@w2/YrY#n';
const device = '2';
const drawertextstyle = TextStyle(fontSize: 16, fontWeight: FontWeight.w600);

final buttonred = Color(0xffAF3F3F);

class Const {
  List<String> month = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12'
  ];
  // List<String> month = [
  //   'January',
  //   'February',
  //   'March',
  //   'April',
  //   'May',
  //   'June',
  //   'July',
  //   'August',
  //   'September',
  //   'October',
  //   'November',
  //   'December'
  // ];
  final decorationfield = BoxDecoration(
      borderRadius: const BorderRadius.all(Radius.circular(5)),
      border: Border.all(width: 1, color: Colors.grey));

  //login Preferes of USer
  String appName = "Vakalat";
  String URL_Services_Image =
      "https://vakalat-public.s3.ap-southeast-1.amazonaws.com/user/service/";

  String URL_profile_pic_FullImage =
      "https://vakalat-public.s3.ap-southeast-1.amazonaws.com/user/profile/";
  String URL_profile_pic_Thumbnail =
      "https://vakalat-public.s3.ap-southeast-1.amazonaws.com/user/profile/thumb/";
  String URL_video_profile =
      "https://vakalat-public.s3.ap-southeast-1.amazonaws.com/user/profile/video/";

  String URL_image = "https://www.vakalat.com/resources/assets/images/";

  String URL_event_image =
      "https://vakalat-public.s3.ap-southeast-1.amazonaws.com/user/event/";
  String URL_livesession_image =
      "https://vakalat-public.s3.ap-southeast-1.amazonaws.com/session_type/";
  String URL_legalnotice_image =
      "https://vakalat-public.s3.ap-southeast-1.amazonaws.com/user/legal_notice/";
  String URL_achivement_image =
      "https://vakalat-public.s3.ap-southeast-1.amazonaws.com/user/achievement/";
  String URL_participation_image =
      "https://vakalat-public.s3.ap-southeast-1.amazonaws.com/user/participation/";

  static String? version;

  String KEY_access_token = 'access_token';

  static clsUser? currentUser;

  Future getLoginPrefrences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // objUser.token_type = prefs.getString(Const().KEY_token_type);
    prefs.getString(Const().KEY_access_token);
    // objUser.userName = prefs.getString(Const().KEY_userName);
    // objUser.accountId = prefs.getString(Const().KEY_accountId);
  }

  Future saveLoginPrefrences(ClsLoginResponseModel userResponseModel) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(
        Const().KEY_access_token, userResponseModel.userData.userFname);
    // prefs.setString(
    //     Const().KEY_token_type, userResponseModel.Data!.token_type!);
    // prefs.setString(Const().KEY_userName, userResponseModel.Data!.userName!);
    // prefs.setString(Const().KEY_accountId, userResponseModel.Data!.accountId!);
  }

  textrow(String text, String answer, context,Function() ontap) {
    return InkWell(
      onTap: ontap,
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0, top: 5, bottom: 5),
        child: Row(
          children: [
            Container(
                width: screenwidth(context, dividedby: 2.5),
                child: Text(
                  text,
                  style: TextStyle(
                      fontSize: screenwidth(context, dividedby: 30),
                      fontWeight: FontWeight.w600,
                      color: CustomColor().colorPrimary),
                )),
            Text(
              answer,
              style: TextStyle(
                fontSize: screenwidth(context, dividedby: 30),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Textinscreen(String text, String text2, BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
            // color: Colors.blue,
            width: screenwidth(context, dividedby: 6),
            child: Text(
              text,
              style:  TextStyle(fontWeight: FontWeight.w600, fontSize: screenwidth(context, dividedby: 30),),
            )),
        Container(
          // color: Colors.blueAccent,
          width: screenwidth(context, dividedby: 2.2),
          child: Text(
            text2,
            style:  TextStyle(
                fontWeight: FontWeight.w600, fontSize: screenwidth(context, dividedby: 30), color: Colors.grey),
          ),
        ),
      ],
    );
  }
  Textinscreen2(String text, String text2, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
              // color: Colors.blue,
              width: screenwidth(context, dividedby: 3),
              child: Text(
                text,
                style:  TextStyle(fontWeight: FontWeight.w600, fontSize: screenwidth(context, dividedby: 30),),
              )),
          Text(
            ':',
            style:  TextStyle(fontWeight: FontWeight.w600, fontSize: screenwidth(context, dividedby: 30),),
          ),
          SizedBox(width: 10,),
          Container(
            // color: Colors.blueAccent,
            width: screenwidth(context, dividedby: 2.2),
            child: Text(
              text2,
              style:  TextStyle(
                  fontWeight: FontWeight.w600, fontSize: screenwidth(context, dividedby: 30), color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }

  cartscreen(String text, String text2, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
              // color: Colors.blue,
              width: screenwidth(context, dividedby: 6),
              child: Text(
                text,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              )),
          Container(
            // color: Colors.blueAccent,
            // width: double.infinity,
            child: Text(
              text2,
              style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
