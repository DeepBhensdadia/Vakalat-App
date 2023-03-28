
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vakalat_flutter/color/customcolor.dart';
import 'package:vakalat_flutter/utils/common_functions.dart';
import 'package:vakalat_flutter/utils/keyboardHiderMixin.dart';

class ContactUsPage extends StatefulWidget {
  const ContactUsPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<ContactUsPage> createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> with KeyboardHiderMixin {
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
    return Center(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              verticalDirection: VerticalDirection.down,
              textBaseline: TextBaseline.alphabetic,
              children: [
                IconButton(
                  icon: FaIcon(FontAwesomeIcons.phoneAlt,
                      color: CustomColor().colorPrimary),
                  onPressed: () {
                    CommonFunctions.makePhoneCall("9327117207");
                  },
                ),
                IconButton(
                  icon: FaIcon(FontAwesomeIcons.whatsapp,
                      color: CustomColor().colorPrimary),
                  onPressed: () {
                    launch(CommonFunctions.whatsapp_LawyerContact(
                        "9327117207",
                        ""));
                  },
                ),
                IconButton(
                  icon: FaIcon(FontAwesomeIcons.envelope,
                      color: CustomColor().colorPrimary),
                  onPressed: () {
                    String url = "mailto:" ;
                    var encoded = Uri.encodeFull(url);
                    launch(encoded);
                  },
                ),
              ],
            ),
            //
            // Padding(
            //   padding: const EdgeInsets.only(top: 10.0),
            //   child: Text(
            //       "vakalat.com",
            //     style:  TextStyle(
            //       color: CustomColor().colorPrimary,
            //     ),
            //     textAlign: TextAlign.center,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }


}
