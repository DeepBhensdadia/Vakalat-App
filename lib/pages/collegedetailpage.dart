
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_html/flutter_html.dart';
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
import 'package:vakalat_flutter/model/clsCourseResponseModel.dart';
import 'package:vakalat_flutter/utils/common_functions.dart';
import 'package:vakalat_flutter/utils/constant.dart';
import 'package:vakalat_flutter/utils/keyboardHiderMixin.dart';

class CollegeDetailPage extends StatefulWidget {
  const CollegeDetailPage(
      {Key? key, required this.title, required this.objCollege})
      : super(key: key);

  final String title;
  final clsCollege objCollege;

  @override
  State<CollegeDetailPage> createState() => _CollegeDetailPageState();
}

class _CollegeDetailPageState extends State<CollegeDetailPage>
    with KeyboardHiderMixin ,TickerProviderStateMixin {


  clsCourseResponseModel? objCourseResponseModel;

  final _scrollcontroller = ScrollController();

  late ScrollController _scrollcontrollerTab;

  late TabController tabController;
  int currentIndex = 0;

  List<Tab> tabs = <Tab>[
    const Tab(child: Text("About")),
    const Tab(child: Text("Course")),
  ];


  @override
  void initState() {
    // TODO: implement initState
    _scrollcontrollerTab = ScrollController();

    APICALL_get_clg_course_detail(true);

    super.initState();



  }
  @override
  void dispose() {
    _scrollcontroller.dispose();
    _scrollcontrollerTab.dispose();
    tabController.dispose();
    super.dispose();
  }
  _smoothScrollToTop() {
    _scrollcontrollerTab.animateTo(
      0,
      duration: const Duration(microseconds: 300),
      curve: Curves.ease,
    );
  }

  @override
  Widget build(BuildContext context) {
    Timer(
      const Duration(seconds: 2),
          () => _scrollcontroller.animateTo(
        _scrollcontroller.position.maxScrollExtent,
        duration: const Duration(seconds: 2),
        curve: Curves.linearToEaseOut,
      ),
    );
    tabController = TabController(
      vsync: this,
      length: tabs.length,
      initialIndex: 0,
    );

    tabController.addListener(_smoothScrollToTop);

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            widget.title,
            style: const TextStyle(
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          centerTitle: true,
          backgroundColor: CustomColor().colorPrimary,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: (objCourseResponseModel == null)
            ?  Container() : buildMainBody(context)  );
  }
  Widget buildMainBody(BuildContext context) {
    Timer(
      const Duration(seconds: 2),
          () => _scrollcontroller.animateTo(
        _scrollcontroller.position.maxScrollExtent,
        duration: const Duration(seconds: 2),
        curve: Curves.linearToEaseOut,
      ),
    );
    tabController = TabController(
      vsync: this,
      length: tabs.length,
      initialIndex: 0,
    );

    tabController.addListener(_smoothScrollToTop);
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    return NestedScrollView(
      controller: _scrollcontrollerTab,
      headerSliverBuilder: (context, value) {
        return [
          SliverToBoxAdapter(child: buildBody(context)),
          SliverToBoxAdapter(
            child: TabBar(
                controller: tabController,
                isScrollable: true,
                indicator: UnderlineTabIndicator(
                  borderSide:
                  BorderSide(color: CustomColor().colorPrimary, width: 2.0),
                ),
                unselectedLabelColor: CustomColor().colorLightGray,
                indicatorSize: TabBarIndicatorSize.label,
                labelColor: CustomColor().colorPrimary,
                tabs: tabs),
          ),
        ];
      },
      body: Container(
        child: TabBarView(
          controller: tabController,
          children: [
            build_About(context),
            build_Course(context),
          ],
        ),
      ),
    );
  }
  Widget buildBody(BuildContext context) {
    return Column(
      children: [
        createBlock(),
      ],
    );
  }

  Widget createBlock() {
    var objLawyer = widget.objCollege;

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
                controller: _scrollcontroller,
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

  Widget build_About(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 5.0, 0, 10),
      child: Card(
        color: CustomColor().colorLightBlue,
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
        elevation: 4,
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Html(
        data: widget.objCollege.about_user!,
        ),
        ),
      ),
    );
  }
  Widget build_Course(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 5.0, 0, 10),
      child: Card(
        color: CustomColor().colorLightBlue,
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
        elevation: 4,
        child: Container(
          padding: const EdgeInsets.all(5),
          child: ListView.separated(
                  scrollDirection: Axis.vertical,
                  separatorBuilder: (context, index) =>
                      const Divider(height: 1, color: Colors.transparent),
                  itemCount: (objCourseResponseModel == null) ? 0 : objCourseResponseModel!.courses!.length ,
                  itemBuilder: (context, index) {
                    return createBlock_Course(index);
                  })

        ),
      ),
    );
  }

  Widget createBlock_Course(int index) {
    var objCourse = objCourseResponseModel!.courses![index];

    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 5.0, 0, 10),
      child: Card(
        color: CustomColor().colorWhite,
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
        elevation: 4,
        child: Container(
          padding: const EdgeInsets.all(10),
          child:Container(
            margin: const EdgeInsets.symmetric(horizontal: 1.0, vertical: 0.0),
            width: double.infinity,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              verticalDirection: VerticalDirection.down,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    verticalDirection: VerticalDirection.down,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        "${objCourse.course_name!} (${objCourse.academic_year!})",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 15,
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
                      Text(
                        "${objCourse.degree_type!} (${objCourse.degree_name!})",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: CustomColor().colorPrimary,
                            fontSize: 13.0,
                            fontWeight: FontWeight.bold),
                      ),
                      Container(
                        margin: const EdgeInsets.all(4),
                        height: 1.0,
                      ),
                      Html(
                          data: objCourse.description!
                      ),
                    ],
                  ),
                ),
              ],
            ),

          )
        ),
      ),
    )
     ;
  }

  Future APICALL_get_clg_course_detail(bool showLoader) async {
    clsCourseResponseModel objResponse = clsCourseResponseModel();
    try {
      Map<String, dynamic> parameters = {
        "college_id": "${widget.objCollege.user_id}",
      };

      if (showLoader == true) EasyLoading.show(status: "Loading...");

      objResponse = await get_clg_course_detail(body: parameters);
      if (objResponse.status == 1) {
        setState(() {
          objCourseResponseModel = objResponse;
        });

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
