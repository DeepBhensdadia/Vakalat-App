
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


class NotificationApi {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> init() async => await _notificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.requestPermission();

  static Future<void> customNotificationChannel() async {
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'CHANNEL_IDS',
      'CHANNEL_NAME',
      description: 'CHANNEL_DESCRIPTION',
      importance: Importance.high,
    );

    await _notificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await _notificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  static Future<void> onClickNotification() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const setting = InitializationSettings(android: android);

    await _notificationsPlugin.initialize(
      setting,
      onDidReceiveBackgroundNotificationResponse: (details) {},
      onDidReceiveNotificationResponse: (details) {},
    );
  }

  static Future<void> showNotification(
      {int id = 0,
      String? title,
      String? body,
      String? payLoad,
      bool onGoing = true}) async {
    await _notificationsPlugin.show(
      id,
      title,
      body,
      await _notificationDetails(onGoing),
      payload: payLoad,
    );
  }

  static Future<NotificationDetails> _notificationDetails(bool onGoing) async {
    return NotificationDetails(
      android: AndroidNotificationDetails(
        'CHANNEL_IDS',
        'CHANNEL_NAME',
        channelDescription: 'CHANNEL_DESCRIPTION',
        importance: Importance.high,
        priority: Priority.high,
        icon: '@mipmap/ic_launcher',
        ongoing: onGoing,
      ),
    );
  }

  static Future<void> removeNotification({int id = 0}) async =>
      await _notificationsPlugin.cancel(id);
}
