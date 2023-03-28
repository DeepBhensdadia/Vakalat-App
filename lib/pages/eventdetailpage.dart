
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_html/flutter_html.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:vakalat_flutter/api/postapi.dart';
import 'package:vakalat_flutter/color/customcolor.dart';
import 'package:vakalat_flutter/model/clsEvent.dart';
import 'package:vakalat_flutter/model/clsEventDetailResponseModel.dart';
import 'package:vakalat_flutter/utils/common_functions.dart';
import 'package:vakalat_flutter/utils/constant.dart';
import 'package:vakalat_flutter/utils/keyboardHiderMixin.dart';
import 'package:flutter_image_slider/carousel.dart';

class EventDetailPage extends StatefulWidget {
  const EventDetailPage({Key? key, required this.title, required this.objEvent})
      : super(key: key);

  final String title;
  final clsEvent objEvent;

  @override
  State<EventDetailPage> createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<EventDetailPage>
    with KeyboardHiderMixin {
  clsEventDetailResponseModel? objEventDetailResponseModel;
  List<Widget> imageSliders = List.empty();

  @override
  void initState() {
    // TODO: implement initState

    APICALL_get_event_detail(true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
        body: (objEventDetailResponseModel == null)
            ? Container()
            : buildBody(context));
  }

  Widget buildBody(BuildContext context) {
    var objEvent = widget.objEvent;
    return ListView(
      children: [
        createBlock_Details(),
        createBlock_Images(),
      ],
    );
  }

  Widget createBlock_Details() {
    var objEvent = widget.objEvent;

    var strThumbnailURL = Const().URL_event_image + objEvent.photo!;

    var strDay =
        CommonFunctions.formatDate("yyyy-MM-dd", "EEE", objEvent.from_date!);
    var strDigit = " ${CommonFunctions.formatDate("yyyy-MM-dd", "dd", objEvent.from_date!)} ";
    var strMonth =
        CommonFunctions.formatDate("yyyy-MM-dd", "MMMM", objEvent.from_date!);
    var strYear =
        CommonFunctions.formatDate("yyyy-MM-dd", "yyyy", objEvent.from_date!);

    var strFee = "";
    if (int.parse(objEvent.registration_fees!) > 0) {
      strFee = objEvent.registration_fees!;
    } else {
      strFee = "Free";
    }
    var strDate = "";
    if (objEvent.from_date! == objEvent.to_date!) {
      strDate = CommonFunctions.formatDate(
          "yyyy-MM-dd", "dd/MM/yyyy", objEvent.from_date!);
    } else {
      strDate = "${CommonFunctions.formatDate(
              "yyyy-MM-dd", "dd/MM/yyyy", objEvent.from_date!)} to ${CommonFunctions.formatDate(
              "yyyy-MM-dd", "dd/MM/yyyy", objEvent.to_date!)}";
    }

    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
      width: double.infinity,
      child: Card(
        color: CustomColor().colorLightBlue,
        clipBehavior: Clip.antiAlias,
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              verticalDirection: VerticalDirection.down,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Container(
                  margin: const EdgeInsets.all(5.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    verticalDirection: VerticalDirection.down,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Expanded(
                        flex: 7,
                        child: Container(
                          margin: const EdgeInsets.all(5.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            verticalDirection: VerticalDirection.down,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              Container(
                                child: Card(
                                  clipBehavior: Clip.antiAlias,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  elevation: 4,
                                  child: FadeInImage.assetNetwork(
                                      placeholder: 'assets/images/loading.gif',
                                      image: strThumbnailURL,
                                      fit: BoxFit.fitHeight),
                                ),
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 5, 8, 0),
                  child: Text(
                    objEvent.event_title!,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: CustomColor().colorPrimary,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 5, 8, 0),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.date_range,
                        color: CustomColor().colorPrimary,
                      ),
                      Text(
                        strDate,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: CustomColor().colorPrimary, fontSize: 14.0),
                      ),
                      // Spacer(),
                      // Icon(
                      //   Icons.paid_outlined,
                      //   color: CustomColor().colorPrimary,
                      // ),
                      // Text(
                      //   strFee,
                      //   textAlign: TextAlign.left,
                      //   style: TextStyle(
                      //       color: CustomColor().colorPrimary,
                      //       fontSize: 14.0),
                      // ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 5, 8, 0),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.watch_later,
                        color: CustomColor().colorPrimary,
                      ),
                      Text(
                        "${objEvent.from_time!} to ${objEvent.to_time!}",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: CustomColor().colorPrimary, fontSize: 14.0),
                      ),
                      // Spacer(),
                      // Icon(
                      //   Icons.paid_outlined,
                      //   color: CustomColor().colorPrimary,
                      // ),
                      // Text(
                      //   strFee,
                      //   textAlign: TextAlign.left,
                      //   style: TextStyle(
                      //       color: CustomColor().colorPrimary,
                      //       fontSize: 14.0),
                      // ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 5, 8, 0),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.location_on,
                        color: CustomColor().colorPrimary,
                      ),
                      Text(
                        objEvent.location!,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: CustomColor().colorPrimary, fontSize: 14.0),
                      ),
                    ],
                  ),
                ),
                (objEvent.law_firm_college!.isEmpty ) ? Container() :
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 5, 8, 0),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.sell,
                        color: CustomColor().colorPrimary,
                      ),
                      Text(
                        objEvent.law_firm_college!,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: CustomColor().colorPrimary, fontSize: 14.0),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 5, 8, 5),
                  child: InkWell(
                    onTap: () {
                      CommonFunctions.makePhoneCall(objEvent.contact_number!);
                    },
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.call,
                          color: CustomColor().colorPrimary,
                        ),
                        Text(
                          objEvent.contact_number!,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: CustomColor().colorPrimary,
                              fontSize: 14.0),
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 5, 8, 5),
                  child: Html(data: objEvent.description!),
                ),
              ],
            )),
      ),
    );
  }

  Widget createBlock_Images() {
    var objEvent = widget.objEvent;

    imageSliders = objEventDetailResponseModel!.images!
        .map((item) => Container(
              child: FadeInImage.assetNetwork(
                  placeholder: 'assets/images/loading.gif',
                  image: Const().URL_event_image + item.image_url!,
                  fit: BoxFit.fitHeight),
            ))
        .toList();

    MediaQueryData queryData;
    queryData = MediaQuery.of(context);

    if (imageSliders.isNotEmpty )
      {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
          width: double.infinity,
          child: Card(
            color: CustomColor().colorLightBlue,
            clipBehavior: Clip.antiAlias,
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  verticalDirection: VerticalDirection.down,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 5, 8, 0),
                      child: Text(
                        "Event Images",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: CustomColor().colorPrimary,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(8, 5, 8, 0),
                      height: 1.0,
                    ),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(8, 5, 8, 0),
                        child: SizedBox(
                            height: queryData.size.height * 0.2,
                            width: queryData.size.width,
                            child: Carousel(
                              indicatorBarColor: Colors.black.withOpacity(0.2),
                              autoScrollDuration: const Duration(seconds: 2),
                              animationPageDuration: const Duration(milliseconds: 500),
                              activateIndicatorColor: Colors.white,
                              animationPageCurve: Curves.bounceInOut,
                              indicatorBarHeight: 20,
                              indicatorHeight: 5,
                              indicatorWidth: 5,
                              unActivatedIndicatorColor: Colors.grey,
                              stopAtEnd: true,
                              autoScroll: true,
                              // widgets
                              items: imageSliders,
                            ))),
                    Container(
                      margin: const EdgeInsets.fromLTRB(8, 5, 8, 5),
                      height: 1.0,
                    ),
                  ],
                )),
          ),
        );
      }
    else
      {
        return Container();
      }

  }

  Future APICALL_get_event_detail(bool showLoader) async {
    clsEventDetailResponseModel objResponse = clsEventDetailResponseModel();
    try {
      Map<String, dynamic> parameters = {
        "event_id": "${widget.objEvent.event_id}",
      };

      if (showLoader == true) EasyLoading.show(status: "Loading...");

      objResponse = await get_event_detail(body: parameters);
      if (objResponse.status == 1) {
        setState(() {
          objEventDetailResponseModel = objResponse;
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
