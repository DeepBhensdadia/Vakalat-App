import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:vakalat_flutter/New%20UI/Dashboard_screens/video_screen.dart';
import 'package:vakalat_flutter/model/GetDashboard.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../color/customcolor.dart';
import '../../helper.dart';
import '../../pages/video_detail_page.dart';

class your_Videos extends StatefulWidget {
  final Getdashboard value;
  const your_Videos({Key? key, required  this.value}) : super(key: key);

  @override
  State<your_Videos> createState() => _your_VideosState();
}

class _your_VideosState extends State<your_Videos> {
  // late ScrollController _controller;
  @override
  Widget build(BuildContext context) {
    return widget.value.data.videos.data.isNotEmpty? ListView.separated(
        // controller: _controller,
        separatorBuilder: (context, index) {

          return const Divider(height: 1, color: Colors.transparent);
        },
        itemCount: widget.value.data.videos.data.length,
        itemBuilder: (context, index) {
          VideosDatum videos = widget.value.data.videos.data[index];
          var videoID = getVideoIDFromURL(widget.value.data.videos.data[index].plainUrl);
          // var rng = new Random();
          // var randomNumber = rng.nextInt(10000);

          var strThumbnailURL = getThumbnailURLfromVideoID(videoID);
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
                        child: Videos_Screen(
                          title: "videoDetail",
                          datavideo: videos,
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
                          height: screenheight(context,dividedby: 4),
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(5.0, 5.0, 2.0, 0.0),
                        child: Text(
                          videos.title,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: CustomColor().colorPrimary, fontSize: 16.0),
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.fromLTRB(5.0, 0.0, 2.0, 0.0),
                      //   child: Text(
                      //     videos.desc,
                      //     textAlign: TextAlign.left,
                      //     style: TextStyle(
                      //         color: CustomColor().colorDarkGray, fontSize: 14.0),
                      //   ),
                      // ),
                      InkWell(
                        splashColor: CustomColor().colorPrimary.withOpacity(0.4),
                        onTap: () {
                          setState(() {
                            // onTap

                            print("onTap");

                            // Navigator.push(
                            //   context,
                            //   PageTransition(
                            //     type: PageTransitionType.rightToLeftWithFade,
                            //     duration: const Duration(milliseconds: 300),
                            //     child: LawyerDetailPage(
                            //       title: " ${objVideo.first_name!} ${objVideo.last_name!}",
                            //       objLawyer: clsLawyer(user_id: objVideo.user_id),
                            //     ),
                            //   ),
                            // );
                          });
                        },
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.person,
                              color: CustomColor().colorPrimary,
                            ),
                            Text(
                              " ${videos.firstName} ${videos.lastName}",
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
          );;
        }) : Center(child: Text('No Data'),);
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

}
