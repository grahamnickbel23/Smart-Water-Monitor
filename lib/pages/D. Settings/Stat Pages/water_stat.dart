import 'package:flutter/material.dart';
import 'package:myapp/pages/D.%20Settings/Stat%20Pages/components/water_sensor.dart';

class WaterStat extends StatelessWidget {
  const WaterStat({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Water Data History', style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.redAccent,
          bottom: const TabBar(
            indicatorColor: Colors.white,
            labelColor: Colors.white, // selected tab text/icon color
            unselectedLabelColor: Color(0xFFFFC1CC), // soft pink that matches redAccent
            tabs: [
              Tab(text: 'Sensor 01', icon: Icon(Icons.water)),
              Tab(text: 'Sensor 02', icon: Icon(Icons.water)),
              Tab(text: 'Sensor 03', icon: Icon(Icons.water)),
            ],
          ),
        ),
        backgroundColor: Colors.grey[200],
        body: const TabBarView(
          children: [
            WaterSensor(Datapath: "Sensor_01_waterLevel"),
            WaterSensor(Datapath: "Sensor_02_waterLevel"),
            WaterSensor(Datapath: "Sensor_03_waterLevel")
          ],
        ),
      ),
    );
  }
}
