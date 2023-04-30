import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:vakalat_flutter/Sharedpref/shared_pref.dart';
import 'package:vakalat_flutter/model/GetDashboard.dart';
import 'package:vakalat_flutter/model/Get_Profile.dart';
import 'package:vakalat_flutter/utils/constant.dart';
import 'package:vakalat_flutter/utils/constant.dart';
import 'package:vakalat_flutter/utils/constant.dart';
import 'package:vakalat_flutter/utils/constant.dart';

import '../../../color/customcolor.dart';
import '../../../helper.dart';

class Jobs_Main extends StatefulWidget {
  final Getdashboard value;
  const Jobs_Main({Key? key, required this.value}) : super(key: key);

  @override
  State<Jobs_Main> createState() => _Jobs_MainState();
}

class _Jobs_MainState extends State<Jobs_Main>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: tabs.length, vsync: this, initialIndex: 0);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  final List<Tab> tabs = <Tab>[
    const Tab(child: Text("Latest Job")),
    const Tab(child: Text("My Applied")),
  ];



  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(
          thickness: 1.5,
          indent: 20,
          endIndent: 20,
        ),
        SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 30,
          child: TabBar(
              controller: _tabController,
              isScrollable: true,

              // labelStyle: TextStyle(fontSize: 16,color: CustomColor().colorPrimary),
              indicator: BoxDecoration(
                  color: CustomColor().colorPrimary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(5)),
              unselectedLabelColor: CustomColor().colorLightGray,
              // padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 8),
              labelColor: CustomColor().colorPrimary,
              tabs: tabs),
        ),
        SizedBox(
          height: 10,
        ),
        Expanded(
            child: TabBarView(
          controller: _tabController,
          children: [
            widget.value.data.jobs.isNotEmpty
                ? ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      Case latestcase = widget.value.data.cases[index];
                      final formattedDate = DateFormat('yyyy-MM-dd').format(
                          widget.value.data.cases[index].caseHearingDate);

                      return Padding(
                        padding:
                            const EdgeInsets.only(left: 10, right: 10, top: 10),
                        child: Card(
                            margin: EdgeInsets.zero,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'Title :',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        '',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )),
                      );
                    },
                  )
                : Center(
                    child: Text('No Data'),
                  ),
            Container(
                child: ListView.builder(
              itemCount: widget.value.data.appliedjobs.length,
              itemBuilder: (context, index) {
                Appliedjob appliedjob = widget.value.data.appliedjobs[index];
                final formattedDate = DateFormat('yyyy-MM-dd')
                    .format(widget.value.data.cases[index].caseHearingDate);

                return Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                  child: Card(
                      margin: EdgeInsets.zero,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Const().textrow('Title :', appliedjob.jpJobTitle,context),
                            Const().textrow('Firm/Collage Name :',
                                appliedjob.lawFirmCollege,context),
                           Const().textrow('Contact :', appliedjob.mobile,context),
                            Const().textrow('Applied Date :',
                                appliedjob.applyJobCreatedDatetime,context),
                          ],
                        ),
                      )),
                );
              },
            )),
          ],
        ))
      ],
    );
  }
}
