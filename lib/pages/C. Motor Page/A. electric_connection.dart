import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:myapp/components/my_notification.dart';

class ElectricConnection extends StatefulWidget {
  const ElectricConnection({super.key});

  @override
  State<ElectricConnection> createState() => _ElectricConnectionState();
}

class _ElectricConnectionState extends State<ElectricConnection> {
  final database = FirebaseDatabase.instance.ref();
  int powerStatus = 0;

  @override
  void initState() {
    super.initState();
    _activateListeners();
  }

  void _activateListeners() {
    // power status listner
    database.child('POWER_STSTUS').onValue.listen(
      (event) {
        final dynamic powerVal = event.snapshot.value;
        setState(() {
          powerStatus = powerVal.hashCode;
        });
        
        // notification for connecting to the power source
        if (powerStatus != 0) {
          MyNotification notification = MyNotification();
          notification.showNotification(
              title: 'Power Connected',
              body: 'Meachine has been connected to the power Source'
            );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity * 0.8,
      height: MediaQuery.of(context).size.height * 0.1635,
      decoration: BoxDecoration(
          color: powerStatus == 0 ? Colors.redAccent : Colors.blueAccent,
          //border: Border.all(color: Colors.white, width: 7),
          borderRadius: BorderRadius.circular(15)),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              powerStatus == 0
                  ? 'Please connect machine to the power source'
                  : 'connected to power source',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: powerStatus == 0 ? 18 : 20,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
