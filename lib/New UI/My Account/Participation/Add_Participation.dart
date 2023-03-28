import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vakalat_flutter/utils/design.dart';

import '../../../color/customcolor.dart';
import '../../../helper.dart';
import '../../../utils/constant.dart';

class Add_Participation extends StatefulWidget {
  const Add_Participation({Key? key}) : super(key: key);

  @override
  State<Add_Participation> createState() => _Add_ParticipationState();
}

class _Add_ParticipationState extends State<Add_Participation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Participation',
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
            CustomTextfield(labelname: 'Title'),
            CustomTextfield(labelname: 'Enter Month',suffixicon: Icons.expand_more),
            CustomTextfield(labelname: 'Enter Year',suffixicon: Icons.expand_more),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
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
                          'Cover Picture',
                          style: TextStyle(fontSize: 16, color: Colors.black54),
                        ),
                        ElevatedButton(
                            onPressed: () {},
                            child: const Icon(FontAwesomeIcons.add, size: 16))
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
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
                          'Other Images',
                          style: TextStyle(fontSize: 16, color: Colors.black54),
                        ),
                        ElevatedButton(
                            onPressed: () {},
                            child: const Icon(FontAwesomeIcons.add, size: 16))
                      ],
                    ),
                  ),
                ),
              ),
            ),
            CustomTextfield(labelname: 'Detais'),
            Button_For_Update_Save(text: 'Save', onpressed: () {  },),

          ],
        ),
      ),
    );
  }
}
