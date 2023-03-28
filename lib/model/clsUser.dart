import 'package:vakalat_flutter/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class clsUser {

  String? user_id;
  String? user_fname;
  String? user_lname;
  String? user_email;
  String? user_mobile;
  String? user_type;
  String? user_city;
  String? user_parent_id;
  String? is_fees_paid;
  String? last_fees_date;
  String? profile_pic;
  String? dob;
  bool? user_logged_in;

  clsUser(
      {this.user_id,
        this.user_fname,
        this.user_lname,
        this.user_email,
        this.user_mobile,
        this.user_type,
        this.user_city,
        this.user_parent_id,
        this.is_fees_paid,
        this.last_fees_date,
        this.profile_pic,
        this.dob,
        this.user_logged_in});

  // This model is sub model of Login for fetching data object

  factory clsUser.fromJson(Map<String, dynamic> json) {
    return clsUser(
      user_id: json['user_id'] == null ? "" : json['user_id'] as String?,
      user_fname: json['user_fname'] == null ? "" : json['user_fname'] as String?,
      user_lname: json['user_lname'] == null ? "" : json['user_lname'] as String?,
      user_email: json['user_email'] == null ? "" : json['user_email'] as String?,
      user_mobile: json['user_mobile'] == null ? "" : json['user_mobile'] as String?,
      user_type: json['user_type'] == null ? "" : json['user_type'] as String?,
      user_city: json['user_city'] == null ? "" : json['user_city'] as String?,
      user_parent_id: json['user_parent_id'] == null ? "" : json['user_parent_id'] as String?,
      is_fees_paid: json['is_fees_paid'] == null ? "" : json['is_fees_paid'] as String?,
      last_fees_date: json['last_fees_date'] == null ? "" : json['last_fees_date'] as String?,
      profile_pic: json['profile_pic'] == null ? "" : json['profile_pic'] as String?,
      dob: json['dob'] == null ? "" : json['dob'] as String?,
      user_logged_in: json['user_logged_in'] == null ? false : json['user_logged_in'] as bool?,
    );
  }

  Future clearLoginPrefrences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(Const().KEY_access_token, "");

  }
}
