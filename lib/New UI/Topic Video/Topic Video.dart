import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../color/customcolor.dart';
import '../DMS/Document Type/Add document.dart';

class Topic_Video extends StatefulWidget {
  final String title;
  const Topic_Video({Key? key, required this.title}) : super(key: key);

  @override
  State<Topic_Video> createState() => _Topic_VideoState();
}

class _Topic_VideoState extends State<Topic_Video> {
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
            child:SizedBox(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Search Topic',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.blue,
                        fontWeight: FontWeight.w600),
                  ),
                  Icon(
                    Icons.expand_more,
                    size: 30,
                  ),
                ],
              ),
            ),
          ),
          Divider(thickness: 1,endIndent: 20,indent: 20,),
          Expanded(
            child: Container(
              child: ListView.builder(
                // physics: NeverScrollableScrollPhysics(),
                itemCount: 4,
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
                                    Text(
                                     index==1?"Not Uploaded": 'Active',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color:index==1?CustomColor().colorRed_notverified: CustomColor().colorGreen,
                                          fontSize: 15),
                                    ),
                                   index ==1?InkWell(
                                     child: Container(
                                       color: CustomColor().colorPrimary,
                                       child: Icon(
                                         Icons.add,
                                         size: 28,
                                         color: Colors.white,
                                       ),
                                     ),
                                   ): Row(
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
                              textwidget("Title", "Knowlage of GST laws"),
                              textwidget("Language", "English"),
                              textwidget("Category", "Corporate Law"),
                              textwidget("Sub Category", "GST"),
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

  textwidget(
      String title,
      String subtitle,
      ) {
    return Row(
      children: [
        SizedBox(
          width: 90,
          child: Text(
            title,
            style:
            TextStyle(fontSize: 14, fontWeight: FontWeight.w600, height: 2),
          ),
        ),
        SizedBox(
          width: 5,
        ),
        Text(
          " : ",
          style: TextStyle(
              fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black54),
        ),
        SizedBox(
          width: 5,
        ),
        Text(
          subtitle,
          style: TextStyle(
              fontSize: 13, fontWeight: FontWeight.w500, color: Colors.black54),
        )
      ],
    );
  }
}
