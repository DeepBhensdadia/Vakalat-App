import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import '../../../helper.dart';
import '../../../utils/constant.dart';
import '../../../utils/design.dart';

class Professional_Detail extends StatefulWidget {
  const Professional_Detail({Key? key}) : super(key: key);

  @override
  State<Professional_Detail> createState() => _Professional_DetailState();
}

class _Professional_DetailState extends State<Professional_Detail> {
  DateTime? ragistration_date;
  DateTime? ragistration_year;
  DateTime? dis_registartion_date;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: ragistration_date ?? DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != ragistration_date) {
      setState(() {
        ragistration_date = picked;
      });
    }
  }

  Future<void> registartion_year(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: ragistration_year ?? DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != ragistration_year) {
      setState(() {
        ragistration_year = picked;
      });
    }
  }

  Future<void> dis_court_registartion_date(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: dis_registartion_date ?? DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != dis_registartion_date) {
      setState(() {
        dis_registartion_date = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    TextEditingController sanadragino = TextEditingController();
    TextEditingController sanadragiyear = TextEditingController();
    TextEditingController welfareragiyear = TextEditingController();
    TextEditingController dis_court_no = TextEditingController();
    TextEditingController law_firm = TextEditingController();
    TextEditingController qualification = TextEditingController();
    TextEditingController expirianceinyear = TextEditingController();
    TextEditingController notoryno = TextEditingController();

    final formattedDate = ragistration_date != null
        ? DateFormat('yyyy-MM-dd').format(ragistration_date!)
        : 'Select Sanad Ragistration date';
    final formattedDate2 = ragistration_year != null
        ? DateFormat('yyyy-MM-dd').format(ragistration_year!)
        : 'Select Welfare Ragistration date';
    final formattedDate3 = dis_registartion_date != null
        ? DateFormat('yyyy-MM-dd').format(dis_registartion_date!)
        : 'Dis. court Ragistration date';
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      'Verification Document',
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue),
                    ),
                  ),
                  MaterialButton(
                      onPressed: () {},
                      child: const Icon(
                        FontAwesomeIcons.add,
                        size: 25,
                      ))
                ],
              ),
            ),
            CustomTextfield(
              labelname: 'Sanad Certificate',
              suffixicon: Icons.expand_more,
            ),
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
                      const Text('Uplode Document'),
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
            const Divider(
              thickness: 1,
            ),
            CustomTextfield(
              labelname: ' Sanad Ragistration No',
              type: TextInputType.number,
              Controller: sanadragino,
              validator: (p0) {
                if (p0!.isEmpty) {
                  return 'PLz Enter Ragistration No';
                }
                return null;
              },
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
              child: InkWell(
                onTap: () => registartion_year(context),
                child: Container(
                  height: 50,
                  width: screenwidth(context, dividedby: 1),
                  decoration: Const().decorationfield,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          formattedDate.toString(),
                          style: const TextStyle(fontSize: 16, color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            CustomTextfield(
              labelname: ' Sanad Ragistration year',
              type: TextInputType.number,
              Controller: sanadragiyear,
              validator: (p0) {
                if (p0!.isEmpty) {
                  return 'PLz Enter Ragistration Year';
                }
                return null;
              },
            ),
            CustomTextfield(
              labelname: ' welfare Ragistration year',
              type: TextInputType.number,
              Controller: welfareragiyear,
              validator: (p0) {
                if (p0!.isEmpty) {
                  return 'PLz Enter Welfare Ragistration Year';
                }
                return null;
              },
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
              child: InkWell(
                onTap: () => _selectDate(context),
                child: Container(
                  height: 50,
                  width: screenwidth(context, dividedby: 1),
                  decoration: Const().decorationfield,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          formattedDate2.toString(),
                          style: const TextStyle(fontSize: 16, color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            CustomTextfield(
              labelname: ' Dis. court Ragistration no',
              type: TextInputType.number,
              Controller: dis_court_no,
              validator: (p0) {
                if (p0!.isEmpty) {
                  return 'PLz Enter  Dis. court Ragistration no';
                }
                return null;
              },
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
              child: InkWell(
                onTap: () => dis_court_registartion_date(context),
                child: Container(
                  height: 50,
                  width: screenwidth(context, dividedby: 1),
                  decoration: Const().decorationfield,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          formattedDate3.toString(),
                          style: const TextStyle(fontSize: 16, color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            CustomTextfield(
              labelname: 'Bar Council',
              suffixicon: Icons.expand_more,
            ),
            CustomTextfield(
              labelname: 'Bar Association',
              suffixicon: Icons.expand_more,
            ),
            CustomTextfield(
              labelname: 'Law Firm',
Controller: law_firm,     validator: (p0) {
              if(p0!.isEmpty){
                return 'PLz Enter Law Firm';
              }
              return null;
            },            ),
            CustomTextfield(
              labelname: 'Qualification',
              Controller: qualification,
              validator: (p0) {
                if(p0!.isEmpty){
                  return 'PLz Enter Qualification';
                }
                return null;
              },
            ),
            CustomTextfield(
              labelname: 'Expirience(In Year)',
              Controller: expirianceinyear,
              validator: (p0) {
                if(p0!.isEmpty){
                  return 'PLz Enter Expirience';
                }
                return null;
              },
            ),
            CustomTextfield(
              labelname: 'Notory No',
              type: TextInputType.number,
              Controller: notoryno,
              validator: (p0) {
                if(p0!.isEmpty){
                  return 'PLz Enter Notory No';
                }
                return null;
              },
            ),
            Button_For_Update_Save(
              text: 'Update',
              onpressed: () {
                if(formKey.currentState!.validate()){}
              },
            ),
          ],
        ),
      ),
    );
  }
}
