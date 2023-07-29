import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vakalat_flutter/helper.dart';

import '../../Sharedpref/shared_pref.dart';
import '../../api/postapi.dart';
import '../../color/customcolor.dart';
import '../../model/clsLoginResponseModel.dart';
import '../../pages/dashboard.dart';
import '../../utils/constant.dart';
import '../model/GetUserRating.dart';
import '../utils/ToastMessage.dart';

class Rating_And_Review extends StatefulWidget {
  const Rating_And_Review({Key? key}) : super(key: key);

  @override
  State<Rating_And_Review> createState() => _Rating_And_ReviewState();
}

class _Rating_And_ReviewState extends State<Rating_And_Review> {
  ClsLoginResponseModel logindetails = clsLoginResponseModelFromJson(
      SharedPref.get(prefKey: PrefKey.loginDetails)!);
  String? ratingstatus;
  final Map<String, String> _ratingsapprove = {
    "0": "Pending",
    "1": "Approved",
    "2": "Rejected",
  };
  bool show = false;
  get_Rating() async {
    Map<String, dynamic> parameters = {
      "apiKey": apikey,
      'device': '2',
      "accessToken": logindetails.accessToken,
      "user_id": logindetails.userData.userId,
      "offset": "0",
    };
    EasyLoading.show(status: 'Loading...');
    await getratingreview(body: parameters).then((value) {
      // log(value.toString());
      setState(() {
        rating = value;
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
    get_Rating();
    log(logindetails.accessToken);
    super.initState();
  }

  late GetUserRating rating;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Rating And Reviews',
          style: TextStyle(
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        backgroundColor: CustomColor().colorPrimary,
      ),
      body: show == true
          ? Container(
              child: rating.ratings.isNotEmpty
                  ? ListView.builder(
                      itemCount: rating.ratings.length,
                      itemBuilder: (context, index) {
                        ratingstatus = rating.ratings[index].status;
                        // DateTime myDate =
                        // DateTime.parse(rating.ratings[index].createdAt);
                        // String formatedate = DateFormat('yyyy-MM-dd').format(myDate);
                        return InkWell(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 12, right: 12, top: 12),
                            child: Card(
                              margin: EdgeInsets.zero,
                              elevation: 3,
                              child: Container(
                                // height: 200,
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(
                                            width: 100,
                                            child: Text(
                                              'Details : ',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '${rating.ratings[index].firstName} ${rating.ratings[index].lastName}',
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 14,
                                                    color: Colors.black54),
                                              ),
                                              const SizedBox(
                                                height: 3,
                                              ),
                                              Text(
                                                rating.ratings[index].email,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 14,
                                                    color: Colors.black54),
                                              ),
                                              const SizedBox(
                                                height: 3,
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  launch(
                                                      "tel:${rating.ratings[index].mobile}");
                                                },
                                                child: Text(
                                                  rating.ratings[index].mobile,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 14,
                                                      color: Colors.black54),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 100,
                                            child: Text(
                                              'Rating : ',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                          RatingBarIndicator(
                                            rating: double.parse(
                                                rating.ratings[index].rating),
                                            itemBuilder: (context, index) =>
                                                Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                            ),
                                            itemCount: 5,
                                            itemSize: 20.0,
                                            direction: Axis.horizontal,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 100,
                                            child: Text(
                                              'Review : ',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: screenwidth(context,
                                                dividedby: 1.8),
                                            child: Text(
                                              rating.ratings[index].review,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14,
                                                  color: Colors.black54),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      text('Date: ',
                                          rating.ratings[index].createdAt),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 100,
                                            child: Text(
                                              'Status: ',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: StatefulBuilder(
                                                builder: (context, set) =>
                                                    DropdownButton<String>(
                                                  isDense: true,
                                                  underline: Container(
                                                    color: Colors.transparent,
                                                  ),
                                                  hint: Text("Pending"),
                                                  value: ratingstatus,
                                                  onChanged:
                                                      (String? newValue) async {
                                                    Map<String, dynamic>
                                                        parameters = {
                                                      "apiKey": apikey,
                                                      'device': '2',
                                                      "accessToken":
                                                          logindetails
                                                              .accessToken,
                                                      "user_id": logindetails
                                                          .userData.userId,
                                                      "offset": "0",
                                                      'csrf_token': '',
                                                      'status': newValue,
                                                      'id': rating
                                                          .ratings[index].id,
                                                      'parent_id': logindetails
                                                          .userData.userId
                                                    };
                                                    EasyLoading.show(
                                                        status: 'Loading...');
                                                    await get_review_status(
                                                            body: parameters)
                                                        .then((value) {
                                                      set(() {
                                                        ratingstatus = newValue;
                                                      });
                                                      // log(value.toString());
                                                      ToastMessage()
                                                          .showmessage(
                                                              value.message);
                                                      EasyLoading.dismiss();
                                                    }).onError((error,
                                                            stackTrace) {
                                                      // Navigator.pushReplacement(
                                                      //     context,
                                                      //     MaterialPageRoute(
                                                      //       builder: (context) => DashboardPage(title: ''),
                                                      //     ));
                                                      // msgexpire;
                                                      // Const().deleteprofilelofinandmenu();
                                                      print(error);
                                                      EasyLoading.dismiss();
                                                    });
                                                  },
                                                  items: _ratingsapprove.entries
                                                      .map((entry) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value: entry.key,
                                                      child: Text(entry.value),
                                                    );
                                                  }).toList(),
                                                  isExpanded: true,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  : Container(
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
                              child: Image.asset(
                                  'assets/images/nodata_search.png')),
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
                    ),
            )
          : const SizedBox(
              child: Center(child: Text('No data found')),
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
              fontSize: 14,
            ),
          ),
        ),
        Text(
          answer,
          style: const TextStyle(
              fontWeight: FontWeight.w600, fontSize: 14, color: Colors.black54),
        ),
      ],
    );
  }
}
