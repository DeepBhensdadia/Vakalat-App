import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../color/customcolor.dart';
import '../../model/UserInquriesResponseModel.dart';

class User_inqury_Details extends StatefulWidget {
  const User_inqury_Details({
    Key? key,
    required this.details,
  }) : super(key: key);
  final UserInquriesDetailsResponceModel details;
  @override
  State<User_inqury_Details> createState() => _User_inqury_DetailsState();
}

class _User_inqury_DetailsState extends State<User_inqury_Details> {
  var ondate;
  @override
  Widget build(BuildContext context) {
    DateTime myDate =
        DateTime.parse(widget.details.userInquiry.createdDatetime);
    String ondate = DateFormat('yyyy-MM-dd').format(myDate);
    // return showDialog(context: context, builder: (context) => AlertDialog(),)
    return Scaffold();
  }

  text123(String title, String name, IconData icon, Function() ontap) {
    return ListTile(
      onTap: ontap,
      title: Text(title),
      subtitle: Text(name),
      leading: Icon(icon,size: 23 ),
    );
  }
  text2(String title, String name, IconData icon, Function() ontap) {
    return ListTile(
      onTap: ontap,
      title: Text(title),
      subtitle: Text(name),
      leading: Icon(icon,size: 23 ),
      trailing: Icon(Icons.arrow_forward_ios,size: 18,),
    );
  }
}
