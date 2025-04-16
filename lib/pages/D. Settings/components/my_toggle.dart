import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class MyToggle extends StatefulWidget {
  // define veriables
  final String text;
  final String filePathInFirebase;

  const MyToggle({
    super.key,
    required this.text,
    required this.filePathInFirebase
    });

  @override
  State<MyToggle> createState() => _MyToggleState();
}

class _MyToggleState extends State<MyToggle> {
  // databse refarance & veriable declaration
  final database = FirebaseDatabase.instance.ref();
  bool forcedInput = false;

  @override
  void initState() {
    super.initState();
    _activateListeners();
  }

  // listner
  void _activateListeners() {
    // Listen for forced Data Upload changes to update UI
    database.child(widget.filePathInFirebase).onValue.listen((event) {
      final dynamic ledStatusValue = event.snapshot.value;
      debugPrint("Admin Action Data received: $ledStatusValue");
      setState(() {
        // setting state for initialization of toggled switch
        int forcedData = ledStatusValue.hashCode;
        if (forcedData == 0) {
          forcedInput = false;
        } else {
          forcedInput = true;
        }
      });
    });
  }

  // chnage data in firebase RTDB
  void _updateForcedData(bool val) async {
    // database update oparation
    try {
      await database.update({widget.filePathInFirebase: val ? 1 : 0});
    } catch (e) {
      print("Error updating Admin Data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        // dynamic width of container
        width: double.infinity * 0.8,
        // decoration of the container
        decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(15)),
        // center widget inside container to arrage stuff at center
        child: Center(
          // main toggle with padding of 5 for vertical
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            // main toggle button
            child: SwitchListTile(
              // initial toggle value
              value: forcedInput,
              onChanged: (bool newValue) {
                // to make switch toggle
                setState(() {
                  forcedInput = newValue;
                });
                // database oparation
                _updateForcedData(newValue);
                // debug print
                debugPrint("Toggle button has pressed: $forcedInput");
              },
              title: Text(
                widget.text,
                textAlign: TextAlign.left,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 19,
                ),
              ),
            ),
          ),
        ));
  }
}
