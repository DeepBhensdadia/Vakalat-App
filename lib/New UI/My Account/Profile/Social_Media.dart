import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vakalat_flutter/model/UpdateSocialDetails.dart';
import 'dart:ui' as ui;
import '../../../Sharedpref/shared_pref.dart';
import '../../../api/postapi.dart';
import '../../../color/customcolor.dart';
import '../../../helper.dart';
import '../../../model/Get_Profile.dart';
import '../../../model/clsLoginResponseModel.dart';
import '../../../utils/ToastMessage.dart';
import '../../../utils/constant.dart';
import '../../../utils/design.dart';
import 'getxcontroller.dart';

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
  void launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
     ToastMessage().showmessage('Could not launch $url') ;
    }
  }
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
  final ProfileControl getxController = Get.put(ProfileControl());
  GlobalKey globalKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          url_field('instagram UrL', FontAwesomeIcons.instagram, insta,() {
            launchURL("https://${insta.text}");
          }),
          url_field('Facebook UrL', FontAwesomeIcons.facebook, facebook,() {
            launchURL("https://${facebook.text}");
          }),
          url_field('Twitter UrL', FontAwesomeIcons.twitter, twitter,() {
            launchURL("https://${twitter.text}");
          }),
          url_field('linkedin UrL', FontAwesomeIcons.linkedin, linkedin,() {
            launchURL("https://${linkedin.text}");
          }),
          url_field('Website UrL', FontAwesomeIcons.globeAsia, web,() {
            launchURL("https://${web.text}");
          }),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Your Vakalat.com's Digital Profile / Handler is:",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
                widget.detail.profile.domain.isNotEmpty
                    ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          style: ButtonStyle(maximumSize: MaterialStateProperty.resolveWith((states) => Size(screenwidth(context,dividedby: 1.3), 50))),
                            onPressed: () {
                              launch(widget.detail.profile.domain);
                            },
                            child: Text(

                              widget.detail.profile.domain,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        IconButton(onPressed: () {
                          Share.share(
                              widget.detail.profile.domain ,
                              subject: '');
                        }, icon: Icon(Icons.share))
                      ],
                    )
                    : SizedBox(),
                // TextButton(
                //         onPressed: () {},
                //         child: Text(
                //           'WWW.vakalat.com/',
                //           style: TextStyle(
                //             fontSize: 14,
                //             fontWeight: FontWeight.w600,
                //           ),
                //         )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    widget.detail.profile.domain.isNotEmpty ?  RepaintBoundary(
                      key: globalKey,
                      child: QrImageView(
                        data: widget.detail.profile.domain,
                        version: QrVersions.auto,
                        size: 200.0,
                      ),
                    ) : Column(
                      children: [
                        SizedBox(height: 20,),
                        MaterialButton(
                            color: CustomColor().colorPrimary,
                            onPressed: () async {
                              await getxController.hand_list(context);
                            },
                            child: Text('Purchase Handler',style: TextStyle(fontSize: 16,color: Colors.white),)),

                        SizedBox(height: 20,),

                      ],
                    )
                  ],
                ),
              ],
            ),
          ),

          Button_For_Update_Save(
            text: 'Update',
            onpressed: () {
              APICALL_Update_Social_Details.call();

            },
          ),
        ],
      ),
    );
  }


  url_field(String lable, IconData icons, TextEditingController Controller,void Function() ontap) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            lable,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
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
                      // hintText: lable,
                      // labelStyle: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),
                    ),
                  ),
                ),
                IconButton(onPressed: ontap, icon: Icon(Icons.webhook))
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future APICALL_Update_Social_Details() async {
    EasyLoading.show(status: 'Loading...');

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
