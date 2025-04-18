import 'package:flutter/material.dart';
import 'package:myapp/pages/C.%20Motor%20Page/B.%20battery%20info/battery_info.dart';
import 'package:myapp/pages/C.%20Motor%20Page/A.%20electric_connection.dart';
import 'package:myapp/pages/C.%20Motor%20Page/C.%20motor%20control/motor_control.dart';

class ModifiedMotor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade400,
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: const Text(
          'Motor',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Emplty space
              SizedBox(height: MediaQuery.of(context).size.height * 0.0015),
              const SizedBox(height: 15),
              // electric connection status
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: ElectricConnection(),
              ),
              const SizedBox(height: 15),
              // batery status
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: BatteryInfo(),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: MotorControl(),
              ),

              const SizedBox(height: 30)
            ],
          ),
        ),
        )
      ),
    );
  }
}
