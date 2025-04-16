import 'package:flutter/material.dart';
import 'package:myapp/pages/D.%20Settings/Stat%20Pages/components/sensor_history.dart';

class WeatherStat extends StatelessWidget {
  const WeatherStat({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Weather Data History', style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.redAccent,
          bottom: const TabBar(
            indicatorColor: Colors.white,
            labelColor: Colors.white, // selected tab text/icon color
            unselectedLabelColor: Color(0xFFFFC1CC), // soft pink that matches redAccent
            tabs: [
              Tab(text: 'DHT11 Sensor 01', icon: Icon(Icons.cloud)),
              Tab(text: 'DHT11 Sensor 02', icon: Icon(Icons.cloud)),
            ],
          ),
        ),
        backgroundColor: Colors.grey[200],
        body: const TabBarView(
          children: [
            Sensor01Data(
              Humidity_Datapath: "Sensor_01_Humidity",
              Temp_Datapath: "Sensor_01_Temperature",
            ),
            Sensor01Data(
              Humidity_Datapath: "Sensor_02_Humidity",
              Temp_Datapath: "Sensor_02_Temperature",
            ),
          ],
        ),
      ),
    );
  }
}
