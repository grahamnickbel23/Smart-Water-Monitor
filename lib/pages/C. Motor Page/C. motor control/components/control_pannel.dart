import 'package:firebase_database/firebase_database.dart';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:myapp/pages/B.%20Home%20Page/components/my_meater.dart';
import 'package:myapp/pages/C.%20Motor%20Page/C.%20motor%20control/components/motor_timer.dart';
import 'package:myapp/pages/C.%20Motor%20Page/B.%20battery%20info/components/padNothing_pannel.dart';
import 'package:myapp/pages/C.%20Motor%20Page/C.%20motor%20control/components/power_switch.dart';
import 'package:myapp/pages/C.%20Motor%20Page/C.%20motor%20control/components/water_meter.dart';

class ControlPannel extends StatefulWidget {
  const ControlPannel({super.key});

  @override
  State<ControlPannel> createState() => _ControlPannelState();
}

class _ControlPannelState extends State<ControlPannel>
    with SingleTickerProviderStateMixin {
  DatabaseReference database = FirebaseDatabase.instance.ref();
  int waterLevel = 0;
  int motorStatus = 0;

  late final AnimationController _animationController;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _activateListeners();

    // Animation Controller for the water wave effect
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _animation = Tween<double>(
      begin: 0,
      end: 2 * math.pi,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.linear,
    ));

    _animationController.repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _activateListeners() {
    // listener for water Level
    database.child('WATER_LEVEL').onValue.listen((event) {
      final dynamic waterVal = event.snapshot.value;
      if (waterVal != null) {
        setState(() {
          waterLevel =
              int.tryParse(waterVal.toString().replaceAll('%', '')) ?? 0;
        });
      }
    });
    // listner for motor status
    database.child('MOTOR').onValue.listen((event) {
      final dynamic motorVal = event.snapshot.value;
      if (motorVal != null) {
        setState(() {
          motorStatus = motorVal.hashCode;
        });
      }
    });
  }

  double _getWaterLevel() {
    // Normalize water level value to a percentage (assuming max 100)
    return (waterLevel.clamp(0, 100)) / 100;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity * 0.8,
      height: MediaQuery.of(context).size.height * 0.42,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 7, right: 200),
            child: Text(
              'Motor Control',
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
          ),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                double outerWidth = constraints.maxWidth;
                double outerHeight = constraints.maxHeight;

                return Center(
                  child: Container(
                    width: outerWidth * 0.95,
                    height: outerHeight * 0.9,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Stack(
                      children: [
                        // Water animation effect
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: CustomPaint(
                            size: Size(outerWidth * 0.95, outerHeight * 0.9),
                            painter: WaterPainter(
                              waterLevel: _getWaterLevel(),
                              animation: _animation,
                            ),
                          ),
                        ),
                        // Power button & percentage of water level
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(height: 15),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    PowerSwitch(),
                                    WaterMeter(),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 15),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                child: motorStatus != 0 ? MotorTimer() : PadnothingPannel(),
                              ),
                              const SizedBox(height: 10)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
