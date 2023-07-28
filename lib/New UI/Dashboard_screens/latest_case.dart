import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:vakalat_flutter/helper.dart';
import 'package:vakalat_flutter/model/GetDashboard.dart';

import '../../color/customcolor.dart';

class Latest_Case extends StatefulWidget {
  final Getdashboard value;
  const Latest_Case({Key? key, required this.value}) : super(key: key);

  @override
  State<Latest_Case> createState() => _Latest_CaseState();
}

class _Latest_CaseState extends State<Latest_Case> {
  @override
  Widget build(BuildContext context) {

    return widget.value.data.cases.isEmpty ? Container(
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
    ): ListView.builder(
      itemCount: widget.value.data.cases.length,
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
    );
  }
}
