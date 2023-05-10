import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz1;

class NotificationService {
  var _local = FlutterLocalNotificationsPlugin();
  NotificationService() {
    initialize();
  }

  void initialize() async {
    tz1.initializeTimeZones();
    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await _local.initialize(
      initializationSettings,
    );
  }

  static Future<void> _backgroundNotificationHandler() async {
    await FlutterLocalNotificationsPlugin()
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();
  }

  Future<void> showNotification() async {
    var androidDetails = AndroidNotificationDetails(
      'channelId',
      'channelName',
      channelDescription: 'channelDescription',
      importance: Importance.high,
      priority: Priority.high,
      ticker: 'ticker',
    );

    var platformDetails = NotificationDetails(
      android: androidDetails,
    );

    await _local.show(
      0,
      'Notification Title',
      'Notification Body',
      platformDetails,
      payload: 'payload',
    );
  }

  Future<void> scheduleNotification(Duration duration) async {
    var androidDetails = const AndroidNotificationDetails(
      'channelId',
      'channelName',
      channelDescription: 'channelDescription',
      importance: Importance.high,
      priority: Priority.high,
      ticker: 'ticker',
    );

    var platformDetails = NotificationDetails(
      android: androidDetails,
    );

    await _local.zonedSchedule(
      0,
      'Cancer Detector',
      'Please don\'t forget your examination',
      tz.TZDateTime.now(tz.local).add(duration),
      platformDetails,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  Future<bool> checkPendingNotifications() async {
    final pendingNotifications = await _local.pendingNotificationRequests();

    if (pendingNotifications.isNotEmpty) {
      print("test 101 there is a registered notification");
      return true;
    } else {
      print("test 101 there are no registered notifications");
      return false;
    }
  }

  Future<void> cancelNotification() async {
    int notificationId = 0; // replace with the ID of the notification to cancel

    // cancel the notification
    await _local.cancel(notificationId);

    // check if the notification was successfully canceled
    final pendingNotifications = await _local.pendingNotificationRequests();
    final canceledNotification = pendingNotifications
        .firstWhere((notification) => notification.id == notificationId);

    if (canceledNotification != null) {
      print("test 101 Notification not Cancelled");
    } else {
      print("test 101 Notification Cancelled");
    }
  }
}
