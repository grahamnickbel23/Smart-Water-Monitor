import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class WaterMeter extends StatefulWidget {
  const WaterMeter({super.key});

  @override
  State<WaterMeter> createState() => _WaterMeterState();
}

class _WaterMeterState extends State<WaterMeter> {
  DatabaseReference database = FirebaseDatabase.instance.ref();

  String fluidLevel = '0%';
  int waterLevel = 0;

  @override
  void initState() {
    super.initState();
    _activateListeners();
  }

  void _activateListeners() {
    // listener for water Level
    database.child('WATER_LEVEL').onValue.listen((event) {
      final dynamic waterVal = event.snapshot.value;
      setState(() {
        // additoanl arrengement to round datavase value to nearest possible round number
        final double parsedVal = double.parse(waterVal.toString());
        fluidLevel = parsedVal.toString();
        waterLevel = parsedVal.round();
      });
    });
  }

  Color _getOuterCircleColor(String waterLevel) {
    String cleanValue = waterLevel.replaceAll('%', '').trim();
    double level = double.tryParse(cleanValue) ?? 0.0;
    level = level.clamp(0.0, 100.0);

    if (level <= 50) {
      return Color.lerp(
          const Color.fromARGB(255, 2, 252, 11), Colors.orange, level / 50)!;
    } else {
      return Color.lerp(Colors.orange, Colors.red, (level - 50) / 50)!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 125,
      height: 125,
      decoration: BoxDecoration(
          shape: BoxShape.circle, color: _getOuterCircleColor(fluidLevel)),
      child: Center(
        child: Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(100)),
          child: Padding(
            padding: EdgeInsets.only(top: 23, left: 5),
            child: Text(
              "$fluidLevel%",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 40),
            ),
          ),
        ),
      ),
    );
  }
}
