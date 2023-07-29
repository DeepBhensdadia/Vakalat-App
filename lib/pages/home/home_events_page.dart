
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:vakalat_flutter/api/postapi.dart';
import 'package:vakalat_flutter/color/customcolor.dart';
import 'package:vakalat_flutter/model/clsCity.dart';
import 'package:vakalat_flutter/model/clsCityResponseModel.dart';
import 'package:vakalat_flutter/model/clsEvent.dart';
import 'package:vakalat_flutter/model/clsEventResponseModel.dart';
import 'package:vakalat_flutter/pages/eventdetailpage.dart';
import 'package:vakalat_flutter/utils/common_functions.dart';
import 'package:vakalat_flutter/utils/constant.dart';
import 'package:vakalat_flutter/utils/keyboardHiderMixin.dart';
import 'package:vakalat_flutter/widgets/my_badge.dart';

class home_events_page extends StatefulWidget {
  const home_events_page({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<home_events_page> createState() => _home_events_page_State();
}

class _home_events_page_State extends State<home_events_page>
    with KeyboardHiderMixin {
  // There is next page or not
  bool _hasNextPage = true;

  // Used to display loading indicators when _firstLoad function is running
  bool _isFirstLoadRunning = false;

  // Used to display loading indicators when _loadMore function is running
  bool _isLoadMoreRunning = false;
  bool _isLoading = false;
  late ScrollController _controller;
  TextEditingController txtSearchController = TextEditingController();
  TextEditingController txtSearchController_City = TextEditingController();

  List<clsEvent> arrEvents = [];

  List<String> arrFilterList = [];

  List<clsCity> arrCity_final = [];
  List<clsCity> arrCity = [];
  List<clsCity> arrCity_filter = [];
  List<clsCity> arrCity_selected = [];
  int selected_FilterIndex = 0;
  int offset = 0;

  late StateSetter statePage;

  @override
  void initState() {
    // TODO: implement initState
    _controller = ScrollController()..addListener(_loadMore);
    txtSearchController.addListener(onSearchTextChanged);
    txtSearchController_City.addListener(onSearchTextChanged_City);
    arrFilterList.clear();
    arrFilterList.add("City");

    APICALL_get_cities(true);

    loadData(true);

    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
            padding: const EdgeInsets.all(4.0),
            color: Colors.white,
            child: _buildSearchBox(context)),
        Expanded(child: createEventsList()),
      ],
    );
  }

  Widget createEventsList() {
    return RefreshIndicator(
      onRefresh: () {
        arrEvents.clear();
        _hasNextPage = false;
        _isFirstLoadRunning = true;
        _isLoadMoreRunning = false;
        offset = 0;
        return APICALL_getEvent(true);
      },
      child: Column(children: [
        Expanded(
          child: ListView.separated(
              controller: _controller,
              separatorBuilder: (context, index) =>
                  const Divider(height: 1, color: Colors.transparent),
              itemCount: arrEvents.length,
              itemBuilder: (context, index) {
                return createBlock(index);
              }),
        ),
        if (_isLoadMoreRunning == true)
          Padding(
            padding: const EdgeInsets.only(top: 5, bottom: 5),
            child: Center(
              child: LinearProgressIndicator(
                backgroundColor: const Color(0xFFB4B4B4),
                valueColor:
                    AlwaysStoppedAnimation<Color>(CustomColor().colorPrimary),
              ),
            ),
          ),
      ]),
    );
  }

  Widget createBlock(int index) {
    var objEvent = arrEvents[index];

    var strThumbnailURL = Const().URL_event_image + objEvent.is_cover!;

    var strDay =
        CommonFunctions.formatDate("yyyy-MM-dd", "EEE", objEvent.from_date!);
    var strDigit = " ${CommonFunctions.formatDate("yyyy-MM-dd", "dd", objEvent.from_date!)} ";
    var strMonth =
        CommonFunctions.formatDate("yyyy-MM-dd", "MMMM", objEvent.from_date!);
    var strYear =
        CommonFunctions.formatDate("yyyy-MM-dd", "yyyy", objEvent.from_date!);

    var strFee = "";
    if (int.parse(objEvent.registration_fees!) > 0) {
      strFee = objEvent.registration_fees!;
    } else {
      strFee = "Free";
    }

    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
      width: double.infinity,
      child: Card(
        color: CustomColor().colorLightBlue,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
        elevation: 4,
        child: InkWell(
            splashColor: CustomColor().colorPrimary.withOpacity(0.4),
            onTap: () {
              setState(() {
                // onTap

                print("onTap");

                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.rightToLeftWithFade,
                    duration: const Duration(milliseconds: 300),
                    child: EventDetailPage(
                      title: "",
                      objEvent: objEvent,
                    ),
                  ),
                );
              });
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              verticalDirection: VerticalDirection.down,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  verticalDirection: VerticalDirection.down,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          verticalDirection: VerticalDirection.down,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Container(
                              margin: const EdgeInsets.all(10),
                            ),
                            Text(
                              strDay,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: CustomColor().colorPrimary,
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.normal),
                            ),
                            Card(
                              color: CustomColor().colorPrimary,
                              clipBehavior: Clip.antiAlias,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              elevation: 4,
                              child: Text(
                                strDigit,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: CustomColor().colorWhite,
                                    fontSize: 42.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Text(
                              strMonth,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: CustomColor().colorPrimary,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.normal),
                            ),
                            Text(
                              strYear,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: CustomColor().colorPrimary,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 7,
                      child: Container(
                        margin: const EdgeInsets.all(5.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          verticalDirection: VerticalDirection.down,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Container(
                              child: Card(
                                clipBehavior: Clip.antiAlias,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                elevation: 4,
                                child: FadeInImage.assetNetwork(
                                    placeholder: 'assets/images/loading.gif',
                                    image: strThumbnailURL,
                                    fit: BoxFit.fitHeight),
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(8, 5, 8, 0),
                  height: 1.0,
                  color: CustomColor().colorLightGray,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 5, 8, 0),
                  child: Text(
                    objEvent.event_title!,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: CustomColor().colorPrimary,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 5, 8, 0),
                  child: Row(
                    children: <Widget>[
                      // Icon(
                      //   Icons.date_range,
                      //   color: CustomColor().colorPrimary,
                      // ),
                      // Text(
                      //   CommonFunctions.formatDate("yyyy-MM-dd",
                      //       "dd/MM/yyyy", objEvent.from_date!) +
                      //       " to " +
                      //       CommonFunctions.formatDate("yyyy-MM-dd",
                      //           "dd/MM/yyyy", objEvent.to_date!),
                      //   textAlign: TextAlign.left,
                      //   style: TextStyle(
                      //       color: CustomColor().colorPrimary,
                      //       fontSize: 14.0),
                      // ),
                      Icon(
                        Icons.watch_later,
                        color: CustomColor().colorPrimary,
                      ),
                      Text(
                        "${objEvent.from_time!} to ${objEvent.to_time!}",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: CustomColor().colorPrimary,
                            fontSize: 14.0),
                      ),
                      // Spacer(),
                      // Icon(
                      //   Icons.paid_outlined,
                      //   color: CustomColor().colorPrimary,
                      // ),
                      // Text(
                      //   strFee,
                      //   textAlign: TextAlign.left,
                      //   style: TextStyle(
                      //       color: CustomColor().colorPrimary,
                      //       fontSize: 14.0),
                      // ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 5, 8, 5),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.location_on,
                        color: CustomColor().colorPrimary,
                      ),
                      Text(
                        objEvent.location!,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: CustomColor().colorPrimary,
                            fontSize: 14.0),
                      ),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }

  Widget _buildSearchBox(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      verticalDirection: VerticalDirection.down,
      children: <Widget>[
        Expanded(
          child: Card(
            elevation: 4.0,
            child: ListTile(
              contentPadding: const EdgeInsets.fromLTRB(5.0, 0, 5, 0),
              leading: const Icon(Icons.search),
              minLeadingWidth: 10,
              horizontalTitleGap: 0.0,
              title: TextField(
                controller: txtSearchController,
                decoration: const InputDecoration(
                    hintText: 'Search', border: InputBorder.none),
                // onChanged: onSearchTextChanged,
              ),
              trailing: txtSearchController.text.isEmpty
                  ? null
                  : IconButton(
                      icon: const Icon(
                        Icons.cancel,
                        size: 18,
                      ),
                      onPressed: () {
                        txtSearchController.clear();
                      },
                    ),
            ),
          ),
        ),
        MyBadge(
          top: 8,
          right: 8,
          color:
              (arrCity_selected.isNotEmpty) ? Colors.red : Colors.transparent,
          value: "",
          child: IconButton(
            icon: const Icon(Icons.filter_alt),
            color: CustomColor().colorPrimary,
            onPressed: () {
              showModalBottomSheet(
                  isDismissible: false,
                  context: context,
                  isScrollControlled: true,
                  builder: (context) {
                    return StatefulBuilder(
                        builder: (BuildContext context, StateSetter state) {
                      return FractionallySizedBox(
                        heightFactor: 0.8,
                        child: _buildFilterBody(context, state),
                      );
                    });
                  });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBox_City(BuildContext context, StateSetter state) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      verticalDirection: VerticalDirection.down,
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: Card(
              elevation: 4.0,
              child: ListTile(
                leading: const Icon(Icons.search),
                minLeadingWidth: 10,
                title: TextField(
                  controller: txtSearchController_City,
                  decoration: const InputDecoration(
                      hintText: 'Search', border: InputBorder.none),
                  // onChanged: onSearchTextChanged_City,
                ),
                trailing: txtSearchController_City.text.isEmpty
                    ? null
                    : IconButton(
                        icon: const Icon(Icons.cancel),
                        onPressed: () {
                          txtSearchController_City.clear();
                        },
                      ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFilterBody(BuildContext context, StateSetter state) {
    statePage = state;
    return Column(
      children: <Widget>[
        Container(
            height: 44.0,
            color: CustomColor().colorPrimary,
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: CustomColor().colorWhite,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  const Spacer(),
                  Text(
                    "Filter",
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: CustomColor().colorWhite,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                ])),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            verticalDirection: VerticalDirection.down,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Expanded(
                flex: 4,
                child: ListView.separated(
                    separatorBuilder: (context, index) =>
                        const Divider(height: 0, color: Colors.transparent),
                    itemCount: arrFilterList.length,
                    itemBuilder: (context, index) {
                      return createBlock_FilterLeft(index, state);
                    }),
              ),
              const VerticalDivider(),
              if (selected_FilterIndex == 0)
                Expanded(flex: 6, child: createCityList(context, state)),
            ],
          ),
        ),
        Row(
          children: <Widget>[
            const Spacer(),
            Container(
              padding: const EdgeInsets.fromLTRB(0, 0, 10, 5),
              child: SizedBox(
                height: 40.0,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      side: BorderSide(
                        width: 1.0,
                        color: CustomColor().colorPrimary,
                      ), backgroundColor: Colors.white,
                    ),
                    onPressed: () {
                      // op press
                      state(() {
                        arrCity_filter.clear();
                      });
                      // Navigator.pop(context);
                    },
                    child: Text(
                      'Reset',
                      style: TextStyle(
                          color: CustomColor().colorPrimary,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold),
                    )),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(0, 0, 10, 5),
              child: SizedBox(
                height: 40.0,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: CustomColor().colorPrimary,
                        textStyle: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold)),
                    onPressed: () {
                      // op press

                      state(() {
                        arrCity_selected.clear();
                        arrCity_selected.addAll(arrCity_filter);
                      });

                      _hasNextPage = false;
                      _isFirstLoadRunning = true;
                      _isLoadMoreRunning = false;
                      offset = 0;
                      loadData(false);

                      Navigator.pop(context);
                    },
                    child: Text('Apply Filter',
                        style: TextStyle(
                            color: CustomColor().colorWhite,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold))),
              ),
            ),
            const Spacer(),
          ],
        ),
      ],
    );
  }

  Widget createBlock_FilterLeft(int index, StateSetter state) {
    var objFilterList = arrFilterList[index];

    String strCount = "";
    switch (index) {
      case 0:
        strCount = (arrCity_filter.isEmpty) ? "" : arrCity_filter.length.toString();
        break;
      default:
        break;
    }

    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 1.0, vertical: 0.0),
      width: double.infinity,
      child: InkWell(
        splashColor: CustomColor().colorPrimary.withOpacity(0.4),
        onTap: () {
          state(() {
            // onTap
            print("onTap $objFilterList");
            selected_FilterIndex = index;
          });
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          verticalDirection: VerticalDirection.down,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                verticalDirection: VerticalDirection.down,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(5.0, 10.0, 0, 10.0),
                    child: Row(
                      children: [
                        Text(
                          objFilterList,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: CustomColor().colorPrimary,
                              fontSize: 15.0,
                              fontWeight: (selected_FilterIndex == index)
                                  ? FontWeight.bold
                                  : FontWeight.normal),
                        ),
                        const Spacer(),
                        (strCount.isEmpty == true)
                            ? Container()
                            : Container(
                                decoration: BoxDecoration(
                                    borderRadius:
                                        const BorderRadius.all(Radius.circular(30)),
                                    color: CustomColor().colorPrimary),
                                padding:
                                    const EdgeInsets.fromLTRB(5.0, 1.0, 5.0, 1.0),
                                child: Text(strCount,
                                    style: TextStyle(
                                      color: CustomColor().colorWhite,
                                      fontSize: 11.0,
                                    )),
                              ),
                        Icon(
                          Icons.arrow_right,
                          color: CustomColor().colorPrimary,
                        ),
                      ],
                    ),
                  ),
                  Divider(height: 1, color: CustomColor().colorDarkGray),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget createCityList(BuildContext context, StateSetter state) {
    return Column(
      children: <Widget>[
        Container(
            padding: const EdgeInsets.all(4.0),
            color: Colors.white,
            child: _buildSearchBox_City(context, state)),
        Expanded(
            child: Container(
          child: Column(children: [
            Expanded(
              child: ListView.separated(
                  separatorBuilder: (context, index) =>
                      const Divider(height: 0, color: Colors.transparent),
                  itemCount: arrCity.length,
                  itemBuilder: (context, index) {
                    return createBlock_City(index, state);
                  }),
            ),
          ]),
        )),
      ],
    );
  }

  Widget createBlock_City(int index, StateSetter state) {
    var objCity = arrCity[index];

    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 1.0, vertical: 0.0),
      width: double.infinity,
      child: InkWell(
        splashColor: CustomColor().colorPrimary.withOpacity(0.4),
        onTap: () {
          setState(() {
            // onTap
            print("onTap ${objCity.city_name!}");
          });
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          verticalDirection: VerticalDirection.down,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.fromLTRB(0.0, 5.0, 2.0, 2.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  verticalDirection: VerticalDirection.down,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: arrCity_filter.contains(arrCity[index]),
                          onChanged: (value) {
                            _onSelectedCity(value!, index, state);
                          },
                        ),
                        Expanded(
                          child: Text(
                            objCity.city_name!,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            maxLines: 2,
                            style: TextStyle(
                                color: CustomColor().colorPrimary,
                                fontSize: 15.0,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                      ],
                    ),
                    Divider(height: 1, color: CustomColor().colorDarkGray),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onSelectedCity(bool selected, int index, StateSetter state) {
    if (selected == true) {
      state(() {
        arrCity_filter.add(arrCity[index]);
      });
    } else {
      state(() {
        arrCity_filter.remove(arrCity[index]);
      });
    }
  }

  void updateData(List<clsEvent> Data) {
    setState(() {
      if (_isFirstLoadRunning == true) {
        arrEvents.clear();
      }

      _isFirstLoadRunning = false;
      arrEvents.addAll(Data);
      offset = arrEvents.length;
    });
  }

  Future APICALL_getEvent(bool showLoader) async {
    String strCity_ids = "";
    for (clsCity city in arrCity_selected) {
      String strID = "${city.city_id!},";
      strCity_ids += strID;
    }

    if (strCity_ids.isNotEmpty) {
      strCity_ids = strCity_ids.substring(0, strCity_ids.length - 1);
    }

    clsEventResponseModel objResponse = clsEventResponseModel();
    try {
      Map<String, dynamic> parameters = {
        "user_id": "",
        "city_id": strCity_ids,
        "search": txtSearchController.text,
        "offset": "$offset",
      };

      if (showLoader == true) EasyLoading.show(status: "Loading...");

      objResponse = await get_events(body: parameters);

      if (objResponse.status == 1) {
        if (objResponse.events!.isNotEmpty) {
          updateData(objResponse.events!);
        }

        if (objResponse.events!.length < objResponse.total!) {
          setState(() {
            _hasNextPage = true;
          });
        } else {
          setState(() {
            _hasNextPage = false;
          });
        }

        if (showLoader == true) EasyLoading.dismiss(animation: true);
      } else {
        if (showLoader == true) EasyLoading.dismiss(animation: true);
        setState(() {
          _hasNextPage = false;
        });
        EasyLoading.showToast(objResponse.message!);
      }

      setState(() => _isLoadMoreRunning = false);
    } catch (exception) {
      if (kDebugMode) {
        print(exception.toString());
      }
      //EasyLoading.showToast("" + exception.toString());
      if (showLoader == true) EasyLoading.dismiss(animation: true);
    }
  }

  void onSearchTextChanged() {
    print(txtSearchController.text);
    setState(() {
      arrEvents.clear();
    });
    _hasNextPage = false;
    _isFirstLoadRunning = true;
    _isLoadMoreRunning = false;
    offset = 0;
    loadData(false);
  }

  void onSearchTextChanged_City() {
    print(txtSearchController_City.text);

    statePage(() {
      if (txtSearchController_City.text.isEmpty) {
        arrCity.clear();
        arrCity.addAll(arrCity_final);
      } else {
        final foundData = arrCity_final.where((element) => element.city_name!
            .toLowerCase()
            .contains(txtSearchController_City.text.toLowerCase()));

        print(foundData.length);
        arrCity.clear();
        arrCity.addAll(foundData);
      }
    });
  }

  void loadData(bool showLoader) async {
    var result = await Connectivity().checkConnectivity();

    if (result == ConnectivityResult.none) {
      setState(() => _isLoading = true);
      return;
    }

    if (_isFirstLoadRunning == true) {
      _scrollTop();
    }

    await APICALL_getEvent(showLoader);
  }

  void _scrollTop() {
    _controller.animateTo(
      _controller.position.minScrollExtent,
      duration: const Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }

  void _loadMore() async {
    if (_hasNextPage == true &&
        _isFirstLoadRunning == false &&
        _isLoadMoreRunning == false &&
        _controller.position.pixels == _controller.position.maxScrollExtent) {
      setState(() {
        _isLoadMoreRunning = true; // Display a progress indicator at the bottom
      });
      loadData(false);
    }
  }

  void updateData_City(List<clsCity> Data) {
    arrCity_selected.clear();
    arrCity.clear();
    arrCity.addAll(Data);
    arrCity_final.clear();
    arrCity_final.addAll(Data);
  }

  Future APICALL_get_cities(bool showLoader) async {
    clsCityResponseModel objResponse = clsCityResponseModel();
    try {
      Map<String, dynamic> parameters = {};

      if (showLoader == true) EasyLoading.show(status: "Loading...");

      objResponse = await get_cities(body: parameters);
      if (objResponse.status == 1) {
        if (objResponse.cities!.isNotEmpty) {
          updateData_City(objResponse.cities!);
        }

        if (showLoader == true) EasyLoading.dismiss(animation: true);
      } else {
        if (showLoader == true) EasyLoading.dismiss(animation: true);

        EasyLoading.showToast(objResponse.message!);
      }

      loadData(showLoader);
    } catch (exception) {
      if (kDebugMode) {
        print(exception.toString());
      }
      //EasyLoading.showToast("" + exception.toString());
      if (showLoader == true) EasyLoading.dismiss(animation: true);
    }
  }
  @override
  void dispose() {
    _controller.removeListener(_loadMore);

    txtSearchController.dispose();
    txtSearchController_City.dispose();
    super.dispose();
  }
}
