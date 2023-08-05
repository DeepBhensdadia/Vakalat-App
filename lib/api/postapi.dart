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
import 'package:vakalat_flutter/model/getallLanguage.dart';

import '../model/Bar Associate List.dart';
import '../model/DeleteServicesModel.dart';
import '../model/GetAllCategory.dart';
import '../model/GetDashboard.dart';
import '../model/GetHandlerList.dart';
import '../model/GetPackageModel.dart';
import '../model/GetPaymentCcavenue.dart';
import '../model/GetServicesModel.dart';
import '../model/GetSubscription.dart';
import '../model/GetUserInquriesResponseModel.dart';
import '../model/GetUserRating.dart';
import '../model/Get_Profile.dart';
import '../model/Get_doc_type.dart';
import '../model/UpdateContactDetails.dart';
import '../model/UpdatePersonalDetails.dart';
import '../model/UpdateSocialDetails.dart';
import '../model/UserInquriesResponseModel.dart';
import '../model/change_password.dart';
import '../model/clsCitiesResponseModel.dart';
import '../model/clsCountriesResponseModel.dart';
import '../model/clsForgotPasswordResponseModel.dart';
import '../model/clsRegisterResponseModel.dart';
import '../model/clsStateResponseModel.dart';
import '../model/clsUserTypeResponseModel.dart';
import '../model/getAchivements.dart';
import '../model/getParticipation.dart';
import '../model/getallLanguage.dart';
import '../model/getallLanguage.dart';
import '../model/getallLanguage.dart';
import '../model/getallLanguage.dart';
import '../model/getallLanguage.dart';
import '../model/getalldeshboard.dart';
import '../model/getbar_councilModel.dart';
import '../model/getdiscountModel.dart';
import '../model/getdocumentdetails.dart';
import '../model/getdrawermenu.dart';
import '../model/updatelanguages.dart';
import '../model/viewcartmodel.dart';
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
  String url = '$baseUrl/register_mobile';
  return http.post(Uri.parse(url), body: body ).then((http.Response response) {
    if (kDebugMode) {
      // print(json.decode(response.body));
    }
    return clsLoginResponseModelFromJson(response.body);
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

Future<ClsUpdatePersonalResponseModel>  change_password({required Map body}) {
  String url = '$baseUrl//user_change_password';
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
Future<ClsUpdateContactResponseModel>  updateprofessionaldetail({required Map body}) {
  String url = '$baseUrl/update_professional_detail';
  return http.post(Uri.parse(url), body: body ).then((http.Response response) {
    if (kDebugMode) {
      // print(json.decode(response.body));
    }
    return clsUpdateContactResponseModelFromJson(response.body);
  });
}
Future<ClsUpdateContactResponseModel>  addtocart({required Map body}) {
  String url = '$baseUrl//app_add_to_cart';
  return http.post(Uri.parse(url), body: body ).then((http.Response response) {
    if (kDebugMode) {
      // print(json.decode(response.body));
    }
    return clsUpdateContactResponseModelFromJson(response.body);
  });
}
Future<Getdiscountmodel>  discountapi({required Map body}) {
  // https://www.vakalat.com/user_api//chk_discount_code
  String url = '$baseUrl//chk_discount_code';
  return http.post(Uri.parse(url), body: body ).then((http.Response response) {
    if (kDebugMode) {
      // print(json.decode(response.body));
    }
    return getdiscountmodelFromJson(response.body);
  });
}
Future<ClsUpdateContactResponseModel>  paymentwithcashcode({required Map body}) {
  // https://www.vakalat.com/user_api//chk_discount_code
  String url = '$baseUrl/check_cash_code';
  return http.post(Uri.parse(url), body: body ).then((http.Response response) {
    if (kDebugMode) {
      // print(json.decode(response.body));
    }
    return clsUpdateContactResponseModelFromJson(response.body);
  });
}
Future<ClsUpdateContactResponseModel>  achivement_iamgedelete({required Map body}) {
  // https://www.vakalat.com/user_api//chk_discount_code
  String url = '$baseUrl/achivements_master_image_delete';
  return http.post(Uri.parse(url), body: body ).then((http.Response response) {
    if (kDebugMode) {
      // print(json.decode(response.body));
    }
    return clsUpdateContactResponseModelFromJson(response.body);
  });
}
Future<ClsUpdateContactResponseModel>  Participation_iamgedelete({required Map body}) {
  // https://www.vakalat.com/user_api//chk_discount_code
  String url = '$baseUrl/participations_master_image_delete';
  return http.post(Uri.parse(url), body: body ).then((http.Response response) {
    if (kDebugMode) {
      // print(json.decode(response.body));
    }
    return clsUpdateContactResponseModelFromJson(response.body);
  });
}
Future<Getalllanguage> Getalllanguages({required Map body}) {
  // https://www.vakalat.com/user_api//chk_discount_code
  String url = '$baseUrl/get_languages';
  return http.post(Uri.parse(url), body: body ).then((http.Response response) {
    if (kDebugMode) {
      // print(json.decode(response.body));
    }
    return getalllanguageFromJson(response.body);
  });
}
Future<Getpaymentonline>  paymentonlineccavenue({required Map body}) {
  // https://www.vakalat.com/user_api//chk_discount_code
  String url = '$baseUrl/checkout';
  return http.post(Uri.parse(url), body: body ).then((http.Response response) {
    if (kDebugMode) {
      // print(json.decode(response.body));
    }
    return getpaymentonlineFromJson(response.body);
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

Future<GetAchivements> get_Achivement({required Map body}) {
  String url = '$baseUrl/get_achievements_view';
  return http.post(Uri.parse(url), body: body ).then((http.Response response) {
    if (kDebugMode) {
      // print(json.decode(response.body));
    }
    return getAchivementsFromJson(response.body);
  });
}

Future<DeleteServicesModel>  Delete_Achivement({required Map body}) {
  String url = '$baseUrl//achivements_master_delete';
  return http.post(Uri.parse(url), body: body ).then((http.Response response) {
    if (kDebugMode) {
      // print(json.decode(response.body));
    }
    return deleteServicesModelFromJson(response.body);
  });
}
Future<DeleteServicesModel>  Delete_Participation({required Map body}) {
  // https://www.vakalat.com/user_api//participations_master_delete
  String url = '$baseUrl//participations_master_delete';
  return http.post(Uri.parse(url), body: body ).then((http.Response response) {
    if (kDebugMode) {
      // print(json.decode(response.body));
    }
    return deleteServicesModelFromJson(response.body);
  });
}

Future<GetParticipation> get_Participation({required Map body}) {
  String url = '$baseUrl/get_participations_view';
  return http.post(Uri.parse(url), body: body ).then((http.Response response) {
    if (kDebugMode) {
      // print(json.decode(response.body));
    }
    return getParticipationFromJson(response.body);
  });
}

Future<GetAllCategory> All_Categories({required Map body}) {
  String url = '$baseUrl/get_category_main';
  return http.post(Uri.parse(url), body: body ).then((http.Response response) {
    if (kDebugMode) {
      // print(json.decode(response.body));
    }
    return getAllCategoryFromJson(response.body);
  });
}
Future<GetHandlerList> get_handler_list({required Map body}) {
  String url = '$baseUrl/get_handler_list_view';
  return http.post(Uri.parse(url), body: body ).then((http.Response response) {
    if (kDebugMode) {
      // print(json.decode(response.body));
    }
    return getHandlerListFromJson(response.body);
  });
}

Future<Getdashboard> get_Deshboard({required Map body}) {
  String url = '$baseUrl/get_dashboard';
  return http.post(Uri.parse(url), body: body ).then((http.Response response) {
    if (kDebugMode) {
      // print(json.decode(response.body));
    }
    return getdashboardFromJson(response.body);
  });
}

Future<GetbarCouncillist> get_bar_council({required Map body}) {
  // https://www.vakalat.com/user_api//get_bar_councils_list
  String url = '$baseUrl//get_bar_councils_list';
  return http.post(Uri.parse(url), body: body ).then((http.Response response) {
    if (kDebugMode) {
      // print(json.decode(response.body));
    }
    return getbarCouncillistFromJson(response.body);
  });
}
Future<GetbarAssociatList> get_bar_Association({required Map body}) {
  // https://www.vakalat.com/user_api//get_bar_councils_list
  String url = '$baseUrl//get_bar_association_list';
  return http.post(Uri.parse(url), body: body ).then((http.Response response) {
    if (kDebugMode) {
      // print(json.decode(response.body));
    }
    return getbarAssociatListFromJson(response.body);
  });
}
// Future<DocTypeGet> getDoctype({required Map body}) {
//   // https://www.vakalat.com/user_api//get_bar_councils_list
//   String url = '$baseUrl/get_doc_types';
//   return http.post(Uri.parse(url), body: body ).then((http.Response response) {
//     if (kDebugMode) {
//       // print(json.decode(response.body));
//     }
//     return docTypeGetFromJson(response.body);
//   });
// }

Future<GetSubscripation> Get_subscription({required Map body}) {
  // https://www.vakalat.com/user_api//get_bar_councils_list
  String url = '$baseUrl//get_subscriptions_list';
  return http.post(Uri.parse(url), body: body ).then((http.Response response) {
    if (kDebugMode) {
      // print(json.decode(response.body));
    }
    return getSubscripationFromJson(response.body);
  });
}
Future<Viewcartmodel> View_cart({required Map body}) {
  // https://www.vakalat.com/user_api//get_bar_councils_list
  String url = '$baseUrl/app_view_cart';
  return http.post(Uri.parse(url), body: body ).then((http.Response response) {
    if (kDebugMode) {
      // print(json.decode(response.body));
    }
    return viewcartmodelFromJson(response.body);
  });
}
Future<Getdrawermenu> getdrawermenu({required Map body}) {
  // https://www.vakalat.com/user_api//get_bar_councils_list
  String url = '$baseUrl/get_app_menu';
  return http.post(Uri.parse(url), body: body ).then((http.Response response) {
    if (kDebugMode) {
      // print(json.decode(response.body));
    }
    return getdrawermenuFromJson(response.body);
  });
}
Future<GetUserRating> getratingreview({required Map body}) {
  // https://www.vakalat.com/user_api//get_bar_councils_list
  String url = '$baseUrl/get_user_rating';
  return http.post(Uri.parse(url), body: body ).then((http.Response response) {
    if (kDebugMode) {
      // print(json.decode(response.body));
    }
    return getUserRatingFromJson(response.body);
  });
}
Future<DeleteServicesModel> get_review_status({required Map body}) {
  // https://www.vakalat.com/user_api//get_bar_councils_list
  String url = '$baseUrl/update_rating_status';
  return http.post(Uri.parse(url), body: body ).then((http.Response response) {
    if (kDebugMode) {
      // print(json.decode(response.body));
    }
    return deleteServicesModelFromJson(response.body);
  });
}

Future<DeleteServicesModel>  Delete_languages({required Map body}) {
  // https://www.vakalat.com/user_api//participations_master_delete
  String url = '$baseUrl/remove_profile_language';
  return http.post(Uri.parse(url), body: body ).then((http.Response response) {
    if (kDebugMode) {
      // print(json.decode(response.body));
    }
    return deleteServicesModelFromJson(response.body);
  });
}
Future<Getupdatelanguage>  update_languages({required Map body}) {
  // https://www.vakalat.com/user_api//participations_master_delete
  String url = '$baseUrl/Update_profile_language_app';
  return http.post(Uri.parse(url), body: body ).then((http.Response response) {
    if (kDebugMode) {
      // print(json.decode(response.body));
    }
    return getupdatelanguageFromJson(response.body);
  });
}
Future<Getdocumentdetails>  getdoctype({required Map body}) {
  // https://www.vakalat.com/user_api//participations_master_delete
  String url = '$baseUrl//get_verification_document_types';
  return http.post(Uri.parse(url), body: body ).then((http.Response response) {
    if (kDebugMode) {
      // print(json.decode(response.body));
    }
    return getdocumentdetailsFromJson(response.body);
  });
}

Future<DeleteServicesModel>  getsendmail({required Map body}) {
  // https://www.vakalat.com/user_api//participations_master_delete
  String url = '$baseUrl//welcome_email';
  return http.post(Uri.parse(url), body: body ).then((http.Response response) {
    if (kDebugMode) {
      // print(json.decode(response.body));
    }
    return deleteServicesModelFromJson(response.body);
  });
}
Future<GetAllDeshboard> getalldashboard({required Map body}) {
  // https://www.vakalat.com/user_api//participations_master_delete
  String url = '$baseUrl/get_main_dashboard';
  return http.post(Uri.parse(url), body: body ).then((http.Response response) {
    if (kDebugMode) {
      // print(json.decode(response.body));
    }
    return getAllDeshboardFromJson(response.body);
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
