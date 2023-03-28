import 'dart:convert';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:vakalat_flutter/color/customcolor.dart';
import 'package:vakalat_flutter/model/clsLoginResponseModel.dart';
import 'package:vakalat_flutter/pages/dashboard.dart';
import 'package:vakalat_flutter/pages/forgotpassword.dart';
import 'package:vakalat_flutter/New%20UI/register.dart';
import 'package:vakalat_flutter/utils/PageOrientation.dart';
import 'package:vakalat_flutter/utils/ToastMessage.dart';
import 'package:vakalat_flutter/utils/keyboardHiderMixin.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:vakalat_flutter/api/postapi.dart';

import '../Sharedpref/shared_pref.dart';
import '../utils/constant.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with KeyboardHiderMixin {
  final _loginFormKey = GlobalKey<FormState>();

  bool _isLoading = false;

  bool isUserSignedIn = false;
  final bool _isbuttonClicked = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FocusNode? edtEmail, edtPassword;
  String strEmail = '';
  String strPassword = '';

  bool _passwordVisible = false;

  @override
  void initState() {
    _passwordVisible = false;
    edtEmail = FocusNode();
    edtPassword = FocusNode();
    edtEmail!.unfocus();
    edtPassword!.unfocus();

    // Local
    emailController.text = "meghalshukla";
    passwordController.text = "test@1234";
    // emailController.text = "Deep_patel";
    // passwordController.text = "9328143230";

    // Production
    // emailController.text = "";
    // passwordController.text = "";
  }

  @override
  void dispose() {
    edtEmail!.dispose();
    edtPassword!.dispose();
    super.dispose();
  }

  void gotoHomePage() {
    // Navigator.pushReplacement(
    //   context,996
    //   PageTransition(
    //     type: PageTransitionType.rightToLeftWithFade,
    //     duration: const Duration(milliseconds: 300),
    //     child: const DashboardPage(title: 'Vakalat'),
    //   ),
    // );

    EasyLoading.showSuccess('Success!');

    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) =>
            const DashboardPage(title: 'Vakalat')));
  }

  void gotoForgotPasswordPage() {
    Navigator.push(
      context,
      PageTransition(
        type: PageTransitionType.rightToLeftWithFade,
        duration: const Duration(milliseconds: 300),
        child: const ForgotPasswordPage(title: "Forgot Password"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    PageOrientation().setOrientationPortrait();
    _loginFormKey.currentState?.validate();
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
           'Sign In',
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

              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Container(
                        margin: const EdgeInsets.only(top: 20.0),
                        height: 100.0,
                        width: 100.0,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/logo.png'),
                            fit: BoxFit.fitHeight,
                          ),
                          shape: BoxShape.rectangle,
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text('Sign In',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w900,
                                fontSize: 22),
                            textAlign: TextAlign.left),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        controller: emailController,
                        focusNode: edtEmail,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'username',
                          // labelStyle: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),

                        ),
                        onSaved: (newValue) {
                          setState(
                            () {
                              strEmail = newValue!.trim();
                            },
                          );
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter username / email';
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        obscureText: !_passwordVisible,
                        controller: passwordController,
                        focusNode: edtPassword,
                        onSaved: (newValue) {
                          setState(
                            () {
                              strPassword = newValue!.trim();
                            },
                          );
                        },
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: 'password',
                          // labelStyle: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),
                          suffixIcon: IconButton(
                            icon: Icon(
                              // Based on passwordVisible state choose the icon
                              _passwordVisible
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Theme.of(context).primaryColorDark,
                            ),
                            onPressed: () {
                              // Update the state i.e. toogle the state of passwordVisible variable
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            },
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter password';
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(5),
                      alignment: Alignment.centerRight,
                      child: TextButton(
                          style: TextButton.styleFrom(
                            foregroundColor: CustomColor().colorPrimary,
                          ),
                          onPressed: () {
                            gotoForgotPasswordPage();
                          },
                          child: const Text('Forgot Password?')),
                    ),
                  ],
                ),
              ),
              Container(
                  height: 65,
                  width: 150,
                  padding: const EdgeInsets.all(10),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: CustomColor().colorPrimary,
                          textStyle: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      onPressed: () {
                        // ignore: avoid_print
                        APICALL_userLogin.call();
                      },
                      child: const Text('Sign in'))),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't Have An Account? "),
                  TextButton(
                    onPressed: () async {
                      Map<String, dynamic> parameters = {
                        "apiKey":apikey,
                        'device': '2',
                      };
                      EasyLoading.show(status: 'loading...');
                      await get_user_type(body: parameters).then((value) {
                        EasyLoading.dismiss();
                        Navigator.push(context, MaterialPageRoute(builder: (context) =>  Register(
                          user_type:value,
                        ),));
                      }).onError((error, stackTrace) {
                        EasyLoading.dismiss();
                      });

                    },
                    child: const Text("Register"),
                  )
                ],
              )
            ],
          ),
        ));
  }

  // Future<void> validate() async {
  //   if (_loginFormKey.currentState!.validate()) {
  //     _loginFormKey.currentState!.save();
  //     setState(() {
  //       _isbuttonClicked = true;
  //     });
  //     if (strEmail == "") {
  //       edtEmail!.requestFocus();
  //     } else if (strPassword == "") {
  //       edtPassword!.requestFocus();
  //     } else if (strPassword.length < 8) {
  //       edtPassword!.requestFocus();
  //     } else {
  //       if (await InternetPanel().checkInternetconnection() == false) {
  //         return;
  //       } else if (await InternetPanel().checkInternetconnection() == true) {
  //         hideKeyboard();
  //         setState(
  //           () {
  //             _isLoading = true;
  //
  //             APICALL_userLogin();
  //           },
  //         );
  //       }
  //     }
  //   }
  // }

  /*Calling Login API goes here*/
  Future APICALL_userLogin() async {
    EasyLoading.show(status: 'loading...');

    try {
      /*Retriving Parent Object*/

      Map<String, dynamic> parameters = {
        "apiKey": '5Xf!-VQ*Zjad>@Q-}Bwb@w2/YrY#n',
        'device': '2',
        "user_name": emailController.text,
        "password": passwordController.text
      };

      ClsLoginResponseModel userResponseModel =
          await userLogin(body: parameters);

      // Mounted is for disposing the calling of Api if User click back button
      if (!mounted) {
        return;
      }

      if (userResponseModel.status == 1) {
        ToastMessage()
            .showmessage("Welcome ${userResponseModel.userData.userFname}");

        // Const.currentUser = userResponseModel.Data!;

        // APICALL_RegisterDevice(userResponseModel);

        await SharedPref.save(
            value: jsonEncode(userResponseModel.toJson()),
            prefKey: PrefKey.loginDetails);

        // ClsLoginResponseModel logindetails = clsLoginResponseModelFromJson(SharedPref.get(prefKey: PrefKey.loginDetails)!);
        Map<String, dynamic> parameters = {
          "apiKey": apikey,
          'device': '2',
          "user_id":userResponseModel.userData.userId
        };
        EasyLoading.show(status: 'loading...');
        await get_profile(body: parameters).then((value) async {
          await SharedPref.save(
              value: jsonEncode(value.toJson()),
              prefKey: PrefKey.get_profile);
          setState(() {

            print(jsonEncode(value));
            gotoHomePage();
          });
          EasyLoading.dismiss();
        }).onError((error, stackTrace) {
          print(error);
          EasyLoading.dismiss();
        });
      } else {
        setState(() {
          _isLoading = false;
        });
EasyLoading.dismiss();
        ToastMessage().showmessage(userResponseModel.message);
      }
    } catch (exception) {
      setState(
        () {
          _isLoading = false;
        },
      );
      EasyLoading.dismiss();

      ToastMessage().showmessage('Enter valid Username and Password!');
    }
  }
}
