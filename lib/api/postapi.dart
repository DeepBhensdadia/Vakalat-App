import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:vakalat_flutter/model/GeneralResponseModel.dart';
import 'package:vakalat_flutter/model/clsAboutUsResponseModel.dart';
import 'package:vakalat_flutter/model/clsCategoryResponseModel.dart';
import 'package:vakalat_flutter/model/clsCityResponseModel.dart';
import 'package:vakalat_flutter/model/clsCollegeResponseModel.dart';
import 'package:vakalat_flutter/model/clsCourseResponseModel.dart';
import 'package:vakalat_flutter/model/clsEventDetailResponseModel.dart';
import 'package:vakalat_flutter/model/clsEventResponseModel.dart';
import 'package:vakalat_flutter/model/clsJobDetailResponseModel.dart';
import 'package:vakalat_flutter/model/clsJobResponseModel.dart';
import 'package:vakalat_flutter/model/clsLanguageResponseModel.dart';
import 'package:vakalat_flutter/model/clsLawyerDetailResponseModel.dart';
import 'package:vakalat_flutter/model/clsLawyerResponseModel.dart';
import 'package:vakalat_flutter/model/clsLegalNewsResponseModel.dart';
import 'package:vakalat_flutter/model/clsLegalNoticeResponseModel.dart';
import 'package:vakalat_flutter/model/clsLiveSessionsResponseModel.dart';
import 'package:vakalat_flutter/model/clsMenuResponseModel.dart';
import 'package:vakalat_flutter/model/clsPrivacyPolicyResponseModel.dart';
import 'package:vakalat_flutter/model/clsSubCategoryResponseModel.dart';
import 'package:vakalat_flutter/model/clsTopicResponseModel.dart';
import 'package:vakalat_flutter/model/clsVideoResponseModel.dart';

import 'package:vakalat_flutter/model/clsLoginResponseModel.dart';

import '../model/DeleteServicesModel.dart';
import '../model/GetPackageModel.dart';
import '../model/GetServicesModel.dart';
import '../model/GetUserInquriesResponseModel.dart';
import '../model/Get_Profile.dart';
import '../model/UpdateContactDetails.dart';
import '../model/UpdatePersonalDetails.dart';
import '../model/UpdateSocialDetails.dart';
import '../model/UserInquriesResponseModel.dart';
import '../model/clsCitiesResponseModel.dart';
import '../model/clsCountriesResponseModel.dart';
import '../model/clsForgotPasswordResponseModel.dart';
import '../model/clsRegisterResponseModel.dart';
import '../model/clsStateResponseModel.dart';
import '../model/clsUserTypeResponseModel.dart';
import 'apiclient.dart';

Map<String, String> headers = {
  'Content-type': 'application/json',
  'Accept': 'application/json',
};

Map<String, String> default_parameters = {
  'apiKey': apiKey,
  'device': device,
};

// Login
//-----Parameters--------
// grant_type:password
// username: xxxxx
// password: xxxxx
Future userLogin({required Map body}) {
  String url = '$baseUrl/login';
  return http.post(Uri.parse(url), body: body ).then((http.Response response) {
    if (kDebugMode) {
      // print(json.decode(response.body));
    }
    return clsLoginResponseModelFromJson(response.body);
  });
}
Future<GetPackagesModel> GetUserpackages({required Map body}) {
  String url = '$baseUrl/get_user_wise_package';
  return http.post(Uri.parse(url), body: body ).then((http.Response response) {
    if (kDebugMode) {
      // print(json.decode(response.body));
    }
    return getPackagesModelFromJson(response.body);
  });
}

Future<GetProfileModel> get_profile({required Map body}) {
  String url = '$baseUrl/get_profile';
  return http.post(Uri.parse(url), body: body ).then((http.Response response) {
    if (kDebugMode) {
      // print(json.decode(response.body));
    }
    return getProfileModelFromJson(response.body);
  });
}

Future userRegister({required Map body}) {
  String url = '$baseUrl/register';
  return http.post(Uri.parse(url), body: body ).then((http.Response response) {
    if (kDebugMode) {
      // print(json.decode(response.body));
    }
    return clsRegisterResponseModelFromJson(response.body);
  });
}
Future userForgotPassword({required Map body}) {
  String url = '$baseUrl/forgot_password';
  return http.post(Uri.parse(url), body: body ).then((http.Response response) {
    if (kDebugMode) {
      // print(json.decode(response.body));
    }
    return clsForgotPasswordResponseModelFromJson(response.body);
  });
}

Future<ClsCountriesResponseModel> userCountries({required Map body}) {
  String url = '$baseUrl/get_countries';
  return http.post(Uri.parse(url), body: body ).then((http.Response response) {
    if (kDebugMode) {
      // print(json.decode(response.body));
    }
    return clsCountriesResponseModelFromJson(response.body);
  });
}

Future<ClsUserTypeResponseModel> get_user_type({required Map body}) {
  String url = '$baseUrl/get_user_type';
  return http.post(Uri.parse(url), body: body ).then((http.Response response) {
    if (kDebugMode) {
      // print(json.decode(response.body));
    }
    return clsUserTypeResponseModelFromJson(response.body);
  });
}

Future<ClsStateResponseModel>  userStates({required Map body}) {
  String url = '$baseUrl/get_states';
  return http.post(Uri.parse(url), body: body ).then((http.Response response) {
    if (kDebugMode) {
      // print(json.decode(response.body));
    }
    return clsStateResponseModelFromJson(response.body);
  });
}

Future<ClsCitiesResponseModel>  userCities({required Map body}) {
  String url = '$baseUrl/get_cities';
  return http.post(Uri.parse(url), body: body ).then((http.Response response) {
    if (kDebugMode) {
      // print(json.decode(response.body));
    }
    return clsCitiesResponseModelFromJson(response.body);
  });
}
Future<ClsUpdatePersonalResponseModel>  Update_Personal_Details({required Map body}) {
  String url = '$baseUrl/update_personal_detail';
  return http.post(Uri.parse(url), body: body ).then((http.Response response) {
    if (kDebugMode) {
      // print(json.decode(response.body));
    }
    return clsUpdatePersonalResponseModelFromJson(response.body);
  });
}
Future<ClsUpdateContactResponseModel>  Update_Contect_Details({required Map body}) {
  String url = '$baseUrl/update_contact_detail';
  return http.post(Uri.parse(url), body: body ).then((http.Response response) {
    if (kDebugMode) {
      // print(json.decode(response.body));
    }
    return clsUpdateContactResponseModelFromJson(response.body);
  });
}
Future<ClsUpdateSocialResponseModel>  Update_Social_Details({required Map body}) {
  String url = '$baseUrl/update_social_detail';
  return http.post(Uri.parse(url), body: body ).then((http.Response response) {
    if (kDebugMode) {
      // print(json.decode(response.body));
    }
    return clsUpdateSocialResponseModelFromJson(response.body);
  });
}
Future<ClsGetServicesResponseModel>  Get_Services({required Map body}) {
  String url = '$baseUrl/Get_services';
  return http.post(Uri.parse(url), body: body ).then((http.Response response) {
    if (kDebugMode) {
      // print(json.decode(response.body));
    }
    return clsGetServicesResponseModelFromJson(response.body);
  });
}
Future<DeleteServicesModel>  Delete_services({required Map body}) {
  String url = '$baseUrl/Delete_service';
  return http.post(Uri.parse(url), body: body ).then((http.Response response) {
    if (kDebugMode) {
      // print(json.decode(response.body));
    }
    return deleteServicesModelFromJson(response.body);
  });
}

Future<GetUserInquriesResponceModel> get_user_inqury({required Map body}) {
  String url = '$baseUrl/Get_user_inquiries';
  return http.post(Uri.parse(url), body: body ).then((http.Response response) {
    if (kDebugMode) {
      // print(json.decode(response.body));
    }
    return getUserInquriesResponceModelFromJson(response.body);
  });
}
Future<UserInquriesDetailsResponceModel> get_user_inqury_Details({required Map body}) {
  String url = '$baseUrl/Get_user_inquiry_detail';
  return http.post(Uri.parse(url), body: body ).then((http.Response response) {
    if (kDebugMode) {
      // print(json.decode(response.body));
    }
    return userInquriesDetailsResponceModelFromJson(response.body);
  });
}

// RegisterDevice
//-----Parameters--------
// FCMDeviceToken:Device 2
Future<GeneralResponseModel> registerDevice(String accessToken,
    {required Map body}) {
  if (kDebugMode) {
    print("Bearer $accessToken");
  }
  String url = '$baseUrl/User/RegisterDevice';
  return http
      .post(Uri.parse(url),
          headers: {
            "Authorization": "Bearer $accessToken",
          },
          body: body)
      .then((http.Response response) {
    if (kDebugMode) {
      // print(json.decode(response.body));
    }
    return GeneralResponseModel.fromJson(json.decode(response.body));
  });
}

Future<clsVideoResponseModel> getVideo({required Map body}) {
  String url = '$baseUrl/get_kyl_video';
  if (kDebugMode) {
    print(url);
  }
  body.addAll(default_parameters);

  return http
      .post(Uri.parse(url), headers: null, body: body)
      .then((http.Response response) {
    if (kDebugMode) {
      // print(json.decode(response.body));
    }

    return clsVideoResponseModel.fromJson(json.decode(response.body));
  });
}

Future<clsLawyerResponseModel> get_lawyer({required Map body}) {
  String url = '$baseUrl/get_lawyer';

  body.addAll(default_parameters);
  if (kDebugMode) {
    print(url);
    print(body);
  }
  return http
      .post(Uri.parse(url), headers: null, body: body)
      .then((http.Response response) {
    if (kDebugMode) {
      // // print(json.decode(response.body));
    }
    return clsLawyerResponseModel.fromJson(json.decode(response.body));
  });
}
Future<clsLawyerResponseModel> get_lawyer_top({required Map body}) {
  String url = '$baseUrl/get_lawyer_top';

  body.addAll(default_parameters);
  if (kDebugMode) {
    print(url);
    print(body);
  }
  return http
      .post(Uri.parse(url), headers: null, body: body)
      .then((http.Response response) {
    if (kDebugMode) {
      // // print(json.decode(response.body));
    }
    return clsLawyerResponseModel.fromJson(json.decode(response.body));
  });
}

Future<clsLawyerDetailResponseModel> get_lawyer_details({required Map body}) {
  String url = '$baseUrl/get_lawyer_details';

  body.addAll(default_parameters);
  if (kDebugMode) {
    print(url);
    print(body);
  }
  return http
      .post(Uri.parse(url), headers: null, body: body)
      .then((http.Response response) {
    if (kDebugMode) {
      // print(json.decode(response.body));
    }
    return clsLawyerDetailResponseModel.fromJson(json.decode(response.body));
  });
}
Future<clsCityResponseModel> get_cities({required Map body}) {
  String url = '$baseUrl/get_cities';

  if (kDebugMode) {
    print(url);
  }

  body.addAll(default_parameters);

  return http
      .post(Uri.parse(url), headers: null, body: body)
      .then((http.Response response) {
    if (kDebugMode) {
      // print(json.decode(response.body));
    }

    return clsCityResponseModel.fromJson(json.decode(response.body));
  });
}

Future<clsCategoryResponseModel> get_category({required Map body}) {
  String url = '$baseUrl/get_category';

  if (kDebugMode) {
    print(url);
  }

  body.addAll(default_parameters);

  return http
      .post(Uri.parse(url), headers: null, body: body)
      .then((http.Response response) {
    if (kDebugMode) {
      // print(json.decode(response.body));
    }

    return clsCategoryResponseModel.fromJson(json.decode(response.body));
  });
}

Future<clsCategoryResponseModel> get_category_for_seach({required Map body}) {
  String url = '$baseUrl/get_category_for_seach';

  if (kDebugMode) {
    print(url);
  }

  body.addAll(default_parameters);

  return http
      .post(Uri.parse(url), headers: null, body: body)
      .then((http.Response response) {
    if (kDebugMode) {
      // print(json.decode(response.body));
    }

    return clsCategoryResponseModel.fromJson(json.decode(response.body));
  });
}
Future<clsCategoryResponseModel> get_category_list({required Map body}) {
  String url = '$baseUrl/get_category_list';

  if (kDebugMode) {
    print(url);
  }

  body.addAll(default_parameters);

  return http
      .post(Uri.parse(url), headers: null, body: body)
      .then((http.Response response) {
    if (kDebugMode) {
      // print(json.decode(response.body));
    }

    return clsCategoryResponseModel.fromJson(json.decode(response.body));
  });
}

Future<clsSubCategoryResponseModel> get_sub_category({required Map body}) {
  String url = '$baseUrl/get_sub_category';

  if (kDebugMode) {
    print(url);
  }

  body.addAll(default_parameters);

  return http
      .post(Uri.parse(url), headers: null, body: body)
      .then((http.Response response) {
    if (kDebugMode) {
      // print(json.decode(response.body));
    }

    return clsSubCategoryResponseModel.fromJson(json.decode(response.body));
  });
}

Future<clsEventResponseModel> get_events({required Map body}) {
  String url = '$baseUrl/get_events';
  if (kDebugMode) {
    print(url);
    print(body);
  }

  body.addAll(default_parameters);

  return http
      .post(Uri.parse(url), headers: null, body: body)
      .then((http.Response response) {
    if (kDebugMode) {
      // print(json.decode(response.body));
    }

    return clsEventResponseModel.fromJson(json.decode(response.body));
  });
}

Future<clsLegalNewsResponseModel> get_legal_news({required Map body}) {
  String url = '$baseUrl/get_legal_news';
  if (kDebugMode) {
    print(url);
  }

  body.addAll(default_parameters);

  return http
      .post(Uri.parse(url), headers: null, body: body)
      .then((http.Response response) {
    if (kDebugMode) {
      // print(json.decode(response.body));
    }

    return clsLegalNewsResponseModel.fromJson(json.decode(response.body));
  });
}


Future<clsLiveSessionsResponseModel> get_live_session({required Map body}) {
  String url = '$baseUrl/get_live_session';
  if (kDebugMode) {
    print(url);
  }

  body.addAll(default_parameters);

  return http
      .post(Uri.parse(url), headers: null, body: body)
      .then((http.Response response) {
    if (kDebugMode) {
      // print(json.decode(response.body));
    }

    return clsLiveSessionsResponseModel.fromJson(json.decode(response.body));
  });
}


Future<clsLegalNoticeResponseModel> get_legal_notices({required Map body}) {
  String url = '$baseUrl/get_legal_notices';
  if (kDebugMode) {
    print(url);
  }

  body.addAll(default_parameters);

  return http
      .post(Uri.parse(url), headers: null, body: body)
      .then((http.Response response) {
    if (kDebugMode) {
      // print(json.decode(response.body));
    }

    return clsLegalNoticeResponseModel.fromJson(json.decode(response.body));
  });
}


Future<clsJobResponseModel> get_jobs({required Map body}) {
  String url = '$baseUrl/get_jobs';
  if (kDebugMode) {
    print(url);
  }

  body.addAll(default_parameters);

  return http
      .post(Uri.parse(url), headers: null, body: body)
      .then((http.Response response) {
    if (kDebugMode) {
      // print(json.decode(response.body));
    }

    return clsJobResponseModel.fromJson(json.decode(response.body));
  });
}

Future<clsJobDetailResponseModel> get_job_detail({required Map body}) {
  String url = '$baseUrl/get_job_detail';

  body.addAll(default_parameters);
  if (kDebugMode) {
    print(url);
    print(body);
  }
  return http
      .post(Uri.parse(url), headers: null, body: body)
      .then((http.Response response) {
    if (kDebugMode) {
      // print(json.decode(response.body));
    }
    return clsJobDetailResponseModel.fromJson(json.decode(response.body));
  });
}

Future<clsCollegeResponseModel> get_colleges({required Map body}) {
  String url = '$baseUrl/get_colleges';
  if (kDebugMode) {
    print(url);
  }

  body.addAll(default_parameters);

  return http
      .post(Uri.parse(url), headers: null, body: body)
      .then((http.Response response) {
    if (kDebugMode) {
      // print(json.decode(response.body));
    }

    return clsCollegeResponseModel.fromJson(json.decode(response.body));
  });
}


Future<clsMenuResponseModel> get_menu({required Map body}) {
  String url = '$baseUrl/get_menu';
  if (kDebugMode) {
    print(url);
  }

  body.addAll(default_parameters);

  return http
      .post(Uri.parse(url), headers: null, body: body)
      .then((http.Response response) {
    if (kDebugMode) {
      // print(json.decode(response.body));
    }

    return clsMenuResponseModel.fromJson(json.decode(response.body));
  });
}
Future<clsVideoResponseModel> get_kyl_related_video({required Map body}) {
  String url = '$baseUrl/get_kyl_related_video';
  if (kDebugMode) {
    print(url);
  }

  body.addAll(default_parameters);

  return http
      .post(Uri.parse(url), headers: null, body: body)
      .then((http.Response response) {
    if (kDebugMode) {
      // print(json.decode(response.body));
    }

    return clsVideoResponseModel.fromJson(json.decode(response.body));
  });
}

Future<clsTopicResponseModel> get_topics({required Map body}) {
  String url = '$baseUrl/get_topics';

  if (kDebugMode) {
    print(url);
  }

  body.addAll(default_parameters);

  return http
      .post(Uri.parse(url), headers: null, body: body)
      .then((http.Response response) {
    if (kDebugMode) {
      // print(json.decode(response.body));
    }

    return clsTopicResponseModel.fromJson(json.decode(response.body));
  });
}
Future<clsLanguageResponseModel> get_languages({required Map body}) {
  String url = '$baseUrl/get_languages';

  if (kDebugMode) {
    print(url);
  }

  body.addAll(default_parameters);

  return http
      .post(Uri.parse(url), headers: null, body: body)
      .then((http.Response response) {
    if (kDebugMode) {
      // print(json.decode(response.body));
    }

    return clsLanguageResponseModel.fromJson(json.decode(response.body));
  });
}
Future<clsAboutUsResponseModel> get_about_us({required Map body}) {
  String url = '$baseUrl/get_about_us';

  if (kDebugMode) {
    print(url);
  }

  body.addAll(default_parameters);

  return http
      .post(Uri.parse(url), headers: null, body: body)
      .then((http.Response response) {
    if (kDebugMode) {
      // print(json.decode(response.body));
    }

    return clsAboutUsResponseModel.fromJson(json.decode(response.body));
  });
}
Future<clsPrivacyPolicyResponseModel> get_privacy_policy({required Map body}) {
  String url = '$baseUrl/get_privacy_policy';

  if (kDebugMode) {
    print(url);
  }

  body.addAll(default_parameters);

  return http
      .post(Uri.parse(url), headers: null, body: body)
      .then((http.Response response) {
    if (kDebugMode) {
      // print(json.decode(response.body));
    }

    return clsPrivacyPolicyResponseModel.fromJson(json.decode(response.body));
  });
}

Future<clsCourseResponseModel> get_clg_course_detail({required Map body}) {
  String url = '$baseUrl/get_clg_course_detail';

  if (kDebugMode) {
    print(url);
  }

  body.addAll(default_parameters);

  return http
      .post(Uri.parse(url), headers: null, body: body)
      .then((http.Response response) {
    if (kDebugMode) {
      // print(json.decode(response.body));
    }

    return clsCourseResponseModel.fromJson(json.decode(response.body));
  });
}
Future<clsEventDetailResponseModel> get_event_detail({required Map body}) {
  String url = '$baseUrl/get_event_detail';

  if (kDebugMode) {
    print(url);
  }

  body.addAll(default_parameters);

  return http
      .post(Uri.parse(url), headers: null, body: body)
      .then((http.Response response) {
    if (kDebugMode) {
      // print(json.decode(response.body));
    }

    return clsEventDetailResponseModel.fromJson(json.decode(response.body));
  });
}
