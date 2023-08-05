import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vakalat_flutter/model/clsUserTypeResponseModel.dart';
import 'package:vakalat_flutter/New%20UI/login.dart';

import '../Sharedpref/shared_pref.dart';
import '../api/postapi.dart';
import '../color/customcolor.dart';
import '../helper.dart';
import '../model/GetHandlerList.dart';
import '../model/clsCitiesResponseModel.dart';
import '../model/clsCountriesResponseModel.dart';
import '../model/clsLoginResponseModel.dart';
import '../model/clsRegisterResponseModel.dart';
import '../model/clsStateResponseModel.dart';
import '../pages/dashboard.dart';
import '../pages/privacypolicypage.dart';
import '../utils/ToastMessage.dart';
import '../utils/constant.dart';
import '../utils/design.dart';
import 'handler_search/Cart.dart';

class Register extends StatefulWidget {
  // final ClsUserTypeResponseModel user_type;

  // const Register({super.key, required this.user_type});
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController fnamecontroller = TextEditingController();
  TextEditingController lnamecontroller = TextEditingController();
  TextEditingController mobilecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  String dropdownValue = '';
  final RegExp _emailRegExp = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Register',
          style: TextStyle(
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        backgroundColor: CustomColor().colorPrimary,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                    // margin: const EdgeInsets.only(top: 20.0),
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
                Container(
                  alignment: Alignment.center,
                  child: const Text('Register',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w900,
                          fontSize: 22),
                      textAlign: TextAlign.left),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  alignment: Alignment.center,
                  child: const Text('Registration to get started',
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w600,
                          fontSize: 14),
                      textAlign: TextAlign.left),
                ),
                const SizedBox(
                  height: 10,
                ),
                const next_page_ui(),
                const SizedBox(
                  height: 10,
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    height: 50,
                    width: screenwidth(context, dividedby: 1),
                    decoration: Const().decorationfield,
                    child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          'Lawyer',
                          style: TextStyle(fontSize: 16),
                        )),
                  ),
                  // CustomDropDownUser_Type(
                  //     onSelection: (p0) {
                  //       dropdownValue = p0.toString();
                  //     },
                  //     user_type: widget.user_type.userType),
                ),
                // CustomTextfield(
                //     Controller: usertypecontroller,
                //     labelname: 'User Type',
                //     suffixicon: Icons.expand_more),
                CustomTextfield(
                    Controller: fnamecontroller,
                    labelname: 'First Name',
                    validator: (p0) {
                      if (p0!.isEmpty) {
                        return 'Please Enter First Name';
                      }
                      return null;
                    },
                    suffixicon: Icons.person_2_outlined),
                CustomTextfield(
                    Controller: lnamecontroller,
                    labelname: 'Last Name',
                    validator: (p0) {
                      if (p0!.isEmpty) {
                        return 'Please Enter Last Name';
                      }
                      return null;
                    },
                    suffixicon: Icons.person_2_outlined),
                // CustomTextfield(
                //     Controller: mobilecontroller,
                //     labelname: ,
                //     suffixicon:),
                SizedBox(
                  height: 5,
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        "Mobile / Username",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Container(
                      height: 85,
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        maxLength: 10,
                        // buildCounter: ,
                        controller: mobilecontroller,
                        validator: (p0) {
                          if (p0!.isEmpty || p0.length != 10) {
                            return 'Please Enter Contact No';
                          }
                          return null;
                        },
                        // focusNode: edtEmail,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            // labelText: 'Mobile/Username',

                            // labelStyle: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),
                            suffixIcon: Icon(Icons.call)),
                      ),
                    ),
                  ],
                ),
                CustomTextfield(
                    Controller: emailcontroller,
                    labelname: 'Email',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your email address';
                      } else if (!_emailRegExp.hasMatch(value)) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                    suffixicon: Icons.email),
                const SizedBox(
                  height: 10,
                ),
                Container(
                    height: 65,
                    width: screenwidth(context, dividedby: 1),
                    padding: const EdgeInsets.all(10),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: CustomColor().colorPrimary,
                            textStyle: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            Map<String, dynamic> parameters = {
                              "apiKey": apikey,
                              'device': '2',
                            };
                            EasyLoading.show(status: 'Loading...');

                            await userCountries(body: parameters).then((value) {
                              EasyLoading.dismiss();

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Register_Now(
                                      country: value,
                                      usertype: '8',
                                      fname: fnamecontroller.text,
                                      lname: lnamecontroller.text,
                                      mobile: mobilecontroller.text,
                                      email: emailcontroller.text,
                                    ),
                                  ));
                            }).onError((error, stackTrace) {
                              EasyLoading.dismiss();
                            });
                          }
                        },
                        child: const Text('Next'))),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already Member? "),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginPage(title: ''),
                            ));
                      },
                      child: const Text("Login"),
                    )
                  ],
                ),
                Container(
                    // height: 65,
                    width: screenwidth(context, dividedby: 1),
                    padding: const EdgeInsets.all(10),
                    child: ElevatedButton(

                        style: ElevatedButton.styleFrom(
                            backgroundColor: CustomColor().colorPrimary,
                            textStyle:
                            TextStyle(fontSize: screenwidth(context, dividedby: 25), fontWeight: FontWeight.bold)),
                        onPressed:() {
                          launch("https://vakalathouse.com");
                        },
                        child: Text( "Please visit VakalatHouse.com also!!")))

              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Register_Now extends StatefulWidget {
  final String usertype;
  final String fname;
  final String lname;
  final String mobile;
  final String email;
  final ClsCountriesResponseModel country;

  const Register_Now(
      {super.key,
      required this.usertype,
      required this.fname,
      required this.lname,
      required this.country,
      required this.mobile,
      required this.email});

  @override
  State<Register_Now> createState() => _Register_NowState();
}

class _Register_NowState extends State<Register_Now> {
  bool _passwordVisible = false;
  bool _cpasswordVisible = false;
  TextEditingController confirmpasswordController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController usernamecontroller = TextEditingController();

  void gotologinPage() {
    EasyLoading.showSuccess('Success!');

    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) => const LoginPage(title: 'Vakalat')));
  }

  late ClsCountriesResponseModel getcountries;
  late String countriecode = '101';
  late String rajyacode = '';
  late String citicode = '';
  @override
  void initState() {
    usernamecontroller = TextEditingController(text: widget.mobile);
    getcountries = widget.country;
    statapi(value: '101');
    super.initState();
  }

  bool value = false;
  ValueNotifier<List<Rajya>> rajyaBuilder = ValueNotifier([]);
  ValueNotifier<List<City>> citiesBuilder = ValueNotifier([]);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  statapi({String? value = ''}) async {
    EasyLoading.show(status: "Loading...");
    Map<String, dynamic> parameters = {
      "apiKey": apikey,
      'device': '2',
      "country_id": value.toString(),
    };
    await userStates(body: parameters).then((value) {
      EasyLoading.dismiss();
      rajyaBuilder.value = value.states;
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                      margin: const EdgeInsets.only(top: 10.0),
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
                  Container(
                    alignment: Alignment.center,
                    child: const Text('Register',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w900,
                            fontSize: 22),
                        textAlign: TextAlign.left),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: const Text('Registration to get started',
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w600,
                            fontSize: 14),
                        textAlign: TextAlign.left),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Register_now_ui(),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 45,
                      width: screenwidth(context, dividedby: 1),
                      decoration: Const().decorationfield,
                      child: Center(
                        child: Text(
                          "UserNumber : ${usernamecontroller.text}",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  // CustomTextfield(
                  //     labelname: 'User Name',
                  //     type: TextInputType.none,
                  //     validator: (p0) {
                  //       if (p0!.isEmpty) {
                  //         return 'Please Enter User name';
                  //       }
                  //       return null;
                  //     },
                  //     suffixicon: Icons.person_2_outlined,
                  //     Controller: usernamecontroller),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      obscureText: !_passwordVisible,
                      controller: passwordController,
                      // // focusNode: edtPassword,
                      // onSaved: (newValue) {
                      //   setState(
                      //         () {
                      //       strPassword = newValue!.trim();
                      //     },
                      //   );
                      // },
                      validator: (p0) {
                        if (p0!.isEmpty) {
                          return 'Please Enter Password';
                        }
                        return null;
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
                            // Update the state i.e. toogle the state of passwordVisible variable
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                        ),
                      ),
                      // validator: (value) {
                      //   if (value == null || value.isEmpty) {
                      //     return 'Please enter password';
                      //   }
                      //   return null;
                      // },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      obscureText: !_cpasswordVisible,
                      controller: confirmpasswordController,
                      validator: (p0) {
                        if (p0!.isEmpty) {
                          return 'Please Enter Password';
                        } else if (p0 != passwordController.text) {
                          return 'Password Does Not Match';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: 'Confirm password',
                        // labelStyle: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),
                        suffixIcon: IconButton(
                          icon: Icon(
                            // Based on passwordVisible state choose the icon
                            _cpasswordVisible
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Theme.of(context).primaryColorDark,
                          ),
                          onPressed: () {
                            // Update the state i.e. toogle the state of passwordVisible variable
                            setState(() {
                              _cpasswordVisible = !_cpasswordVisible;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 10),
                    child: Column(
                      children: [
                        CustomDropDownCountry(
                          onSelection: (var value) async {
                            countriecode = value.toString();
                            rajyaBuilder.value = [];
                            citiesBuilder.value = [];
                            statapi(value: value);
                          },
                          country: getcountries.countries,
                          initialValue: '101',
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ValueListenableBuilder(
                            valueListenable: rajyaBuilder,
                            builder: (context, value, child) =>
                                CustomDropDownState(
                                  raja: value,
                                  onSelection: (p0) async {
                                    rajyacode = p0.toString();
                                    citiesBuilder.value = [];

                                    EasyLoading.show(status: "Loading...");
                                    Map<String, dynamic> parameters = {
                                      "apiKey": apikey,
                                      'device': '2',
                                      "state_id": p0.toString(),
                                    };
                                    await userCities(body: parameters)
                                        .then((value) {
                                      EasyLoading.dismiss();
                                      citiesBuilder.value = value.cities;
                                    }).onError((error, stackTrace) {
                                      EasyLoading.dismiss();
                                    });
                                  },
                                )),
                        const SizedBox(
                          height: 20,
                        ),
                        ValueListenableBuilder(
                            valueListenable: citiesBuilder,
                            builder: (context, value, child) =>
                                CustomDropCities(
                                  citi: value,
                                  onSelection: (p0) {
                                    citicode = p0.toString();
                                  },
                                )),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: value,
                        onChanged: (val) {
                          setState(() {
                            value = val!;
                          });
                        },
                      ),
                      Text(
                        'I accept the',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                      TextButton(
                          onPressed: () {
                            launch('https://www.vakalat.com/privacy-policy');
                            // Navigator.push(context, MaterialPageRoute(builder: (context) => PrivacyPolicyPage(title: ''),));
                          },
                          child: Text(
                            'Terms and conditions',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w600),
                          ))
                    ],
                  ),
                  Container(
                      height: 65,
                      width: screenwidth(context, dividedby: 1),
                      padding: const EdgeInsets.all(10),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                              value == true
                                  ? CustomColor().colorPrimary
                                  : CustomColor().colorPrimary.withOpacity(0.4),
                              textStyle: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          onPressed: () {
                            if (value == true) {
                              APICALL_userRegister.call();

                            }
                          },
                          child: const Text('Register Now'))),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already Member? "),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const LoginPage(title: ''),
                              ));
                        },
                        child: const Text("Login"),
                      )
                    ],
                  ),
                  Button_For_Update_Save(
                    text: "Please visit VakalatHouse.com also!!",
                    onpressed: () {
                      launch("https://vakalathouse.com");
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future APICALL_userRegister() async {
    if (_formKey.currentState!.validate()) {
      if (countriecode.isNotEmpty) {
        if (rajyacode.isNotEmpty) {
          if (citicode.isNotEmpty) {
            EasyLoading.show(status: 'Loading...');

            try {
              /*Retriving Parent Object*/
              Map<String, dynamic> parameters = {
                "apiKey": '5Xf!-VQ*Zjad>@Q-}Bwb@w2/YrY#n',
                'device': '2',
                "user_type": widget.usertype,
                "first_name": widget.fname,
                "last_name": widget.lname,
                "mobile": widget.mobile,
                "email": widget.email,
                "user_name": usernamecontroller.text,
                "password": confirmpasswordController.text,
                "country": countriecode.toString(),
                "state": rajyacode.toString(),
                "city": citicode.toString(),
              };

              ClsLoginResponseModel userResponseModel =
                  await userRegister(body: parameters);

              if (userResponseModel.status == 1) {
                ToastMessage().showmessage("Registration Successfully!");
                await SharedPref.save(
                    value: jsonEncode(userResponseModel.toJson()),
                    prefKey: PrefKey.loginDetails);
                Map<String, dynamic> parameters = {
                  "apiKey": apikey,
                  'device': '2',
                  'accessToken': userResponseModel.accessToken,
                  'csrf_token': '',
                  'user_id': userResponseModel.userData.userId,
                  'user_type': userResponseModel.userData.userType,
                  'current_pkg_id': "0",
                  "customname": userResponseModel.userData.userFname +
                      userResponseModel.userData.userLname
                };

                await getalldashboard(body: parameters).then((value) async {
                  await SharedPref.save(
                      value: jsonEncode(value.data.getprofile.toJson()),
                      prefKey: PrefKey.getProfile);

                  await SharedPref.save(
                      value: jsonEncode(value.data.getAppMenu.toJson()),
                      prefKey: PrefKey.getMenu);

                  Get.offAll(
                    Cart_Screen(
                        name: value.data.handlers.customhandler.first.name,
                        packages: value.data.getUserWisePkg),
                  );
                  EasyLoading.dismiss();
                  Map<String, dynamic> parameters = {
                    "apiKey": apikey,
                    'device': '2',
                    "accessToken": userResponseModel.accessToken,
                    "csrf_token": "",
                    "user_id": userResponseModel.userData.userId,
                  };
                  await getsendmail(body: parameters);
                }).onError((error, stackTrace) {
                  print("...$error");
                });

                // Map<String, dynamic> parameters = {
                //   "apiKey": apikey,
                //   'device': '2',
                //   "user_id": userResponseModel.userData.userId
                // };
                // await get_profile(body: parameters).then((value) async {
                //   await SharedPref.save(
                //       value: jsonEncode(value.toJson()), prefKey: PrefKey.getProfile);
                //
                //   Map<String, dynamic> parameters = {
                //     "apiKey": apikey,
                //     'device': '2',
                //     'accessToken': userResponseModel.accessToken,
                //     'csrf_token': '',
                //     'user_id': userResponseModel.userData.userId,
                //     'user_type': userResponseModel.userData.userType,
                //     'current_pkg_id': value.profile.currentPkgId,
                //   };
                //
                //   await getdrawermenu(body: parameters).then((value) async {
                //     log(jsonEncode(value));
                //     await SharedPref.save(
                //         value: jsonEncode(value.toJson()), prefKey: PrefKey.getMenu);
                //
                //     Map<String, dynamic> parameters = {
                //       "apiKey": apikey,
                //       'device': '2',
                //       "city_id": userResponseModel.userData.userCity,
                //       "first_name": userResponseModel.userData.userFname,
                //       "last_name": userResponseModel.userData.userLname,
                //       "customname": userResponseModel.userData.userFname +
                //           userResponseModel.userData.userLname
                //     };
                //
                //     await get_handler_list(body: parameters).then((value) async {
                //       GetHandlerList list = value;
                //       Map<String, dynamic> parameters = {
                //         "apiKey": apikey,
                //         'device': '2',
                //         "user_type_id": userResponseModel.userData.userType,
                //       };
                //       await GetUserpackages(body: parameters).then((value) async {
                //         if (value.packages.isNotEmpty) {
                //           Navigator.push(
                //               context,
                //               CupertinoPageRoute(
                //                 builder: (context) => Cart_Screen(
                //                     name: list.customhandler.first.name, packages: value),
                //               ));
                //
                //           EasyLoading.dismiss();
                //         } else {
                //           ToastMessage().showmessage('Do Not Have Any Packages');
                //         }
                //
                //
                //         log(jsonEncode(value));
                //         Map<String, dynamic> parameters = {
                //           "apiKey": apikey,
                //           'device': '2',
                //           "accessToken": userResponseModel.accessToken,
                //           "csrf_token": "",
                //           "user_id": userResponseModel.userData.userId,
                //         };
                //         await getsendmail(body: parameters);
                //       }).onError((error, stackTrace) {
                //         print(error);
                //
                //         EasyLoading.dismiss();
                //       });
                //
                //       EasyLoading.dismiss();
                //     }).onError((error, stackTrace) {
                //       print(error);
                //       EasyLoading.dismiss();
                //     });
                //
                //   }).onError((error, stackTrace) {
                //     // ToastMessage().showmessage(error.toString());
                //     print(error);
                //     print(stackTrace);
                //     EasyLoading.dismiss();
                //   });
                // }).onError((error, stackTrace) {
                //   print(error);
                //
                //   EasyLoading.dismiss();
                // });
              } else {
                EasyLoading.dismiss();
                ToastMessage()
                    .showmessage(userResponseModel.message.toString());
              }
            } catch (exception) {
              EasyLoading.dismiss();
              ToastMessage().showmessage(
                  "Entered Username or Email is taken by other user please enter new one and unique!");
            }
          } else {
            EasyLoading.dismiss();
            ToastMessage().showmessage('Please Select City');
          }
        } else {
          ToastMessage().showmessage('Please Select State');
        }
      } else {
        ToastMessage().showmessage('Please Select Country');
      }
    }
  }

  Future APICALL_userLogin(userResponseModel) async {
    EasyLoading.show(status: 'Loading...');
    await SharedPref.deleteSpecific(prefKey: PrefKey.username);
    await SharedPref.deleteSpecific(prefKey: PrefKey.password);
    // try {
    /*Retriving Parent Object*/

    // Map<String, dynamic> parameters = {
    //   "apiKey": '5Xf!-VQ*Zjad>@Q-}Bwb@w2/YrY#n',
    //   'device': '2',
    //   "user_name": usernamecontroller.text,
    //   "password": confirmpasswordController.text
    // };

    // ClsLoginResponseModel userResponseModel =
    //     await userLogin(body: parameters);

    // Mounted is for disposing the calling of Api if User click back button
    // if (!mounted) {
    //   return;
    // }

    // if (userResponseModel.status == 1) {
    //   ToastMessage()
    //       .showmessage("Welcome ${userResponseModel.userData.userFname}");

    // Const.currentUser = userResponseModel.Data!;

    // APICALL_RegisterDevice(userResponseModel);

    // } else {
    //   EasyLoading.dismiss();
    //   ToastMessage().showmessage(userResponseModel.message);
    // }
    // } catch (exception) {
    //   EasyLoading.dismiss();
    //   // ToastMessage().showmessage('Enter valid Username and Password!');
    // }
  }
}
