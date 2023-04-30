import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../color/customcolor.dart';
import '../DMS/Document Type/Add document.dart';
import 'Add_Client_Management.dart';

class Client_Management extends StatefulWidget {
  final String title;
  const Client_Management({Key? key, required this.title}) : super(key: key);

  @override
  State<Client_Management> createState() => _Client_ManagementState();
}

class _Client_ManagementState extends State<Client_Management> {
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
                  builder: (context) => Add_Client_Management(),
                ));
          },
          child: Icon(Icons.add)),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.only(top: 20.0, left: 20, right: 20),
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
                                Icon(
                                  Icons.person,
                                  color: CustomColor().colorPrimary,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'Deep Patel',
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
                              ],
                            )
                          ],
                        ),
                      ),
                      Divider(indent: 10,endIndent: 10,thickness: 1,),
                      icontext(Icons.call,"9328143230"),
                      icontext(Icons.email,"bhensdadiadeep@gmail.com"),
                      icontext(Icons.location_on,"Surat"),
                    ],
                  ),
                ),
              )),
        ),
      ),
    );
  }
  icontext(IconData icon,String name){
    return Row(
      children: [
        Icon(icon,color: Colors.grey,size: 18,),
        SizedBox(width: 10,),
        Text(
          name,
          style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.black,
              fontSize: 13,height: 2.5),
        )
      ],
    );
  }
}
