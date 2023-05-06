import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:vakalat_flutter/model/clsUserTypeResponseModel.dart';
import 'package:vakalat_flutter/New%20UI/login.dart';

import '../api/postapi.dart';
import '../color/customcolor.dart';
import '../helper.dart';
import '../model/clsCitiesResponseModel.dart';
import '../model/clsCountriesResponseModel.dart';
import '../model/clsRegisterResponseModel.dart';
import '../model/clsStateResponseModel.dart';
import '../utils/ToastMessage.dart';
import '../utils/constant.dart';
import '../utils/design.dart';

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
                  child: const Text('Sign up to get started',
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
                  padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10),
                  child:Container(
                    alignment: Alignment.centerLeft,
                    height: 50,
                    width: screenwidth(context, dividedby: 1),
                    decoration: Const().decorationfield,
                    child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text('Lawyer',style: TextStyle(fontSize: 16),)
                    ),
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
                        labelText: 'Mobile',

                        // labelStyle: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),
                        suffixIcon: Icon(Icons.call)),
                  ),
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
                            EasyLoading.show(status: 'loading...');

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
                )
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
  bool _isLoading = false;

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
  late String countriecode = '';
  late String rajyacode = '';
  late String citicode = '';
  @override
  void initState() {
    usernamecontroller = TextEditingController(text: widget.mobile);
    getcountries = widget.country;
    super.initState();
  }

  ValueNotifier<List<Rajya>> rajyaBuilder = ValueNotifier([]);
  ValueNotifier<List<City>> citiesBuilder = ValueNotifier([]);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                    child: const Text('Sign up to get started',
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
                  CustomTextfield(
                      labelname: 'User Name',
                      type: TextInputType.none,
                      validator: (p0) {
                        if (p0!.isEmpty) {
                          return 'Please Enter User name';
                        }
                        return null;
                      },
                      suffixicon: Icons.person_2_outlined,
                      Controller: usernamecontroller),
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
                          },
                          country: getcountries.countries,
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
                  Container(
                      height: 65,
                      width: screenwidth(context, dividedby: 1),
                      padding: const EdgeInsets.all(10),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: CustomColor().colorPrimary,
                              textStyle: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          onPressed: () {
                            APICALL_userRegister.call();
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
            EasyLoading.show(status: 'loading...');

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

              ClsRegisterResponseModel userResponseModel =
                  await userRegister(body: parameters);

              // Mounted is for disposing the calling of Api if User click back button
              if (!mounted) {
                return;
              }

              if (userResponseModel.status == 1) {
                ToastMessage()
                    .showmessage("Welcome ${userResponseModel.message}");

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
}
