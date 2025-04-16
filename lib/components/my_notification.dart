import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class MyNotification {
  final notificationPlugin = FlutterLocalNotificationsPlugin();

  bool _isInitializes = false;

  bool get isInitializes => _isInitializes;

  // Initialized
  Future<void> isInitializesNotification() async {
    if (_isInitializes) return; // prevent re-initialization

    // prepare android init settings
    const initSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // init settings
    const initSettings = InitializationSettings(
      android: initSettingsAndroid,
    );

    // finaly initialize plugin
    await notificationPlugin.initialize(initSettings);
  }

  //Notification details setups
  NotificationDetails notificationDetails() {
    return const NotificationDetails(
        android: AndroidNotificationDetails(
            'daily channel id', 'daily Notification',
            channelDescription: 'Daily Notification Channel',
            importance: Importance.max,
            priority: Priority.high));
  }

  //Show Notification
  Future<void> showNotification({
  int id = 0,
  String? title,
  String? body,
}) async {
  try {
    await isInitializesNotification(); // Ensure initialization
    await notificationPlugin.show(
      id, 
      title, 
      body, 
      notificationDetails(),
    );
  } catch (e) {
    print('Error showing notification: $e');
  }
}
  //On tapping notification
}
