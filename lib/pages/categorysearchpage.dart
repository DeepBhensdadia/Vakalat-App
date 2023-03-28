
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:vakalat_flutter/api/postapi.dart';
import 'package:vakalat_flutter/color/customcolor.dart';
import 'package:vakalat_flutter/model/clsCategory.dart';
import 'package:vakalat_flutter/model/clsCategoryResponseModel.dart';
import 'package:vakalat_flutter/pages/dashboard.dart';
import 'package:vakalat_flutter/utils/constant.dart';
import 'package:vakalat_flutter/utils/keyboardHiderMixin.dart';
import 'package:flutter_svg/svg.dart';

class CategorySearchPage extends StatefulWidget {
  const CategorySearchPage({Key? key, required this.title ,
    required this.dashboardPageState,}) : super(key: key);

  final String title;

  final DashboardPageState dashboardPageState;
  @override
  State<CategorySearchPage> createState() => _CategorySearchPageState();
}

class _CategorySearchPageState extends State<CategorySearchPage>
    with KeyboardHiderMixin {
  TextEditingController txtSearchController = TextEditingController();

  List<clsCategory> arrCategory = [];
  List<clsCategory> arrCategorySearch = [];

  @override
  void initState() {
    // TODO: implement initState
    txtSearchController.addListener(onSearchTextChanged);
    APICALL_getcategory(false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            "Categories",
            style: TextStyle(
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          centerTitle: true,
          backgroundColor: CustomColor().colorPrimary,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: _buildBody(context));
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
            padding: const EdgeInsets.all(4.0),
            color: Colors.white,
            child: _buildSearchBox(context)),
        Expanded(child: createCategoryList()),
      ],
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

  Widget createCategoryList() {
    return Container(
      child: RefreshIndicator(
        onRefresh: () {
          txtSearchController.text = "";
          return APICALL_getcategory(true);
        },
        child: Column(children: [
          Expanded(
            child: ListView.separated(
                separatorBuilder: (context, index) =>
                    const Divider(height: 0, color: Colors.transparent),
                itemCount: arrCategorySearch.length,
                itemBuilder: (context, index) {
                  return createBlock(index);
                }),
          ),
        ]),
      ),
    );
  }

  Widget createBlock(int index) {
    var objCategory = arrCategorySearch[index];

    var strThumbnailURL = Const().URL_image + objCategory.cat_img!;

    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
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
              // html.window.open('https://www.fluttercampus.com',"_blank");
              // Navigator.push(
              //   context,
              //   PageTransition(
              //     type: PageTransitionType.rightToLeftWithFade,
              //     duration: const Duration(milliseconds: 300),
              //     child: DashboardPage(title: ""),
              //   ),
              // );

              widget.dashboardPageState.objCategoryToSearch = objCategory;
              widget.dashboardPageState.loadPage_AS_index(2);
              Navigator.pop(context);
            });
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            verticalDirection: VerticalDirection.down,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  padding: const EdgeInsets.all(2.0),
                  child: Card(
                      margin: EdgeInsets.zero,
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      elevation: 4,
                      child: Container(
                        padding: const EdgeInsets.all(10.0),
                        height: 80.0,
                        width: 80.0,
                        child: SvgPicture.network(
                          strThumbnailURL,
                          placeholderBuilder: (BuildContext context) =>
                              Container(
                                  height: 20.0,
                                  width: 20.0,
                                  padding: const EdgeInsets.all(40.0),
                                  child: const CircularProgressIndicator()),
                          height: 30.0,
                          width: 30.0,
                        ),
                      )),
                ),
              ),
              Expanded(
                flex: 8,
                child: Container(
                  margin: const EdgeInsets.all(5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    verticalDirection: VerticalDirection.down,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        objCategory.cat_name!,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: CustomColor().colorPrimary,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
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

  @override
  void dispose() {
    txtSearchController.dispose();
    super.dispose();
  }

  void updateData_Category(List<clsCategory> Data) {
    setState(() {
      arrCategory.clear();
      arrCategory.addAll(Data);
      arrCategorySearch.clear();
      arrCategorySearch.addAll(Data);
    });
  }

  Future APICALL_getcategory(bool showLoader) async {
    clsCategoryResponseModel objResponse = clsCategoryResponseModel();
    try {
      Map<String, dynamic> parameters = {};

      if (showLoader == true) EasyLoading.show(status: "Loading...");

      objResponse = await get_category_list(body: parameters);
      if (objResponse.status == 1) {
        if (objResponse.categories!.isNotEmpty) {
          updateData_Category(objResponse.categories!);
        }

        if (showLoader == true) EasyLoading.dismiss(animation: true);
      } else {
        if (showLoader == true) EasyLoading.dismiss(animation: true);

        EasyLoading.showToast(objResponse.message!);
      }
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
      if (txtSearchController.text.isEmpty) {
        arrCategorySearch.clear();
        arrCategorySearch.addAll(arrCategory);
      } else {
        final foundData = arrCategory.where((element) => element.cat_name!
            .toLowerCase()
            .contains(txtSearchController.text.toLowerCase()));

        print(foundData.length);
        arrCategorySearch.clear();
        arrCategorySearch.addAll(foundData);
      }
    });
  }
}
