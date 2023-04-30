import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../color/customcolor.dart';
import '../../../utils/constant.dart';
import '../Document Type/Add document.dart';
import 'add_upload_document.dart';

class Upload_Document extends StatefulWidget {
  final String title;
  const Upload_Document({Key? key, required this.title}) : super(key: key);

  @override
  State<Upload_Document> createState() => _Upload_DocumentState();
}

class _Upload_DocumentState extends State<Upload_Document> {
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
                  builder: (context) => Add_Upload_Documents(),
                ));
          },
          child: Icon(Icons.add)),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) => Container(
          // height: 80,
          child: Padding(
            padding: const EdgeInsets.only(top: 15.0, left: 15, right: 15),
            child: Card(
              margin: EdgeInsets.zero,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    texttype(   'Documnet Type', 'Case Document',),
                    texttype(   'Documnet Title', 'FIR',),
                    texttype(   'Detail', 'Case Related Document',),

                    Row(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Action',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w600,height: 1.5),
                        ),
                        Row(
                          children: [

                            MaterialButton(
                              color: const Color(0xff448BE8),
                              height: 25,
                              minWidth: 35,
                              padding: EdgeInsets.zero,
                              onPressed: () {},
                              child: const Icon(
                                FontAwesomeIcons.edit,
                                size: 12,
                                color: Colors.white,
                              ),
                            ),
                            MaterialButton(
                              color: buttonred,
                              height: 25,
                              minWidth: 35,
                              padding: EdgeInsets.zero,
                              onPressed: () {},
                              child: const Icon(
                                Icons.delete,
                                size: 12,
                                color: Colors.white,
                              ),
                            ),    MaterialButton(

                              color: CustomColor().colorPrimary,
                              height: 25,
                              minWidth: 35,
                              padding: EdgeInsets.zero,
                              onPressed: () {},
                              child: const Icon(
                                Icons.cloud_download_outlined,
                                size: 12,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  texttype(String title,String subtitle){
    return       Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
         title,
          style: TextStyle(
              fontSize: 14, fontWeight: FontWeight.w600,height: 2),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          subtitle,
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black54),
        )
      ],
    );
  }
}
