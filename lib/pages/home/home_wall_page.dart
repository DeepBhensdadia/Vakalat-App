import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:page_transition/page_transition.dart';
import 'package:recase/recase.dart';
import 'package:vakalat_flutter/api/postapi.dart';
import 'package:vakalat_flutter/color/customcolor.dart';
import 'package:vakalat_flutter/model/clsCategory.dart';
import 'package:vakalat_flutter/model/clsCategoryResponseModel.dart';
import 'package:vakalat_flutter/model/clsEvent.dart';
import 'package:vakalat_flutter/model/clsEventResponseModel.dart';
import 'package:vakalat_flutter/model/clsLawyer.dart';
import 'package:vakalat_flutter/model/clsLawyerResponseModel.dart';
import 'package:vakalat_flutter/model/clsLegalNews.dart';
import 'package:vakalat_flutter/model/clsLegalNewsResponseModel.dart';
import 'package:vakalat_flutter/model/clsVideo.dart';
import 'package:vakalat_flutter/model/clsVideoResponseModel.dart';
import 'package:vakalat_flutter/pages/categorysearchpage.dart';
import 'package:vakalat_flutter/pages/dashboard.dart';
import 'package:vakalat_flutter/pages/eventdetailpage.dart';
import 'package:vakalat_flutter/pages/homepage.dart';
import 'package:vakalat_flutter/pages/lawyerdetailpage.dart';
import 'package:vakalat_flutter/pages/video_detail_page.dart';
import 'package:vakalat_flutter/utils/constant.dart';
import 'package:vakalat_flutter/utils/keyboardHiderMixin.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class home_wall_page extends StatefulWidget {
  const home_wall_page({
    Key? key,
    required this.title,
    required this.dashboardPageState,
    required this.homePageState,
  }) : super(key: key);
  final DashboardPageState dashboardPageState;

  final HomePageState homePageState;
  final String title;

  @override
  State<home_wall_page> createState() => _home_wall_page_State();
}

class _home_wall_page_State extends State<home_wall_page>
    with KeyboardHiderMixin {
  List<String> arrSliders = [];

  List<clsLawyer> arrLawyers = [];
  List<clsVideo> arrVideos = [];
  List<clsCategory> arrCategory = [];
  List<clsEvent> arrEvents = [];
  List<clsLegalNews> arrLegalNews = [];

  @override
  void initState() {
    // TODO: implement initState

    setState(() {
      arrSliders.clear();
      arrSliders.add("Top Lawyers");
      arrSliders.add("Know your law");
      arrSliders.add("Law categories");
      arrSliders.add("Events");
      arrSliders.add("News");

      // arrLawyers.clear();
      // arrVideos.clear();
      // arrCategory.clear();
      // arrEvents.clear();
    });

    APICALL_getLawyer(true);
    APICALL_getVideos(false);
    APICALL_getCategory(false);
    APICALL_getEvent(false);
    APICALL_getLegalNews(false);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return createHomePage(context);
  }

  Widget createHomePage(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 2.0),
        child: ListView.separated(
            scrollDirection: Axis.vertical,
            separatorBuilder: (context, index) =>
                const Divider(height: 1, color: Colors.transparent),
            itemCount: arrSliders.length,
            itemBuilder: (context, index) {
              Widget widget = Container();
              switch (index) {
                case 0:
                  widget =
                      createHorizontalSlider_TopLawyers(context, arrSliders[0]);
                  break;
                case 1:
                  widget =
                      createHorizontalSlider_Videos(context, arrSliders[1]);
                  break;
                case 2:
                  widget =
                      createHorizontalSlider_Category(context, arrSliders[2]);
                  break;
                case 3:
                  widget =
                      createHorizontalSlider_Events(context, arrSliders[3]);
                  break;
                case 4:
                  widget =
                      createHorizontalSlider_LegalNews(context, arrSliders[4]);
                  break;

                default:
                  widget = Container();
              }
              return widget;
            }),
      ),
    );
  }

  Widget createHorizontalSlider(String titleLabel) {
    return Column(children: <Widget>[
      Container(
        alignment: Alignment.centerLeft,
        child: Text(
          titleLabel,
          style: TextStyle(
            color: CustomColor().colorPrimary,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.left,
        ),
      ),
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        height: 160.0,
        child: ListView(
          // This next line does the trick.
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            createBlock(),
            createBlock(),
            createBlock(),
            createBlock(),
            createBlock(),
            createBlock(),
            createBlock_ViewALL(),
          ],
        ),
      )
    ]);
  }

  Widget createBlock() {
    var rng = Random();
    var randomNumber = rng.nextInt(10000);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
      width: 150.0,
      child: Column(
        children: [
          Card(
            margin: EdgeInsets.zero,
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.0),
            ),
            elevation: 4,
            child: FadeInImage.assetNetwork(
              placeholder: 'assets/images/loading.gif',
              image: 'https://picsum.photos/300/200?random=$randomNumber',
              height: 100.0,
              width: 150.0,
              alignment: Alignment.center,
              fit: BoxFit.cover,
            ),
          ),
          const Text(
            'A card that can be tapped',
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          )
        ],
      ),
    );
  }

  Widget createBlock_ViewALL() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      width: 100.0,
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 40),
            child: const Text('View All'),
            // Other widgets
          ),
        ],
      ),
    );
  }

  //#region Lawyer

  Widget createHorizontalSlider_TopLawyers(
      BuildContext context, String strTitle) {
    return InkWell(
      splashColor: CustomColor().colorPrimary.withOpacity(0.4),
      onTap: () {
        setState(() {
          // onTap

          print("onTap");

          // Navigator.push(
          //   context,
          //   PageTransition(
          //     type: PageTransitionType.rightToLeftWithFade,
          //     duration: const Duration(milliseconds: 300),
          //     child: video_detail_page(
          //       title: "videoDetail",
          //       objVideo: objVideo,
          //     ),
          //   ),
          // );
        });
      },
      child: Column(children: <Widget>[
        Row(
          children: [
            Container(
              // margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 0.0),
                child: Text(
                  strTitle,
                  style: TextStyle(
                    color: CustomColor().colorPrimary,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
              height: 40.0,
              child: IconButton(
                  icon: const Icon(Icons.list, size: 28.0),
                  onPressed: () {
                    // op press
                    widget.dashboardPageState.loadPage_AS_index(2);
                    setState(() {});
                  }),
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 2.0),
          height: 165.0,
          child: ListView.separated(
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) =>
                  const Divider(height: 1, color: Colors.grey),
              itemCount: arrLawyers.length,
              itemBuilder: (context, index) {
                return createBlock_Lawyer(index);
              }),
        )
      ]),
    );
  }

  Widget createBlock_Lawyer(int index) {
    // print('Index ' + index.toString());
    // print('Total ' + arrLawyers.length.toString());
    var objLawyer = arrLawyers[index];

    String strProfileImageURL =
        Const().URL_profile_pic_FullImage + objLawyer.profile_pic!;

    print(strProfileImageURL);

    String strFullName = "${objLawyer.first_name!} ${objLawyer.last_name!}";

    var height = 120.0;
    var width = 100.0;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
      width: width,
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
                child: LawyerDetailPage(
                  title: strFullName,
                  objLawyer: objLawyer,
                ),
              ),
            );
          });
        },
        child: Column(
          children: [
            Card(
              margin: EdgeInsets.zero,
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0),
              ),
              elevation: 4,
              child: CachedNetworkImage(
                imageUrl: strProfileImageURL,
                imageBuilder: (context, imageProvider) => Container(
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
                    Image.asset('assets/images/loading.gif'),
                errorWidget: (context, url, error) =>
                    Image.asset('assets/images/default.png'),
                height: height,
                width: width,
              ),
              // FadeInImage.assetNetwork(
              //   placeholder: 'assets/images/loading.gif',
              //   image: strProfileImageURL ,
              //   height: 100.0,
              //   width: 100.0,
              //   alignment: Alignment.center,
              //   fit: BoxFit.cover,
              // ),
            ),
            Expanded(
              child: Text(
                strFullName.toLowerCase().titleCase,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: CustomColor().colorPrimary,
                    fontSize: 14.0,
                    fontWeight: FontWeight.normal),
                maxLines: 2,
              ),
            )
          ],
        ),
      ),
    );
  }

  //#endregion

  //#region Videos
  String getVideoIDFromURL(String strURL) {
    String? videoId = "";
    try {
      videoId = YoutubePlayer.convertUrlToId(strURL);
      print('this is ${videoId!}');
    } on Exception {
      // only executed if error is of type Exception
      print('exception');
    } catch (error) {
      // executed for errors of all types other than Exception
      print('catch error');
      //  videoIdd="error";

    }

    return videoId!;
  }

  String getThumbnailURLfromVideoID(String videoID) {
    // Default Thumbnail: http://img.youtube.com/vi/{videoID}/default.jpg
    // High Quality Thumbnail: http://img.youtube.com/vi/{videoID}/hqdefault.jpg
    // Medium Quality Thumbnail: http://img.youtube.com/vi/{videoID}/mqdefault.jpg

    String strThumbnailURL = "";

    // strThumbnailURL = "http://img.youtube.com/vi/$videoID/default.jpg";
    strThumbnailURL = "http://img.youtube.com/vi/$videoID/hqdefault.jpg";
    // strThumbnailURL= "http://img.youtube.com/vi/$videoID/mqdefault.jpg";

    return strThumbnailURL;
  }

  Widget createHorizontalSlider_Videos(BuildContext context, String strTitle) {
    return Column(children: <Widget>[
      Row(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 0.0),
              child: Text(
                strTitle,
                style: TextStyle(
                  color: CustomColor().colorPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
            height: 40.0,
            child: IconButton(
                icon: const Icon(Icons.list, size: 28.0),
                onPressed: () {
                  // op press

                  widget.homePageState.gotoVideoPage();
                  setState(() {});
                }),
          ),
        ],
      ),
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 2.0),
        height: 150.0,
        child: ListView.separated(
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) =>
                const Divider(height: 1, color: Colors.grey),
            itemCount: arrVideos.length,
            itemBuilder: (context, index) {
              return createBlock_Video(index);
            }),
      )
    ]);
  }

  Widget createBlock_Video(int index) {
    // print('Index ' + index.toString());
    // print('Total ' + arrLawyers.length.toString());
    var objVideo = arrVideos[index];

    var videoID = getVideoIDFromURL(objVideo.plain_url!);

    var strThumbnailURL = getThumbnailURLfromVideoID(videoID);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
      width: 150.0,
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
                child: video_detail_page(
                  title: "videoDetail",
                  objVideo: objVideo,
                ),
              ),
            );
          });
        },
        child: Column(
          children: [
            Card(
              margin: EdgeInsets.zero,
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0),
              ),
              elevation: 4,
              child: FadeInImage.assetNetwork(
                placeholder: 'assets/images/loading.gif',
                image: strThumbnailURL,
                height: 100.0,
                width: 150.0,
                alignment: Alignment.center,
                fit: BoxFit.cover,
              ),
            ),
            Text(
              objVideo.title!,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              textAlign: TextAlign.left,
            )
          ],
        ),
      ),
    );
  }

  //#endregion

  //#region Category

  Widget createHorizontalSlider_Category(
      BuildContext context, String strTitle) {
    return Column(children: <Widget>[
      Row(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 0.0),
              child: Text(
                strTitle,
                style: TextStyle(
                  color: CustomColor().colorPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
            height: 40.0,
            child: IconButton(
                icon: const Icon(Icons.list, size: 28.0),
                onPressed: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.rightToLeftWithFade,
                      duration: const Duration(milliseconds: 300),
                      child: CategorySearchPage(
                        title: "",
                        dashboardPageState: widget.dashboardPageState,
                      ),
                    ),
                  );
                  // op press
                  setState(() {});
                }),
          ),
        ],
      ),
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 2.0),
        height: 150.0,
        child: ListView.separated(
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) =>
                const Divider(height: 1, color: Colors.grey),
            itemCount: arrCategory.length,
            itemBuilder: (context, index) {
              return createBlock_Category(index);
            }),
      )
    ]);
  }

  Widget createBlock_Category(int index) {
    // print('Index ' + index.toString());
    // print('Total ' + arrLawyers.length.toString());
    var objCategory = arrCategory[index];

    var strThumbnailURL = Const().URL_image + objCategory.cat_img!;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
      width: 100.0,
      child: InkWell(
        splashColor: CustomColor().colorPrimary.withOpacity(0.4),
        onTap: () {
          setState(() {
            // onTap

            print("onTap");
            widget.dashboardPageState.objCategoryToSearch = objCategory;
            widget.dashboardPageState.loadPage_AS_index(2);
          });
        },
        child: Column(
          children: [
            Card(
                margin: EdgeInsets.zero,
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                ),
                elevation: 4,
                child: Container(
                  padding: const EdgeInsets.all(20.0),
                  height: 100.0,
                  width: 100.0,
                  child: SvgPicture.network(
                    strThumbnailURL,
                    placeholderBuilder: (BuildContext context) => Container(
                        height: 20.0,
                        width: 20.0,
                        padding: const EdgeInsets.all(40.0),
                        child: const CircularProgressIndicator()),
                    height: 60.0,
                    width: 60.0,
                  ),
                )),
            Expanded(
              child: Text(
                objCategory.cat_name!,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }

  //#endregion

  //#region Events
  Widget createHorizontalSlider_Events(BuildContext context, String strTitle) {
    return Column(children: <Widget>[
      Row(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 0.0),
              child: Text(
                strTitle,
                style: TextStyle(
                  color: CustomColor().colorPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
            height: 40.0,
            child: IconButton(
                icon: const Icon(Icons.list, size: 28.0),
                onPressed: () {
                  // op press
                  widget.homePageState.gotoEventPage();

                  setState(() {});
                }),
          ),
        ],
      ),
      Container(
        height: 150.0,
        margin: const EdgeInsets.fromLTRB(2.0, 0.0, 2.0, 0.0),
        child: ListView.separated(
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) =>
                const Divider(height: 1, color: Colors.grey),
            itemCount: arrEvents.length,
            itemBuilder: (context, index) {
              return createBlock_Events(index);
            }),
      )
    ]);
  }

  Widget createBlock_Events(int index) {
    // print('Index ' + index.toString());
    // print('Total ' + arrLawyers.length.toString());
    var objEvent = arrEvents[index];

    var strThumbnailURL = Const().URL_event_image + objEvent.photo!;

    print(strThumbnailURL);

    return InkWell(
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
                child: EventDetailPage(
                  title: "" , objEvent: objEvent,
                ),
              ),
            );
          });
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
          width: 150.0,
          child: Column(
            children: [
              Card(
                margin: EdgeInsets.zero,
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                ),
                elevation: 4,
                child: FadeInImage.assetNetwork(
                  placeholder: 'assets/images/loading.gif',
                  image: strThumbnailURL,
                  height: 100.0,
                  width: 150.0,
                  alignment: Alignment.center,
                  fit: BoxFit.cover,
                ),
              ),
              Text(
                objEvent.event_title!,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                textAlign: TextAlign.left,
              )
            ],
          ),
        ));
  }

  //#endregion

  //#region News
  Widget createHorizontalSlider_LegalNews(
      BuildContext context, String strTitle) {
    return Column(children: <Widget>[
      Row(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 0.0),
              child: Text(
                strTitle,
                style: TextStyle(
                  color: CustomColor().colorPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
            height: 40.0,
            child: IconButton(
                icon: const Icon(Icons.list, size: 28.0),
                onPressed: () {
                  // op press
                  widget.homePageState.gotoLegalNewsPage();
                  setState(() {});
                }),
          ),
        ],
      ),
      Container(
        height: 150.0,
        margin: const EdgeInsets.fromLTRB(2.0, 0.0, 2.0, 20.0),
        child: ListView.separated(
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) =>
                const Divider(height: 1, color: Colors.grey),
            itemCount: arrLegalNews.length,
            itemBuilder: (context, index) {
              return createBlock_LegalNews(index);
            }),
      )
    ]);
  }

  Widget createBlock_LegalNews(int index) {
    // print('Index ' + index.toString());
    // print('Total ' + arrLawyers.length.toString());
    var objLegalNews = arrLegalNews[index];

    var strThumbnailURL = objLegalNews.photo_url!;

    return InkWell(
      splashColor: CustomColor().colorPrimary.withOpacity(0.4),
      onTap: () {
        setState(() {
          // onTap

          print("onTap");
          String url = objLegalNews.link!;
          // launch(_url);

          FlutterWebBrowser.openWebPage(url: url);
        });
      },
      child: Container(
        width: 150.0,
        margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
        child: Column(
          children: [
            Card(
              margin: EdgeInsets.zero,
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0),
              ),
              elevation: 4,
              child: FadeInImage.assetNetwork(
                placeholder: 'assets/images/loading.gif',
                image: strThumbnailURL,
                height: 100.0,
                width: 150.0,
                alignment: Alignment.center,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Text(
                objLegalNews.title!,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                textAlign: TextAlign.left,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget createBlock_LegalNews_ViewALL() {
    return InkWell(
      splashColor: CustomColor().colorPrimary.withOpacity(0.4),
      onTap: () {
        print("onTap");
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        width: 110.0,
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 40),
              child: const Text('View All'),
              // Other widgets
            ),
          ],
        ),
      ),
    );
  }

  //#endregion

  //#region APICALL

  void updateData_Lawyer(List<clsLawyer> Data) {
    setState(() {
      arrLawyers.clear();
      arrLawyers.addAll(Data);

      print(arrLawyers.length);
    });
  }

  Future APICALL_getLawyer(bool showLoader) async {
    int offset = 0;

    clsLawyerResponseModel objResponse = clsLawyerResponseModel();
    try {
      Map<String, dynamic> parameters = {
        "offset": "$offset",
      };

      if (showLoader == true) EasyLoading.show(status: "Loading...");

      objResponse = await get_lawyer_top(body: parameters);
      if (objResponse.status == 1) {
        updateData_Lawyer(objResponse.lawyers!);
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

  void updateData_Videos(List<clsVideo> Data) {
    setState(() {
      arrVideos.clear();
      arrVideos.addAll(Data);
    });
  }

  Future APICALL_getVideos(bool showLoader) async {
    int offset = 0;
    clsVideoResponseModel objResponse = clsVideoResponseModel();
    try {
      Map<String, dynamic> parameters = {
        "offset": "$offset",
      };
      if (showLoader == true) EasyLoading.show(status: "Loading...");

      objResponse = await getVideo(body: parameters);
      if (objResponse.status == 1) {
        updateData_Videos(objResponse.videos!);
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

  void updateData_Category(List<clsCategory> Data) {
    setState(() {
      arrCategory.clear();
      arrCategory.addAll(Data);
    });
  }

  Future APICALL_getCategory(bool showLoader) async {
    int offset = 0;
    clsCategoryResponseModel objResponse = clsCategoryResponseModel();
    try {
      Map<String, dynamic> parameters = {
        "offset": "$offset",
      };
      if (showLoader == true) EasyLoading.show(status: "Loading...");

      objResponse = await get_category(body: parameters);
      if (objResponse.status == 1) {
        updateData_Category(objResponse.categories!);
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

  void updateData_Event(List<clsEvent> Data) {
    setState(() {
      arrEvents.clear();
      arrEvents.addAll(Data);
    });
  }

  Future APICALL_getEvent(bool showLoader) async {
    int offset = 0;
    clsEventResponseModel objResponse = clsEventResponseModel();
    try {
      Map<String, dynamic> parameters = {
        "offset": "$offset",
      };
      if (showLoader == true) EasyLoading.show(status: "Loading...");

      objResponse = await get_events(body: parameters);
      if (objResponse.status == 1) {
        updateData_Event(objResponse.events!);
        if (showLoader == true) EasyLoading.dismiss(animation: true);
      } else {
        if (showLoader == true) EasyLoading.dismiss(animation: true);

        EasyLoading.showToast(objResponse.message!);
      }
    } catch (exception) {
      if (kDebugMode) {
        print(exception.toString());
      }
      if (showLoader == true) EasyLoading.dismiss(animation: true);
    }
  }

  void updateData_LegalNews(List<clsLegalNews> Data) {
    setState(() {
      arrLegalNews.clear();
      arrLegalNews.addAll(Data);
    });
  }

  Future APICALL_getLegalNews(bool showLoader) async {
    int offset = 0;
    clsLegalNewsResponseModel objResponse = clsLegalNewsResponseModel();
    try {
      Map<String, dynamic> parameters = {
        "offset": "$offset",
      };
      if (showLoader == true) EasyLoading.show(status: "Loading...");

      objResponse = await get_legal_news(body: parameters);
      if (objResponse.status == 1) {
        updateData_LegalNews(objResponse.legal_news!);
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

//#endregion
}
