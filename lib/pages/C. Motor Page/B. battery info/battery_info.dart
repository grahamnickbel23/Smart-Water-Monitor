import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:myapp/components/my_dialog.dart';
import 'package:myapp/pages/C.%20Motor%20Page/B.%20battery%20info/components/linerPogress_bar.dart';
import 'package:myapp/pages/C.%20Motor%20Page/B.%20battery%20info/components/pogressBar_battery.dart';

class BatteryInfo extends StatefulWidget {
  const BatteryInfo({super.key});

  @override
  State<BatteryInfo> createState() => _BatteryInfoState();
}

class _BatteryInfoState extends State<BatteryInfo> {
  final database = FirebaseDatabase.instance.ref();
  int powerStatus = 0;
  int dilogVeriable = 0;

  @override
  void initState() {
    super.initState();
    _activateListeners();
  }

  void _activateListeners() {
    // power status listener
    database.child('POWER_STSTUS').onValue.listen((event) {
      final dynamic powerVal = event.snapshot.value;
        setState(() {
          powerStatus = powerVal.hashCode;
        });
    });

    // battery level listener
    database.child('BATTERY_LEVEL').onValue.listen((event) {
      final dynamic batteryVal = event.snapshot.value;
        setState(() {
          dilogVeriable = batteryVal.toInt();
          _popupcaller(); // Call popup when battery level updates
        });
    });
  }

  void _popupcaller() {
    if (dilogVeriable <= 15 && powerStatus == 0) {
      Future.delayed(const Duration(seconds: 2), () {
        MyDialog.show(
          context,
          titleText: 'Battery Low',
          contentText: 'Machine battery is low, please connect to power',
          buttonText: 'OK',
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity * 0.8,
      height: 200,
      decoration: BoxDecoration(
        color: powerStatus == 0 ? Colors.orangeAccent : Colors.green,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          const SizedBox(height: 7),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Battery status',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                Text(
                  powerStatus != 0 ? 'Battery charging' : '',
                  style: const TextStyle(fontSize: 15, color: Colors.white),
                ),
              ],
            ),
          ),
          const SizedBox(height: 7),
          Container(
            width: 400,
            height: 156,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.grey.shade200,
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 15, left: 15),
                  child: LinerpogressBar(),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 5),
                  child: PogressbarBattery(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
