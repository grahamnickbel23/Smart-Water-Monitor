import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:myapp/pages/C.%20Motor%20Page/C.%20motor%20control/components/control_pannel.dart';
import 'package:myapp/pages/C.%20Motor%20Page/C.%20motor%20control/nothing_pannel.dart';

class MotorControl extends StatefulWidget {
  @override
  State<MotorControl> createState() => _MotorControlState();
}

class _MotorControlState extends State<MotorControl> {
  DatabaseReference database = FirebaseDatabase.instance.ref();
  int powerStatus = 0;
  int waterLevel = 0;

  @override
  void initState() {
    super.initState();
    _activateListeners();
  }

  // listener for core power button function
  void _activateListeners() {
    // listener for power status
    database.child('POWER_STSTUS').onValue.listen((event) {
      final dynamic powerVal = event.snapshot.value;
      setState(() {
        powerStatus = powerVal.hashCode;
      });
    });
  }

@override
Widget build(BuildContext context) {
  return Opacity(
    opacity: powerStatus == 0 ? 0.5 : 1.0, // Reduce opacity when inactive
    child: powerStatus != 0 ? ControlPannel() : NothingPannel(),
  );
}
}
