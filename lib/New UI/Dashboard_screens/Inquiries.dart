import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:vakalat_flutter/helper.dart';
import 'package:vakalat_flutter/model/GetDashboard.dart';

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
      itemCount: 10,
      itemBuilder: (context, index) {
        Case latestcase = widget.value.data.cases[index];
        final formattedDate = DateFormat('yyyy-MM-dd').format(widget.value.data.cases[index].caseHearingDate);

        return Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
          child: Card(
            margin: EdgeInsets.zero,
            child: SizedBox(
              // height: 80,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: screenwidth(context,dividedby: 1.8),

                          child: Text(
                            '${latestcase.caseDetailsId}  ${latestcase.caseTitle}',
                            style: const TextStyle(
                                overflow: TextOverflow.ellipsis,
                                color: Colors.blue,
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Row(
                          children:  [
                            Icon(
                              Icons.call,
                              size: 13,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text('${latestcase.firstName} ${latestcase.lastName} - ${latestcase.mobile}',
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black54)),
                          ],
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          color: Colors.yellow,
                          child: const Padding(
                            padding: EdgeInsets.all(2.0),
                            child: Text(
                              'in process',
                              style:
                              TextStyle(fontSize: 12, color: Colors.green),
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Row(
                          children:  [
                            Icon(
                              FontAwesomeIcons.calendar,
                              size: 14,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(formattedDate.toString(),
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w500)),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    ) : Center(child: Text('No Data'),);
  }
}
