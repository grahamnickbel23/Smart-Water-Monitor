import 'package:permission_handler/permission_handler.dart';

Future<void> requestNotificationPermission() async {
  var status = await Permission.notification.status;
  if (!status.isGranted) {
    var result = await Permission.notification.request();
    if (result.isGranted) {
      print("
    } else {
      print("
    }
  } else {
    print("
  }
}
