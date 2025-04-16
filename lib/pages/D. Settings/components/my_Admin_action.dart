import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:myapp/components/my_notification.dart';
import 'package:myapp/pages/D.%20Settings/components/app_history.dart';
import 'package:myapp/pages/D.%20Settings/components/my_toggle.dart';
import 'package:myapp/pages/D.%20Settings/components/otp_number.dart';

class MyAdminAction extends StatefulWidget {
  const MyAdminAction({super.key});

  @override
  State<MyAdminAction> createState() => _MyAdminActionState();
}

class _MyAdminActionState extends State<MyAdminAction> {
  // detabase reference (for new reset notification)
  final database = FirebaseDatabase.instance.ref();
  int resetStatus = 10; // veriable for reset status
  bool resetValue = false; // deciding veriable for notification

  @override
  void initState() {
    super.initState();
    _activateListeners();
  }

  void _activateListeners() {
    // Listen for RESET_STATUS changes to update UI
    database.child('/Feedback/MOTOR_RESET').onValue.listen((event) {
      final dynamic resetStatusValue = event.snapshot.value;
      debugPrint("RESET STATUS received: $resetStatusValue");
      setState(() {
        resetStatus = resetStatusValue.hashCode;
        // notification decider
        if (resetStatus == 0) {
          resetValue = false;
        } else {
          resetValue = true;
        }

        // notification for mechine reset
        if (resetValue) {
          _triggerNotification();
        }
      });
    });
  }

  void _triggerNotification() {
    MyNotification notification = MyNotification();
    notification.showNotification(
      title: 'Machine Reset',
      body: 'Machine has been pogrmically reset',
    );
  }

  @override
  Widget build(BuildContext) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(15)),
        child: const Column(
          children: [
            SizedBox(height: 15),

            // heading of Admin Action
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    child: Text(
                      'Admin Action Pannel',
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 15),

            // Forced Reset
            MyToggle(
                text: "Forced Restart:",
                filePathInFirebase: "/Maintance/RESET_ESP"
              ),

            SizedBox(height: 10),

            // Forced Motor
            MyToggle(
              text: "Forced Motor", 
              filePathInFirebase: "/MOTOR"
            ),

            SizedBox(height: 10),

            // App Running
            MyToggle(
              text: "App Running", 
              filePathInFirebase: "/APP_RUNNING"
            ),

            SizedBox(height: 10),

            // otp number chnaged
            OtpNumber(),

            SizedBox(height: 10),

            // App History
            AppHistory()
          ],
        ));
  }
}
