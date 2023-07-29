import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:vakalat_flutter/New%20UI/My%20Account/Participation/Add_Participation.dart';
import 'package:vakalat_flutter/New%20UI/My%20Account/Participation/Edit_Participation.dart';
import 'package:vakalat_flutter/model/getParticipation.dart';

import '../../../Sharedpref/shared_pref.dart';
import '../../../api/postapi.dart';
import '../../../color/customcolor.dart';
import '../../../helper.dart';
import '../../../model/DeleteServicesModel.dart';
import '../../../model/clsLoginResponseModel.dart';
import '../../../pages/dashboard.dart';
import '../../../utils/constant.dart';
import '../Profile/getxcontroller.dart';
import '../image_viewer.dart';

class Partocipation_myacc extends StatefulWidget {
  const Partocipation_myacc({
    Key? key,
  }) : super(key: key);

  @override
  State<Partocipation_myacc> createState() => _Partocipation_myaccState();
}

class _Partocipation_myaccState extends State<Partocipation_myacc> {

  ClsLoginResponseModel logindetails = clsLoginResponseModelFromJson(
      SharedPref.get(prefKey: PrefKey.loginDetails)!);

  final ProfileControl getxController = Get.put(ProfileControl());

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => const Add_Participation(),
                ));
          },
          child: const Icon(Icons.add)),
      appBar: AppBar(
        title: const Text('Participation'),
        centerTitle: true,
        backgroundColor: CustomColor().colorPrimary,
        elevation: 0,
      ),
      body: getxController.participations.isEmpty ? Container(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          verticalDirection: VerticalDirection.down,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Card(
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                ),
                elevation: 4,
                child:Image.asset('assets/images/nodata_search.png')),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text(
                "No data found.",
                style:  TextStyle(
                    color: CustomColor().colorPrimary,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ):Obx(() => ListView.builder(
        itemCount: getxController.participations.length,
        itemBuilder: (context, index) {
          Participation participation = getxController.participations[index];
          return Padding(
            padding:
            const EdgeInsets.only(left: 10.0, right: 10, top: 10),
            child: Card(
              margin: EdgeInsets.zero,
              elevation: 2,
              child: SizedBox(
                // height: 150,
                width: double.infinity,
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 10.0),
                        child: CachedNetworkImage(
                          imageUrl: Const().URL_achivement_image +
                              participation.achievementCoverImage,
                          imageBuilder: (context, imageProvider) =>
                              InkWell(
                                onTap: () => Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                      builder: (context) => Image_viewer(
                                          image:
                                          Const().URL_achivement_image +
                                              participation
                                                  .achievementCoverImage),
                                    )),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                      // colorFilter:
                                      //     ColorFilter.mode(Colors.red, BlendMode.colorBurn),
                                    ),
                                  ),
                                ),
                              ),
                          placeholder: (context, url) =>
                              Image.asset('assets/images/loading.gif'),
                          errorWidget: (context, url, error) =>
                              Image.asset('assets/images/default.png'),
                          width: 100,
                          height: 100,
                        ),
                        // Image.network(
                        //   Const().URL_achivement_image+achive.achievementCoverImage,
                        //   height: 100,
                        //   width: 100,
                        // ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment:
                          MainAxisAlignment.spaceAround,
                          children: [
                            Const().Textinscreen('Title',
                                participation.achievementBody, context),
                            SizedBox(
                              height: 5,
                            ),
                            Const().Textinscreen('Month',
                                participation.achievementMonth, context),
                            SizedBox(
                              height: 5,
                            ),
                            Const().Textinscreen('Year',
                                participation.achievementYear, context),
                            Row(
                              children: [
                                SizedBox(
                                    width: screenwidth(context,
                                        dividedby: 7),
                                    child: const Text(
                                      'Action',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12),
                                    )),
                                Row(
                                  children: [
                                    MaterialButton(
                                      color: const Color(0xff448BE8),
                                      height: 25,
                                      minWidth: 40,
                                      padding: EdgeInsets.zero,
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  Edit_Participation(
                                                    value : participation,
                                                    title: participation
                                                        .achievementBody,
                                                    month: participation
                                                        .achievementMonth,
                                                    year: participation
                                                        .achievementYear,
                                                    image: participation
                                                        .achievementCoverImage,
                                                    detail: participation
                                                        .achievementDetail,
                                                    achievementId:
                                                    participation
                                                        .achievementId,
                                                  ),
                                            ));
                                      },
                                      child: const Icon(
                                        FontAwesomeIcons.penToSquare,
                                        size: 12,
                                        color: Colors.white,
                                      ),
                                    ),
                                    MaterialButton(
                                      color: const Color(0xffAF3F3F),
                                      height: 25,
                                      minWidth: 40,
                                      padding: EdgeInsets.zero,
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) =>
                                              AlertDialog(
                                                title: Text(
                                                    'Are you Sure Delete Participation ?'),
                                                actions: [
                                                  TextButton(
                                                      onPressed: () {
                                                        delete_participation(
                                                            participation);
                                                      },
                                                      child: Text('Yes')),
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(
                                                            context);
                                                      },
                                                      child: Text('No')),
                                                ],
                                              ),
                                        );
                                      },
                                      child: const Icon(
                                        Icons.delete,
                                        size: 12,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      )
                    ]),
              ),
            ),
          );
        },
      ))
    );
  }

  delete_participation(participation) async {

    EasyLoading.show(status: 'Loading...');
    Map<String, dynamic> parameters = {
      "apiKey": apikey,
      'device': '2',
      "accessToken": logindetails.accessToken,
      "user_id": logindetails.userData.userId,
      "participation_id": participation.achievementId,
      "csrf_token": ""
    };
    DeleteServicesModel delete = await Delete_Participation(body: parameters);
    if (delete.status == 1) {
      Fluttertoast.showToast(msg: delete.message);
      EasyLoading.dismiss();
  getxController.get_Participation_dep2();
    } else {
      EasyLoading.dismiss();

      Fluttertoast.showToast(msg: delete.message);
    }
  }

}
