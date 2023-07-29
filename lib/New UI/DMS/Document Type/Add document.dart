import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vakalat_flutter/utils/design.dart';

import '../../../color/customcolor.dart';
import '../../../helper.dart';
import '../../../utils/constant.dart';

class Add_Document extends StatefulWidget {
  const Add_Document({Key? key}) : super(key: key);

  @override
  State<Add_Document> createState() => _Add_DocumentState();
}

class _Add_DocumentState extends State<Add_Document> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Documnet',
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
            CustomTextfield(labelname: 'Enter Doc Name'),
            Button_For_Update_Save(text: 'Update', onpressed: () {  },),

          ],
        ),
      ),
    );
  }
}
