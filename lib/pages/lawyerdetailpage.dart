
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_html/flutter_html.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_tags_x/flutter_tags_x.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recase/recase.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vakalat_flutter/api/postapi.dart';
import 'package:vakalat_flutter/color/customcolor.dart';
import 'package:vakalat_flutter/model/clsLawyer.dart';
import 'package:vakalat_flutter/model/clsLawyerDetailResponseModel.dart';
import 'package:vakalat_flutter/utils/common_functions.dart';
import 'package:vakalat_flutter/utils/constant.dart';
import 'package:vakalat_flutter/utils/keyboardHiderMixin.dart';

// import 'package:video_player/video_player.dart';
// import 'package:bulleted_list/bulleted_list.dart';

class LawyerDetailPage extends StatefulWidget {
  const LawyerDetailPage(
      {Key? key, required this.title, required this.objLawyer})
      : super(key: key);

  final String title;
  final clsLawyer objLawyer;

  @override
  State<LawyerDetailPage> createState() => _LawyerDetailPageState();
}

class _LawyerDetailPageState extends State<LawyerDetailPage>
    with KeyboardHiderMixin, TickerProviderStateMixin {
  clsLawyerDetailResponseModel? objLawyerDetailResponseModel;

  // late VideoPlayerController _videoPlayerController;

  final _scrollcontroller = ScrollController();

  late ScrollController _scrollcontrollerTab;

  late TabController tabController;
  int currentIndex = 0;

  List<Tab> tabs = <Tab>[
    const Tab(child: Text("Professional Detail")),
    const Tab(child: Text("Specialization")),
    const Tab(child: Text("Services")),
  ];

  @override
  void initState() {
    // TODO: implement initState
    _scrollcontrollerTab = ScrollController();

    APICALL_get_lawyer_details(true);

    super.initState();
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.

    // _videoPlayerController.dispose();
    super.deactivate();
  }

  @override
  void dispose() {
    _scrollcontroller.dispose();
    _scrollcontrollerTab.dispose();
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            "",
            style: TextStyle(
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
          actions: <Widget>[
            (widget.objLawyer.video_profile!.isNotEmpty) ?
            IconButton(
                icon: const Icon(Icons.videocam),
                onPressed: () {
                  // live session

                  String strURL_video_profile = Const().URL_video_profile +
                      widget.objLawyer.video_profile!;
                  print(strURL_video_profile);

                  loadVideo(strURL_video_profile);

                }) : Container(),
          ],
        ),
        body: (objLawyerDetailResponseModel == null)
            ? Container()
            : buildMainBody(context));
  }

  void loadVideo(String url) {
    // _videoPlayerController = VideoPlayerController.network(url);
    //
    // _videoPlayerController.addListener(() {
    //   setState(() {});
    // });
    // _videoPlayerController.setLooping(false);
    // _videoPlayerController.initialize();
  }

  _smoothScrollToTop() {
    _scrollcontrollerTab.animateTo(
      0,
      duration: const Duration(microseconds: 300),
      curve: Curves.ease,
    );
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
    String strFullName =
        "${objLawyerDetailResponseModel!.lawyer_data!.first_name!} ${objLawyerDetailResponseModel!.lawyer_data!.last_name!}";

    strFullName = strFullName.toLowerCase().titleCase;
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
            buildProf_Detail(context),
            buildSpecialization_Detail(context),
            buildServices_Detail(context),
          ],
        ),
      ),
    );
  }

  Widget buildBody(BuildContext context) {


    String strProfileImageURL = Const().URL_profile_pic_FullImage +
        objLawyerDetailResponseModel!.lawyer_data!.profile_pic!;

    // print(strProfileImageURL);
    String strFullName =
        "${objLawyerDetailResponseModel!.lawyer_data!.first_name!} ${objLawyerDetailResponseModel!.lawyer_data!.last_name!}";

    strFullName = strFullName.toLowerCase().titleCase;

    String strExperience =
        (objLawyerDetailResponseModel!.lawyer_data!.experience!.isEmpty == true)
            ? ""
            : " ${objLawyerDetailResponseModel!.lawyer_data!.experience!} Years Experience";

    String strAbout =
        objLawyerDetailResponseModel!.lawyer_data!.about_user!.trim();

    String strLocation = "";

    if ((objLawyerDetailResponseModel!.lawyer_data!.city_name!.isEmpty ==
            true) &&
        (objLawyerDetailResponseModel!.lawyer_data!.state_name!.isEmpty ==
            true) &&
        (objLawyerDetailResponseModel!.lawyer_data!.country_name!.isEmpty ==
            true)) {
      strLocation = " Not Provided";
    } else {
      strLocation = " ${objLawyerDetailResponseModel!.lawyer_data!.city_name!}, ${objLawyerDetailResponseModel!.lawyer_data!.state_name!}, ${objLawyerDetailResponseModel!.lawyer_data!.country_name!}";
    }

    String strAllCategory = "";
    for (var obj in objLawyerDetailResponseModel!.user_category!) {
      strAllCategory = "$strAllCategory${obj.cat_name!}, ";
    }

    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    return Column(children: [
      Card(
        color: CustomColor().colorLightBlue,
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
        elevation: 4,
        child: Column(
          children: <Widget>[
            Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: 1.0, vertical: 0.0),
              width: double.infinity,
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
                                    height: 160.0,
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
                                  (objLawyerDetailResponseModel!
                                              .lawyer_data!.is_verified! ==
                                          "1")
                                      ? Container(
                                          width: double.maxFinite,
                                          padding: const EdgeInsets.all(2),
                                          margin: const EdgeInsets.only(bottom: 0),
                                          decoration: BoxDecoration(
                                              color: CustomColor()
                                                  .colorGreen_verified,
                                              borderRadius: const BorderRadius.all(
                                                  Radius.circular(0))),
                                          child: Text(
                                            "Verified",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: CustomColor().colorWhite,
                                                fontSize: 14.0),
                                          ),
                                        )
                                      : Container(
                                          width: double.maxFinite,
                                          padding: const EdgeInsets.all(2),
                                          margin: const EdgeInsets.only(bottom: 0),
                                          decoration: BoxDecoration(
                                              color: CustomColor()
                                                  .colorRed_notverified,
                                              borderRadius: const BorderRadius.all(
                                                  Radius.circular(0))),
                                          child: Text(
                                            "Not Verified",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: CustomColor().colorWhite,
                                                fontSize: 14.0),
                                          ),
                                        ),
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
                          (strExperience.isEmpty)
                              ? Container()
                              : Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.business_center,
                                      color: CustomColor().colorPrimary,
                                    ),
                                    Text(
                                      strExperience,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: CustomColor().colorPrimary,
                                          fontSize: 14.0),
                                    ),
                                  ],
                                ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            verticalDirection: VerticalDirection.down,
                            textBaseline: TextBaseline.alphabetic,
                            children: <Widget>[
                              FaIcon(
                                FontAwesomeIcons.addressCard,
                                size: 20,
                                color: CustomColor().colorPrimary,
                              ),
                              Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(2, 2, 2, 0),
                                  child: Container()),
                              Expanded(
                                child: Text(
                                  objLawyerDetailResponseModel!
                                      .lawyer_data!.address!,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: CustomColor().colorPrimary,
                                      fontSize: 14.0),
                                ),
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
            Container(
              margin: const EdgeInsets.fromLTRB(8, 5, 8, 0),
              height: 1.0,
              color: CustomColor().colorLightGray,
            ),
            SizedBox(
              height: 50,
              child: ListView(
                  controller: _scrollcontroller,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    // Website
                    IconButton(
                      icon: FaIcon(FontAwesomeIcons.globe,
                          color: CustomColor().colorPrimary),
                      onPressed: () {
                        String url = objLawyerDetailResponseModel!
                            .lawyer_data!.website_url!;

                        String strURL_slug = "https://www.vakalat.com/${objLawyerDetailResponseModel!.lawyer_data!.slug!}";

                        if (url.isEmpty) {
                          url = strURL_slug;
                        }

                        var encoded =
                            Uri.encodeFull(CommonFunctions.checkHttp(url));
                        // launch(encoded);
                        FlutterWebBrowser.openWebPage(url: encoded);
                      },
                    ),
                    (objLawyerDetailResponseModel!
                                .lawyer_data!.is_display_web! ==
                            "0")
                        ? Container()
                        : IconButton(
                            icon: FaIcon(FontAwesomeIcons.sms,
                                color: CustomColor().colorPrimary),
                            onPressed: () {
                              String url = "sms:${objLawyerDetailResponseModel!
                                      .lawyer_data!.mobile!}";
                              var encoded = Uri.encodeFull(url);
                              launch(encoded);
                            },
                          ),
                    // SMS
                    (objLawyerDetailResponseModel!
                                .lawyer_data!.is_display_web! ==
                            "0")
                        ? Container()
                        : IconButton(
                            icon: FaIcon(FontAwesomeIcons.phoneAlt,
                                color: CustomColor().colorPrimary),
                            onPressed: () {
                              CommonFunctions.makePhoneCall(
                                  objLawyerDetailResponseModel!
                                      .lawyer_data!.mobile!);
                            },
                          ),
                    // Call
                    (objLawyerDetailResponseModel!
                                .lawyer_data!.is_display_web! ==
                            "0")
                        ? Container()
                        : IconButton(
                            icon: FaIcon(FontAwesomeIcons.whatsapp,
                                color: CustomColor().colorPrimary),
                            onPressed: () {
                              launch(CommonFunctions.whatsapp_LawyerContact(
                                  objLawyerDetailResponseModel!
                                      .lawyer_data!.mobile!,
                                  strFullName));
                            },
                          ),
                    // Whatsapp
                    IconButton(
                      icon: FaIcon(FontAwesomeIcons.envelope,
                          color: CustomColor().colorPrimary),
                      onPressed: () {
                        String url = "mailto:${objLawyerDetailResponseModel!.lawyer_data!.email!}";
                        var encoded = Uri.encodeFull(url);
                        launch(encoded);
                      },
                    ),
                    // Share
                    IconButton(
                      icon: FaIcon(FontAwesomeIcons.shareAlt,
                          color: CustomColor().colorPrimary),
                      onPressed: () {
                        String strURL_slug = "https://www.vakalat.com/${objLawyerDetailResponseModel!.lawyer_data!.slug!}";

                        Share.share(
                            '${strFullName.toLowerCase().titleCase} at Vakalat \ncheck my profile\n$strURL_slug',
                            subject: '');
                      },
                    ),
                    // Linkedin
                    (objLawyerDetailResponseModel!
                            .lawyer_data!.linkedin_url!.isNotEmpty)
                        ? IconButton(
                            icon: FaIcon(FontAwesomeIcons.linkedin,
                                color: CustomColor().colorPrimary),
                            onPressed: () {
                              String url = objLawyerDetailResponseModel!
                                  .lawyer_data!.linkedin_url!;
                              var encoded = Uri.encodeFull(
                                  CommonFunctions.checkHttp(url));
                              launch(encoded);
                            },
                          )
                        : Container(),
                    //Facebook
                    (objLawyerDetailResponseModel!
                            .lawyer_data!.fb_url!.isNotEmpty)
                        ? IconButton(
                            icon: FaIcon(FontAwesomeIcons.facebookF,
                                color: CustomColor().colorPrimary),
                            onPressed: () {
                              String url = objLawyerDetailResponseModel!
                                  .lawyer_data!.fb_url!;
                              var encoded = Uri.encodeFull(
                                  CommonFunctions.checkHttp(url));
                              launch(encoded);
                            },
                          )
                        : Container(),
                    // Twitter
                    (objLawyerDetailResponseModel!
                            .lawyer_data!.twitter_url!.isNotEmpty)
                        ? IconButton(
                            icon: FaIcon(FontAwesomeIcons.twitter,
                                color: CustomColor().colorPrimary),
                            onPressed: () {
                              String url = objLawyerDetailResponseModel!
                                  .lawyer_data!.twitter_url!;
                              var encoded = Uri.encodeFull(
                                  CommonFunctions.checkHttp(url));
                              launch(encoded);
                            },
                          )
                        : Container(),
                    // Instagram
                    (objLawyerDetailResponseModel!
                            .lawyer_data!.insta_url!.isNotEmpty)
                        ? IconButton(
                            icon: FaIcon(FontAwesomeIcons.instagram,
                                color: CustomColor().colorPrimary),
                            onPressed: () {
                              String url = objLawyerDetailResponseModel!
                                  .lawyer_data!.insta_url!;
                              var encoded = Uri.encodeFull(
                                  CommonFunctions.checkHttp(url));
                              launch(encoded);
                            },
                          )
                        : Container(),
                  ]),
            ),
          ],
        ),
      ),
    ]);
  }

  Widget buildProf_Detail(BuildContext context) {
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
            data: objLawyerDetailResponseModel!.lawyer_data!.about_user!,
          ),
        ),
      ),
    );
  }

  Widget buildSpecialization_Detail(BuildContext context) {
    return (objLawyerDetailResponseModel == null)
        ? Container()
        : Padding(
            padding: const EdgeInsets.fromLTRB(0, 5.0, 0, 0),
            child: Card(
              color: CustomColor().colorLightBlue,
              clipBehavior: Clip.hardEdge,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0),
              ),
              elevation: 4,
              child: Container(
                  margin: const EdgeInsets.all(10),
                  child: Tags(
                    columns: 2,
                    symmetry: true,
                    alignment: WrapAlignment.start,
                    itemCount:
                        objLawyerDetailResponseModel!.user_category!.length,
                    itemBuilder: (int index) {
                      var item =
                          objLawyerDetailResponseModel!.user_category![index];
                      return Tooltip(
                          message: item.cat_name,
                          child: ItemTags(
                            pressEnabled: true,
                            activeColor: CustomColor().colorPrimary,
                            singleItem: true,
                            splashColor: CustomColor().colorPrimary,
                            title: item.cat_name!,
                            index: index,
                            onPressed: (item) => print(index),
                          ));
                    },
                  )),
            ),
          );
  }

  Widget buildServices_Detail(BuildContext context) {

    return (objLawyerDetailResponseModel == null)
        ? Container()
        : Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 5.0, 10, 10),
            child: Card(
              color: CustomColor().colorLightBlue,
              clipBehavior: Clip.hardEdge,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0),
              ),
              elevation: 4,
              child: Container(
                padding: const EdgeInsets.all(10),
                child: ListView.separated(
                    scrollDirection: Axis.vertical,
                    separatorBuilder: (context, index) =>
                        const Divider(height: 1, color: Colors.transparent),
                    itemCount: (objLawyerDetailResponseModel == null) ? 0 : objLawyerDetailResponseModel!.services!.length ,
                    itemBuilder: (context, index) {
                      return createBlock_Services(index);
                    })
              ),
            ),
          );
  }
  Widget createBlock_Services(int index) {
    var objService = objLawyerDetailResponseModel!.services![index];

    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    return Container(
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
                  Container(
                    margin: const EdgeInsets.fromLTRB(5.0, 10.0, 0, 10.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.task_alt,
                          color: CustomColor().colorPrimary,
                        ),
                        Container(
                          margin: const EdgeInsets.all(7),
                          height: 1.0,
                        ),
                        Text(
                          objService.sm_title!,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: CustomColor().colorPrimary,
                              fontSize: 15.0,
                              fontWeight:  FontWeight.normal),
                        ),


                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

    );
  }

  Future APICALL_get_lawyer_details(bool showLoader) async {
    clsLawyerDetailResponseModel objResponse = clsLawyerDetailResponseModel();
    try {
      Map<String, dynamic> parameters = {
        "lawyer_id": "${widget.objLawyer.user_id}",
      };

      if (showLoader == true) EasyLoading.show(status: "Loading...");

      objResponse = await get_lawyer_details(body: parameters);
      if (objResponse.status == 1) {
        setState(() {
          // arrServices.clear();
          // for (var obj in objResponse.services!)
          // {
          //   arrServices.add(obj.sm_title!);
          // }
          objLawyerDetailResponseModel = objResponse;
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
