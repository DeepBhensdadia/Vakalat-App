import 'package:flutter/material.dart';
import 'package:vakalat_flutter/model/clsLoginResponseModel.dart';
import 'package:vakalat_flutter/model/clsUser.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helper.dart';
const apikey ='5Xf!-VQ*Zjad>@Q-}Bwb@w2/YrY#n';
const device ='2';
const drawertextstyle =  TextStyle(
fontSize: 16, fontWeight: FontWeight.w600);


class Const {
  final decorationfield = BoxDecoration(
      borderRadius: const BorderRadius.all(Radius.circular(5)),
      border: Border.all(width: 1, color: Colors.grey));


  //login Preferes of USer
  String appName = "Vakalat";
  String URL_Services_Image = "https://vakalat-public.s3.ap-southeast-1.amazonaws.com/user/service/";

  String URL_profile_pic_FullImage = "https://vakalat-public.s3.ap-southeast-1.amazonaws.com/user/profile/";
  String URL_profile_pic_Thumbnail = "https://vakalat-public.s3.ap-southeast-1.amazonaws.com/user/profile/thumb/";
  String URL_video_profile = "https://vakalat-public.s3.ap-southeast-1.amazonaws.com/user/profile/video/";

  String URL_image = "https://www.vakalat.com/resources/assets/images/";

  String URL_event_image = "https://vakalat-public.s3.ap-southeast-1.amazonaws.com/user/event/";


  String URL_livesession_image = "https://vakalat-public.s3.ap-southeast-1.amazonaws.com/session_type/";


  String URL_legalnotice_image = "https://vakalat-public.s3.ap-southeast-1.amazonaws.com/user/legal_notice/";

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

  Textinscreen(String text, String text2,BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          // color: Colors.blue,
            width: screenwidth(context,dividedby: 7),
            child: Text(
              text,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            )),
        const SizedBox(
          width: 10,
        ),
        Container(
          // color: Colors.blueAccent,
          // width: screenwidth(context,dividedby: 2.5),
          child: Text(
            text2,
            style: const TextStyle(
                fontWeight: FontWeight.w600, fontSize: 15, color: Colors.grey),
          ),
        ),
      ],
    );
  }

  cartscreen(String text, String text2,BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            // color: Colors.blue,
              width: screenwidth(context,dividedby: 6),
              child: Text(
                text,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              )),

          Container(
            // color: Colors.blueAccent,
            // width: double.infinity,
            child: Text(
              text2,
              style: const TextStyle(
                  fontWeight: FontWeight.w600, fontSize: 14, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }


}
