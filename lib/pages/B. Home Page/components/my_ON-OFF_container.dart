import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:myapp/components/my_notification.dart';

class MyContainer extends StatefulWidget {
  // define all veriable
  final String heading;

  const MyContainer({super.key, required this.heading});

  @override
  State<MyContainer> createState() => _MyContainerState();
}

class _MyContainerState extends State<MyContainer> {
  // detabase reference (for new feature)
  final database = FirebaseDatabase.instance.ref();
  int ledStatus = 0; // veriable for led status
  bool ledValue = false; // deciding veriable for switch
  int val = 100;
  bool meachineStatus = false;  // deciding veriable for Turn OFF / ON

  @override
  void initState() {
    super.initState();
    _activateListeners();
  }

  void _activateListeners() {
    // Listen for LED_STATUS changes to update UI
    database.child('LED_STATUS').onValue.listen((event) {
      final dynamic ledStatusValue = event.snapshot.value;
      debugPrint("LED STATUS received: $ledStatusValue");
      setState(() {
        ledStatus = ledStatusValue.hashCode;
        ledValue = ledStatus != 0;
      });
    });

    // Listen for ESP32 confirmation via MACHINE_POWER
    database.child('/Feedback/MACHINE_POWER').onValue.listen((event) {
      final dynamic motorPowerStatus = event.snapshot.value;
      debugPrint("Machine POWER received: $motorPowerStatus");
      setState(() {
        val = motorPowerStatus.hashCode;
        debugPrint("Machine POWER Status Changed: $val");

        // color chnage logic for on off pannel
        if (val == 0) {
          meachineStatus = false;
          debugPrint("Machine Support:$meachineStatus");
        } else {
          meachineStatus = true;
          debugPrint("Machine Support:$meachineStatus");
        }
      });

      // notification for motor connection
      _triggerNotification(val);
    });
  }

  /* we have make this complex arrengemnt due to the fact that we have used hashcode and 
  it don't convert into 1 for 1 in RTDB but in 1160 or any random number but for 0 
  it alawyes will be 0 so our main logic centured arround 0 not 1. 
  singed on 16:38 4th April 2025 */

  void _triggerNotification(int newVal) {
    MyNotification notification = MyNotification();
    notification.showNotification(
      title: !(newVal == 0) ? 'Machine Started' : 'Machine Stopped',
      body: !(newVal == 0)
          ? 'Machine has started running in the background'
          : 'Machine has been turned off',
    );
  }

  // Initial Color
  Color secondContainerColor = Colors.orange;

  void updateLEDStatus(bool newValue) async {
    // local detabase refacrafce (actually can't modify it as it was desgined erlier and then we have no lan for additional fleature)
    DatabaseReference ref = FirebaseDatabase.instance.ref();

    try {
      await ref.update({"LED_STATUS": newValue ? 1 : 0});
      print("LED_STATUS updated to ${newValue ? 1 : 0}");
    } catch (e) {
      print("Error updating LED_STATUS: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              // fix the size of the container
              width: double.infinity,
              // get the border
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.transparent,
                    width: 2,
                  ),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25)),
              child: Column(
                children: [
                  const SizedBox(height: 5),
                  // get the heading
                  SizedBox(
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        widget.heading,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 23),
                      ),
                    ),
                  ),
                  // get the switch and ON / OFF function
                  SwitchListTile(
                    value: ledValue,
                    onChanged: (bool newValue) {
                      print("Switch pressed: $newValue");

                      updateLEDStatus(newValue); // Update Firebase
                    },
                    title: const Text(
                      'Press to turn ON',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
          ),
          //get another conatiner
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Container(
                width: double.infinity,
                height: 27,
                decoration: BoxDecoration(
                  color: meachineStatus ? Colors.green : Colors.orange,
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15)),
                ),
                child: Center(
                  child: Text(
                    meachineStatus ? 'Turned ON' : 'Turned OFF',
                    style: const TextStyle(color: Colors.white, fontSize: 15),
                  ),
                )),
          )
        ],
      ),
    );
  }
}
