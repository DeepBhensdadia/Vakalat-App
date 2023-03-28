import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';

class FCM {
  getFCMToken() async {
    String? fcmtoken;
    if (Platform.isAndroid) {
      await FirebaseMessaging.instance.getToken().then((token) async {
        print("Token isAndroid--->${token!}");
        fcmtoken = token;
      });
    } else {
      //need to change in case of ios
      await FirebaseMessaging.instance.getAPNSToken().then((token) async {
        print("Token ios--->${token!}");
        fcmtoken = token;
      });
    }

    return fcmtoken;
  }
}
