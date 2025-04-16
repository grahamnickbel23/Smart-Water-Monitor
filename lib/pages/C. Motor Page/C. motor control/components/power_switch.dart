import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:myapp/components/my_notification.dart';

class PowerSwitch extends StatefulWidget {
  const PowerSwitch({super.key});

  @override
  State<PowerSwitch> createState() => _PowerSwitchState();
}

class _PowerSwitchState extends State<PowerSwitch> {
  DatabaseReference database = FirebaseDatabase.instance.ref();
  int motorStatus = 0; // 0 = OFF, 1 = ON
  final LocalAuthentication auth = LocalAuthentication();

  // Function to authenticate user before performing actions
  Future<bool> _authenticateUser() async {
    bool isAvailable = await auth.canCheckBiometrics;
    if (!isAvailable) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Biometric authentication is not available.")),
      );
      return false;
    }

    try {
      bool isAuthenticated = await auth.authenticate(
        localizedReason: 'Scan your Finger to proceed',
        options: const AuthenticationOptions(stickyAuth: true),
      );

      if (!isAuthenticated) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Authentication failed!")),
        );
      }
      return isAuthenticated;
    } catch (e) {
      print("Biometric authentication error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Authentication error occurred!")),
      );
      return false;
    }
  }

  // Function to turn motor ON/OFF
  void _motorController() async {
    print('Motor Controller has been pressed');

    bool authenticated = await _authenticateUser();
    if (!authenticated) return; // Stop execution if authentication fails

    MyNotification notification = MyNotification();

    if (motorStatus == 0) {
      await database.update({"MOTOR": 1});
      notification.showNotification(
        title: 'Motor Started',
        body: 'Motor has started pumping out water',
      );

      setState(() {
        motorStatus = 1;
      });

      // Turn off motor after 10 seconds automatically
      Future.delayed(Duration(seconds: 10), () async {
        await database.update({"MOTOR": 0});
        notification.showNotification(
          title: 'Motor Stopped',
          body: 'Motor stopped after 10 seconds. Press power again to turn it on.',
        );

        setState(() {
          motorStatus = 0;
        });
      });
    } else {
      await database.update({"MOTOR": 0});
      notification.showNotification(
        title: 'Motor Stopped',
        body: 'Motor has stopped as you turned it off.',
      );

      setState(() {
        motorStatus = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 75,
      height: 75,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(100),
      ),
      child: IconButton(
        onPressed: _motorController,
        icon: Icon(
          Icons.power_settings_new,
          size: 50,
          color: motorStatus == 0 ? Colors.red : Colors.green,
        ),
      ),
    );
  }
}
