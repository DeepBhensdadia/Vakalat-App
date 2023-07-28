import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../Sharedpref/shared_pref.dart';
import '../../api/postapi.dart';
import '../../color/customcolor.dart';
import '../../model/DeleteServicesModel.dart';
import '../../model/GetServicesModel.dart';
import '../../model/clsLoginResponseModel.dart';
import '../../utils/constant.dart';
import '../My Account/image_viewer.dart';
import 'Add_services.dart';
import 'Edit_Services.dart';

class Services_screen extends StatefulWidget {
  const Services_screen({Key? key}) : super(key: key);

  @override
  State<Services_screen> createState() => _Services_screenState();
}

class _Services_screenState extends State<Services_screen> {
  ClsLoginResponseModel logindetails = clsLoginResponseModelFromJson(
      SharedPref.get(prefKey: PrefKey.loginDetails)!);
  bool show = false;

  Future<void> get_services() async {
    Map<String, dynamic> parameters = {
      "apiKey": apikey,
      'device': '2',
      "accessToken": logindetails.accessToken,
      "user_id": logindetails.userData.userId,
      "offset": "0",
    };
    EasyLoading.show(status: 'Loading...');
    await Get_Services(body: parameters).then((value) {
      setState(() {
        services = value;
        show = true;
      });
      EasyLoading.dismiss();
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    get_services();
    super.initState();
  }

  late ClsGetServicesResponseModel services;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Services',
          style: TextStyle(
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        backgroundColor: CustomColor().colorPrimary,
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const Add_Services(),
                ));
          },
          child: const Icon(Icons.add)),
      body: show == true
          ?services.services.isEmpty?Container(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          verticalDirection: VerticalDirection.down,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Card(
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                ),
                elevation: 4,
                child:
                Image.asset('assets/images/nodata_search.png')),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text(
                "No data found.",
                style: TextStyle(
                    color: CustomColor().colorPrimary,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ): ListView.builder(
              itemCount: services.services.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(
                  left: 10.0,
                  right: 10,
                  top: 10,
                ),
                child: Column(
                  children: [
                    Card(
                      color: const Color(0xffF4F9FF),
                      margin: EdgeInsets.zero,
                      elevation: 2,
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        // height: 150,
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 1.0),
                                child: CachedNetworkImage(
                                  imageUrl: Const().URL_Services_Image +
                                      services.services[index].smImage,
                                  imageBuilder: (context, imageProvider) =>
                                      InkWell(
                                        onTap: () => Navigator.push(
                                            context,
                                            CupertinoPageRoute(
                                              builder: (context) => Image_viewer(
                                                  image:  Const().URL_Services_Image +
                                                      services.services[index].smImage,),
                                            )),
                                        child: Container(
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover,
                                          // colorFilter:
                                          //     ColorFilter.mode(Colors.red, BlendMode.colorBurn),
                                        ),
                                    ),
                                  ),
                                      ),
                                  placeholder: (context, url) =>
                                      Image.asset('assets/images/loading.gif'),
                                  errorWidget: (context, url, error) =>
                                      Image.asset('assets/images/default.png'),
                                  height: 100,
                                  width: 100,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        services.services[index].smTitle,
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      HtmlWidget(
                                        '${services.services[index].smDetails}',
                                        textStyle: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.grey),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '₹ ${services.services[index].smAmount}',
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black54),
                                          ),
                                          Row(
                                            children: [
                                              MaterialButton(
                                                color: const Color(0xff448BE8),
                                                height: 30,
                                                minWidth: 30,
                                                padding: EdgeInsets.zero,
                                                onPressed: () {
                                                  Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            Edit_Services(
                                                          service_id: services
                                                              .services[index]
                                                              .smId,
                                                          title: services
                                                              .services[index]
                                                              .smTitle,
                                                          amount: services
                                                              .services[index]
                                                              .smAmount,
                                                          detail: services
                                                              .services[index]
                                                              .smDetails,
                                                        ),
                                                      ));
                                                },
                                                child: const Icon(
                                                  FontAwesomeIcons.edit,
                                                  size: 14,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              MaterialButton(
                                                color: const Color(0xffAF3F3F),
                                                height: 30,
                                                minWidth: 30,
                                                padding: EdgeInsets.zero,
                                                onPressed: () async {
                                                  showDialog(
                                                    context: context,
                                                    builder: (context) =>
                                                        AlertDialog(
                                                          title: Text(
                                                              'Are you Sure Delete Services ?'),
                                                          actions: [
                                                            TextButton(
                                                                onPressed: () {
                                                              delete_service(index);
                                                                },
                                                                child: Text('Yes')),
                                                            TextButton(
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child: Text('No')),
                                                          ],
                                                        ),
                                                  );
                                                },
                                                child: const Icon(
                                                  Icons.delete,
                                                  size: 14,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              // Text(services.services[index].smId),
                                              // Text(logindetails.accessToken)
                                            ],
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ]),
                      ),
                    ),
                    index == services.services.length - 1
                        ? const SizedBox(
                            height: 60,
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
            )
          : const Center(child: SizedBox()),
    );
  }
  delete_service(index) async {
    EasyLoading.show(
        status: 'Loading...');
    Map<String, dynamic>
    parameters = {
      "apiKey": apikey,
      'device': '2',
      "accessToken": logindetails
          .accessToken,
      "user_id": logindetails
          .userData.userId,
      "service_id": services
          .services[index].smId,
    };
    DeleteServicesModel delete =
        await Delete_services(
        body: parameters);
    if (delete.status == 1) {
      Fluttertoast.showToast(
          msg: delete.message);
      EasyLoading.dismiss();
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
            const Services_screen(),
          ));
    } else {
      EasyLoading.dismiss();

      Fluttertoast.showToast(
          msg: delete.message);
    }
  }
}
