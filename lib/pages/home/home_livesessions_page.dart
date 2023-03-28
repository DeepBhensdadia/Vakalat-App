
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:vakalat_flutter/api/postapi.dart';
import 'package:vakalat_flutter/color/customcolor.dart';
import 'package:vakalat_flutter/model/clsLiveSessions.dart';
import 'package:vakalat_flutter/model/clsLiveSessionsResponseModel.dart';
import 'package:vakalat_flutter/pages/livesessionsdetailpage.dart';
import 'package:vakalat_flutter/utils/common_functions.dart';
import 'package:vakalat_flutter/utils/constant.dart';
import 'package:vakalat_flutter/utils/keyboardHiderMixin.dart';

class home_livesessions_page extends StatefulWidget {
  const home_livesessions_page({Key? key, required this.title})
      : super(key: key);

  final String title;

  @override
  State<home_livesessions_page> createState() =>
      _home_livesessions_page_State();
}

class _home_livesessions_page_State extends State<home_livesessions_page>
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

  List<clsLiveSessions> arrLiveSessions = [];

  int offset = 0;

  @override
  void initState() {
    // TODO: implement initState
    _controller = ScrollController()..addListener(_loadMore);
    txtSearchController.addListener(onSearchTextChanged);

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
        Expanded(child: createLiveSessionsList()),
      ],
    );
  }

  Widget createLiveSessionsList() {
    return RefreshIndicator(
      onRefresh: () {
        arrLiveSessions.clear();
        _hasNextPage = false;
        _isFirstLoadRunning = true;
        _isLoadMoreRunning = false;
        offset = 0;
        return APICALL_getLiveSessions(true);
      },
      child: Column(children: [
        Expanded(
          child: ListView.separated(
              controller: _controller,
              separatorBuilder: (context, index) =>
                  const Divider(height: 1, color: Colors.transparent),
              itemCount: arrLiveSessions.length,
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
    var objLiveSession = arrLiveSessions[index];

    var strThumbnailURL = Const().URL_livesession_image + objLiveSession.photo!;

    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
      width: double.infinity,
      child: Card(
        color: CustomColor().colorLightBlue,
        clipBehavior: Clip.hardEdge,
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
                  child: LiveSessionsDetailPage(
                    title: "LiveSession Detail",
                    objLiveSession: objLiveSession,
                  ),
                ),
              );
            });
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            verticalDirection: VerticalDirection.down,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Expanded(
                flex: 3,
                child: SizedBox(
                  height : 100.0,
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    elevation: 4,
                    child: FadeInImage.assetNetwork(
                      placeholder: 'assets/images/loading.gif',
                      image: strThumbnailURL,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 6,
                child: Container(
                  margin: const EdgeInsets.all(5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    verticalDirection: VerticalDirection.down,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        objLiveSession.title!,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: CustomColor().colorPrimary,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.date_range,
                            color: CustomColor().colorPrimary,
                          ),
                          Text(
                            "${CommonFunctions.formatDate("yyyy-MM-dd",
                                    "dd/MM/yyyy", objLiveSession.from_date!)} to ${CommonFunctions.formatDate("yyyy-MM-dd",
                                    "dd/MM/yyyy", objLiveSession.to_date!)}",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: CustomColor().colorPrimary,
                                fontSize: 14.0),
                          ),
                        ],
                      ),
                      Text(
                        objLiveSession.description!,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        softWrap: false,
                        style: TextStyle(
                            color: CustomColor().colorDarkGray, fontSize: 14.0),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
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

      ],
    );
  }

  void updateData(List<clsLiveSessions> Data) {
    setState(() {
      if (_isFirstLoadRunning == true) {
        arrLiveSessions.clear();
      }

      _isFirstLoadRunning = false;
      arrLiveSessions.addAll(Data);
      offset = arrLiveSessions.length;
    });
  }

  Future APICALL_getLiveSessions(bool showLoader) async {
    clsLiveSessionsResponseModel objResponse = clsLiveSessionsResponseModel();
    try {
      Map<String, dynamic> parameters = {
        "user_id": "",
        "search": txtSearchController.text,
        "offset": "$offset",
      };



      if (showLoader == true) EasyLoading.show(status: "Loading...");

      objResponse = await get_live_session(body: parameters);

      if (objResponse.status == 1) {
        if (objResponse.live_session!.isNotEmpty) {
          updateData(objResponse.live_session!);
        }

        if (objResponse.live_session!.length < objResponse.total!) {
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
      arrLiveSessions.clear();
    });
    _hasNextPage = false;
    _isFirstLoadRunning = true;
    _isLoadMoreRunning = false;
    offset = 0;
    loadData(false);
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

    await APICALL_getLiveSessions(showLoader);
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
}
