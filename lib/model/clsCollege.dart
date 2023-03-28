class clsCollege {

  String? user_id;
  String? first_name;
  String? middle_name;
  String? last_name;
  String? email;
  String? mobile;
  String? website_url;
  String? profile_pic;
  String? fb_url;
  String? insta_url;
  String? twitter_url;
  String? linkedin_url;
  String? user_url;
  String? about_user;
  String? law_firm_college;
  String? is_verified;
  String? city_name;
  String? state_name;
  String? country_name;
  String? experience;
  String? cat_name;
  String? slug;
  String? is_display_web;

  clsCollege(
      {this.user_id,
        this.first_name,
        this.middle_name,
        this.last_name,
        this.email,
        this.mobile,
        this.website_url,
        this.profile_pic,
        this.fb_url,
        this.insta_url,
        this.twitter_url,
        this.linkedin_url,
        this.user_url,
        this.about_user,
        this.law_firm_college,
        this.is_verified,
        this.city_name,
        this.state_name,
        this.country_name,
        this.experience,
        this.cat_name,
        this.slug,
        this.is_display_web,});

  // This model is sub model of Login for fetching data object

  factory clsCollege.fromJson(Map<String, dynamic> json) {
    return clsCollege(
      user_id: json['user_id'] == null ? "" : json['user_id'] as String?,
      first_name: json['first_name'] == null ? "" : json['first_name'] as String?,
      middle_name: json['middle_name'] == null ? "" : json['middle_name'] as String?,
      last_name: json['last_name'] == null ? "" : json['last_name'] as String?,
      email: json['email'] == null ? "" : json['email'] as String?,
      mobile: json['mobile'] == null ? "" : json['mobile'] as String?,
      website_url: json['website_url'] == null ? "" : json['website_url'] as String?,
      profile_pic: json['profile_pic'] == null ? "" : json['profile_pic'] as String?,
      fb_url: json['fb_url'] == null ? "" : json['fb_url'] as String?,
      insta_url: json['insta_url'] == null ? "" : json['insta_url'] as String?,
      twitter_url: json['twitter_url'] == null ? "" : json['twitter_url'] as String?,
      linkedin_url: json['linkedin_url'] == null ? "" : json['linkedin_url'] as String?,
      user_url: json['user_url'] == null ? "" : json['user_url'] as String?,
      about_user: json['about_user'] == null ? "" : json['about_user'] as String?,
      law_firm_college: json['law_firm_college'] == null ? "" : json['law_firm_college'] as String?,
      is_verified: json['is_verified'] == null ? "" : json['is_verified'] as String?,
      city_name: json['city_name'] == null ? "" : json['city_name'] as String?,
      state_name: json['state_name'] == null ? "" : json['state_name'] as String?,
      country_name: json['country_name'] == null ? "" : json['country_name'] as String?,
      experience: json['experience'] == null ? "" : json['experience'] as String?,
      cat_name: json['cat_name'] == null ? "" : json['cat_name'] as String?,
      slug: json['slug'] == null ? "" : json['slug'] as String?,
      is_display_web: json['is_display_web'] == null ? "" : json['is_display_web'] as String?,
    );
  }

}
