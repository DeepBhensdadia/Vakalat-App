import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:vakalat_flutter/api/postapi.dart';
import 'package:vakalat_flutter/color/customcolor.dart';
import 'package:vakalat_flutter/model/clsLawyer.dart';
import 'package:vakalat_flutter/model/clsLegalNotice.dart';
import 'package:vakalat_flutter/model/clsLegalNoticeResponseModel.dart';
import 'package:vakalat_flutter/pages/lawyerdetailpage.dart';
import 'package:vakalat_flutter/pages/legalnoticedetailpage.dart';
import 'package:vakalat_flutter/utils/common_functions.dart';
import 'package:vakalat_flutter/utils/constant.dart';
import 'package:vakalat_flutter/utils/keyboardHiderMixin.dart';

class home_legalnotice_page extends StatefulWidget {
  const home_legalnotice_page({Key? key, required this.title})
      : super(key: key);

  final String title;

  @override
  State<home_legalnotice_page> createState() => _home_legalnotice_page_State();
}

class _home_legalnotice_page_State extends State<home_legalnotice_page>
    with KeyboardHiderMixin {
  // There is next page or not
  bool _hasNextPage = true;

  // Used to display loading indicators when _firstLoad function is running
  bool _isFirstLoadRunning = false;

  // Used to display loading indicators when _loadMore function is running
  bool _isLoadMoreRunning = false;
  bool _isLoading = false;
  late ScrollController _controller;
  List<clsLegalNotice> arrLegalNotice = [];

  int offset = 0;

  @override
  void initState() {
    // TODO: implement initState
    _controller = ScrollController()..addListener(_loadMore);

    loadData(true);

    super.initState();
  }

  @override
  void dispose() {
    _controller.removeListener(_loadMore);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return createLiveSessionsList();
  }

  Widget createLiveSessionsList() {
    return RefreshIndicator(
      onRefresh: () {
        arrLegalNotice.clear();
        _hasNextPage = false;
        _isFirstLoadRunning = true;
        _isLoadMoreRunning = false;
        offset = 0;
        return APICALL_getLegalNotice(true);
      },
      child: Column(children: [
        Expanded(
          child: ListView.separated(
              controller: _controller,
              separatorBuilder: (context, index) =>
                  const Divider(height: 1, color: Colors.transparent),
              itemCount: arrLegalNotice.length,
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
    var objLegalNotice = arrLegalNotice[index];

    var strThumbnailURL = Const().URL_legalnotice_image + objLegalNotice.photo!;

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
                  child: LegalNoticeDetailPage(
                    title: "",
                    objLegalNotice: objLegalNotice,
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
                  height: 100.0,
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
                        objLegalNotice.title!,
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
                          const Spacer(),
                          Icon(
                            Icons.date_range,
                            color: CustomColor().colorPrimary,
                          ),
                          Text(
                            CommonFunctions.formatDate("yyyy-MM-dd HH:mm:ss",
                                "dd/MM/yyyy", objLegalNotice.created_at!),
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: CustomColor().colorPrimary,
                                fontSize: 14.0),
                          ),
                        ],
                      ),
                      Container(
                        child: InkWell(
                          splashColor:
                              CustomColor().colorPrimary.withOpacity(0.4),
                          onTap: () {
                            setState(() {
                              // onTap

                              print("onTap");

                              Navigator.push(
                                context,
                                PageTransition(
                                  type: PageTransitionType.rightToLeftWithFade,
                                  duration: const Duration(milliseconds: 300),
                                  child: LawyerDetailPage(
                                    title: " ${objLegalNotice.first_name!} ${objLegalNotice.last_name!}",
                                    objLawyer:
                                        clsLawyer(user_id: objLegalNotice.user_id!,),
                                  ),
                                ),
                              );
                            });
                          },
                          child: Row(
                            children: <Widget>[
                              const Spacer(),
                              Icon(
                                Icons.person,
                                color: CustomColor().colorPrimary,
                              ),
                              Text(
                                "${objLegalNotice.first_name!} ${objLegalNotice.last_name!}",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: CustomColor().colorPrimary,
                                    fontSize: 14.0),
                              ),
                            ],
                          ),
                        ),
                      ),
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

  void updateData(List<clsLegalNotice> Data) {
    setState(() {
      if (_isFirstLoadRunning == true) {
        arrLegalNotice.clear();
      }

      _isFirstLoadRunning = false;
      arrLegalNotice.addAll(Data);
      offset = arrLegalNotice.length;
    });
  }

  Future APICALL_getLegalNotice(bool showLoader) async {
    clsLegalNoticeResponseModel objResponse = clsLegalNoticeResponseModel();
    try {
      Map<String, dynamic> parameters = {
        "offset": "$offset",
      };

      if (showLoader == true) EasyLoading.show(status: "Loading...");

      objResponse = await get_legal_notices(body: parameters);

      if (objResponse.status == 1) {
        if (objResponse.legal_notices!.isNotEmpty) {
          updateData(objResponse.legal_notices!);
        }

        if (objResponse.legal_notices!.length < objResponse.total!) {
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

  void loadData(bool showLoader) async {
    var result = await Connectivity().checkConnectivity();

    if (result == ConnectivityResult.none) {
      setState(() => _isLoading = true);
      return;
    }

    if (_isFirstLoadRunning == true) {
      _scrollTop();
    }

    await APICALL_getLegalNotice(showLoader);
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
