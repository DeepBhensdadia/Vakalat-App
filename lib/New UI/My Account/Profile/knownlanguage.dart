import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:vakalat_flutter/color/customcolor.dart';
import 'package:vakalat_flutter/helper.dart';
import 'package:vakalat_flutter/model/Get_Profile.dart';
import 'package:vakalat_flutter/utils/ToastMessage.dart';
import 'package:vakalat_flutter/utils/design.dart';

import '../../../Sharedpref/shared_pref.dart';
import '../../../api/postapi.dart';
import '../../../model/clsLoginResponseModel.dart';
import '../../../pages/dashboard.dart';
import '../../../utils/constant.dart';
import 'getxcontroller.dart';

class KnownLanguage extends StatefulWidget {
  final GetProfileModel detail;
  const KnownLanguage({Key? key, required this.detail}) : super(key: key);

  @override
  State<KnownLanguage> createState() => _KnownLanguageState();
}

class _KnownLanguageState extends State<KnownLanguage> {
  ClsLoginResponseModel? logindetails = SharedPref.get(prefKey: PrefKey.loginDetails) != null? clsLoginResponseModelFromJson(
      SharedPref.get(prefKey: PrefKey.loginDetails)!):null;
  late ValueNotifierList<KnownLan> valueNotifier;

  @override
  void initState() {
    valueNotifier = ValueNotifierList(widget.detail.getKnownLanguage());
    super.initState();
  }
 var data = [];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 50,
          width: double.infinity,
          color: Colors.grey.shade300,
          child: Row(
            children: [
              Container(
                width: screenwidth(context, dividedby: 4),
                alignment: Alignment.center,
                child: Text(
                  'Language',
                  style: TextStyle(
                    fontSize: 16,
                    overflow: TextOverflow.ellipsis,
                    color: CustomColor().colorPrimary,
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Read',
                      style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          color: CustomColor().colorPrimary,
                          fontSize: 14),
                    ),
                    Text(
                      'Write',
                      style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          color: CustomColor().colorPrimary,
                          fontSize: 14),
                    ),
                    Text(
                      'Speak',
                      style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          color: CustomColor().colorPrimary,
                          fontSize: 14),
                    ),
                    Text(
                      ' Deal',
                      style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          color: CustomColor().colorPrimary,
                          fontSize: 14),
                    ),
                  ],
                ),
              ),
              Container(
                width: screenwidth(context, dividedby: 7.5),
                // color: Colors.red,
                alignment: Alignment.center,
                child: TextButton(
                    onPressed: () {
                      valueNotifier.add(KnownLan());
                    },
                    child: Icon(
                      Icons.add,
                      color: CustomColor().colorPrimary,
                    )),
              ),
            ],
          ),
        ),
        Expanded(
          child: ValueListenableBuilder(
            valueListenable: valueNotifier,
            builder: (context, value, child) => ListView(
              children: value
                  .map((e) => SingleLanguageTile(
                        knownLan: e,
                        onRemoved: () async {
                          Map<String, dynamic> parameters = {
                            "apiKey": apikey,
                            'device': '2',
                            "accessToken": logindetails!.accessToken,
                            "user_id": logindetails!.userData.userId,
                            "user_lang_id": e.id.toString()

                          };
                          EasyLoading.show(status: 'Loading...');
                          await Delete_languages(body: parameters).then((value) {
                         if(value.status != 0){
                           valueNotifier.remove(e);
                         }
                         ToastMessage().showmessage(value.message);
                            EasyLoading.dismiss();
                          }).onError((error, stackTrace) {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DashboardPage(title: ''),
                                ));
                            Const().deleteprofilelofinandmenu();
                            msgexpire;
                            print(error);
                            EasyLoading.dismiss();
                          });
                        },
                onselection: (p0) {
                  setState(() {
                    e.language = p0!;
                  });
                },
                initial: e.language,
                      ),
              )
                  .toList(),
            ),
          ),
        ),
        Button_For_Update_Save(
          text: 'Update',
          onpressed: () {
            for (var element in valueNotifier.value) {
              data.add(JsonEncoder.withIndent(" " * 4).convert(element.toJson()));
              debugPrint(
                  JsonEncoder.withIndent(" " * 4).convert(element.toJson()));
            }
            log(data.toString());
            // print(data);
            updatelanguage();
          },
        )
      ],
    );
  }
  updatelanguage() async {
    Map<String, dynamic> parameters = {
      "apiKey": apikey,
      'device': '2',
      "accessToken": logindetails!.accessToken,
      "user_id": logindetails!.userData.userId,
      "languagedata": data.toString()

    };
    EasyLoading.show(status: 'Loading...');
    await update_languages(body: parameters).then((value) {
      if(value.status != 0){
        setState(() {
          data.clear();
        });
      }
    ToastMessage().showmessage(value.message);
      EasyLoading.dismiss();
    }).onError((error, stackTrace) {
      log(error.toString());
      EasyLoading.dismiss();
    });
  }
}

class SingleLanguageTile extends StatelessWidget {
  const SingleLanguageTile(
      {Key? key, required this.knownLan, required this.onRemoved, required this.initial, required this.onselection})
      : super(key: key);

  final KnownLan knownLan;
  final String initial;
  final void Function() onRemoved;
  final void Function(String?) onselection;

  @override
  Widget build(BuildContext context) {
    final ProfileControl getXController = Get.put(ProfileControl());
    return SizedBox(
      // height: 50,
      width: double.infinity,
      child: Row(
        children: [
          Container(
            width: screenwidth(context, dividedby: 4),
            alignment: Alignment.center,
            child: Get_language_drop(
              languages: getXController.language.languages,
              onSelection: onselection,
              initialvalue: initial,
            ),

          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomCheckBox(
                  value: knownLan.read,
                  onChanged: (value) => knownLan.read = value,
                ),
                CustomCheckBox(
                  value: knownLan.write,
                  onChanged: (value) => knownLan.write = value,
                ),
                CustomCheckBox(
                  value: knownLan.speak,
                  onChanged: (value) => knownLan.speak = value,
                ),
                CustomCheckBox(
                  value: knownLan.canDeal,
                  onChanged: (value) => knownLan.canDeal = value,
                ),
              ],
            ),
          ),
          Container(
            width: screenwidth(context, dividedby: 7.5),
            alignment: Alignment.center,
            child: TextButton(
                onPressed: onRemoved,
                child: Icon(
                  Icons.delete,
                  color: CustomColor().colorPrimary,
                )),
          ),
        ],
      ),
    );
  }
}

class CustomCheckBox extends StatefulWidget {
  const CustomCheckBox({Key? key, required this.value, required this.onChanged})
      : super(key: key);

  final bool value;
  final void Function(bool value) onChanged;

  @override
  State<CustomCheckBox> createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  late bool value;

  @override
  void initState() {
    value = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: value,
      onChanged: (val) {
        setState(() {
          value = val!;
        });
        widget.onChanged(val!);
      },
    );
  }
}

class ValueNotifierList<T> extends ValueNotifier<List<T>> {
  ValueNotifierList(List<T> value) : super(value);

  void add(T valueToAdd) {
    value = [...value, valueToAdd];
  }

  void remove(T valueToRemove) {
    value = value.where((value) => value != valueToRemove).toList();
  }
}
