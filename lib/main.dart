import 'package:firebase_core/firebase_core.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:myapp/services/internet_cheaker_service.dart';
import 'package:myapp/pages/A.%20Introdunction/Authentication/components/auth_gate.dart';
import 'package:myapp/services/user_tracking_services.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:myapp/components/my_notification.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize notifications
  MyNotification notification = MyNotification();
  await notification.isInitializesNotification();

  // cheack Iternet (under active devolopment, currently not working. Digitally singnd on 11th April 2025)
  InternetCheckerService.initialize();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context)
          .copyWith(textScaler: const TextScaler.linear(1.0)),
      child: const LifecycleHandler(
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            body: AuthGate(),
          ),
        ),
      ),
    );
  }
}
