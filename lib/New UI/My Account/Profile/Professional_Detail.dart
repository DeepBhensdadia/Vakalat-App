import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:vakalat_flutter/model/Get_Profile.dart';
import 'package:vakalat_flutter/model/updatePortfoliodetails.dart';

import '../../../Sharedpref/shared_pref.dart';
import '../../../api/postapi.dart';
import '../../../helper.dart';
import '../../../model/Bar Associate List.dart';
import '../../../model/Get_doc_type.dart';
import '../../../model/UpdateContactDetails.dart';
import '../../../model/clsLoginResponseModel.dart';
import '../../../model/getbar_councilModel.dart';
import '../../../utils/ToastMessage.dart';
import '../../../utils/constant.dart';
import '../../../utils/design.dart';

class Professional_Detail extends StatefulWidget {
  final GetProfileModel detail;
  const Professional_Detail({Key? key, required  this.detail}) : super(key: key);

  @override
  State<Professional_Detail> createState() => _Professional_DetailState();
}

class _Professional_DetailState extends State<Professional_Detail> {
  ValueNotifier<List<BarCouncil>> council_builder = ValueNotifier([]);
  ValueNotifier<List<BarAssoc>> association_builder = ValueNotifier([]);
  // ValueNotifier<List<DocType>> doctypes = ValueNotifier([]);
  String barcouncil = '';
  String barassociation = '';
  String documenttype = '';
  ClsLoginResponseModel logindetails = clsLoginResponseModelFromJson(
      SharedPref.get(prefKey: PrefKey.loginDetails)!);
  // late  GetbarCouncillist barcouncil;
  void bar_council() async {
    EasyLoading.show(status: 'loading...');

    Map<String, dynamic> parameters = {
      "apiKey": apikey,
      'device': '2',
    };
    await get_bar_council(body: parameters).then((value) {
      EasyLoading.dismiss();
      setState(() {
        council_builder.value = value.barCouncils;
      });
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
    });
  }

  // void doc_type() async {
  //   EasyLoading.show(status: 'loading...');
  //
  //   Map<String, dynamic> parameters = {
  //     "apiKey": apikey,
  //     'device': '2',
  //     "accessToken": logindetails.accessToken,
  //     "user_id": logindetails.userData.userId,
  //     "offset":"0"
  //   };
  //   await getDoctype(body: parameters).then((value) {
  //     EasyLoading.dismiss();
  //     setState(() {
  //       doctypes.value = value.docType;
  //     });
  //   }).onError((error, stackTrace) {
  //     EasyLoading.dismiss();
  //   });
  // }

  void bar_associasion() async {
    EasyLoading.show(status: 'loading...');

    Map<String, dynamic> parameters = {
      "apiKey": apikey,
      'device': '2',
    };
    await get_bar_Association(body: parameters).then((value) {
      EasyLoading.dismiss();
      setState(() {
        association_builder.value = value.barAssoc;
      });
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
    });
  }

  DateTime? ragistration_date;
  DateTime? welfareragidate;
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

  Future<void> welfarerdate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: welfareragidate ?? DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != welfareragidate) {
      setState(() {
        welfareragidate = picked;
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
  void initState() {
    // TODO: implement initState
    // doc_type();
    sanadragino = TextEditingController(text:  widget.detail.profile.sanadRegNo);
    sanadragiyear = TextEditingController(text:  widget.detail.profile.sanadRegYear);
    welfareragiyear = TextEditingController(text:  widget.detail.profile.welfareNo);
    dis_court_no = TextEditingController(text:  widget.detail.profile.distCourtRegiNo);
    law_firm = TextEditingController(text:  widget.detail.profile.lawFirmName);
    assetsmemno = TextEditingController(text:  widget.detail.profile.assoMemberNo);
    qualification = TextEditingController(text:  widget.detail.profile.qualification);
    expirianceinyear = TextEditingController(text:  widget.detail.profile.experience);
    notoryno = TextEditingController(text:  widget.detail.profile.notaryNo);
    formattedDate = widget.detail.profile.sanadRegDate;
    formattedDate2 = widget.detail.profile.distCourtRegiDate;
    formattedDate3 = widget.detail.profile.welfareDate;
    bar_council();
    bar_associasion();
    super.initState();
  }

   String? formattedDate ='';
   String? formattedDate2 ='';
   String? formattedDate3 = '';
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController sanadragino = TextEditingController();
  TextEditingController sanadragiyear = TextEditingController();
  TextEditingController welfareragiyear = TextEditingController();
  TextEditingController dis_court_no = TextEditingController();
  TextEditingController law_firm = TextEditingController();
  TextEditingController assetsmemno = TextEditingController();
  TextEditingController qualification = TextEditingController();
  TextEditingController expirianceinyear = TextEditingController();
  TextEditingController notoryno = TextEditingController();
  @override
  Widget build(BuildContext context) {
    formattedDate = ragistration_date != null
        ? DateFormat('yyyy-MM-dd').format(ragistration_date!)
        : formattedDate == "" ?'Select Sanad Ragistration date' :formattedDate;
    formattedDate2 = welfareragidate != null
        ? DateFormat('yyyy-MM-dd').format(welfareragidate!)
        : formattedDate3 == "" ?'Select Welfare Ragistration date' :formattedDate2;
    formattedDate3 = dis_registartion_date != null
        ? DateFormat('yyyy-MM-dd').format(dis_registartion_date!)
        : formattedDate3 == "" ?'Dis. court Ragistration date' :formattedDate3;
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          children: [
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 15.0),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       const Padding(
            //         padding: EdgeInsets.symmetric(horizontal: 10.0),
            //         child: Text(
            //           'Verification Document',
            //           style: TextStyle(
            //               fontSize: 22,
            //               fontWeight: FontWeight.bold,
            //               color: Colors.blue),
            //         ),
            //       ),
            //       MaterialButton(
            //           onPressed: () {},
            //           child: const Icon(
            //             FontAwesomeIcons.add,
            //             size: 25,
            //           ))
            //     ],
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: dropdowngetdoctype(
            //     doctype: doctypes.value,
            //     onSelection: (p0) {
            //       documenttype = p0.toString();
            //     },
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            //   child: Container(
            //     height: 50,
            //     width: screenwidth(context, dividedby: 1),
            //     decoration: Const().decorationfield,
            //     child: Padding(
            //       padding: const EdgeInsets.only(left: 8.0),
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: [
            //           const Text('Uplode Document'),
            //           Container(
            //             height: 50,
            //             width: 50,
            //             color: Colors.blue,
            //             child: const Center(
            //               child: Icon(
            //                 FontAwesomeIcons.add,
            //                 color: Colors.white,
            //               ),
            //             ),
            //           )
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
            // const Divider(
            //   thickness: 1,
            // ),
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
                          formattedDate.toString(),
                          style: const TextStyle(
                              fontSize: 16, color: Colors.black54),
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
                onTap: () => welfarerdate(context),
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
                          style: const TextStyle(
                              fontSize: 16, color: Colors.black54),
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
                          style: const TextStyle(
                              fontSize: 16, color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
              child: drodownbar_council(
                  onSelection: (p0) {
                    barcouncil = p0.toString();
                    print(p0);
                  },
                  bar_council: council_builder.value),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
              child: dropdownbar_assoc(
                  onSelection: (p0) {
                    print(p0);
                    barassociation = p0.toString();
                  },
                  bar_assoc: association_builder.value),
            ),
            CustomTextfield(
              labelname: 'Law Firm',
              Controller: law_firm,
              validator: (p0) {
                if (p0!.isEmpty) {
                  return 'PLz Enter Law Firm';
                }
                return null;
              },
            ),
            CustomTextfield(
              labelname: 'Assets Member Number',
              Controller: assetsmemno,
              validator: (p0) {
                if (p0!.isEmpty) {
                  return 'PLz Enter Law Firm';
                }
                return null;
              },
            ),
            CustomTextfield(
              labelname: 'Qualification',
              Controller: qualification,
              validator: (p0) {
                if (p0!.isEmpty) {
                  return 'PLz Enter Qualification';
                }
                return null;
              },
            ),
            CustomTextfield(
              labelname: 'Expirience(In Year)',
              Controller: expirianceinyear,
              validator: (p0) {
                if (p0!.isEmpty) {
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
                if (p0!.isEmpty) {
                  return 'PLz Enter Notory No';
                }
                return null;
              },
            ),
            Button_For_Update_Save(
              text: 'Update',
              onpressed: () {
                if (formKey.currentState!.validate()) {
                  APICALL_Update_profeesional_Details.call();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Future APICALL_Update_profeesional_Details() async {
    EasyLoading.show(status: 'loading...');

    try {
      /*Retriving Parent Object*/
      ClsLoginResponseModel logindetails = clsLoginResponseModelFromJson(
          SharedPref.get(prefKey: PrefKey.loginDetails)!);

      Map<String, dynamic> parameters = {
        "apiKey": apikey,
        'device': '2',
        "accessToken": logindetails.accessToken,
        "user_id": logindetails.userData.userId,
        "sanad_reg_no": sanadragino.text,
        "sanad_reg_year": sanadragiyear.text,
        "sanad_reg_date": formattedDate,
        "welfare_no": welfareragiyear.text,
        "welfare_date": formattedDate2,
        "dist_court_regi_no": dis_court_no.text,
        "dist_court_regi_date": formattedDate3,
        "council_id": barcouncil,
        "association_id": barassociation,
        "law_firm_name": law_firm.text,
        "asso_member_no": assetsmemno.text,
        "qualification": qualification.text,
        "experience": expirianceinyear.text,
        "notary_no": notoryno.text,

      };

      ClsUpdateContactResponseModel userResponseModel =
          await updateprofessionaldetail(body: parameters);

      // Mounted is for disposing the calling of Api if User click back button
      if (!mounted) {
        return;
      }

      if (userResponseModel.status == 1) {
        ToastMessage().showmessage(userResponseModel.message);
        setState(() {});

        EasyLoading.dismiss();
        // Const.currentUser = userResponseModel.Data!;

        // APICALL_RegisterDevice(userResponseModel);
        // gotoHomePage();
        // await SharedPref.save(
        //     value: userResponseModel.toString(),
        //     prefKey: PrefKey.loginDetails);
      } else {
        EasyLoading.dismiss();
        ToastMessage().showmessage(userResponseModel.message);
      }
    } catch (exception) {
      EasyLoading.dismiss();

      ToastMessage().showmessage(exception.toString());
    }
  }
}
