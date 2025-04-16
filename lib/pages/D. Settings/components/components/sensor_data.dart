import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class SensorData extends StatefulWidget {
  // define input text
  final String text;
  final String filePathInFirebase;
  final String symbol;
  final double topRadiusLeft;
  final double topRadiusRight;
  final double bottomRadiusLeft;
  final double bottomRadiusRight;
  // requred text
  const SensorData(
      {super.key,
      required this.text,
      required this.filePathInFirebase,
      required this.symbol,
      required this.topRadiusLeft,
      required this.topRadiusRight,
      required this.bottomRadiusLeft,
      required this.bottomRadiusRight
      });

  @override
  State<SensorData> createState() => _WeatherComponentState();
}

class _WeatherComponentState extends State<SensorData> {
  // get database refarance
  final database = FirebaseDatabase.instance.ref();
  String valueDB = "0";

  @override
  void initState() {
    super.initState();
    _activateListeners();
  }

  void _activateListeners() {
    // General listener from Firebase RTDB
    database.child(widget.filePathInFirebase).onValue.listen((event) {
      final dynamic generalValue = event.snapshot.value;
      debugPrint("New value received: $generalValue");
      setState(() {
        valueDB = generalValue.toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // dynamic width for diffrent devices
      width: double.infinity * 0.8,
      height: 65,
      // decoration of the container
      decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(widget.topRadiusLeft),
            topRight: Radius.circular(widget.topRadiusRight),
            bottomLeft: Radius.circular(widget.bottomRadiusLeft),
            bottomRight: Radius.circular(widget.bottomRadiusRight),
          )),
      // main body
      child: Center(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          // text for the widget
          Text(
            widget.text,
            style: const TextStyle(fontSize: 20, color: Colors.black),
          ),
          // value for firebase RTDB
          Text(
            "$valueDB ${widget.symbol}",
            style: const TextStyle(
                fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
          )
        ]),
      )),
    );
  }
}
