import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../color/customcolor.dart';
import 'Add document.dart';

class Document_Type extends StatefulWidget {
  final String title;
  const Document_Type({Key? key, required this.title}) : super(key: key);

  @override
  State<Document_Type> createState() => _Document_TypeState();
}

class _Document_TypeState extends State<Document_Type> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

     appBar: AppBar(
        title:  Text(widget.title),
        centerTitle: true,
        backgroundColor: CustomColor().colorPrimary,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(onPressed: () { Navigator.push(context, CupertinoPageRoute(builder: (context) => Add_Document(),)); },
      child: Icon(Icons.add)),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) => Container(
          // height: 80,
          child: Padding(
            padding: const EdgeInsets.only(top: 15.0,left: 15,right: 15),
            child: Card(
              margin: EdgeInsets.zero,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Documnet Type',style: TextStyle(fontSize: 13,fontWeight: FontWeight.w600),),
                        SizedBox(height: 10,),
                        Text('Agreement',style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500,color: Colors.black54),)
                      ],
                    ),
                    Row(
                      children: [
                        MaterialButton(
                          color: const Color(0xff448BE8),
                          height: 25,
                          minWidth: 25,
                          padding: EdgeInsets.zero,
                          onPressed: () {},
                          child: const Icon(
                            FontAwesomeIcons.edit,
                            size: 12,
                            color: Colors.white,
                          ),
                        ),
                        MaterialButton(
                          color: const Color(0xffAF3F3F),
                          height: 25,
                          minWidth: 25,
                          padding: EdgeInsets.zero,
                          onPressed: () {},
                          child: const Icon(
                            Icons.delete,
                            size: 12,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),),
    );
  }
}
