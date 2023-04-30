import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import '../../color/customcolor.dart';
import '../../helper.dart';
import '../../utils/constant.dart';

import 'package:vakalat_flutter/model/GetDashboard.dart';

class Joined_Event extends StatefulWidget {
  final Getdashboard value;
  const Joined_Event({Key? key, required this.value}) : super(key: key);

  @override
  State<Joined_Event> createState() => _Joined_EventState();
}

class _Joined_EventState extends State<Joined_Event> {
  @override
  Widget build(BuildContext context) {

    return widget.value.data.events.data.isNotEmpty ? ListView.builder(
      itemCount: widget.value.data.events.data.length,
      itemBuilder: (context, index) {
        EventsDatum events = widget.value.data.events.data[index];
        final formDate = DateFormat('yyyy-MM-dd')
            .format(widget.value.data.events.data[index].fromDate);
        final toDate = DateFormat('yyyy-MM-dd')
            .format(widget.value.data.events.data[index].toDate );

        return Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
          child: Card(
              margin: EdgeInsets.zero,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                   Const().textrow('Title :', events.eventTitle,context),
                   Const().textrow('Firm/Collage Name :',
                        events.lawFirmCollege,context),
                     Const().textrow('Contact :', events.contactNumber,context),
                     // Const().textrow('Applied Date :',
                     //     formDate,context),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 5,bottom: 5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          width: screenwidth(context, dividedby: 2.5),
                          child: Text(
                            'Applied Date :',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: CustomColor().colorPrimary),
                          )),
                      Container(
                        width: screenwidth(context,dividedby: 2.2),
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  formDate,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(width: 5,),
                                Text(
                                  events.fromTime,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),          Row(
                              children: [
                                Text(
                                  toDate,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(width: 5,),
                                Text(
                                  events.toTime,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                  ],
                ),
              )),
        );
      },
    ) : Center(child: Text('No Data'),);
  }
}
