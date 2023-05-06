import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:vakalat_flutter/utils/design.dart';

import '../../../Sharedpref/shared_pref.dart';
import '../../../api/postapi.dart';
import '../../../model/clsLoginResponseModel.dart';
import '../../../utils/constant.dart';

class Change_Password extends StatefulWidget {
  const Change_Password({Key? key}) : super(key: key);

  @override
  State<Change_Password> createState() => _Change_PasswordState();
}

class _Change_PasswordState extends State<Change_Password> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController oldpassword = TextEditingController();
  TextEditingController newpassword = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();
  ClsLoginResponseModel logindetails = clsLoginResponseModelFromJson(
      SharedPref.get(prefKey: PrefKey.loginDetails)!);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            CustomTextfield(
              labelname: 'Old Password',
              Controller: oldpassword,
              validator: (p0) {
                if (p0!.isEmpty) {
                  return 'Please Enter Old Password';
                }
                return null;
              },
            ),
            CustomTextfield(
              labelname: 'New Password',
              Controller: newpassword,
              validator: (p0) {
                if (p0!.isEmpty) {
                  return 'Please Enter Password';
                }
                return null;
              },
            ),
            CustomTextfield(
              labelname: 'Confirm Password',
              Controller: confirmpassword,
              validator: (p0) {
                if (p0!.isEmpty) {
                  return 'Please Enter Password';
                } else if (p0 != newpassword.text) {
                  return "Password doesn't match";
                }
                return null;
              },
            ),
            Button_For_Update_Save(
              text: 'Update',
              onpressed: () {
                if (_formKey.currentState!.validate()) {
                  changePasswod.call();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> changePasswod() async {
    Map<String, dynamic> parameters = {
      "apiKey": apikey,
      'device': '2',
      "accessToken": logindetails.accessToken,
      "user_id": logindetails.userData.userId,
      "old_password": oldpassword.text,
      "new_password": newpassword.text,
      "confirm_password": confirmpassword.text
    };
    EasyLoading.show(status: 'loading...');
    await change_password(body: parameters).then((value) {
      EasyLoading.dismiss();
      oldpassword.clear();
      newpassword.clear();
      confirmpassword.clear();
      EasyLoading.showToast(value.message);
    }).onError((error, stackTrace) {
      print(error.toString());
      EasyLoading.dismiss();
    });
  }
}
