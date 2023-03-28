
class clsJobDetail {

  String? jp_id;
  String? jp_job_title;
  String? jp_description;
  String? jp_gender;
  String? jp_fresher_apply;
  String? jp_experience;
  String? jp_from_salary;
  String? jp_to_salary;
  String? jp_work_time;
  String? jp_country_id;
  String? jp_city_id;
  String? jp_facilites;
  String? jp_start_date;
  String? jp_end_date;
  String? jp_no_of_vacancy;
  String? jp_employment_type;
  String? jp_is_lpo;
  String? jp_is_pw;
  String? jp_isdelete;
  String? jp_created_by;
  String? user_master_id;
  String? jp_created_datetime;
  String? jp_updated_by;
  String? jp_updated_datetime;
  String? city_name;
  String? state_name;
  String? country_name;
  String? law_firm_college;
  String? profile_pic;
  String? about_user;
  String? office_address;
  String? ut_name;
  String? wt_name;

  clsJobDetail(
      {this.jp_id,
        this.jp_job_title,
        this.jp_description,
        this.jp_gender,
        this.jp_fresher_apply,
        this.jp_experience,
        this.jp_from_salary,
        this.jp_to_salary,
        this.jp_work_time,
        this.jp_country_id,
        this.jp_city_id,
        this.jp_facilites,
        this.jp_start_date,
        this.jp_end_date,
        this.jp_no_of_vacancy,
        this.jp_employment_type,
        this.jp_is_lpo,
        this.jp_is_pw,
        this.jp_isdelete,
        this.jp_created_by,
        this.user_master_id,
        this.jp_created_datetime,
        this.jp_updated_by,
        this.jp_updated_datetime,
        this.city_name,
        this.state_name,
        this.country_name,
        this.law_firm_college,
        this.profile_pic,
        this.about_user,
        this.office_address,
        this.ut_name,
        this.wt_name,});

  // This model is sub model of Login for fetching data object

  factory clsJobDetail.fromJson(Map<String, dynamic> json) {
    return clsJobDetail(
      jp_id: json['jp_id'] == null ? "" : json['jp_id'] as String?,
      jp_job_title: json['jp_job_title'] == null ? "" : json['jp_job_title'] as String?,
      jp_description: json['jp_description'] == null ? "" : json['jp_description'] as String?,
      jp_gender: json['jp_gender'] == null ? "" : json['jp_gender'] as String?,
      jp_fresher_apply: json['jp_fresher_apply'] == null ? "" : json['jp_fresher_apply'] as String?,
      jp_experience: json['jp_experience'] == null ? "" : json['jp_experience'] as String?,
      jp_from_salary: json['jp_from_salary'] == null ? "" : json['jp_from_salary'] as String?,
      jp_to_salary: json['jp_to_salary'] == null ? "" : json['jp_to_salary'] as String?,
      jp_work_time: json['jp_work_time'] == null ? "" : json['jp_work_time'] as String?,
      jp_country_id: json['jp_country_id'] == null ? "" : json['jp_country_id'] as String?,
      jp_city_id: json['jp_city_id'] == null ? "" : json['jp_city_id'] as String?,
      jp_facilites: json['jp_facilites'] == null ? "" : json['jp_facilites'] as String?,
      jp_start_date: json['jp_start_date'] == null ? "" : json['jp_start_date'] as String?,
      jp_end_date: json['jp_end_date'] == null ? "" : json['jp_end_date'] as String?,
      jp_no_of_vacancy: json['jp_no_of_vacancy'] == null ? "" : json['jp_no_of_vacancy'] as String?,
      jp_employment_type: json['jp_employment_type'] == null ? "" : json['jp_employment_type'] as String?,
      jp_is_lpo: json['jp_is_lpo'] == null ? "" : json['jp_is_lpo'] as String?,
      jp_is_pw: json['jp_is_pw'] == null ? "" : json['jp_is_pw'] as String?,
      jp_isdelete: json['jp_isdelete'] == null ? "" : json['jp_isdelete'] as String?,
      jp_created_by: json['jp_created_by'] == null ? "" : json['jp_created_by'] as String?,
      user_master_id: json['user_master_id'] == null ? "" : json['user_master_id'] as String?,
      jp_created_datetime: json['jp_created_datetime'] == null ? "" : json['jp_created_datetime'] as String?,
      jp_updated_by: json['jp_updated_by'] == null ? "" : json['jp_updated_by'] as String?,
      jp_updated_datetime: json['jp_updated_datetime'] == null ? "" : json['jp_updated_datetime'] as String?,
      city_name: json['city_name'] == null ? "" : json['city_name'] as String?,
      state_name: json['state_name'] == null ? "" : json['state_name'] as String?,
      country_name: json['country_name'] == null ? "" : json['country_name'] as String?,
      law_firm_college: json['law_firm_college'] == null ? "" : json['law_firm_college'] as String?,
      profile_pic: json['profile_pic'] == null ? "" : json['profile_pic'] as String?,
      about_user: json['about_user'] == null ? "" : json['about_user'] as String?,
      office_address: json['office_address'] == null ? "" : json['office_address'] as String?,
      ut_name: json['ut_name'] == null ? "" : json['ut_name'] as String?,
      wt_name: json['wt_name'] == null ? "" : json['wt_name'] as String?,
    );
  }

}
