import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:vakalat_flutter/helper.dart';
import 'package:vakalat_flutter/model/getAchivements.dart';

import '../../../Sharedpref/shared_pref.dart';
import '../../../api/postapi.dart';
import '../../../color/customcolor.dart';
import '../../../model/DeleteServicesModel.dart';
import '../../../model/clsLoginResponseModel.dart';
import '../../../utils/constant.dart';
import '../../model/GetSubscription.dart';

class subscrption_screen extends StatefulWidget {
  final GetSubscripation data;
  const subscrption_screen({Key? key, required this.data}) : super(key: key);

  @override
  State<subscrption_screen> createState() => _subscrption_screenState();
}

class _subscrption_screenState extends State<subscrption_screen> {
  String expirydate ='';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Subscription'),
        centerTitle: true,
        backgroundColor: CustomColor().colorPrimary,
        elevation: 0,
      ),
      body: widget.data.subscriptions.length == 0 ?Container(
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
      ):ListView.builder(
        itemCount: widget.data.subscriptions.length,
        itemBuilder: (context, index) {

          final Subscription subscription =
          widget.data.subscriptions[index];
expirydate = DateFormat('dd/MM/yyyy').format(subscription.expireDate);
          return Padding(
            padding:
            const EdgeInsets.only(left: 10.0, right: 10, top: 12),
            child: Card(
              margin: EdgeInsets.zero,
              elevation: 2,
              child: SizedBox(
                // height: 150,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical:  15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Const().Textinscreen2('Receipt No.',
                          subscription.rpReceiptNo, context),
                      // SizedBox(
                      //   height: 5,
                      // ),
                      Const().Textinscreen2('Package Name',
                          subscription.packageName, context),
                      // SizedBox(
                      //   height: 5,
                      // ),
                      Const().Textinscreen2(
                          'Amount/Discount',
                          '${subscription.rpAmount}/${subscription.rpDiscountAmount}',
                          context),
                      Const().Textinscreen2(
                          'GST',
                         "0",
                          context),
                      Const().Textinscreen2(
                          'Payment Mode',
                          subscription.paymentStatus,
                          context),
                      Const().Textinscreen2(
                          'Expire date',
                          expirydate,
                          context),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 3),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            // color: Colors.blue,
                              width: screenwidth(context, dividedby: 3),
                              child: Text(
                                'Status',
                                style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                              )),
                          Text(
                            ':',
                            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                          ),
                          SizedBox(width: 10,),
                          Container(
                            // color: Colors.blueAccent,
                            width: screenwidth(context, dividedby: 2.2),
                            child: Text(
                              subscription.status == '1'?"Active":"Expire!",
                              style:  TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 14, color: subscription.status ==  "1"?Colors.green:Colors.red),
                            ),
                          ),
                        ],
                      ),
                    ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 3),
                        child: Row(
                          children: [
                            SizedBox(
                                width: screenwidth(context, dividedby: 3),
                                child: const Text(
                                  'Action',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12),
                                )),
                            // SizedBox(width: 15,),
                            MaterialButton(
                              color: const Color(0xff448BE8),
                              height: 25,
                              minWidth: 55,
                              padding: EdgeInsets.zero,
                              onPressed: () {},
                              child: const Icon(
                                FontAwesomeIcons.eye,
                                size: 12,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      )
    );
  }
}
