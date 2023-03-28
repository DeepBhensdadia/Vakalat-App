import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:vakalat_flutter/api/postapi.dart';
import 'package:vakalat_flutter/color/customcolor.dart';
import 'package:vakalat_flutter/model/clsVideo.dart';
import 'package:vakalat_flutter/model/clsVideoResponseModel.dart';
import 'package:vakalat_flutter/utils/common_functions.dart';
import 'package:vakalat_flutter/utils/keyboardHiderMixin.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class video_detail_page extends StatefulWidget {
  const video_detail_page(
      {Key? key, required this.title, required this.objVideo})
      : super(key: key);

  final String title;
  final clsVideo objVideo;

  @override
  State<video_detail_page> createState() => _video_detail_page_State();
}

class _video_detail_page_State extends State<video_detail_page>
    with KeyboardHiderMixin {
  clsVideo objVideoCurrent = clsVideo();

  late YoutubePlayerController _controller;
  List<clsVideo> arrVideos = [];
  late ScrollController _scrollController;
  @override
  void initState() {
    // TODO: implement initState
    _scrollController = ScrollController();
    objVideoCurrent = widget.objVideo;
    loadVideo(objVideoCurrent.plain_url!);
    APICALL_get_kyl_related_video(false, objVideoCurrent);
    super.initState();
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void loadVideo(String strURL) {
    _controller = YoutubePlayerController(
      initialVideoId: getVideoIDFromURL(strURL),
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
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

  @override
  Widget build(BuildContext context ) {
    return YoutubePlayerBuilder(
      onExitFullScreen: () {
        // The player forces portraitUp after exiting fullscreen. This overrides the behaviour.
        // SystemChrome.setPreferredOrientations(DeviceOrientation.values);
      },
      player: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: CustomColor().colorPrimary,
        onReady: () {
          if (kDebugMode) {
            print('onReady');
          }
        },
        onEnded: (data) {
          if (kDebugMode) {
            print('onEnded');
          }
        },
      ),
      builder: (context, player) => Scaffold(
        appBar: AppBar(
          title: Text(
            objVideoCurrent.title!,
            style: const TextStyle(
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          centerTitle: true,
          backgroundColor: CustomColor().colorPrimary,
          leading: null,
        ),
        body: Container(
          margin: const EdgeInsets.all(5.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              verticalDirection: VerticalDirection.down,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Container(
                  margin: const EdgeInsets.all(5.0),
                ),
                player,
                Padding(
                  padding: const EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 0.0),
                  child: Text(
                    objVideoCurrent.topic!,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: CustomColor().colorPrimary, fontSize: 14.0),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 0.0),
                  child: Text(
                    objVideoCurrent.title!,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: CustomColor().colorPrimary,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 0.0),
                  child: Text(
                    objVideoCurrent.topic_desc!,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: CustomColor().colorDarkGray, fontSize: 14.0),
                  ),
                ),
                Container(
                    margin: const EdgeInsets.only(left: 10.0, right: 15.0),
                    child: const Divider(
                      color: Colors.black,
                      height: 5,
                    )),
                Expanded(
                  child: ListView.separated(
                      controller: _scrollController,
                      separatorBuilder: (context, index) =>
                          const Divider(height: 1, color: Colors.transparent),
                      itemCount: arrVideos.length,
                      itemBuilder: (context, index) {
                        return createBlock(index);
                      }),
                ),
              ]),
        ),
      ),
    );
  }

  Widget createBlock(int index ) {
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
      child: InkWell(
        splashColor: CustomColor().colorPrimary.withOpacity(0.4),
        onTap: () {
          setState(() {
            // onTap

            print("onTap");

            setState(() {
              objVideoCurrent = objVideo;
              _scrollTop();
              _controller.load(videoID);
              APICALL_get_kyl_related_video(false, objVideoCurrent);
            });
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
                      objVideo.topic!,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: CustomColor().colorPrimary, fontSize: 14.0),
                    ),
                    Text(
                      objVideo.title!,
                      textAlign: TextAlign.left,
                      maxLines: 1,
                      style: TextStyle(
                          color: CustomColor().colorPrimary,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      objVideo.topic_desc!,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: CustomColor().colorDarkGray, fontSize: 14.0),
                    ),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.date_range,
                          color: CustomColor().colorPrimary,
                        ),
                        Text(
                          CommonFunctions.formatDate(
                              "yyyy-MM-dd", "dd/MM/yyyy", objVideo.created_at!),
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: CustomColor().colorPrimary,
                              fontSize: 14.0),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  void _scrollTop() {
    _scrollController.animateTo(
      _scrollController.position.minScrollExtent,
      duration: const Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }
  void updateData(List<clsVideo> Data) {
    setState(() {
      arrVideos.clear();
      arrVideos.addAll(Data);
    });
  }

  Future APICALL_get_kyl_related_video(
      bool showLoader, clsVideo objVideo) async {
    clsVideoResponseModel objResponse = clsVideoResponseModel();
    try {
      Map<String, dynamic> parameters = {
        "video_id": objVideo.id,
        "topic_id": objVideo.topic_id,
      };

      if (showLoader == true) EasyLoading.show(status: "Loading...");

      objResponse = await get_kyl_related_video(body: parameters);
      if (objResponse.status == 1) {
        if (objResponse.videos!.isNotEmpty) {
          updateData(objResponse.videos!);
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
