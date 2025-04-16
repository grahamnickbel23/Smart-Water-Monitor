import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class PogressbarBattery extends StatefulWidget {
  const PogressbarBattery({super.key});

  @override
  State<PogressbarBattery> createState() => _PogressbarBatteryState();
}

class _PogressbarBatteryState extends State<PogressbarBattery> {
  DatabaseReference database = FirebaseDatabase.instance.ref();
  int powerStatus = 0;
  double batteryLavel = 0;
  int colorChange = 0;

  @override
  void initState() {
    super.initState();
    _activateListeners();
  }

  void _activateListeners() {
    database.child('BATTERY_LEVEL').onValue.listen((event) {
      final dynamic batteryVal = event.snapshot.value;
      if (batteryVal != null) {
        setState(() {
          batteryLavel = (batteryVal as num).toDouble();
          colorChange = batteryLavel.toInt();
        });
      }
    });
    // power status listner
    database.child('POWER_STSTUS').onValue.listen(
      (event) {
        final dynamic powerVal = event.snapshot.value;
        setState(() {
          powerStatus = powerVal.hashCode;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 120,
      color: Colors.transparent,
      child: Center(
        child: CircularPercentIndicator(
          radius: 55,
          lineWidth: 15,
          percent: batteryLavel * 0.01,
          progressColor: powerStatus == 0 
            ? (colorChange <= 15) ? Colors.red : Colors.deepPurple
            : Colors.green,
          backgroundColor: powerStatus == 0
              ? (colorChange <= 15) ? Colors.red.shade200 : Colors.deepPurple.shade200
              : Colors.lightGreenAccent,
          circularStrokeCap: CircularStrokeCap.round,
          center: Text(
            '${batteryLavel.toInt()}%', // Show actual percentage
            style: const TextStyle(
              fontSize: 30,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
