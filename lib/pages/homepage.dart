
import 'package:flutter/material.dart';
import 'package:vakalat_flutter/color/customcolor.dart';
import 'package:vakalat_flutter/pages/home/home_events_page.dart';
import 'package:vakalat_flutter/pages/home/home_legalnews_page.dart';
import 'package:vakalat_flutter/pages/home/home_legalnotice_page.dart';
import 'package:vakalat_flutter/pages/home/home_livesessions_page.dart';
import 'package:vakalat_flutter/pages/home/home_videos_page.dart';
import 'package:vakalat_flutter/utils/keyboardHiderMixin.dart';

import 'package:vakalat_flutter/pages/home/home_wall_page.dart';
import 'package:vakalat_flutter/pages/dashboard.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title, required this.selectedPage, required this.dashboardPageState }) : super(key: key);

  final DashboardPageState dashboardPageState ;
  final String title;
  final int selectedPage;
  @override
  State<HomePage> createState() => HomePageState();
}


class HomePageState extends State<HomePage> with KeyboardHiderMixin  , SingleTickerProviderStateMixin {

  late TabController tabController;
  int currentIndex = 0;
  final List<Tab> tabs = <Tab>[
    const Tab(child: Text("Wall")),
    const Tab(child: Text("Know your law")),
    const Tab(child: Text("Live Sessions")),
    const Tab(child: Text("Events")),
    const Tab(child: Text("Legal News")),
    const Tab(child: Text("Public Legal Notice")),
  ];
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    tabController = TabController(vsync: this, length: tabs.length , initialIndex: 0,);

  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: widget.selectedPage,
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          flexibleSpace: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TabBar(
                controller: tabController,
                isScrollable: true,
                indicator: UnderlineTabIndicator(
                  borderSide:
                  BorderSide(color: CustomColor().colorPrimary, width: 2.0),
                ),
                unselectedLabelColor: CustomColor().colorLightGray,
                indicatorSize: TabBarIndicatorSize.label,
                labelColor: CustomColor().colorPrimary,
                tabs: tabs
              )
            ],
          ),
        ),
        body: TabBarView(
          controller: tabController,
          children: [
            createHomeWallPage(),
            createHomeVideosPage(),
            createHomeLiveSessionsPage(),
            createHomeEventsPage(),
            createHomeLegalNewsPage(),
            createHomeLegalNoticePage(),
          ],
        ),
      ),
    );

  }

  Widget createHomeWallPage() {
    return home_wall_page(title: "title" ,dashboardPageState: widget.dashboardPageState, homePageState: this,);
  }

  Widget createHomeVideosPage() {
    return const home_videos_page(title: "title");
  }
  Widget createHomeLiveSessionsPage() {
    return const home_livesessions_page(title: "title");
  }
  Widget createHomeEventsPage() {
    return const home_events_page(title: "title");
  }
  Widget createHomeLegalNewsPage() {
    return const home_legalnews_page(title: "title");
  }
  Widget createHomeLegalNoticePage() {
    return const home_legalnotice_page(title: "title");
  }


  void gotoVideoPage()
  {
    print("gotoVideoPage");
    tabController.index = 1;

  }
  void gotoEventPage()
  {
    print("gotoVideoPage");
    tabController.index = 3;

  }
  void gotoLegalNewsPage()
  {
    print("gotoVideoPage");
    tabController.index = 4;

  }
}
