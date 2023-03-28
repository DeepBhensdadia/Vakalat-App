
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:vakalat_flutter/api/postapi.dart';
import 'package:vakalat_flutter/color/customcolor.dart';
import 'package:vakalat_flutter/model/clsJob.dart';
import 'package:vakalat_flutter/model/clsJobResponseModel.dart';
import 'package:vakalat_flutter/pages/jobdetailpage.dart';
import 'package:vakalat_flutter/utils/keyboardHiderMixin.dart';

class JobsPage extends StatefulWidget {
  const JobsPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<JobsPage> createState() => _JobsPageState();
}

class _JobsPageState extends State<JobsPage> with KeyboardHiderMixin {
  List<clsJob> arrJobs = [];

  int offset = 0;

  @override
  void initState() {
    // TODO: implement initState
    APICALL_getJobs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return createJobList();
  }

  Widget createJobList() {
    return RefreshIndicator(
      onRefresh: () {
        offset = 0;
        return APICALL_getJobs();
      },
      child: Column(children: [
        Expanded(
          child: ListView.separated(
              separatorBuilder: (context, index) =>
                  const Divider(height: 1, color: Colors.transparent),
              itemCount: arrJobs.length,
              itemBuilder: (context, index) {
                return createBlock(index);
              }),
        ),
      ]),
    );
  }

  Widget createBlock(int index) {
    var objJob = arrJobs[index];

    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
      width: double.infinity,
      child:Card(
        color: CustomColor().colorLightBlue,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
        elevation: 4,
        child:  InkWell(
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
                child: JobDetailPage(
                  title: "",
                  objJobs : objJob,
                ),
              ),
            );
          });
        },
        child: Container(
            padding: const EdgeInsets.all(10.0),
            child:  Row(
              children: <Widget>[ Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  verticalDirection: VerticalDirection.down,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      objJob.jp_job_title!,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: CustomColor().colorPrimary,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.business_center,
                          color: CustomColor().colorPrimary,
                        ),
                        Text(
                          " ${objJob.jp_experience!} year(s) of Experience",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: CustomColor().colorPrimary, fontSize: 14.0),
                        ),

                      ],
                    ),
                    Row(
                      children: <Widget>[

                        Icon(
                          Icons.location_on,
                          color: CustomColor().colorPrimary,
                        ),
                        Text(
                          "${objJob.city_name!},${objJob.state_name!},${objJob.country_name!}",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: CustomColor().colorPrimary, fontSize: 14.0),
                        ),
                      ],
                    ),
                    // new Html( data: objJob.jp_description!,),
                  ],
                ),
              ),
                const Icon(Icons.keyboard_arrow_right)
            ],
            ),
          ),
        ),
      ),
    );
  }

  void updateData_Event(List<clsJob> Data) {
    setState(() {
      arrJobs.clear();
      arrJobs.addAll(Data);
    });
  }

  Future APICALL_getJobs() async {
    int offset = 0;
    clsJobResponseModel objResponse = clsJobResponseModel();
    try {
      Map<String, dynamic> parameters = {
        "offset": "$offset",
      };
      EasyLoading.show(status: "Loading...");

      objResponse = await get_jobs(body: parameters);
      if (objResponse.status == 1) {
        updateData_Event(objResponse.jobs!);
        EasyLoading.dismiss(animation: true);
      } else {
        EasyLoading.dismiss(animation: true);

        EasyLoading.showToast(objResponse.message!);
      }
    } catch (exception) {
      if (kDebugMode) {
        print(exception.toString());
      }
      //EasyLoading.showToast("" + exception.toString());
     EasyLoading.dismiss(animation: true);
    }
  }
}
