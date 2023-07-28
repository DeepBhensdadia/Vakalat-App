import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:vakalat_flutter/pages/dashboard.dart';
import 'package:vakalat_flutter/New%20UI/login.dart';
import 'package:vakalat_flutter/utils/fcm.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:page_transition/page_transition.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:vakalat_flutter/color/customcolor.dart';
import 'package:vakalat_flutter/utils/constant.dart';

class MyApp extends StatefulWidget {
  final AndroidNotificationChannel? channel;

  const MyApp({super.key, this.channel});
  @override
  State<StatefulWidget> createState() {
    // Extra code here
    return MyAppState();
  }

}

class MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  initState() {
    getPackageInfo();

    super.initState();
    // String deviceId = await _getId();;

    //print("DeviceId------->"+deviceId);

    var android = const AndroidInitializationSettings('mipmap/ic_launcher');
    var ios = const DarwinInitializationSettings();
    var platform = InitializationSettings(android: android, iOS: ios);
    flutterLocalNotificationsPlugin.initialize(platform);

    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null) {}
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (notification != null && android != null) {
        print('A new onMessageApp event was published!');
        //ToastMessage().showmessage('A new onMessageApp event was published!');
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                widget.channel!.id,
                widget.channel!.name,
                // TODO add a proper drawable resource to android, for now using
                //      one that already exists in example app.
                icon: 'launch_background',
              ),
            ));
      }
    });

/*
    FirebaseMessaging.onBackgroundMessage((message) {
      //  ToastMessage().showmessage('A new onBackgroundMessage event was published!!');
    } as Future<void> Function(RemoteMessage));
*/

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      //ToastMessage().showmessage('A new onMessageOpenedApp event was published!!');
      /* Navigator.pushNamed(context, '/message',
          arguments: MessageArguments(message, true));*/
    });
  }
  void configLoading() {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.fadingCircle
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorSize = 45.0
      ..radius = 10.0
      ..progressColor = Colors.white
      ..backgroundColor = CustomColor().colorPrimary.withOpacity(0.5)
      ..indicatorColor = Colors.white
      ..textColor = Colors.white
      ..maskType = EasyLoadingMaskType.custom
      ..maskColor = CustomColor().colorPrimary.withOpacity(0.3)
      ..userInteractions = false;
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    // Const().getLoginPrefrences();
    // bool isLogin = false;

    configLoading();

    // if (Const.currentUser != null) {
    //   if (Const.currentUser!.user_logged_in != null &&
    //       Const.currentUser!.user_logged_in !=  false ) {
    //     isLogin = true;
    //   }
    // }

    return LayoutBuilder(builder: (context, constraints) {
      // ScreenUtil.init(
      //   constraints,
      //   orientation: Orientation.portrait,
      // );
      WidgetsFlutterBinding.ensureInitialized();
      // await EasyLocalization.ensureInitialized();
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);

      return ScreenUtilInit(
        builder: (contex,child) => GetMaterialApp(
          builder: EasyLoading.init(),
          title: Const().appName.toString(),
          debugShowCheckedModeBanner: false,
          initialRoute: '/',
          routes: {
            // When navigating to the '/" route, build the FirstScreen widget.
            '/': (context) =>const DashboardPage(title: "Dashboard"),
          },
          onGenerateRoute: (settings) {
            switch (settings.name) {
              case '/login':
                return pageRedirection(
                    child: const LoginPage(title: "Login"), settings: settings);
              case '/dashboard':
                return pageRedirection(
                    child: const DashboardPage(title: "Dashboard"),
                    settings: settings);

              /* case '/add_edit_address':
                  return PageTransition(
                      child: AddEditAddressActivity(addEditType: 'add',userAddress: null),
                      duration: Duration(milliseconds: 300),
                      type: PageTransitionType.rightToLeftWithFade,
                      settings: settings);
                  break;*/
              default:
                return null;
            }
          },
          theme: ThemeData(
              textTheme: GoogleFonts.openSansTextTheme(
                Theme.of(context).textTheme,
              ),
              visualDensity: VisualDensity.adaptivePlatformDensity,
              scaffoldBackgroundColor: CustomColor().colorMainActivityBackColor,
              primaryColor: CustomColor().colorPrimary,
              primaryColorDark: CustomColor().colorPrimary, colorScheme: ColorScheme.fromSwatch().copyWith(secondary: CustomColor().colorPrimary)),
        ),
      );
    });
  }

  showNotification(Map<String, dynamic> msg) async {
    msg.entries.toList();

    var android = const AndroidNotificationDetails(
      'sdffds dsffds',
      "CHANNEL NAME",
    );
    var iOS = const DarwinNotificationDetails ();
    var platform = NotificationDetails(android: android, iOS: iOS);
    await flutterLocalNotificationsPlugin.show(
        0, msg['notification']['title'], msg['notification']['body'], platform);
  }

  pageRedirection({required Widget child, required RouteSettings settings}) {
    return PageTransition(
        child: child,
        duration: const Duration(milliseconds: 300),
        type: PageTransitionType.rightToLeftWithFade,
        settings: settings);
  }

  void getPackageInfo() {
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) async {
      String appName = packageInfo.appName;
      String packageName = packageInfo.packageName;
      String version = packageInfo.version;
      String buildNumber = packageInfo.buildNumber;

      print("appName----->$appName");
      print("packageName----->$packageName");
      print("version----->$version");
      print("buildNumber----->$buildNumber");

      String token = await FCM().getFCMToken();
      print("getFCMToken----->$token");

      Const.version = version.toString();
    });
  }
}
