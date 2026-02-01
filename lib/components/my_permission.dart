import 'package:permission_handler/permission_handler.dart';

Future<void> requestNotificationPermission() async {
  var status = await Permission.notification.status;
  if (!status.isGranted) {
    var result = await Permission.notification.request();
    if (result.isGranted) {
      print("Notification permission granted");
    } else {
      print("Notification permission denied");
    }
  } else {
    print("Notification permission already granted");
  }
}
