
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../helper.dart';
import '../../../utils/constant.dart';
import '../../../utils/design.dart';

class Portfolio_screen extends StatefulWidget {
  const Portfolio_screen({Key? key}) : super(key: key);

  @override
  State<Portfolio_screen> createState() => _Portfolio_screenState();
}

class _Portfolio_screenState extends State<Portfolio_screen> {
TextEditingController aboutyou = TextEditingController();
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            CustomTextfield(labelname: 'About You',Controller: aboutyou,validator: (p0) {
              if(p0!.isEmpty){
                return 'Enter About You';
              }
              return null;
            },),
            CustomTextfield(labelname: 'Category/Sub Category',suffixicon: Icons.expand_more,),
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
                          'Bio Data',
                          style: TextStyle(fontSize: 16, color: Colors.black54),
                        ),
                        ElevatedButton(
                            onPressed: () {},
                            child: Row(
                              children: const [
                                Icon(FontAwesomeIcons.add, size: 16),
                                VerticalDivider(
                                    thickness: 2,
                                    color: Colors.white,
                                    endIndent: 5,
                                    indent: 5),
                                Icon(
                                  FontAwesomeIcons.download,
                                  size: 16,
                                ),
                              ],
                            ))
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Button_For_Update_Save(text: 'Update', onpressed: () {
              if(_formKey.currentState!.validate()){}
            },),

          ],
        ),
      ),
    );
  }
}
