import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vakalat_flutter/model/UpdateSocialDetails.dart';

import '../../../Sharedpref/shared_pref.dart';
import '../../../api/postapi.dart';
import '../../../helper.dart';
import '../../../model/Get_Profile.dart';
import '../../../model/clsLoginResponseModel.dart';
import '../../../utils/ToastMessage.dart';
import '../../../utils/constant.dart';
import '../../../utils/design.dart';

class Social_Media extends StatefulWidget {
  const Social_Media({Key? key, required this.detail}) : super(key: key);
  final GetProfileModel detail;

  @override
  State<Social_Media> createState() => _Social_MediaState();
}

class _Social_MediaState extends State<Social_Media> {
  TextEditingController insta = TextEditingController();
  TextEditingController facebook = TextEditingController();
  TextEditingController twitter = TextEditingController();
  TextEditingController linkedin = TextEditingController();
  TextEditingController web = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    insta.text = widget.detail.profile.instaUrl;
    facebook.text = widget.detail.profile.fbUrl;
    twitter.text = widget.detail.profile.twitterUrl;
    linkedin.text = widget.detail.profile.linkedinUrl;
    web.text = widget.detail.profile.websiteUrl;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          url_field('Enter instagram Url', FontAwesomeIcons.instagram, insta),
          url_field('Enter Facebook Url', FontAwesomeIcons.facebook, facebook),
          url_field('Enter Twitter Url', FontAwesomeIcons.twitter, twitter),
          url_field('Enter linkedin Url', FontAwesomeIcons.linkedin, linkedin),
          url_field('Enter Website Url', FontAwesomeIcons.globeAsia, web),
          Button_For_Update_Save(
            text: 'Update',
            onpressed: () {
              if (web.text.isNotEmpty ||
                  facebook.text.isNotEmpty ||
                  insta.text.isNotEmpty) {
                APICALL_Update_Social_Details.call();
              } else {
                Fluttertoast.showToast(msg: 'Plz Fill Details');
              }
            },
          ),
        ],
      ),
    );
  }

  url_field(String lable, IconData icons, TextEditingController Controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
      child: Container(
        height: 45,
        width: screenwidth(context, dividedby: 1),
        decoration: Const().decorationfield,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.grey,
                ),
                height: 35,
                width: 35,
                child: Center(
                    child: Icon(
                  icons,
                  color: Colors.white,
                  size: 30,
                )),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Expanded(
              child: TextFormField(
                controller: Controller,
                // focusNode: edtEmail,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: lable,
                  // labelStyle: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future APICALL_Update_Social_Details() async {
    EasyLoading.show(status: 'loading...');

    try {
      /*Retriving Parent Object*/
      ClsLoginResponseModel logindetails = clsLoginResponseModelFromJson(
          SharedPref.get(prefKey: PrefKey.loginDetails)!);

      Map<String, dynamic> parameters = {
        "apiKey": '5Xf!-VQ*Zjad>@Q-}Bwb@w2/YrY#n',
        'device': '2',
        "accessToken": logindetails.accessToken,
        "user_id": logindetails.userData.userId,
        "website_url": web.text,
        "linkedin_url": linkedin.text,
        "twitter_url": twitter.text,
        "insta_url": insta.text,
        "fb_url": facebook.text,
      };

      ClsUpdateSocialResponseModel userResponseModel =
          await Update_Social_Details(body: parameters);

      // Mounted is for disposing the calling of Api if User click back button
      if (!mounted) {
        return;
      }

      if (userResponseModel.status == 1) {
        ToastMessage().showmessage(userResponseModel.message);
       setState(() {
         insta.text = insta.text;
         facebook.text = facebook.text;
         twitter.text = twitter.text;
         linkedin.text = linkedin.text;
         web.text = web.text;
       });

        EasyLoading.dismiss();
        // Const.currentUser = userResponseModel.Data!;

        // APICALL_RegisterDevice(userResponseModel);
        // gotoHomePage();
        // await SharedPref.save(
        //     value: userResponseModel.toString(),
        //     prefKey: PrefKey.loginDetails);
      } else {
        setState(() {
          _isLoading = false;
        });
        EasyLoading.dismiss();
        ToastMessage().showmessage(userResponseModel.message);
      }
    } catch (exception) {
      EasyLoading.dismiss();
      setState(
        () {
          _isLoading = false;
        },
      );
      EasyLoading.dismiss();

      ToastMessage().showmessage(exception.toString());
    }
  }
}
