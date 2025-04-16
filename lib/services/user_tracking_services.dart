import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

/// Service class to update APP_RUNNING status in Firebase RTDB
class UserTrackingPage {
  final DatabaseReference _databaseRef = FirebaseDatabase.instance.ref();

  // Set APP_RUNNING to 1 when app is opened
  Future<void> setAppRunning() async {
    try {
      await _databaseRef.child("/APP_RUNNING").set(1);

      // Set APP_RUNNING to 0 if the app disconnects unexpectedly
      _databaseRef.child("/APP_RUNNING").onDisconnect().set(0);
    } catch (e) {
      print("Error setting APP_RUNNING to 1: $e");
    }
  }

  // Set APP_RUNNING to 0 when app is closed or paused
  Future<void> setAppClosed() async {
    try {
      await _databaseRef.child("/APP_RUNNING").set(0);
    } catch (e) {
      print("Error setting APP_RUNNING to 0: $e");
    }
  }
}

/// Lifecycle handler widget to track app open/close state
class LifecycleHandler extends StatefulWidget {
  final Widget child;

  const LifecycleHandler({super.key, required this.child});

  @override
  State<LifecycleHandler> createState() => _LifecycleHandlerState();
}

class _LifecycleHandlerState extends State<LifecycleHandler> with WidgetsBindingObserver {
  final UserTrackingPage _presenceService = UserTrackingPage();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _presenceService.setAppRunning(); // When app launches
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _presenceService.setAppClosed(); // When app is closed
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _presenceService.setAppRunning();
    } else if (state == AppLifecycleState.paused ||
               state == AppLifecycleState.inactive ||
               state == AppLifecycleState.detached) {
      _presenceService.setAppClosed();
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
