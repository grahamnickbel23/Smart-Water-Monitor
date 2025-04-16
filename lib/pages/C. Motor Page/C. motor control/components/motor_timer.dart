import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class MotorTimer extends StatefulWidget {
  const MotorTimer({super.key});

  @override
  State<MotorTimer> createState() => _MotorTimerState();
}

class _MotorTimerState extends State<MotorTimer> {
  DatabaseReference database = FirebaseDatabase.instance.ref();
  int seconds = 10;
  int motorStatus = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _activateListeners();
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (seconds > 0) {
        setState(() {
          seconds -= 1;
        });
      } else {
        timer.cancel(); // Stop when timer reaches 0
      }
    });
  }

  void stopTimer() {
    _timer?.cancel();
    setState(() {
      seconds = 10; // Reset countdown when motor is off
    });
  }

  void _activateListeners() {
    database.child('MOTOR').onValue.listen((event) {
      final dynamic powerVal = event.snapshot.value;

      setState(() {
        motorStatus = (powerVal ?? 0) as int;
      });

      if (motorStatus != 0) {
        if (_timer == null || !_timer!.isActive) {
          startTimer(); // Start timer only if not already running
        }
      } else {
        stopTimer(); // Stop timer and reset when motor is off
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel timer when widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9, // Dynamic width
      height: 55,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 15),
            child: Text(
              'Motor will stop in:',
              style: TextStyle(fontSize: 20),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Text(
              '$seconds s',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: motorStatus != 0 ? Colors.red : Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
