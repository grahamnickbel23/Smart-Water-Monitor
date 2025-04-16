import 'package:flutter/material.dart';

class SensorHeading extends StatefulWidget {
  // define input text
  final String text;
  const SensorHeading({super.key, required this.text});

  @override
  State<SensorHeading> createState() => _SensorHeadingState();
}

class _SensorHeadingState extends State<SensorHeading> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity * 0.8,
        height: 40,
        decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(15)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                width: 200,
                height: 40,
                decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(15),
                    )),
                child: Column(
                  children: [
                    SizedBox(height: 5),
                    Text(
                      widget.text,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                  ],
                )),
          ],
        ));
  }
}
