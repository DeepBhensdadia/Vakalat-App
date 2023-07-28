import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vakalat_flutter/helper.dart';
import 'package:vakalat_flutter/model/GetDashboard.dart';

import '../../color/customcolor.dart';

class Latest_Inquiries extends StatefulWidget {
  final Getdashboard value;
  const Latest_Inquiries({Key? key, required this.value}) : super(key: key);

  @override
  State<Latest_Inquiries> createState() => _Latest_InquiriesState();
}

class _Latest_InquiriesState extends State<Latest_Inquiries> {
  @override
  Widget build(BuildContext context) {

    return widget.value.data.inquiries.isNotEmpty ? ListView.builder(
      itemCount: widget.value.data.inquiries.length,
      itemBuilder: (context, index) {
        Inquiry inq = widget.value.data.inquiries[index];

        DateTime myDate =
        DateTime.parse(widget.value.data.inquiries[index].createdDatetime);
        String formatedate = DateFormat('dd/MM/yyyy').format(myDate);
        return Padding(
          padding: const EdgeInsets.only(left: 12,right: 12,top: 12),
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
                      inq.subject),
                    SizedBox(height: 5,),
                    text('message : ',
                      inq.message),
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
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${inq.firstName} ${inq.lastName}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Colors.black54),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Text(
                              inq.email,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Colors.black54),
                            ), const SizedBox(
                              height: 3,
                            ),
                            InkWell(
                              onTap: () {
                                launch('tel:${inq.contactNo}');
                              },
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 3.0),
                                    child: Text(
                                      inq.contactNo,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                          color: Colors.black54),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 5,),
                    text('Date of Inquiry : ',
                        formatedate),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    ) : Container(
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
