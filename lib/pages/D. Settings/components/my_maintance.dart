import 'package:flutter/material.dart';
import 'package:myapp/pages/D.%20Settings/Stat%20Pages/water_stat.dart';
import 'package:myapp/pages/D.%20Settings/Stat%20Pages/weather_stat.dart';
import 'package:myapp/pages/D.%20Settings/components/components/sensor_heading.dart';
import 'package:myapp/pages/D.%20Settings/components/components/sensor_data.dart';

class MyMaintance extends StatefulWidget {
  const MyMaintance({super.key});

  @override
  State<MyMaintance> createState() => _MyMaintanceState();
}

class _MyMaintanceState extends State<MyMaintance> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey.shade300, borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          const SizedBox(height: 12),

          // heading of maintance
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  child: Text(
                    'Miantance Data',
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 5),

          // DHT11 Sensor 01

          GestureDetector(
            onDoubleTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const WeatherStat()));
            },
            child: const Column(
              children: [
                SensorHeading(text: "DHT11 Sensor 01"),
                SensorData(
                  text: "Humidity :",
                  filePathInFirebase: "/Maintance/1st_DHT11/HUMIDITY",
                  symbol: "%",
                  topRadiusLeft: 0,
                  topRadiusRight: 15,
                  bottomRadiusLeft: 0,
                  bottomRadiusRight: 0,
                ),
                SensorData(
                  text: "Temperature :",
                  filePathInFirebase: "/Maintance/1st_DHT11/TEMPRATURE",
                  symbol: "°C",
                  topRadiusLeft: 0,
                  topRadiusRight: 0,
                  bottomRadiusLeft: 15,
                  bottomRadiusRight: 15,
                ),
              ],
            ),
          ),

          const SizedBox(height: 25),

          // DHT11 sensor 02

          GestureDetector(
            onDoubleTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const WeatherStat()));
            },
            child: const Column(
              children: [
                SensorHeading(text: "DHT11 sensor 02"),
                SensorData(
                    text: "Humidity :",
                    filePathInFirebase: "/Maintance/2nd_DHT11/HUMIDITY",
                    symbol: "%",
                    topRadiusLeft: 0,
                    topRadiusRight: 15,
                    bottomRadiusLeft: 0,
                    bottomRadiusRight: 0),
                SensorData(
                    text: "Temperature :",
                    filePathInFirebase: "/Maintance/2nd_DHT11/TEMPRATURE",
                    symbol: "°C",
                    topRadiusLeft: 0,
                    topRadiusRight: 0,
                    bottomRadiusLeft: 15,
                    bottomRadiusRight: 15),
              ],
            ),
          ),

          const SizedBox(height: 25),

          // waterlevel sensor

          GestureDetector(
            onDoubleTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const WaterStat()));
            },
            child: const Column(
              children: [
                // over all heading
                SensorHeading(text: "Water Level Sensors"),
                // main content
                SensorData(
                    text: "Sensor - 01:",
                    filePathInFirebase:
                        "/Maintance/Water_Level_Sensor/1st_sensor",
                    symbol: "%",
                    topRadiusLeft: 0,
                    topRadiusRight: 15,
                    bottomRadiusLeft: 0,
                    bottomRadiusRight: 0),
                SensorData(
                    text: "Sensor - 02:",
                    filePathInFirebase:
                        "/Maintance/Water_Level_Sensor/2nd_sensor",
                    symbol: "%",
                    topRadiusLeft: 0,
                    topRadiusRight: 0,
                    bottomRadiusLeft: 0,
                    bottomRadiusRight: 0),
                SensorData(
                    text: "Sensor - 03:",
                    filePathInFirebase:
                        "/Maintance/Water_Level_Sensor/3rd_sensor",
                    symbol: "%",
                    topRadiusLeft: 0,
                    topRadiusRight: 0,
                    bottomRadiusLeft: 0,
                    bottomRadiusRight: 0),
                SensorData(
                    text: "Avarage from ESP32:",
                    filePathInFirebase: "/WATER_LEVEL",
                    symbol: "%",
                    topRadiusLeft: 0,
                    topRadiusRight: 0,
                    bottomRadiusLeft: 15,
                    bottomRadiusRight: 15),
              ],
            ),
          ),

          const SizedBox(height: 25),

          //HC--SR04 Ultrssound sensor data

          SensorData(
              text: "HC-SR04:",
              filePathInFirebase: "/Maintance/ULTRASOUND",
              symbol: "cm",
              topRadiusLeft: 15,
              topRadiusRight: 15,
              bottomRadiusLeft: 15,
              bottomRadiusRight: 15),
        ],
      ),
    );
  }
}
