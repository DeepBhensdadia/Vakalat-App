import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../New UI/Dashboard_screens/Dashboard_Screen.dart';
import '../color/customcolor.dart';

class Message_page extends StatefulWidget {
  final String title;
  const Message_page({Key? key, required this.title, }) : super(key: key);

  @override
  State<Message_page> createState() => _Message_pageState();
}

class _Message_pageState extends State<Message_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(
          widget.title,
          style: TextStyle(
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        backgroundColor: CustomColor().colorPrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              textAlign: TextAlign.center,
              'Plz Used Web Version.',
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.grey, fontSize: 20),
            ),
            CupertinoButton(child: Text('https://www.vakalat.com',  style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 20)), onPressed: (){launch('https://www.vakalat.com');}),
          ],
        ),
      ),
    );
  }
}
