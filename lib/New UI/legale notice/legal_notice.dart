import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../color/customcolor.dart';
import '../DMS/Document Type/Add document.dart';

class Legal_Notice extends StatefulWidget {
  final String title;
  const Legal_Notice({Key? key, required this.title}) : super(key: key);

  @override
  State<Legal_Notice> createState() => _Legal_NoticeState();
}

class _Legal_NoticeState extends State<Legal_Notice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        backgroundColor: CustomColor().colorPrimary,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => Add_Document(),
                ));
          },
          child: Icon(Icons.add)),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20, top: 20),
            child: ElevatedButton(
              style: ButtonStyle(backgroundColor: MaterialStateColor.resolveWith((states) => CustomColor().colorPrimary)),
                onPressed: () {},
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.shopping_cart),
                      Text('Buy Legal Notice Package')
                    ],
                  ),
                )),
          ),
          Expanded(
            child: Container(
              child: ListView.builder(
                // physics: NeverScrollableScrollPhysics(),
                itemCount: 2,
                itemBuilder: (context, index) => Padding(
                  padding:
                      const EdgeInsets.only(top: 20.0, left: 20, right: 20),
                  child: Container(
                      // height: 150,
                      child: Card(
                    margin: EdgeInsets.zero,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Container(
                            height: 30,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                        'assets/images/sample_user.png'),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'legle notice',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: CustomColor().colorPrimary,
                                          fontSize: 15),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    InkWell(
                                      child: Icon(
                                        Icons.edit_note,
                                        size: 28,
                                        color: CustomColor().colorPrimary,
                                      ),
                                    ),
                                    VerticalDivider(
                                      thickness: 1,
                                      endIndent: 5,
                                      indent: 5,
                                    ),
                                    InkWell(
                                      child: Icon(
                                        Icons.delete,
                                        size: 28,
                                        color: Color(0xffAF3F3F),
                                      ),
                                    ),
                                    VerticalDivider(
                                      thickness: 1,
                                      endIndent: 5,
                                      indent: 5,
                                    ),
                                    InkWell(
                                      child: Icon(
                                        Icons.remove_red_eye_rounded,
                                        size: 28,
                                        color: CustomColor().colorPrimary,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Divider(
                            indent: 10,
                            endIndent: 10,
                            thickness: 1,
                          ),
                          icontext("From Notice", "Homiyar Vasuna"),
                          icontext("To Notice", "NareshBhai Patel"),
                          icontext("Status", "Active"),
                        ],
                      ),
                    ),
                  )),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  icontext(
    String title,
    String subtitle,
  ) {
    return Row(
      children: [
        SizedBox(
          width: 80,
          child: Text(
            title,
            style:
                TextStyle(fontSize: 14, fontWeight: FontWeight.w600, height: 2),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          " : ",
          style: TextStyle(
              fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black54),
        ),
        Text(
          subtitle,
          style: TextStyle(
              fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black54),
        )
      ],
    );
  }
}
