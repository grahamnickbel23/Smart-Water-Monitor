import 'package:flutter/material.dart';
import 'package:myapp/pages/C.%20Motor%20Page/B.%20battery%20info/battery_info.dart';

class Debug extends StatelessWidget {
  const Debug({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 500,
          height: 300,
          child: BatteryInfo(),
        ),
      ),
    );
  }
}
