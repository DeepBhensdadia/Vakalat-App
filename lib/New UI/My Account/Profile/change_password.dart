import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vakalat_flutter/utils/design.dart';


class Change_Password extends StatefulWidget {
  const Change_Password({Key? key}) : super(key: key);

  @override
  State<Change_Password> createState() => _Change_PasswordState();
}

class _Change_PasswordState extends State<Change_Password> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
TextEditingController oldpassword =TextEditingController();
TextEditingController newpassword =TextEditingController();
TextEditingController confirmpassword =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            CustomTextfield(labelname: 'Old Password',Controller: oldpassword,validator: (p0) {
              if(p0!.isEmpty){
                return 'PLz Fill Old Password';
              }
              return null;
            },),
            CustomTextfield(labelname: 'New Password',Controller: newpassword,validator: (p0) {
              if(p0!.isEmpty){
                return 'PLz Enter Password';
              }
              return null;
            },),
            CustomTextfield(labelname: 'Confirm Password',Controller: confirmpassword,validator: (p0) {
              if(p0!.isEmpty){
                return 'PLz Enter Password';
              }else if(p0 != confirmpassword){
                return 'PLz Password does not match';

              }
              return null;
            },),

            Button_For_Update_Save(text: 'Update', onpressed: () { if(_formKey.currentState!.validate()){} },),

          ],
        ),
      ),
    );
  }
}
