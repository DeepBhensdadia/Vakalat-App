
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:recase/recase.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vakalat_flutter/api/postapi.dart';
import 'package:vakalat_flutter/color/customcolor.dart';
import 'package:vakalat_flutter/model/clsCollege.dart';
import 'package:vakalat_flutter/model/clsCollegeResponseModel.dart';
import 'package:vakalat_flutter/pages/collegedetailpage.dart';
import 'package:vakalat_flutter/utils/common_functions.dart';
import 'package:vakalat_flutter/utils/constant.dart';
import 'package:vakalat_flutter/utils/keyboardHiderMixin.dart';


class CollegesPage extends StatefulWidget {
  const CollegesPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<CollegesPage> createState() => _CollegesPageState();
}

class _CollegesPageState extends State<CollegesPage> with KeyboardHiderMixin {

  List<clsCollege> arrCollege = [];

  int offset = 0;
  TextEditingController txtSearchController = TextEditingController();

  String strSearchText = "";

  @override
  void initState() {
    // TODO: implement initState
    APICALL_getColleges(true);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  Widget _buildSearchBox() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      verticalDirection: VerticalDirection.down,
      children: <Widget>[
        Expanded(
          child: Card(
            elevation: 4.0,
            child: ListTile(
              contentPadding: const EdgeInsets.fromLTRB(5.0, 0, 5, 0),
              leading: const Icon(Icons.search),
              minLeadingWidth: 10,
              horizontalTitleGap: 0.0,
              title: TextField(
                controller: txtSearchController,
                decoration: const InputDecoration(
                    hintText: 'Search', border: InputBorder.none),
                // onChanged: onSearchTextChanged,
              ),
              trailing: txtSearchController.text.isEmpty
                  ? null
                  : IconButton(
                icon: const Icon(
                  Icons.cancel,
                  size: 18,
                ),
                onPressed: () {
                  txtSearchController.clear();
                },
              ),
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.filter_alt),
          color: CustomColor().colorPrimary,
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildBody() {
    return Column(
      children: <Widget>[
        Container(
            padding: const EdgeInsets.all(4.0),
            color: Colors.white,
            child: _buildSearchBox()),
        Expanded(child: createCollegeList()),
      ],
    );
  }

  Widget createCollegeList() {
    return Container(
      child: RefreshIndicator(
        onRefresh: () {
          offset = 0;
          return APICALL_getColleges(true);
        },
        child: Column(children: [
          Expanded(
            child: ListView.separated(
                separatorBuilder: (context, index) =>
                    const Divider(height: 0, color: Colors.transparent),
                itemCount: arrCollege.length,
                itemBuilder: (context, index) {
                  return createBlock(index);
                }),
          ),
        ]),
      ),
    );
  }


  Widget createBlock(int index) {
    var objLawyer = arrCollege[index];

    String strProfileImageURL =
        Const().URL_profile_pic_FullImage + objLawyer.profile_pic!;

    // print(strProfileImageURL);
    String strFullName = objLawyer.law_firm_college!;

    strFullName = strFullName.toLowerCase().titleCase;

    String strExperience = (objLawyer.experience!.isEmpty == true)
        ? ""
        : " ${objLawyer.experience!}";

    String strAbout = objLawyer.about_user!.trim();

    String strLocation = "";

    if ((objLawyer.city_name!.isEmpty == true) &&
        (objLawyer.state_name!.isEmpty == true) &&
        (objLawyer.country_name!.isEmpty == true)) {
      strLocation = " Not Provided";
    } else {
      strLocation = " ${objLawyer.city_name!}, ${objLawyer.state_name!}, ${objLawyer.country_name!}";
    }

    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    return Card(
      color: CustomColor().colorLightBlue,
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
      ),
      elevation: 4,
      child: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 1.0, vertical: 0.0),
            width: double.infinity,
            child: InkWell(
              splashColor: CustomColor().colorPrimary.withOpacity(0.4),
              onTap: () {
                setState(() {
                  // onTap

                  print("onTap");

                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.rightToLeftWithFade,
                      duration: const Duration(milliseconds: 300),
                      child: CollegeDetailPage(
                        title: strFullName, objCollege: objLawyer,
                      ),
                    ),
                  );
                });
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                verticalDirection: VerticalDirection.down,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        verticalDirection: VerticalDirection.down,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Card(
                            clipBehavior: Clip.hardEdge,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            elevation: 4,
                            child: Stack(alignment: Alignment.bottomCenter,
                                //alignment:new Alignment(x, y)
                                children: <Widget>[
                                  Container(
                                    padding: const EdgeInsets.all(0),
                                    height: 100.0,
                                    child: CachedNetworkImage(
                                      imageUrl: strProfileImageURL,
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.cover,
                                                // colorFilter:
                                                //     ColorFilter.mode(Colors.red, BlendMode.colorBurn),
                                              ),
                                            ),
                                          ),
                                      placeholder: (context, url) =>
                                          Image.asset(
                                              'assets/images/loading.gif'),
                                      errorWidget: (context, url, error) =>
                                          Image.asset(
                                              'assets/images/default.png'),
                                    ),
                                  ),
                                  // (objLawyer.is_verified! == "1" )
                                  //     ? Container(
                                  //   width: double.maxFinite,
                                  //   padding: EdgeInsets.all(2),
                                  //   margin: EdgeInsets.only(bottom: 0),
                                  //   decoration: BoxDecoration(
                                  //       color: CustomColor()
                                  //           .colorGreen_verified,
                                  //       borderRadius: BorderRadius.all(
                                  //           Radius.circular(0))),
                                  //   child: Text(
                                  //     "Verified",
                                  //     textAlign: TextAlign.center,
                                  //     style: TextStyle(
                                  //         color: CustomColor().colorWhite,
                                  //         fontSize: 14.0),
                                  //   ),
                                  // )
                                  //     : Container(
                                  //   width: double.maxFinite,
                                  //   padding: EdgeInsets.all(2),
                                  //   margin: EdgeInsets.only(bottom: 0),
                                  //   decoration: BoxDecoration(
                                  //       color: CustomColor()
                                  //           .colorRed_notverified,
                                  //       borderRadius: BorderRadius.all(
                                  //           Radius.circular(0))),
                                  //   child: Text(
                                  //     "Not Verified",
                                  //     textAlign: TextAlign.center,
                                  //     style: TextStyle(
                                  //         color: CustomColor().colorWhite,
                                  //         fontSize: 14.0),
                                  //   ),
                                  // ),
                                ]),
                          ),
                        ]),
                  ),
                  Expanded(
                    flex: 6,
                    child: Container(
                      margin: const EdgeInsets.all(5.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        verticalDirection: VerticalDirection.down,
                        textBaseline: TextBaseline.alphabetic,
                        children: [

                          Text(
                            strFullName,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: CustomColor().colorPrimary,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold),
                          ),
                          Container(
                            margin: const EdgeInsets.all(4),
                            height: 1.0,
                          ),
                          Container(
                            margin: const EdgeInsets.all(2),
                            height: 1.0,
                          ),
                          (strLocation.trim().isEmpty == true)
                              ? Container()
                              : Row(
                            children: <Widget>[
                              Icon(
                                Icons.location_on,
                                color: CustomColor().colorPrimary,
                              ),
                              Text(
                                strLocation,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: CustomColor().colorPrimary,
                                    fontSize: 14.0),
                              ),
                            ],
                          ),

                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(8, 5, 8, 0),
            height: 1.0,
            color: CustomColor().colorLightGray,
          ),
          SizedBox(
            height: 50,
            child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  // Website
                  IconButton(
                    icon: FaIcon(FontAwesomeIcons.globe,
                        color: CustomColor().colorPrimary),
                    onPressed: () {
                      String url = objLawyer.website_url!;

                      String strURL_slug =
                          "https://www.vakalat.com/${objLawyer.slug!}";

                      if (url.isEmpty) {
                        url = strURL_slug;
                      }

                      var encoded =
                      Uri.encodeFull(CommonFunctions.checkHttp(url));
                      // launch(encoded);
                      FlutterWebBrowser.openWebPage(url: encoded);
                    },
                  ),
                  (objLawyer.is_display_web! == "0")
                      ? Container()
                      : IconButton(
                    icon: FaIcon(FontAwesomeIcons.sms,
                        color: CustomColor().colorPrimary),
                    onPressed: () {
                      String url = "sms:${objLawyer.mobile!}";
                      var encoded = Uri.encodeFull(url);
                      launch(encoded);
                    },
                  ),
                  // SMS
                  (objLawyer.is_display_web! == "0")
                      ? Container()
                      : IconButton(
                    icon: FaIcon(FontAwesomeIcons.phoneAlt,
                        color: CustomColor().colorPrimary),
                    onPressed: () {
                      CommonFunctions.makePhoneCall(objLawyer.mobile!);
                    },
                  ),
                  // Call
                  (objLawyer.is_display_web! == "0")
                      ? Container()
                      : IconButton(
                    icon: FaIcon(FontAwesomeIcons.whatsapp,
                        color: CustomColor().colorPrimary),
                    onPressed: () {

                      launch(CommonFunctions.whatsapp_LawyerContact(
                          objLawyer.mobile!, strFullName));
                    },
                  ),
                  // Whatsapp
                  IconButton(
                    icon: FaIcon(FontAwesomeIcons.envelope,
                        color: CustomColor().colorPrimary),
                    onPressed: () {
                      String url = "mailto:${objLawyer.email!}";
                      var encoded = Uri.encodeFull(url);
                      launch(encoded);
                    },
                  ),
                  // Share
                  IconButton(
                    icon: FaIcon(FontAwesomeIcons.shareAlt,
                        color: CustomColor().colorPrimary),
                    onPressed: () {
                      String strURL_slug =
                          "https://www.vakalat.com/${objLawyer.slug!}";

                      Share.share(
                          '${strFullName.toLowerCase().titleCase} at Vakalat \ncheck my profile\n$strURL_slug',
                          subject: '');
                    },
                  ),
                  // Linkedin
                  (objLawyer.linkedin_url!.isNotEmpty)
                      ? IconButton(
                    icon: FaIcon(FontAwesomeIcons.linkedin,
                        color: CustomColor().colorPrimary),
                    onPressed: () {
                      String url = objLawyer.linkedin_url!;
                      var encoded =
                      Uri.encodeFull(CommonFunctions.checkHttp(url));
                      launch(encoded);
                    },
                  )
                      : Container(),
                  //Facebook
                  (objLawyer.fb_url!.isNotEmpty)
                      ? IconButton(
                    icon: FaIcon(FontAwesomeIcons.facebookF,
                        color: CustomColor().colorPrimary),
                    onPressed: () {
                      String url = objLawyer.fb_url!;
                      var encoded =
                      Uri.encodeFull(CommonFunctions.checkHttp(url));
                      launch(encoded);
                    },
                  )
                      : Container(),
                  // Twitter
                  (objLawyer.twitter_url!.isNotEmpty)
                      ? IconButton(
                    icon: FaIcon(FontAwesomeIcons.twitter,
                        color: CustomColor().colorPrimary),
                    onPressed: () {
                      String url = objLawyer.twitter_url!;
                      var encoded =
                      Uri.encodeFull(CommonFunctions.checkHttp(url));
                      launch(encoded);
                    },
                  )
                      : Container(),
                  // Instagram
                  (objLawyer.insta_url!.isNotEmpty)
                      ? IconButton(
                    icon: FaIcon(FontAwesomeIcons.instagram,
                        color: CustomColor().colorPrimary),
                    onPressed: () {
                      String url = objLawyer.insta_url!;
                      var encoded =
                      Uri.encodeFull(CommonFunctions.checkHttp(url));
                      launch(encoded);
                    },
                  )
                      : Container(),

                ]),
          ),
        ],
      ),
    );
  }

  void updateData_Colleges(List<clsCollege> Data) {
    setState(() {
      arrCollege.clear();
      arrCollege.addAll(Data);
    });
  }

  Future APICALL_getColleges(bool showLoader) async {
    int offset = 0;

    clsCollegeResponseModel objResponse = clsCollegeResponseModel();
    try {
      Map<String, dynamic> parameters = {
        "name": strSearchText,
        "offset": "$offset",
      };

      if (showLoader == true) EasyLoading.show(status: "Loading...");

      objResponse = await get_colleges(body: parameters);
      if (objResponse.status == 1) {
        updateData_Colleges(objResponse.colleges!);
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
      if (showLoader == true) EasyLoading.dismiss(animation: true); if (showLoader == true) EasyLoading.dismiss(animation: true);
    }
  }

  void onSearchTextChanged(String value) {
    setState(() {
      strSearchText = value;
    });

    offset = 0;
    APICALL_getColleges(false);
  }
}
