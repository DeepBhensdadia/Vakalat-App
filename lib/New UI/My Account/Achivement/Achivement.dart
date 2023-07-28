import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:vakalat_flutter/New%20UI/My%20Account/image_viewer.dart';
import 'package:vakalat_flutter/helper.dart';
import 'package:vakalat_flutter/model/getAchivements.dart';
import 'package:vakalat_flutter/utils/ToastMessage.dart';

import '../../../Sharedpref/shared_pref.dart';
import '../../../api/postapi.dart';
import '../../../color/customcolor.dart';
import '../../../model/DeleteServicesModel.dart';
import '../../../model/clsLoginResponseModel.dart';
import '../../../pages/dashboard.dart';
import '../../../utils/constant.dart';
import '../Profile/getxcontroller.dart';
import 'Add_Achivements.dart';
import 'Edit_Achivement.dart';

class Achivement_Screen extends StatefulWidget {
  @override
  State<Achivement_Screen> createState() => _Achivement_ScreenState();
}

class _Achivement_ScreenState extends State<Achivement_Screen> {
  final ProfileControl getxController = Get.put(ProfileControl());

  bool show = false;
  ClsLoginResponseModel logindetails = clsLoginResponseModelFromJson(
      SharedPref.get(prefKey: PrefKey.loginDetails)!);



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

           Get.to(()=> Add_Achivements());
          },
          child: const Icon(Icons.add)),
      appBar: AppBar(
        title: const Text('Achivements'),
        centerTitle: true,
        backgroundColor: CustomColor().colorPrimary,
        elevation: 0,
      ),
      body: getxController.achievements.isEmpty
          ? Container(
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
                child:
                Image.asset('assets/images/nodata_search.png')),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text(
                "No data found.",
                style: TextStyle(
                    color: CustomColor().colorPrimary,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      )
          : Obx(() => ListView.builder(
        itemCount:  getxController.achievements.length,
        itemBuilder: (context, index) {
          final Achievement achive =  getxController.achievements[index];

          return Padding(
            padding:
            const EdgeInsets.only(left: 10.0, right: 10, top: 12),
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0),
                        child: CachedNetworkImage(
                          imageUrl: Const().URL_achivement_image +
                              achive.achievementCoverImage,
                          imageBuilder: (context, imageProvider) =>
                              InkWell(
                                onTap: () => Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                      builder: (context) => Image_viewer(
                                          image: Const()
                                              .URL_achivement_image +
                                              achive
                                                  .achievementCoverImage),
                                    )),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.circular(5),
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                      // colorFilter:
                                      //     ColorFilter.mode(Colors.red, BlendMode.colorBurn),
                                    ),
                                  ),
                                ),
                              ),
                          placeholder: (context, url) => Image.asset(
                              'assets/images/loading.gif'),
                          errorWidget: (context, url, error) =>
                              Image.asset(
                                  'assets/images/default.png'),
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
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          mainAxisAlignment:
                          MainAxisAlignment.spaceAround,
                          children: [
                            Const().Textinscreen('Title',
                                achive.achievementBody, context),
                            SizedBox(
                              height: 5,
                            ),
                            Const().Textinscreen('Month',
                                achive.achievementMonth, context),
                            SizedBox(
                              height: 5,
                            ),
                            Const().Textinscreen('Year',
                                achive.achievementYear, context),
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
                                        Get.to(()=> Edit_Achivement(
                                            value: achive),);
                                      },
                                      child: const Icon(
                                        FontAwesomeIcons.edit,
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
                                                    'Are you Sure Delete Achivement ?'),
                                                actions: [
                                                  TextButton(
                                                      onPressed: () {
                                                        Delete(achive);
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

  Delete(achive) async {
    EasyLoading.show(status: 'Loading...');
    Map<String, dynamic> parameters = {
      "apiKey": apikey,
      'device': '2',
      "accessToken": logindetails.accessToken,
      "user_id": logindetails.userData.userId,
      "achievement_id": achive.achievementId,
      "csrf_token": ""
    };
    DeleteServicesModel delete = await Delete_Achivement(body: parameters);
    if (delete.status == 1) {
      Fluttertoast.showToast(msg: delete.message);
      EasyLoading.dismiss();
   getxController.get_Achivement_dep2(context);
    } else {
      EasyLoading.dismiss();

      Fluttertoast.showToast(msg: delete.message);
    }
  }
}
