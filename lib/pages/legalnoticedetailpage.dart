
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:vakalat_flutter/color/customcolor.dart';
import 'package:vakalat_flutter/model/clsLawyer.dart';
import 'package:vakalat_flutter/model/clsLegalNotice.dart';
import 'package:vakalat_flutter/pages/lawyerdetailpage.dart';
import 'package:vakalat_flutter/utils/common_functions.dart';
import 'package:vakalat_flutter/utils/constant.dart';
import 'package:vakalat_flutter/utils/keyboardHiderMixin.dart';

class LegalNoticeDetailPage extends StatefulWidget {
  const LegalNoticeDetailPage({Key? key, required this.title ,required this.objLegalNotice}) : super(key: key);

  final String title;
  final clsLegalNotice objLegalNotice;

  @override
  State<LegalNoticeDetailPage> createState() => _LegalNoticeDetailPageState();
}

class _LegalNoticeDetailPageState extends State<LegalNoticeDetailPage> with KeyboardHiderMixin {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            widget.title,
            style: const TextStyle(
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
        body: buildBody(context));
  }

  Widget buildBody(BuildContext context) {
    return ListView(
      children: [
        createBlock_Details(),
      ],
    );
  }

  Widget createBlock_Details() {
    var objLegalNotice = widget.objLegalNotice;

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


            });
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            verticalDirection: VerticalDirection.down,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Container(
                margin: const EdgeInsets.all(5.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  verticalDirection: VerticalDirection.down,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Expanded(
                      flex: 7,
                      child: Container(
                        margin: const EdgeInsets.all(5.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
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
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(8, 5, 8, 0),
                height: 1.0,
                color: CustomColor().colorLightGray,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 5, 8, 0),
                child: Text(
                  objLegalNotice.title!,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: CustomColor().colorPrimary,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 5, 8, 0),
                child: Row(
                  children: <Widget>[
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
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 5, 8, 0),
                child: Container(
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
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 5, 8, 0),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.date_range,
                      color: CustomColor().colorPrimary,
                    ),
                    Text(
                        "Published On Vakalat ${CommonFunctions.formatDate("yyyy-MM-dd",
                          "dd/MM/yyyy", objLegalNotice.publish_start_date!)}" ,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: CustomColor().colorPrimary,
                          fontSize: 14.0),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 5, 8, 8),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.person,
                      color: CustomColor().colorPrimary,
                    ),
                    Text(
                      "Notice from : ${objLegalNotice.from_notice!}" ,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: CustomColor().colorPrimary,
                          fontSize: 14.0),
                    ),
                    const Spacer(),
                    Icon(
                      Icons.person,
                      color: CustomColor().colorPrimary,
                    ),
                    Text(
                      "Notice to : ${objLegalNotice.to_notice!}" ,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: CustomColor().colorPrimary,
                          fontSize: 14.0),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(8, 5, 8, 0),
                height: 1.0,
                color: CustomColor().colorLightGray,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 5, 8, 5),
                child: Html(data: objLegalNotice.desc!),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
