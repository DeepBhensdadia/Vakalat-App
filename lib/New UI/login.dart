import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vakalat_flutter/color/customcolor.dart';
import 'package:vakalat_flutter/helper.dart';
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
import '../utils/design.dart';
import 'Dashboard_screens/Dashboard_Screen.dart';

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

  bool isUserSignedIn = true;
  final bool _isbuttonClicked = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FocusNode? edtEmail, edtPassword;
  String strEmail = '';
  String strPassword = '';

  bool _passwordVisible = false;
  String? username = SharedPref.get(prefKey: PrefKey.username) ?? "";
  String? password = SharedPref.get(prefKey: PrefKey.password) ?? "";
  @override
  void initState() {
    _passwordVisible = false;
    edtEmail = FocusNode();
    edtPassword = FocusNode();
    edtEmail!.unfocus();
    edtPassword!.unfocus();
   remember = SharedPref.get(prefKey: PrefKey.passbool) == "true" ?  true : false;
    // Local
    emailController.text = username ?? "";
    passwordController.text = password ?? "";
    // emailController.text = "9265376681";
    // passwordController.text = "123456";
    // emailController.text = "Deep_patel";
    // passwordController.text ="123456";

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

  bool remember = true;
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
          child: Form(
            key: _loginFormKey,
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
                            labelText: 'Username',
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
                              return 'Please Enter username';
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
                            labelText: 'Password',
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
                      Row(
                        children: [
                          Checkbox(
                            value: remember,
                            onChanged: (value) {
                              setState(() {
                                remember = !remember;
                                SharedPref.save(value: remember.toString(), prefKey: PrefKey.passbool);
                              });
                            },
                          ),
                          Text(
                            'Remember Me ?',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.all(5),
                        alignment: Alignment.centerRight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                                style: TextButton.styleFrom(
                                  foregroundColor: CustomColor().colorPrimary,
                                ),
                                onPressed: () {
                                  Get.off(DashboardPage(title: ""));
                                },
                                child: const Text('Go to Home')),
                            TextButton(
                                style: TextButton.styleFrom(
                                  foregroundColor: CustomColor().colorPrimary,
                                ),
                                onPressed: () {
                                  gotoForgotPasswordPage();
                                },
                                child: const Text('Forgot Password?')),
                          ],
                        ),
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
                          if (_loginFormKey.currentState!.validate()) {
                            APICALL_userLogin.call();
                          }
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Register(),
                            ));
                        // Map<String, dynamic> parameters = {
                        //   "apiKey": apikey,
                        //   'device': '2',
                        // };
                        // EasyLoading.show(status: 'loading...');
                        // await get_user_type(body: parameters).then((value) {
                        //   EasyLoading.dismiss();
                        //   Navigator.push(
                        //       context,
                        //       MaterialPageRoute(
                        //         builder: (context) => Register(
                        //           user_type: value,
                        //         ),
                        //       ));
                        // }).onError((error, stackTrace) {
                        //   EasyLoading.dismiss();
                        // });
                      },
                      child: const Text("Register"),
                    )
                  ],
                ),
                SizedBox(
                  height: screenheight(context, dividedby: 25),
                ),
                Button_For_Update_Save(
                  text: "Please visit vakalatHouse.com also!!",
                  onpressed: () {
                    launch("https://vakalathouse.com");
                  },
                )
              ],
            ),
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
    await SharedPref.deleteSpecific(prefKey: PrefKey.username);
    await SharedPref.deleteSpecific(prefKey: PrefKey.password);
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
        if (remember == true) {
          await SharedPref.save(
              value: emailController.text, prefKey: PrefKey.username);
          await SharedPref.save(
              value: passwordController.text, prefKey: PrefKey.password);
        }

        Map<String, dynamic> parameters = {
          "apiKey": apikey,
          'device': '2',
          'accessToken': userResponseModel.accessToken,
          'csrf_token': '',
          'user_id': userResponseModel.userData.userId,
          'user_type': userResponseModel.userData.userType,
          'current_pkg_id': userResponseModel.userData.currentPkgId,
        };
        EasyLoading.show(status: 'loading...');
        await getdrawermenu(body: parameters).then((value) async {
          await SharedPref.save(
              value: jsonEncode(value.toJson()), prefKey: PrefKey.getMenu);

          EasyLoading.dismiss();
        }).onError((error, stackTrace) {
          ToastMessage().showmessage(error.toString());
          print(error);
          print(stackTrace);
          EasyLoading.dismiss();
        });
        userResponseModel.userData.currentPkgId == "0"
            ? Get.off(() => DashboardPage(title: ""))
            : getdashboard(userResponseModel);
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

  getdashboard(logindetails) async {
    Map<String, dynamic> parameters = {
      "apiKey": apikey,
      'device': '2',
      "accessToken": logindetails.accessToken,
      "user_id": logindetails.userData.userId,
      "csrf_token": ""
    };
    EasyLoading.show(status: 'loading...');
    await get_Deshboard(body: parameters).then((value) {
      EasyLoading.dismiss();

      log(value.toString());
      Navigator.pushReplacement(
          context,
          CupertinoPageRoute(
            builder: (context) => DashBoard_Screen(data: value),
          ));
    }).onError((error, stackTrace) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const DashboardPage(title: ''),
          ));
      msgexpire;
      Const().deleteprofilelofinandmenu();
      print(error);
      // ToastMessage().showmessage(error.toString());
      EasyLoading.dismiss();
    });
  }
}
