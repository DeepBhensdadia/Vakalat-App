
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_html/flutter_html.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:vakalat_flutter/api/postapi.dart';
import 'package:vakalat_flutter/color/customcolor.dart';
import 'package:vakalat_flutter/model/clsJob.dart';
import 'package:vakalat_flutter/model/clsJobDetailResponseModel.dart';
import 'package:vakalat_flutter/utils/common_functions.dart';
import 'package:vakalat_flutter/utils/constant.dart';
import 'package:vakalat_flutter/utils/keyboardHiderMixin.dart';

class JobDetailPage extends StatefulWidget {
  const JobDetailPage({Key? key, required this.title, required this.objJobs})
      : super(key: key);

  final String title;
  final clsJob objJobs;

  @override
  State<JobDetailPage> createState() => _JobDetailPageState();
}

class _JobDetailPageState extends State<JobDetailPage> with KeyboardHiderMixin {
  clsJobDetailResponseModel? objJobDetailResponseModel;

  @override
  void initState() {
    // TODO: implement initState
    APICALL_get_lawyer_details(true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: CustomColor().colorPrimary,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: (objJobDetailResponseModel == null)
            ? Container()
            : buildBody(context));
  }

  Widget buildBody(BuildContext context) {
    String strProfileImageURL = Const().URL_profile_pic_Thumbnail +
        objJobDetailResponseModel!.job!.profile_pic!;

    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 5.0, 5, 2),
          child: Text(
            "Apply For ${widget.objJobs.jp_job_title!}",
            style: TextStyle(
              color: CustomColor().colorPrimary,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.left,
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Divider(
            color: Colors.black,
            height: 20,
          ),
        ),
        // Column(
        //   crossAxisAlignment: CrossAxisAlignment.center,
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   verticalDirection: VerticalDirection.down,
        //   textBaseline: TextBaseline.alphabetic,
        //   children: <Widget>[
        //     Row(
        //       crossAxisAlignment: CrossAxisAlignment.center,
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       verticalDirection: VerticalDirection.down,
        //       textBaseline: TextBaseline.alphabetic,
        //       children: <Widget>[
        //         Container(
        //           padding: const EdgeInsets.all(2.0),
        //           height: 150.0,
        //           width: 150.0,
        //           child: CachedNetworkImage(
        //             imageUrl: strProfileImageURL,
        //             imageBuilder: (context, imageProvider) => Container(
        //               decoration: BoxDecoration(
        //                 shape: BoxShape.circle,
        //                 image: DecorationImage(
        //                   image: imageProvider,
        //                   fit: BoxFit.cover,
        //                   // colorFilter:
        //                   //     ColorFilter.mode(Colors.red, BlendMode.colorBurn),
        //                 ),
        //               ),
        //             ),
        //             placeholder: (context, url) =>
        //                 Image.asset('assets/images/loading.gif'),
        //             errorWidget: (context, url, error) =>
        //                 Image.asset('assets/images/default.png'),
        //           ),
        //         ),
        //       ],
        //     ),
        //     Text(
        //       "" + objJobDetailResponseModel!.job!.law_firm_college!,
        //       style: TextStyle(
        //         color: CustomColor().colorPrimary,
        //         fontSize: 18,
        //         fontWeight: FontWeight.bold,
        //       ),
        //       textAlign: TextAlign.center,
        //     ),
        //   ],
        // ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 5.0, 5, 0),
          child: Text(
            "Job Summary",
            style: TextStyle(
              color: CustomColor().colorPrimary,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.left,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Card(
            color: CustomColor().colorLightBlue,
            clipBehavior: Clip.hardEdge,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.0),
            ),
            elevation: 4,
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  verticalDirection: VerticalDirection.down,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    jobSummary(
                      context,
                      Icon(
                        Icons.location_on,
                        color: CustomColor().colorPrimary,
                      ),
                      "${objJobDetailResponseModel!.job!.city_name!},${objJobDetailResponseModel!.job!.state_name!},${objJobDetailResponseModel!.job!.country_name!}",
                    ),
                    jobSummary(
                        context,
                        Icon(
                          Icons.business_center,
                          color: CustomColor().colorPrimary,
                        ),
                        objJobDetailResponseModel!.job!.wt_name!),
                    jobSummary(
                        context,
                        Icon(
                          Icons.transgender,
                          color: CustomColor().colorPrimary,
                        ),
                        CommonFunctions.getGenderName(
                                objJobDetailResponseModel!.job!.jp_gender!)),
                    jobSummary(
                        context,
                        Icon(
                          Icons.workspace_premium,
                          color: CustomColor().colorPrimary,
                        ),
                        "Experience ${objJobDetailResponseModel!.job!.jp_experience!} year(s)"),
                    jobSummary(
                        context,
                        Icon(
                          Icons.date_range,
                          color: CustomColor().colorPrimary,
                        ),
                        "Posted On ${CommonFunctions.formatDate(
                                "yyyy-MM-dd HH:mm:ss",
                                "dd/MM/yyyy",
                                objJobDetailResponseModel!
                                    .job!.jp_created_datetime!)}"),
                    jobSummary(
                        context,
                        Icon(
                          Icons.touch_app,
                          color: CustomColor().colorPrimary,
                        ),
                        CommonFunctions.getBoolenName(objJobDetailResponseModel!
                                .job!.jp_fresher_apply!)
                            ? "Freshers can Apply"
                            : "Freshers can't Apply"),
                    CommonFunctions.getBoolenName(
                            objJobDetailResponseModel!.job!.jp_is_lpo!)
                        ? jobSummary(
                            context,
                            Icon(
                              Icons.fingerprint,
                              color: CustomColor().colorPrimary,
                            ),
                            "LPO Job")
                        : Container(),
                    CommonFunctions.getBoolenName(
                            objJobDetailResponseModel!.job!.jp_is_pw!)
                        ? jobSummary(
                            context,
                            Icon(
                              Icons.fingerprint,
                              color: CustomColor().colorPrimary,
                            ),
                            "Paralegal Work")
                        : Container(),
                  ]),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 5.0, 5, 0),
          child: Text(
            "Job Description",
            style: TextStyle(
              color: CustomColor().colorPrimary,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.left,
          ),
        ),
        Padding(
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
              child: Html(
                data: objJobDetailResponseModel!.job!.jp_description!,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 5.0, 5, 0),
          child: Text(
            "Post by : ${objJobDetailResponseModel!.job!.ut_name!}" ,
            style: TextStyle(
              color: CustomColor().colorPrimary,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.left,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Card(
            color: CustomColor().colorLightBlue,
            clipBehavior: Clip.hardEdge,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.0),
            ),
            elevation: 4,
            child: Container(
              padding: const EdgeInsets.all(2),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                verticalDirection: VerticalDirection.down,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      padding: const EdgeInsets.all(0.0),
                      height: 100.0,
                      child: Card(
                        clipBehavior: Clip.hardEdge,
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
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 7,
                    child: Container(
                      margin: const EdgeInsets.all(5.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        verticalDirection: VerticalDirection.down,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              objJobDetailResponseModel!.job!.law_firm_college!,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: CustomColor().colorPrimary,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),


                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget jobSummary(BuildContext context, Icon icon, String strValue) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0, top: 5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        verticalDirection: VerticalDirection.down,
        textBaseline: TextBaseline.alphabetic,
        children: <Widget>[
          icon,
          const Padding(padding: EdgeInsets.only(left: 5)),
          Text(
            strValue,
            textAlign: TextAlign.left,
            style: TextStyle(color: CustomColor().colorPrimary, fontSize: 14.0),
          ),
        ],
      ),
    );
  }

  Future APICALL_get_lawyer_details(bool showLoader) async {
    clsJobDetailResponseModel objResponse = clsJobDetailResponseModel();
    try {
      Map<String, dynamic> parameters = {
        "job_id": "${widget.objJobs.jp_id}",
      };

      if (showLoader == true) EasyLoading.show(status: "Loading...");

      objResponse = await get_job_detail(body: parameters);
      if (objResponse.status == 1) {
        setState(() {
          objJobDetailResponseModel = objResponse;
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
