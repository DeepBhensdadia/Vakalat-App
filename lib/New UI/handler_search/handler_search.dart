import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../Sharedpref/shared_pref.dart';
import '../../api/postapi.dart';
import '../../color/customcolor.dart';
import '../../model/Get_Profile.dart';
import '../../model/clsCitiesResponseModel.dart';
import '../../model/clsLoginResponseModel.dart';
import '../../utils/constant.dart';
import '../../utils/design.dart';
import 'Handler_serach_list.dart';

class Handler_Search extends StatefulWidget {
  const Handler_Search({Key? key}) : super(key: key);

  @override
  State<Handler_Search> createState() => _Handler_SearchState();
}

class _Handler_SearchState extends State<Handler_Search> {
  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  ValueNotifier<List<City>> citiesBuilder = ValueNotifier([]);
  String citicode_home = '';
  ClsLoginResponseModel logindetails = clsLoginResponseModelFromJson(
      SharedPref.get(prefKey: PrefKey.loginDetails)!);
  GetProfileModel getprofile = getProfileModelFromJson(SharedPref.get(prefKey: PrefKey.get_profile)!);
  @override
  void initState() {
    // TODO: implement initState
    getcities();
    super.initState();
  }
  Future<void> getcities() async {

    EasyLoading.show(status: "Loading...");
    Map<String, dynamic> parameters = {
      "apiKey": apikey,
      'device': '2',
      "state_id": getprofile.profile.stateId,
    };
    await userCities(body: parameters)
        .then((value) {
      EasyLoading.dismiss();
      citiesBuilder.value = value.cities;
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Handler Search',
          style: TextStyle(
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        backgroundColor: CustomColor().colorPrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // SizedBox(height: 100,),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomTextfield(
                        labelname: 'Enter First Name',
                        Controller: firstname,
                        validator: (p0) {
                          if (p0!.isEmpty) {
                            return 'Enter First Name';
                          }
                          return null;
                        },
                      ),
                      CustomTextfield(
                          labelname: 'Enter last Name', Controller: lastname,  validator: (p0) {
                        if (p0!.isEmpty) {
                          return 'Enter last Name';
                        }
                        return null;
                      },),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: ValueListenableBuilder(
                          valueListenable: citiesBuilder,
                          builder: (context, value, child) => value.isNotEmpty
                              ? CustomDropCities(
                            citi: value,
                            onSelection: (p0) {
                              citicode_home = p0.toString();
                            },
                          )
                              : const SizedBox.shrink(),
                        ),
                      ),
                      // CustomTextfield(
                      //     labelname: 'Enter Your City',
                      //     suffixicon: Icons.expand_more),
                      CustomTextfield(
                          labelname: 'Enter Categories(Max-3)',
                          suffixicon: Icons.expand_more),
                      Button_For_Update_Save(
                        text: 'SEARCH',
                        onpressed: () {
                          Navigator.push(context,MaterialPageRoute(builder: (context) => const Handler_Serach_list(),));
                          // if(_formKey.currentState!.validate()){}
                        },
                      )
                    ],
                  )),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  'Handler Search',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  children: [
                    EasyRichText(
                      "In this world of growing online presence on various platforms where name and brand matters, we at VAKALAT.com are imperatively telling you to book your online presence NOW.",
                      defaultStyle:
                          const TextStyle(color: Colors.black, fontSize: 12),
                      patternList: [
                        EasyRichTextPattern(
                          targetString: 'VAKALAT.com',
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 12),
                        ),
                        EasyRichTextPattern(
                          targetString: 'NOW',
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 12),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    EasyRichText(
                      "Yes, you can have your desired name with VAKALAT.com for people to find your online presence on professional front other than Social Media which we call it your HANDLER.",
                      defaultStyle:
                          const TextStyle(color: Colors.black, fontSize: 12),
                      patternList: [
                        EasyRichTextPattern(
                          targetString: 'VAKALAT.com',
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 12),
                        ),
                        EasyRichTextPattern(
                          targetString: 'HANDLER',
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 12),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'The sooner you book the better chances of availability for your desired Name.',
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    EasyRichText(
                      "Let your professional-self grow by booking your HANDLER and presenting yourself to people at large in the world of Law.",
                      defaultStyle:
                          const TextStyle(color: Colors.black, fontSize: 12),
                      patternList: [
                        EasyRichTextPattern(
                          targetString: 'HANDLER',
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 12),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Being a Lawyer or a Law firm gives you this access to have your own professional online presence for the citizens to know you and the law better.',
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
