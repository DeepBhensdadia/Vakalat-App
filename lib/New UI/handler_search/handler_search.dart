import 'dart:convert';

import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:vakalat_flutter/helper.dart';

import '../../Sharedpref/shared_pref.dart';
import '../../api/postapi.dart';
import '../../color/customcolor.dart';
import '../../model/GetAllCategory.dart';
import '../../model/GetHandlerList.dart';
import '../../model/Get_Profile.dart';
import '../../model/clsCitiesResponseModel.dart';
import '../../model/clsLoginResponseModel.dart';
import '../../utils/constant.dart';
import '../../utils/design.dart';
import 'Handler_serach_list.dart';

class Handler_Search extends StatefulWidget {
  final GetHandlerList value;
  final String name;
  const Handler_Search({Key? key, required  this.value, required  this.name}) : super(key: key);

  @override
  State<Handler_Search> createState() => _Handler_SearchState();
}

class _Handler_SearchState extends State<Handler_Search> {
  TextEditingController customName = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  ClsLoginResponseModel logindetails = clsLoginResponseModelFromJson(
      SharedPref.get(prefKey: PrefKey.loginDetails)!);
  GetProfileModel getprofile =
      getProfileModelFromJson(SharedPref.get(prefKey: PrefKey.get_profile)!);



  String slected_handler = '';
  @override
  void initState() {
    // TODO: implement initState
    customName = TextEditingController(text:   widget.value.customhandler.first.name);
    slected_handler =
       widget.value.customhandler.first.name;
    // getcities();
    // categorypostapi();
    super.initState();
  }

  late GetHandlerList list;

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
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: CustomTextfield(
                    labelname: 'Custom Name',
                    Controller: customName,
                    validator: (p0) {
                      if (p0!.isEmpty)
                        return 'Please Enter Your Handler Name';
                      return null;
                    },
                  ),
                ),
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateColor.resolveWith(
                                (states) => CustomColor().colorPrimary)),
                    onPressed: () async {
                      Map<String, dynamic> parameters = {
                        "apiKey": apikey,
                        'device': '2',
                        "city_id": getprofile.profile.cityId,
                        "first_name": getprofile.profile.firstName,
                        "last_name": getprofile.profile.lastName,
                        "customname": customName.text
                      };
                      EasyLoading.show(status: 'loading...');
                      await get_handler_list(body: parameters)
                          .then((value) {
                        print(jsonEncode(value));
                        list = value;

                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Handler_Search(value: list, name: customName.text,),
                            ));
                        EasyLoading.dismiss();
                      }).onError((error, stackTrace) {
                        EasyLoading.dismiss();
                      });
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: screenheight(context, dividedby: 70)),
                      child: Icon(Icons.search),
                    ))
              ],
            ),
            // Button_For_Update_Save(
            //   text: 'SEARCH',
            //   onpressed: () async {
            //     if (_formKey.currentState!.validate()) {
            //       Map<String, dynamic> parameters = {
            //         "apiKey": apikey,
            //         'device': '2',
            //         "city_id": getprofile.profile.cityId,
            //         "first_name": getprofile.profile.firstName,
            //         "last_name": getprofile.profile.lastName,
            //         "customname": customName.text
            //       };
            //       EasyLoading.show(status: 'loading...');
            //       await get_handler_list(body: parameters)
            //           .then((value) {
            //         print(value.toString());
            //         list = value;
            //         setState(() {
            //           show = true;
            //         });
            //         EasyLoading.dismiss();
            //       }).onError((error, stackTrace) {
            //         EasyLoading.dismiss();
            //       });
            //     }
            //   },
            // )
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Hey ${getprofile.profile.firstName} ${getprofile.profile.lastName} following usernames are available, ',
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount:widget.value.customhandler.length,
                itemBuilder: (context, index) => RadioListTile(
                  visualDensity: VisualDensity.compact,
                  dense: true,
                  title: Text(widget.value.customhandler[index].name,
                      style: TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w600)),
                  value: widget.value.customhandler[index].name,
                  groupValue: slected_handler,
                  onChanged: (value) {
                    setState(() {
                      slected_handler = value!;
                    });
                  },
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                 'Your Handler Is available',
                    style: TextStyle(
                        fontSize: 17,
                        color:  Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 5,)
,                  Row(
                    children: [
                      Text(
                        'www.vakalat.com/',
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        slected_handler,
                        style: TextStyle(
                            fontSize: 17,
                            color: Colors.green.shade700,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Click "Book Now"to continue with this username. ',
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateColor.resolveWith(
                            (states) => Colors.green.shade700)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 70.0),
                  child: Text('Book Now'),
                ),
                onPressed: () {},
              ),
            )
          ],
        ),
      ),
    );
  }
}
