import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:vakalat_flutter/color/customcolor.dart';
import 'package:vakalat_flutter/New%20UI/login.dart';
import 'package:vakalat_flutter/utils/PageOrientation.dart';
import 'package:vakalat_flutter/utils/ToastMessage.dart';
import 'package:vakalat_flutter/utils/keyboardHiderMixin.dart';
import 'package:flutter/material.dart';
import 'package:vakalat_flutter/api/postapi.dart';

import '../model/clsForgotPasswordResponseModel.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage>
    with KeyboardHiderMixin {
  final _loginFormKey = GlobalKey<FormState>();

  bool _isLoading = false;

  final bool _isbuttonClicked = false;

  TextEditingController PhoneController = TextEditingController();
  FocusNode? edtEmail;
  String strEmail = '';

  @override
  void initState() {
    edtEmail = FocusNode();
    edtEmail!.unfocus();

    // Local
    // emailController.text = "test@gmail.com";
  }

  @override
  void dispose() {
    edtEmail!.dispose();

    super.dispose();
  }

  void gotologinPage() {
    // Navigator.pushReplacement(
    //   context,
    //   PageTransition(
    //     type: PageTransitionType.rightToLeftWithFade,
    //     duration: const Duration(milliseconds: 300),
    //     child: const DashboardPage(title: 'Vakalat'),
    //   ),
    // );
    // EasyLoading.showSuccess('Success!');

    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) =>
            const LoginPage(title: '')));
  }

  @override
  Widget build(BuildContext context) {
    PageOrientation().setOrientationPortrait();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          widget.title,
          style: const TextStyle(
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        backgroundColor: CustomColor().colorPrimary,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: _loginFormKey,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),

                  child: TextFormField(
                    validator: (value) {
                      if(value!.isEmpty){
                        return 'Please Enter Mobile Number';
                      }
                      return null;
                    },
                    maxLength: 10,
                    keyboardType: TextInputType.phone,
                    controller: PhoneController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Phone Number',
                    ),
                  ),
                ),
                Container(
                    height: 75,
                    padding: const EdgeInsets.all(10),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: CustomColor().colorPrimary,
                            textStyle: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        onPressed: () {
                          if(_loginFormKey.currentState!.validate()){
                          APICALL_userForgotPassword.call();}
                        },
                        child: const Text('Submit'))),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Future APICALL_userForgotPassword() async {
    EasyLoading.show(status: 'loading...');

    try {
      /*Retriving Parent Object*/

      Map<String, dynamic> parameters = {
        "apiKey": '5Xf!-VQ*Zjad>@Q-}Bwb@w2/YrY#n',
        'device': '2',
       "mobile": PhoneController.text
      };

      ClsForgotPasswordResponseModel userResponseModel =
      await userForgotPassword(body: parameters);

      // Mounted is for disposing the calling of Api if User click back button
      if (!mounted) {
        return;
      }

      if (userResponseModel.status == 1) {
        EasyLoading.showToast(userResponseModel.message);
        // Const.currentUser = userResponseModel.Data!;

        // APICALL_RegisterDevice(userResponseModel);
        gotologinPage();
        // await SharedPref.save(
        //     value: userResponseModel.userData.userFname.toString(),
        //     prefKey: PrefKey.loginDetails);
      } else {
        setState(() {
          _isLoading = false;
        });

        ToastMessage().showmessage(userResponseModel.message);
      }
    } catch (exception) {
      setState(
            () {
          _isLoading = false;
        },
      );

      ToastMessage().showmessage(exception.toString());
    }
  }
}
