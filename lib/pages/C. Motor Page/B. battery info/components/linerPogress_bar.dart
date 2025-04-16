import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class LinerpogressBar extends StatefulWidget {
  const LinerpogressBar({super.key});

  @override
  State<LinerpogressBar> createState() => _LinerpogressBarState();
}

class _LinerpogressBarState extends State<LinerpogressBar> {
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
    // battery level listner
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
      width: 200,
      height: 100,
      decoration: BoxDecoration(color: Colors.transparent),
      child: Center(
          child: Column(
        children: [
          const Text(
            'Here is the battery level',
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
          const SizedBox(height: 10),
          LinearPercentIndicator(
            lineHeight: 40,
            percent: batteryLavel * 0.01,
            progressColor: powerStatus == 0 
            ? (colorChange <= 15) ? Colors.red : Colors.deepPurple
            : Colors.green,
            backgroundColor: powerStatus == 0
                ? (colorChange <= 15) ? Colors.red.shade200 : Colors.deepPurple.shade200
                : Colors.lightGreenAccent,
            barRadius: const Radius.circular(10),
          )
        ],
      )),
    );
  }
}
