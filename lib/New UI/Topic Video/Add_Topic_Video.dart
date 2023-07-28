import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vakalat_flutter/utils/design.dart';

import '../../color/customcolor.dart';
import '../../helper.dart';
import '../../utils/constant.dart';

class Add_Topic_Video extends StatefulWidget {
  const Add_Topic_Video({Key? key}) : super(key: key);

  @override
  State<Add_Topic_Video> createState() => _Add_Topic_VideoState();
}

class _Add_Topic_VideoState extends State<Add_Topic_Video> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Upload Documnet',
          style: TextStyle(
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        backgroundColor: CustomColor().colorPrimary,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomTextfield(labelname: 'Languages'),
            CustomTextfield(labelname: 'Category'),
            CustomTextfield(labelname: 'Sub Category'),
            CustomTextfield(labelname: 'Topic'),
            CustomTextfield(labelname: 'Title'),
            CustomTextfield(labelname: 'Details'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Container(
                height: 50,
                width: screenwidth(context, dividedby: 1),
                decoration: Const().decorationfield,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Topic Video'),
                      Container(
                        height: 50,
                        width: 50,
                        color: Colors.blue,
                        child: const Center(
                          child: Icon(
                            FontAwesomeIcons.add,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Button_For_Update_Save(
              text: 'Update',
              onpressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
