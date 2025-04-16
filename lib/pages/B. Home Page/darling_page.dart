import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:myapp/pages/B.%20Home%20Page/components/my_ON-OFF_container.dart';
import 'package:myapp/pages/B.%20Home%20Page/components/my_drawer.dart';
import 'package:myapp/pages/B.%20Home%20Page/components/my_meater.dart';
import 'package:myapp/components/my_notification.dart';
import 'package:myapp/pages/D.%20Settings/Stat%20Pages/waterData_computed.dart';
import 'package:myapp/pages/D.%20Settings/Stat%20Pages/weatherData_computed.dart';

// Add the StatefulWidget class definition
class DarlingPage extends StatefulWidget {
  const DarlingPage({Key? key}) : super(key: key);

  @override
  _DarlingPageState createState() => _DarlingPageState();
}

class _DarlingPageState extends State<DarlingPage> {
  final database = FirebaseDatabase.instance.ref();
  String waterLevel = "0%";
  String humidity = "0%";
  String temperature = "0";
  int powerStatus = 0;
  int lastNotifiedLevel = 0;

  @override
  void initState() {
    super.initState();
    _activateListeners();
  }

  void _activateListeners() {
    // Water Level Listener
    database.child('WATER_LEVEL').onValue.listen((event) {
      final dynamic description = event.snapshot.value;
      debugPrint("New water level received: $description");
      setState(() {
        // to convert decimal figure to whole number
        final roundedValue = double.parse(description.toString()).round();
        waterLevel = roundedValue.toString();
      });

      // code for notification upon increasing water level
      int currentLevel =
          int.tryParse(description.toString().replaceAll('%', '')) ??
              0; // Remove the '%' sign and convert to integer

      // Check if water level is above 50% and has increased by at least 1%
      if (currentLevel > 50 && currentLevel > lastNotifiedLevel) {
        // Only notify for each 1% increase
        if (currentLevel - lastNotifiedLevel >= 1) {
          MyNotification notification = MyNotification();
          notification.showNotification(
            title: 'Water Level Alert',
            body: 'Water level has increased to $currentLevel%',
          );

          // Update the last notified level
          lastNotifiedLevel = currentLevel;
        }
      }
    });

    // Humidity Listener
    database.child('HUMIDITY').onValue.listen((event) {
      final dynamic humidityValue = event.snapshot.value;
      debugPrint("New humidity received: $humidityValue");
      setState(() {
        humidity = humidityValue.toString();
      });
    });

    // Temperature Listener
    database.child('TEMPERATURE').onValue.listen((event) {
      final dynamic tempValue = event.snapshot.value;
      debugPrint("New temperature received: $tempValue");
      setState(() {
        temperature = tempValue.toString();
      });
    });

    // power connecter listner & Notification
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
              body: 'Meachine has been connected to power Source');
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        title: const Text(
          'Home Page',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.redAccent,
      ),
      drawer: const MyDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 15),
              child: MyContainer(heading: 'See Machine Status'),
            ),
            const SizedBox(height: 20),

            // function fot water Level
            GestureDetector(
              onDoubleTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const WaterdataComputed()));
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3),
                child: MyMeater(waterLevel: waterLevel),
              ),
            ),

            // function for AI prediction is here
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13),
              child: Container(
                width: double.infinity,
                height: 75,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.transparent, width: 2),
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15))),
                child: const Column(
                  children: [
                    // text inside
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Icon(Icons.star_rounded),
                        ),
                        // Difaarence Between two element
                        SizedBox(width: 4),
                        Text(
                          'AI ',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              color: Color.fromARGB(255, 48, 44, 44)),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 175),
                          child: Text(
                            'prediction',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 48, 44, 44)),
                          ),
                        ),
                      ],
                    ),
                    // Predicted test
                    Text(
                      'water will be overflowed with in next 1d 14hrs',
                      style: TextStyle(
                          color: Color.fromARGB(255, 90, 84, 84),
                          fontSize: 16,
                          fontStyle: FontStyle.italic),
                    )
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // for two another container
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // humidity
                  GestureDetector(
                    onDoubleTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const WeatherdataComputed()));
                    },
                    child: Container(
                      width: 175,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border:
                              Border.all(color: Colors.transparent, width: 2),
                          borderRadius: BorderRadius.circular(15)),
                      // get text
                      child: Center(
                        child: Column(
                          children: [
                            // humidity reading
                            const Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: Text(
                                'Humidity (%)',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                            // humidity reading
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 3, left: 10, bottom: 3),
                              child: Text(
                                humidity,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 55,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),

                  // temparature
                  GestureDetector(
                    onDoubleTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const WeatherdataComputed()));
                    },
                    child: Container(
                      width: 175,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border:
                              Border.all(color: Colors.transparent, width: 2),
                          borderRadius: BorderRadius.circular(15)),
                      // get text
                      child: Center(
                        child: Column(
                          children: [
                            // humidity reading
                            const Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: Text(
                                'Temp. (C)',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                            // temprature reading
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 3, left: 10, bottom: 3),
                              child: Text(
                                temperature,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 55,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
