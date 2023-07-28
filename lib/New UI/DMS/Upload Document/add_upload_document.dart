import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vakalat_flutter/utils/design.dart';

import '../../../color/customcolor.dart';
import '../../../helper.dart';
import '../../../utils/constant.dart';

class Add_Upload_Documents extends StatefulWidget {
  const Add_Upload_Documents({Key? key}) : super(key: key);

  @override
  State<Add_Upload_Documents> createState() => _Add_Upload_DocumentsState();
}

class _Add_Upload_DocumentsState extends State<Add_Upload_Documents> {
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
            CustomTextfield(labelname: 'Document_Type'),
            Row(
              children: [
                Expanded(child: CustomTextfield(labelname: 'Client')),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(width: 1),
                        borderRadius: BorderRadius.circular(5)),
                    width: 40,
                    height: 50,
                    child: Icon(Icons.add),
                  ),
                ),
              ],
            ),
            CustomTextfield(labelname: 'Category'),
            CustomTextfield(labelname: 'Sub Category'),
            CustomTextfield(labelname: 'Doc Title'),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
              child: InkWell(
                onTap: () {},
                child: Container(
                  height: 50,
                  width: screenwidth(context, dividedby: 1),
                  decoration: Const().decorationfield,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Upload Document',
                          style: TextStyle(fontSize: 16, color: Colors.black54),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          child: Icon(FontAwesomeIcons.add, size: 16),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Document 1',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  Row(
                    children: [
                      MaterialButton(
                        color: CustomColor().colorPrimary,
                        height: 25,
                        minWidth: 35,
                        padding: EdgeInsets.zero,
                        onPressed: () {},
                        child: const Icon(
                          FontAwesomeIcons.download,
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
                      ),
                    ],
                  )
                ],
              ),
            ),
            CustomTextfield(labelname: 'Enter Details'),
            Button_For_Update_Save(text:'Update', onpressed: () {
              
            },)

          ],
        ),
      ),
    );
  }
}
