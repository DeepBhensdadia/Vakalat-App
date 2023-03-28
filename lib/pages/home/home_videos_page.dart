
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:vakalat_flutter/api/postapi.dart';
import 'package:vakalat_flutter/color/customcolor.dart';
import 'package:vakalat_flutter/model/clsCategory.dart';
import 'package:vakalat_flutter/model/clsCategoryResponseModel.dart';
import 'package:vakalat_flutter/model/clsLanguage.dart';
import 'package:vakalat_flutter/model/clsLanguageResponseModel.dart';
import 'package:vakalat_flutter/model/clsLawyer.dart';
import 'package:vakalat_flutter/model/clsTopic.dart';
import 'package:vakalat_flutter/model/clsTopicResponseModel.dart';
import 'package:vakalat_flutter/model/clsVideo.dart';
import 'package:vakalat_flutter/model/clsVideoResponseModel.dart';
import 'package:vakalat_flutter/pages/lawyerdetailpage.dart';
import 'package:vakalat_flutter/pages/video_detail_page.dart';
import 'package:vakalat_flutter/utils/keyboardHiderMixin.dart';
import 'package:vakalat_flutter/widgets/my_badge.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class home_videos_page extends StatefulWidget {
  const home_videos_page({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<home_videos_page> createState() => _home_videos_page_State();
}

class _home_videos_page_State extends State<home_videos_page>
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

  List<clsVideo> arrVideos = [];

  List<String> arrFilterList = [];

  int selected_FilterIndex = 0;
  late StateSetter statePage;

  List<clsLanguage> arrLanguage = [];
  List<clsLanguage> arrLanguage_filter = [];
  List<clsLanguage> arrLanguage_selected = [];

  List<clsCategory> arrCategory = [];
  List<clsCategory> arrCategory_filter = [];
  List<clsCategory> arrCategory_selected = [];

  List<clsTopic> arrTopic = [];
  List<clsTopic> arrTopic_filter = [];
  List<clsTopic> arrTopic_selected = [];

  int offset = 0;

  @override
  void initState() {
    // TODO: implement initState

    arrFilterList.clear();
    arrFilterList.add("Language");
    arrFilterList.add("Category");
    arrFilterList.add("Topic");

    _controller = ScrollController()..addListener(_loadMore);
    txtSearchController.addListener(onSearchTextChanged);

    APICALL_get_languages(true);

    loadData(true);

    super.initState();
  }

  @override
  void dispose() {
    _controller.removeListener(_loadMore);

    txtSearchController.dispose();
    super.dispose();
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
        Expanded(child: createVideoList()),
      ],
    );
  }

  Widget createVideoList() {
    return RefreshIndicator(
      onRefresh: () {
        arrVideos.clear();
        _hasNextPage = false;
        _isFirstLoadRunning = true;
        _isLoadMoreRunning = false;
        offset = 0;
        return APICALL_getVideos(true);
      },
      child: Column(children: [
        Expanded(
          child: ListView.separated(
              controller: _controller,
              separatorBuilder: (context, index) =>
                  const Divider(height: 1, color: Colors.transparent),
              itemCount: arrVideos.length,
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
          color: (arrCategory_selected.isNotEmpty ||
                  arrLanguage_selected.isNotEmpty ||
                  arrTopic_selected.isNotEmpty)
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
                Expanded(flex: 6, child: createLanguageList(context, state)),
              if (selected_FilterIndex == 1)
                Expanded(flex: 6, child: createCategoryList(context, state)),
              if (selected_FilterIndex == 2)
                Expanded(flex: 6, child: createTopicList(context, state)),
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
                        arrLanguage_filter.clear();
                        arrCategory_filter.clear();
                        arrTopic_filter.clear();
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
                        arrLanguage_selected.clear();
                        arrLanguage_selected.addAll(arrLanguage_filter);

                        arrCategory_selected.clear();
                        arrCategory_selected.addAll(arrCategory_filter);

                        arrTopic_selected.clear();
                        arrTopic_selected.addAll(arrTopic_filter);
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
        strCount = (arrLanguage_filter.isEmpty)
                ? ""
                : arrLanguage_filter.length.toString();
        break;
      case 1:
        strCount = (arrCategory_filter.isEmpty)
                ? ""
                : arrCategory_filter.length.toString();
        break;
      case 2:
        strCount = (arrTopic_filter.isEmpty)
                ? ""
                : arrTopic_filter.length.toString();
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

  Widget createLanguageList(BuildContext context, StateSetter state) {
    return Column(
      children: <Widget>[
        // Container(
        //     padding: EdgeInsets.all(4.0),
        //     color: Colors.white,
        //     child: _buildSearchBox_City(context, state)),
        Expanded(
            child: Container(
          child: Column(children: [
            Expanded(
              child: ListView.separated(
                  separatorBuilder: (context, index) =>
                      const Divider(height: 0, color: Colors.transparent),
                  itemCount: arrLanguage.length,
                  itemBuilder: (context, index) {
                    return createBlock_Language(index, state);
                  }),
            ),
          ]),
        )),
      ],
    );
  }

  Widget createBlock_Language(int index, StateSetter state) {
    var objLanguage = arrLanguage[index];

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
            print("onTap ${objLanguage.title!}");
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
                        Checkbox(
                          value:
                              arrLanguage_filter.contains(arrLanguage[index]),
                          onChanged: (value) {
                            _onSelectedLanguage(
                                value!, arrLanguage[index], state);
                          },
                        ),
                        Expanded(
                          child: Text(
                            objLanguage.title!,
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

  void _onSelectedLanguage(
      bool selected, clsLanguage object, StateSetter state) {
    if (selected == true) {
      state(() {
        arrLanguage_filter.add(object);
      });
    } else {
      state(() {
        arrLanguage_filter.remove(object);
      });
    }
  }

  Widget createCategoryList(BuildContext context, StateSetter state) {
    return Column(
      children: <Widget>[
        // Container(
        //     padding: EdgeInsets.all(4.0),
        //     color: Colors.white,
        //     child: _buildSearchBox_City(context, state)),
        Expanded(
            child: Container(
          child: Column(children: [
            Expanded(
              child: ListView.separated(
                  separatorBuilder: (context, index) =>
                      const Divider(height: 0, color: Colors.transparent),
                  itemCount: arrCategory.length,
                  itemBuilder: (context, index) {
                    return createBlock_Category(index, state);
                  }),
            ),
          ]),
        )),
      ],
    );
  }

  Widget createBlock_Category(int index, StateSetter state) {
    var objCategory = arrCategory[index];

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
                        Checkbox(
                          value:
                              arrCategory_filter.contains(arrCategory[index]),
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

  Widget createTopicList(BuildContext context, StateSetter state) {
    return Column(
      children: <Widget>[
        // Container(
        //     padding: EdgeInsets.all(4.0),
        //     color: Colors.white,
        //     child: _buildSearchBox_City(context, state)),
        Expanded(
            child: Container(
          child: Column(children: [
            Expanded(
              child: ListView.separated(
                  separatorBuilder: (context, index) =>
                      const Divider(height: 0, color: Colors.transparent),
                  itemCount: arrTopic.length,
                  itemBuilder: (context, index) {
                    return createBlock_Topic(index, state);
                  }),
            ),
          ]),
        )),
      ],
    );
  }

  Widget createBlock_Topic(int index, StateSetter state) {
    var objTopic = arrTopic[index];

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
            print("onTap ${objTopic.title!}");
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
                        Checkbox(
                          value: arrTopic_filter.contains(arrTopic[index]),
                          onChanged: (value) {
                            _onSelectedTopic(value!, arrTopic[index], state);
                          },
                        ),
                        Expanded(
                          child: Text(
                            objTopic.title!,
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

  void _onSelectedTopic(bool selected, clsTopic object, StateSetter state) {
    if (selected == true) {
      state(() {
        arrTopic_filter.add(object);
      });
    } else {
      state(() {
        arrTopic_filter.remove(object);
      });
    }
  }

  String getThumbnailURLfromVideoID(String videoID) {
    // Default Thumbnail: http://img.youtube.com/vi/{videoID}/default.jpg
    // High Quality Thumbnail: http://img.youtube.com/vi/{videoID}/hqdefault.jpg
    // Medium Quality Thumbnail: http://img.youtube.com/vi/{videoID}/mqdefault.jpg

    String strThumbnailURL = "";

    // strThumbnailURL = "http://img.youtube.com/vi/$videoID/default.jpg";
    strThumbnailURL = "http://img.youtube.com/vi/$videoID/hqdefault.jpg";
    // strThumbnailURL= "http://img.youtube.com/vi/$videoID/mqdefault.jpg";

    return strThumbnailURL;
  }

  String getVideoIDFromURL(String strURL) {
    String? videoId = "";
    try {
      videoId = YoutubePlayer.convertUrlToId(strURL);
      print('this is ${videoId!}');
    } on Exception {
      // only executed if error is of type Exception
      print('exception');
    } catch (error) {
      // executed for errors of all types other than Exception
      print('catch error');
      //  videoIdd="error";

    }

    return videoId!;
  }

  Widget createBlock(int index) {
    var objVideo = arrVideos[index];

    var videoID = getVideoIDFromURL(objVideo.plain_url!);
    // var rng = new Random();
    // var randomNumber = rng.nextInt(10000);

    var strThumbnailURL = getThumbnailURLfromVideoID(videoID);

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
                  child: video_detail_page(
                    title: "videoDetail",
                    objVideo: objVideo,
                  ),
                ),
              );
            });
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              verticalDirection: VerticalDirection.down,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Card(
                  margin: EdgeInsets.zero,
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  elevation: 4,
                  child: FadeInImage.assetNetwork(
                    placeholder: 'assets/images/loading.gif',
                    image: strThumbnailURL,
                    height: queryData.size.width * 0.5,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(5.0, 5.0, 2.0, 0.0),
                  child: Text(
                    objVideo.topic!,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: CustomColor().colorPrimary, fontSize: 14.0),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(5.0, 0.0, 2.0, 0.0),
                  child: Text(
                    objVideo.title!,
                    maxLines: 2,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: CustomColor().colorPrimary,
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(5.0, 0.0, 2.0, 0.0),
                  child: Text(
                    objVideo.topic_desc!,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: CustomColor().colorDarkGray, fontSize: 14.0),
                  ),
                ),
                InkWell(
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
                            title: " ${objVideo.first_name!} ${objVideo.last_name!}",
                            objLawyer: clsLawyer(user_id: objVideo.user_id),
                          ),
                        ),
                      );
                    });
                  },
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.person,
                        color: CustomColor().colorPrimary,
                      ),
                      Text(
                        " ${objVideo.first_name!} ${objVideo.last_name!}",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: CustomColor().colorPrimary, fontSize: 14.0),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void updateData(List<clsVideo> Data) {
    setState(() {
      if (_isFirstLoadRunning == true) {
        arrVideos.clear();
      }

      _isFirstLoadRunning = false;
      arrVideos.addAll(Data);
      offset = arrVideos.length;
    });
  }

  Future APICALL_getVideos(bool showLoader) async {
    // Language
    String strLanguage_ids = "";
    for (clsLanguage obj in arrLanguage_selected) {
      String strID = "${obj.id!},";
      strLanguage_ids += strID;
    }

    if (strLanguage_ids.isNotEmpty) {
      strLanguage_ids =
          strLanguage_ids.substring(0, strLanguage_ids.length - 1);
    }

    // Category
    String strCategory_ids = "";
    for (clsCategory obj in arrCategory_selected) {
      String strID = "${obj.cat_id!},";
      strCategory_ids += strID;
    }

    if (strCategory_ids.isNotEmpty) {
      strCategory_ids =
          strCategory_ids.substring(0, strCategory_ids.length - 1);
    }
    // Language
    String strTopic_ids = "";
    for (clsTopic obj in arrTopic_selected) {
      String strID = "${obj.id!},";
      strTopic_ids += strID;
    }

    if (strTopic_ids.isNotEmpty) {
      strTopic_ids = strTopic_ids.substring(0, strTopic_ids.length - 1);
    }

    clsVideoResponseModel objResponse = clsVideoResponseModel();
    try {
      Map<String, dynamic> parameters = {
        "user_id": "",
        "lang_id": strLanguage_ids,
        "cat_id": strCategory_ids,
        "sub_cat_id": "",
        "topic_id": strTopic_ids,
        "offset": "$offset",
        "search": txtSearchController.text
      };

      if (showLoader == true) EasyLoading.show(status: "Loading...");

      objResponse = await getVideo(body: parameters);

      if (objResponse.status == 1) {
        if (objResponse.videos!.isNotEmpty) {
          updateData(objResponse.videos!);
        }

        if (objResponse.videos!.length < objResponse.total!) {
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
      arrVideos.clear();
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

    await APICALL_getVideos(showLoader);
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

  void updateData_Language(List<clsLanguage> Data) {
    setState(() {
      arrLanguage.clear();
      arrLanguage_filter.clear();
      arrLanguage_selected.clear();

      arrLanguage.addAll(Data);
    });
  }

  Future APICALL_get_languages(bool showLoader) async {
    clsLanguageResponseModel objResponse = clsLanguageResponseModel();
    try {
      Map<String, dynamic> parameters = {};

      if (showLoader == true) EasyLoading.show(status: "Loading...");

      objResponse = await get_languages(body: parameters);
      if (objResponse.status == 1) {
        if (objResponse.languages!.isNotEmpty) {
          updateData_Language(objResponse.languages!);
        }

        if (showLoader == true) EasyLoading.dismiss(animation: true);
      } else {
        if (showLoader == true) EasyLoading.dismiss(animation: true);

        EasyLoading.showToast(objResponse.message!);
      }

      APICALL_getcategory(showLoader);
    } catch (exception) {
      if (kDebugMode) {
        print(exception.toString());
      }
      //EasyLoading.showToast("" + exception.toString());
      if (showLoader == true) EasyLoading.dismiss(animation: true);
    }
  }

  void updateData_Category(List<clsCategory> Data) {
    setState(() {
      arrCategory.clear();
      arrCategory_filter.clear();
      arrCategory_selected.clear();

      arrCategory.addAll(Data);
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
      APICALL_get_topics(showLoader);
    } catch (exception) {
      if (kDebugMode) {
        print(exception.toString());
      }
      //EasyLoading.showToast("" + exception.toString());
      if (showLoader == true) EasyLoading.dismiss(animation: true);
    }
  }

  void updateData_Topic(List<clsTopic> Data) {
    setState(() {
      arrTopic.clear();
      arrTopic_filter.clear();
      arrTopic_selected.clear();
      arrTopic.addAll(Data);
    });
  }

  Future APICALL_get_topics(bool showLoader) async {
    clsTopicResponseModel objResponse = clsTopicResponseModel();
    try {
      Map<String, dynamic> parameters = {};

      if (showLoader == true) EasyLoading.show(status: "Loading...");

      objResponse = await get_topics(body: parameters);
      if (objResponse.status == 1) {
        if (objResponse.topics!.isNotEmpty) {
          updateData_Topic(objResponse.topics!);
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
}
