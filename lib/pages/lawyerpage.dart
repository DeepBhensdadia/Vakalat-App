
import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:page_transition/page_transition.dart';
import 'package:recase/recase.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vakalat_flutter/api/postapi.dart';
import 'package:vakalat_flutter/color/customcolor.dart';
import 'package:vakalat_flutter/model/clsCategory.dart';
import 'package:vakalat_flutter/model/clsCategoryResponseModel.dart';
import 'package:vakalat_flutter/model/clsCity.dart';
import 'package:vakalat_flutter/model/clsCityResponseModel.dart';
import 'package:vakalat_flutter/model/clsLawyer.dart';
import 'package:vakalat_flutter/model/clsLawyerResponseModel.dart';
import 'package:vakalat_flutter/pages/lawyerdetailpage.dart';
import 'package:vakalat_flutter/utils/common_functions.dart';
import 'package:vakalat_flutter/utils/constant.dart';
import 'package:vakalat_flutter/widgets/my_badge.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LawyerPage extends StatefulWidget {
  const LawyerPage({Key? key, required this.title, required this.objCategory})
      : super(key: key);

  final String title;
  final clsCategory? objCategory;

  @override
  State<LawyerPage> createState() => _LawyerPageState();
}

class _LawyerPageState extends State<LawyerPage> {
// There is next page or not
  bool _hasNextPage = true;

  // Used to display loading indicators when _firstLoad function is running
  bool _isFirstLoadRunning = false;

  // Used to display loading indicators when _loadMore function is running
  bool _isLoadMoreRunning = false;
  bool _isLoading = false;

  late ScrollController _controller;
  List<clsLawyer> arrLawyers = [];
  List<String> arrFilterList = [];

  int selected_FilterIndex = 0;

  List<clsCategory> arrCategory = [];
  List<clsCategory> arrCategory_filter = [];
  List<clsCategory> arrCategory_selected = [];

  List<clsCity> arrCity_final = [];
  List<clsCity> arrCity = [];
  List<clsCity> arrCity_filter = [];
  List<clsCity> arrCity_selected = [];

  int offset = 0;
  TextEditingController txtSearchController = TextEditingController();
  TextEditingController txtSearchController_City = TextEditingController();
  String strSearchText = "";
  String strSearchText_City = "";

  late StateSetter statePage;

  @override
  void initState() {
    // TODO: implement initState

    // print(widget.objCategory!.cat_id);
    arrFilterList.clear();
    arrFilterList.add("Category");
    arrFilterList.add("City");

    _controller = ScrollController()..addListener(_loadMore);

    txtSearchController.addListener(onSearchTextChanged);
    txtSearchController_City.addListener(onSearchTextChanged_City);

    arrLawyers.clear();
    _hasNextPage = false;
    _isFirstLoadRunning = true;
    _isLoadMoreRunning = false;

    APICALL_getcategory(true);
    //
    // if (widget.objCategory != null) {
    //   // arrCategory_selected.add(widget.objCategory!);
    //   APICALL_getcategory(true);
    // }
    // else
    //   {
    //
    //   }

    super.initState();
  }

  @override
  void dispose() {
    _controller.removeListener(_loadMore);

    txtSearchController.dispose();
    txtSearchController_City.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
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
              trailing: strSearchText.isEmpty
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
              (arrCategory_selected.isNotEmpty || arrCity_selected.isNotEmpty)
                  ? Colors.red
                  : Colors.transparent,
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
                Expanded(
                  flex: 6,
                  child: ListView.separated(
                      separatorBuilder: (context, index) =>
                          const Divider(height: 0, color: Colors.transparent),
                      itemCount: arrCategory.length,
                      itemBuilder: (context, index) {
                        return createBlock_Category(index, state);
                      }),
                )
              else if (selected_FilterIndex == 1)
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
                        arrCategory_filter.clear();
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
                        arrCategory_selected.clear();
                        arrCategory_selected.addAll(arrCategory_filter);

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
        strCount = (arrCategory_filter.isEmpty)
                ? ""
                : arrCategory_filter.length.toString();
        break;
      case 1:
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

  void _onSelectedCategory(
      bool selected, clsCategory object, StateSetter state) {
    if (selected == true) {
      state(() {
        arrCategory_filter.add(object);
      });
    } else {
      state(() {
        arrCategory_filter.remove(object);
      });
    }
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

  Widget createBlock_Category(int index, StateSetter state) {
    var objCategory = arrCategory[index];

    var arrSubcategories = objCategory.subcategories;

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
            print("onTap ${objCategory.cat_name!}");
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
                margin: const EdgeInsets.fromLTRB(0.0, 5.0, 2.0, 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  verticalDirection: VerticalDirection.down,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Row(
                      children: [
                        (objCategory.subcategories!.isNotEmpty)
                            ? Container()
                            : Checkbox(
                                value: arrCategory_filter
                                    .contains(arrCategory[index]),
                                onChanged: (value) {
                                  _onSelectedCategory(
                                      value!, arrCategory[index], state);
                                },
                              ),
                        Expanded(
                          child: Text(
                            objCategory.cat_name!,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: CustomColor().colorPrimary,
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    // Divider(height: 1, color: CustomColor().colorDarkGray),
                    ListView.separated(
                        shrinkWrap: true,
                        // 1st add
                        physics: const ClampingScrollPhysics(),
                        separatorBuilder: (context, index) =>
                            const Divider(height: 0, color: Colors.transparent),
                        itemCount: objCategory.subcategories!.length,
                        itemBuilder: (context, index) {
                          return createBlock_SubCategory(
                              objCategory, index, state);
                        }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget createBlock_SubCategory(
      clsCategory objCategory, int index, StateSetter state) {
    var arrSubcategories = objCategory.subcategories;

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
            print("onTap ${objCategory.cat_name!}");
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
                          value: arrCategory_filter
                              .contains(arrSubcategories![index]),
                          onChanged: (value) {
                            _onSelectedCategory(
                                value!, arrSubcategories[index], state);
                          },
                        ),
                        Expanded(
                          child: Text(
                            arrSubcategories[index].cat_name!,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
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

  Widget createBlock(int index) {
    var objLawyer = arrLawyers[index];

    String strProfileImageURL =
        Const().URL_profile_pic_FullImage + objLawyer.profile_pic!;

    // print(strProfileImageURL);
    String strFullName = "${objLawyer.first_name!} ${objLawyer.last_name!}";

    strFullName = strFullName.toLowerCase().titleCase;

    String strExperience = (objLawyer.experience!.isEmpty == true)
        ? ""
        : " ${objLawyer.experience!}";

    String strAbout = objLawyer.about_user!.trim();

    String strLocation = "";

    if ((objLawyer.city_name!.isEmpty == true) &&
        (objLawyer.state_name!.isEmpty == true) &&
        (objLawyer.country_name!.isEmpty == true)) {
      strLocation = " Not Provided";
    } else {
      strLocation = " ${objLawyer.city_name!}, ${objLawyer.state_name!}, ${objLawyer.country_name!}";
    }

    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    return Card(
      color: CustomColor().colorLightBlue,
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
      ),
      elevation: 4,
      child: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 1.0, vertical: 0.0),
            width: double.infinity,
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
                      child: LawyerDetailPage(
                        title: strFullName,
                        objLawyer: objLawyer,
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
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        verticalDirection: VerticalDirection.down,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Card(
                            clipBehavior: Clip.hardEdge,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            elevation: 4,
                            child: Stack(alignment: Alignment.bottomCenter,
                                //alignment:new Alignment(x, y)
                                children: <Widget>[
                                  Container(
                                    padding: const EdgeInsets.all(0),
                                    height: 160.0,
                                    child: CachedNetworkImage(
                                      imageUrl: strProfileImageURL,
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover,
                                            // colorFilter:
                                            //     ColorFilter.mode(Colors.red, BlendMode.colorBurn),
                                          ),
                                        ),
                                      ),
                                      placeholder: (context, url) =>
                                          Image.asset(
                                              'assets/images/loading.gif'),
                                      errorWidget: (context, url, error) =>
                                          Image.asset(
                                              'assets/images/default.png'),
                                    ),
                                  ),
                                  (objLawyer.is_verified! == "1" )
                                      ? Container(
                                    width: double.maxFinite,
                                    padding: const EdgeInsets.all(2),
                                    margin: const EdgeInsets.only(bottom: 0),
                                    decoration: BoxDecoration(
                                        color: CustomColor()
                                            .colorGreen_verified,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(0))),
                                    child: Text(
                                      "Verified",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: CustomColor().colorWhite,
                                          fontSize: 14.0),
                                    ),
                                  )
                                      : Container(
                                    width: double.maxFinite,
                                    padding: const EdgeInsets.all(2),
                                    margin: const EdgeInsets.only(bottom: 0),
                                    decoration: BoxDecoration(
                                        color: CustomColor()
                                            .colorRed_notverified,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(0))),
                                    child: Text(
                                      "Not Verified",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: CustomColor().colorWhite,
                                          fontSize: 14.0),
                                    ),
                                  ),
                                ]),
                          ),
                        ]),
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
                            strFullName,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: CustomColor().colorPrimary,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold),
                          ),
                          Container(
                            margin: const EdgeInsets.all(7),
                            height: 1.0,
                          ),
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.grid_view,
                                color: CustomColor().colorPrimary,
                              ),
                              Text(
                                " ${objLawyer.cat_name!}",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: CustomColor().colorPrimary,
                                    fontSize: 14.0),
                              ),
                            ],
                          ),
                          Container(
                            margin: const EdgeInsets.all(2),
                            height: 1.0,
                          ),
                          (strLocation.trim().isEmpty == true)
                              ? Container()
                              : Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.location_on,
                                      color: CustomColor().colorPrimary,
                                    ),
                                    Text(
                                      strLocation,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: CustomColor().colorPrimary,
                                          fontSize: 14.0),
                                    ),
                                  ],
                                ),
                          (strExperience.isEmpty)
                              ? Container()
                              : Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.business_center,
                                      color: CustomColor().colorPrimary,
                                    ),
                                    Text(
                                      strExperience,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: CustomColor().colorPrimary,
                                          fontSize: 14.0),
                                    ),
                                  ],
                                ),
                          // Row(
                          //   children: <Widget>[
                          //     Container(
                          //         padding: const EdgeInsets.all(2),
                          //         child: ElevatedButton(
                          //             child: const Text('Contact Now'),
                          //             style: ElevatedButton.styleFrom(
                          //                 primary: CustomColor().colorPrimary,
                          //                 textStyle: const TextStyle(
                          //                     fontSize: 14,
                          //                     fontWeight: FontWeight.bold)),
                          //             onPressed: () {
                          //               // op press
                          //
                          //               //LawyerContactPage
                          //               Navigator.push(
                          //                 context,
                          //                 PageTransition(
                          //                   type: PageTransitionType
                          //                       .rightToLeftWithFade,
                          //                   duration: const Duration(
                          //                       milliseconds: 300),
                          //                   child: LawyerContactPage(
                          //                     title: "Contact " + strFullName,
                          //                   ),
                          //                 ),
                          //               );
                          //             })),
                          //   ],
                          // ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(8, 5, 8, 0),
            height: 1.0,
            color: CustomColor().colorLightGray,
          ),
          SizedBox(
            height: 50,
            child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  // Website
                  IconButton(
                    icon: FaIcon(FontAwesomeIcons.globe,
                        color: CustomColor().colorPrimary),
                    onPressed: () {
                      String url = objLawyer.website_url!;

                      String strURL_slug =
                          "https://www.vakalat.com/${objLawyer.slug!}";

                      if (url.isEmpty) {
                        url = strURL_slug;
                      }

                      var encoded =
                      Uri.encodeFull(CommonFunctions.checkHttp(url));
                      // launch(encoded);
                      FlutterWebBrowser.openWebPage(url: encoded);
                    },
                  ),
                  (objLawyer.is_display_web! == "0")
                      ? Container()
                      : IconButton(
                    icon: FaIcon(FontAwesomeIcons.sms,
                        color: CustomColor().colorPrimary),
                    onPressed: () {
                      String url = "sms:${objLawyer.mobile!}";
                      var encoded = Uri.encodeFull(url);
                      launch(encoded);
                    },
                  ),
                  // SMS
                  (objLawyer.is_display_web! == "0")
                      ? Container()
                      : IconButton(
                    icon: FaIcon(FontAwesomeIcons.phoneAlt,
                        color: CustomColor().colorPrimary),
                    onPressed: () {
                      CommonFunctions.makePhoneCall(objLawyer.mobile!);
                    },
                  ),
                  // Call
                  (objLawyer.is_display_web! == "0")
                      ? Container()
                      : IconButton(
                    icon: FaIcon(FontAwesomeIcons.whatsapp,
                        color: CustomColor().colorPrimary),
                    onPressed: () {

                      launch(CommonFunctions.whatsapp_LawyerContact(
                          objLawyer.mobile!, strFullName));
                    },
                  ),
                  // Whatsapp
                  IconButton(
                    icon: FaIcon(FontAwesomeIcons.envelope,
                        color: CustomColor().colorPrimary),
                    onPressed: () {
                      String url = "mailto:${objLawyer.email!}";
                      var encoded = Uri.encodeFull(url);
                      launch(encoded);
                    },
                  ),
                  // Share
                  IconButton(
                    icon: FaIcon(FontAwesomeIcons.shareAlt,
                        color: CustomColor().colorPrimary),
                    onPressed: () {
                      String strURL_slug =
                          "https://www.vakalat.com/${objLawyer.slug!}";

                      Share.share(
                          '${strFullName.toLowerCase().titleCase} at Vakalat \ncheck my profile\n$strURL_slug',
                          subject: '');
                    },
                  ),
                  // Linkedin
                  (objLawyer.linkedin_url!.isNotEmpty)
                      ? IconButton(
                    icon: FaIcon(FontAwesomeIcons.linkedin,
                        color: CustomColor().colorPrimary),
                    onPressed: () {
                      String url = objLawyer.linkedin_url!;
                      var encoded =
                      Uri.encodeFull(CommonFunctions.checkHttp(url));
                      launch(encoded);
                    },
                  )
                      : Container(),
                  //Facebook
                  (objLawyer.fb_url!.isNotEmpty)
                      ? IconButton(
                          icon: FaIcon(FontAwesomeIcons.facebookF,
                              color: CustomColor().colorPrimary),
                          onPressed: () {
                            String url = objLawyer.fb_url!;
                            var encoded =
                                Uri.encodeFull(CommonFunctions.checkHttp(url));
                            launch(encoded);
                          },
                        )
                      : Container(),
                  // Twitter
                  (objLawyer.twitter_url!.isNotEmpty)
                      ? IconButton(
                          icon: FaIcon(FontAwesomeIcons.twitter,
                              color: CustomColor().colorPrimary),
                          onPressed: () {
                            String url = objLawyer.twitter_url!;
                            var encoded =
                                Uri.encodeFull(CommonFunctions.checkHttp(url));
                            launch(encoded);
                          },
                        )
                      : Container(),
                  // Instagram
                  (objLawyer.insta_url!.isNotEmpty)
                      ? IconButton(
                          icon: FaIcon(FontAwesomeIcons.instagram,
                              color: CustomColor().colorPrimary),
                          onPressed: () {
                            String url = objLawyer.insta_url!;
                            var encoded =
                                Uri.encodeFull(CommonFunctions.checkHttp(url));
                            launch(encoded);
                          },
                        )
                      : Container(),

                ]),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
            padding: const EdgeInsets.all(0.0),
            color: Colors.white,
            child: _buildSearchBox(context)),
        Expanded(child: createLawyerList()),
      ],
    );
  }

  Widget createLawyerList() {
    return Container(
      child: RefreshIndicator(
        onRefresh: () {
          arrLawyers.clear();
          _hasNextPage = false;
          _isFirstLoadRunning = true;
          _isLoadMoreRunning = false;
          offset = 0;
          return APICALL_getLawyer(true);
        },
        child: Column(children: [
          Expanded(
            child: ListView.separated(
                controller: _controller,
                separatorBuilder: (context, index) =>
                    const Divider(height: 0, color: Colors.transparent),
                itemCount: arrLawyers.length,
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
      ),
    );
  }

  void updateData_Lawyer(List<clsLawyer> Data) {
    setState(() {
      if (_isFirstLoadRunning == true) {
        arrLawyers.clear();
      }

      _isFirstLoadRunning = false;
      arrLawyers.addAll(Data);
      offset = arrLawyers.length;
    });
  }

  Future APICALL_getLawyer(bool showLoader) async {
    String strCategory_ids = "";
    for (clsCategory obj in arrCategory_selected) {
      String strID = "${obj.cat_id!},";
      strCategory_ids += strID;
    }

    if (strCategory_ids.isNotEmpty) {
      strCategory_ids =
          strCategory_ids.substring(0, strCategory_ids.length - 1);
    }

    String strCity_ids = "";
    for (clsCity city in arrCity_selected) {
      String strID = "${city.city_id!},";
      strCity_ids += strID;
    }

    if (strCity_ids.isNotEmpty) {
      strCity_ids = strCity_ids.substring(0, strCity_ids.length - 1);
    }

    clsLawyerResponseModel objResponse = clsLawyerResponseModel();
    try {
      Map<String, dynamic> parameters = {
        "category": strCategory_ids,
        "city": strCity_ids,
        "name": strSearchText,
        "offset": "$offset",
      };

      if (showLoader == true) EasyLoading.show(status: "Loading...");

      objResponse = await get_lawyer(body: parameters);
      if (objResponse.status == 1) {
        if (objResponse.lawyers!.isNotEmpty) {
          updateData_Lawyer(objResponse.lawyers!);
        }

        if (objResponse.lawyers!.length < objResponse.total! || objResponse.total! == 0 ) {
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
      arrLawyers.clear();
      strSearchText = txtSearchController.text;
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

    await APICALL_getLawyer(showLoader);
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

  void updateData_Category(List<clsCategory> Data) {
    arrCategory.clear();

    if (widget.objCategory == null) {
      arrCategory_selected.clear();
      arrCategory_filter.clear();
      arrCategory.addAll(Data);
    } else {
      arrCategory_selected.clear();
      arrCategory_filter.clear();
      for (var obj in Data) {
        if (obj.cat_id == widget.objCategory!.cat_id!) {
          if (obj.subcategories!.isNotEmpty) {
            for (var objSub in obj.subcategories!) {
              arrCategory_selected.add(objSub);
              arrCategory_filter.add(objSub);
            }
          } else {
            arrCategory_selected.add(obj);
            arrCategory_filter.add(obj);
          }
        } else if (obj.subcategories!.isNotEmpty) {
          for (var objSub in obj.subcategories!) {
            if (objSub.cat_id == widget.objCategory!.cat_id!) {
              arrCategory_selected.add(objSub);
              arrCategory_filter.add(objSub);
            }
          }
        }
        arrCategory.add(obj);
      }
    }
  }

  Future APICALL_getcategory(bool showLoader) async {
    clsCategoryResponseModel objResponse = clsCategoryResponseModel();
    try {
      Map<String, dynamic> parameters = {};

      if (showLoader == true) EasyLoading.show(status: "Loading...");

      objResponse = await get_category_for_seach(body: parameters);
      if (objResponse.status == 1) {
        if (objResponse.categories!.isNotEmpty) {
          updateData_Category(objResponse.categories!);
        }

        if (showLoader == true) EasyLoading.dismiss(animation: true);
      } else {
        if (showLoader == true) EasyLoading.dismiss(animation: true);

        EasyLoading.showToast(objResponse.message!);
      }

      APICALL_get_cities(showLoader);
    } catch (exception) {
      if (kDebugMode) {
        print(exception.toString());
      }
      //EasyLoading.showToast("" + exception.toString());
      if (showLoader == true) EasyLoading.dismiss(animation: true);
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
}
