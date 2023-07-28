import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vakalat_flutter/helper.dart';

import '../../Sharedpref/shared_pref.dart';
import '../../api/postapi.dart';
import '../../color/customcolor.dart';
import '../../model/GetUserInquriesResponseModel.dart';
import '../../model/clsLoginResponseModel.dart';
import '../../pages/dashboard.dart';
import '../../utils/constant.dart';
import 'User_Inquiry_details.dart';

class User_Inquries_screen extends StatefulWidget {
  const User_Inquries_screen({Key? key}) : super(key: key);

  @override
  State<User_Inquries_screen> createState() => _User_Inquries_screenState();
}

class _User_Inquries_screenState extends State<User_Inquries_screen> {
  ClsLoginResponseModel logindetails = clsLoginResponseModelFromJson(
      SharedPref.get(prefKey: PrefKey.loginDetails)!);
  bool show = false;
  get_inquries() async {
    Map<String, dynamic> parameters = {
      "apiKey": apikey,
      'device': '2',
      "accessToken": logindetails.accessToken,
      "user_id": logindetails.userData.userId,
      "offset": "0",
    };
    EasyLoading.show(status: 'Loading...');
    await get_user_inqury(body: parameters).then((value) {
      // log(value.toString());
      setState(() {
        inqury = value;
        show = true;
      });
      EasyLoading.dismiss();
    }).onError((error, stackTrace) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => DashboardPage(title: ''),
          ));
      msgexpire;
      Const().deleteprofilelofinandmenu();
      print(error);
      EasyLoading.dismiss();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    get_inquries();
    log(logindetails.accessToken);
    super.initState();
  }

  late GetUserInquriesResponceModel inqury;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'User Inquries',
          style: TextStyle(
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        backgroundColor: CustomColor().colorPrimary,
      ),
      body: show == true
          ? inqury.inquiries.isEmpty ?Container(
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
      ) :ListView.builder(
            itemCount: inqury.inquiries.length,
            itemBuilder: (context, index) {
              DateTime myDate =
                  DateTime.parse(inqury.inquiries[index].createdDatetime);
              String formatedate = DateFormat('yyyy-MM-dd').format(myDate);
              return InkWell(
                onTap: () async {
                  log(inqury.inquiries[index].id);
                  Map<String, dynamic> parameters = {
                    "apiKey": apikey,
                    'device': '2',
                    "accessToken": logindetails.accessToken,
                    "user_id": logindetails.userData.userId,
                    "user_inquiry_id": inqury.inquiries[index].id,
                  };
                  EasyLoading.show(status: 'Loading...');
                  await get_user_inqury_Details(body: parameters)
                      .then((value) {
                    EasyLoading.dismiss();
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                          title: Container(
                        height: screenheight(context, dividedby: 1.4),
                        width: double.maxFinite,
                        decoration: BoxDecoration(border: Border.all(width: 2,color: CustomColor().colorPrimary)),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Text("Title : User Inquiry",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
                                   SizedBox(height: 10,),
                                text123(
                                    'Inquiry By :',
                                    '${value.userInquiry.firstName} ${value.userInquiry.lastName}',
                                    FontAwesomeIcons.user,
                                    () {}),
                                text2('Email :', value.userInquiry.email,
                                    FontAwesomeIcons.envelope, () {
                                  launch('mailto:${value.userInquiry.email}');
                                }),
                                text2('Mobile :', value.userInquiry.contactNo,
                                    FontAwesomeIcons.mobileScreen, () {
                                  launch('tel:${value.userInquiry.contactNo}');
                                }),
                                text123(
                                    'Inquiry On :',
                                    value.userInquiry.createdDatetime
                                        .toString(),
                                    FontAwesomeIcons.calendar,
                                    () {}),
                                text123('Subject :', value.userInquiry.subject,
                                    FontAwesomeIcons.penFancy, () {}),
                                text123('Details :', "${value.userInquiry.message}",
                                    Icons.arrow_forward , () {}),
                              ],
                            ),
                          ),
                        ),
                      )),
                    );
                  }).onError((error, stackTrace) {
                    print(error);
                    EasyLoading.dismiss();
                  });
                },
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 12, right: 12, top: 12),
                  child: Card(
                    margin: EdgeInsets.zero,
                    elevation: 3,
                    child: Container(
                      // height: 200,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          children: [
                            text('Subject : ',
                                inqury.inquiries[index].subject),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  width: 100,
                                  child: Text(
                                    'User Details : ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${inqury.inquiries[index].firstName} ${inqury.inquiries[index].lastName}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12,
                                            color: Colors.black54),
                                      ),
                                      const SizedBox(
                                        height: 3,
                                      ),
                                      Text(
                                        inqury.inquiries[index].email,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12,
                                            color: Colors.black54),
                                      ),
                                      const SizedBox(
                                        height: 3,
                                      ),
                                      Text(
                                        inqury.inquiries[index].contactNo,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12,
                                            color: Colors.black54),
                                      ),
                                    ],
                                  ),
                                ),
                                const Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.grey,
                                  size: 20,
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            text('Date of Inquiry : ', formatedate),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                // child: Container(
                //   // height: 100,
                //   color: index % 2 == 0
                //       ? Colors.transparent
                //       : Colors.grey.withOpacity(0.2),
                //   child: Padding(
                //     padding: const EdgeInsets.only(
                //         left: 10.0, top: 15, bottom: 15, right: 5),
                //     child: Row(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         Container(
                //           // color: Colors.red,
                //           width: screenwidth(context, dividedby: 3.3),
                //           child: Column(
                //             mainAxisAlignment:
                //                 MainAxisAlignment.start,
                //             children: [
                //               Row(
                //                 children: [
                //                   Icon(
                //                     FontAwesomeIcons.rightLong,
                //                     color: Colors.blueAccent,
                //                     size: 14,
                //                   ),
                //                   SizedBox(
                //                     width: 3,
                //                   ),
                //                   Text(
                //                       inqury.inquiries[index].queryId,
                //                       style: TextStyle(
                //                         fontSize: 12,
                //                       )),
                //                 ],
                //               ),
                //               SizedBox(
                //                 height: 5,
                //               ),
                //               Row(
                //                 mainAxisAlignment:
                //                     MainAxisAlignment.start,
                //                 children: [
                //                   Icon(
                //                     FontAwesomeIcons.rightLong,
                //                     color: Colors.blueAccent,
                //                     size: 14,
                //                   ),
                //                   SizedBox(
                //                     width: 3,
                //                   ),
                //                   Text(
                //                       inqury.inquiries[index].subject,
                //                       style: TextStyle(
                //                         fontSize: 12,
                //                       )),
                //                 ],
                //               ),
                //             ],
                //           ),
                //         ),
                //         Expanded(
                //             child: Column(
                //           crossAxisAlignment:
                //               CrossAxisAlignment.start,
                //           children: [
                //             Text(
                //                 '${inqury.inquiries[index].firstName} ${inqury.inquiries[index].lastName}',
                //                 style: TextStyle(
                //                   fontSize: 12,
                //                 )),
                //             SizedBox(
                //               height: 5,
                //             ),
                //             Text(inqury.inquiries[index].email,
                //                 style: TextStyle(
                //                   fontSize: 12,
                //                 )),
                //             SizedBox(
                //               height: 5,
                //             ),
                //             Text(inqury.inquiries[index].contactNo,
                //                 style: TextStyle(
                //                   fontSize: 12,
                //                 )),
                //           ],
                //         )),
                //         Container(
                //             // color: Colors.green,
                //             width:
                //                 screenwidth(context, dividedby: 4.3),
                //             child: Row(
                //               children: [
                //                 Row(
                //                   children: [
                //                     Text(formatedate,
                //                         style: TextStyle(
                //                           fontSize: 12,
                //                         )),
                //                     SizedBox(
                //                       width: 5,
                //                     ),
                //                     Icon(FontAwesomeIcons.eye,
                //                         color: Colors.blueAccent,
                //                         size: 18),
                //                   ],
                //                 ),
                //               ],
                //             )),
                //       ],
                //     ),
                //   ),
                // ),
              );
            },
          )
          : const SizedBox(
            ),
    );
  }

  text123(String title, String name, IconData icon, Function() ontap) {
    return ListTile(
      onTap: ontap,
      title: Text(title),
      subtitle: Text(name),
      leading: Icon(icon, size: 23),
    );
  }

  text2(String title, String name, IconData icon, Function() ontap) {
    return ListTile(
      onTap: ontap,
      title: Text(title),
      subtitle: Text(name),
      leading: Icon(icon, size: 23),
      trailing: Icon(
        Icons.double_arrow,
        size: 18,
      ),
    );
  }

  text(String text, String answer) {
    return Row(
      children: [
        SizedBox(
          width: 100,
          child: Text(
            text,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ),
        Text(
          answer,
          style: const TextStyle(
              fontWeight: FontWeight.w600, fontSize: 12, color: Colors.black54),
        ),
      ],
    );
  }
}
