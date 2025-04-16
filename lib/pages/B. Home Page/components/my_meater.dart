import 'package:flutter/material.dart';
import 'dart:math' as math;

class WaterPainter extends CustomPainter {
  final double waterLevel;
  final double waveHeight;
  final double waveSpeed;
  final Animation<double> animation;

  WaterPainter({
    required this.waterLevel,
    this.waveHeight = 10.0,
    this.waveSpeed = 1.0,
    required this.animation,
  }) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue.withOpacity(0.7)
      ..style = PaintingStyle.fill;

    // Create clipping path for circle
    final clipPath = Path()
      ..addOval(Rect.fromLTWH(0, 0, size.width, size.height));
    canvas.clipPath(clipPath);

    final path = Path();
    final centerY = size.height * (1 - waterLevel);

    path.moveTo(0, size.height);
    path.lineTo(0, centerY);

    // Create wave effect
    for (double i = 0; i <= size.width; i++) {
      final wave1 = math.sin(
              (i / size.width * 2 * math.pi) + (animation.value * waveSpeed)) *
          waveHeight;
      final wave2 = math.sin((i / size.width * 4 * math.pi) +
              (animation.value * waveSpeed * 1.5)) *
          waveHeight *
          0.1;
      path.lineTo(i, centerY + wave1 + wave2);
    }

    path.lineTo(size.width, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(WaterPainter oldDelegate) => true;
}

class MyMeater extends StatefulWidget {
  final String waterLevel;
  const MyMeater({super.key, required this.waterLevel});

  @override
  State<MyMeater> createState() => _MyMeaterState();
}

class _MyMeaterState extends State<MyMeater>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    // Initialize the animation
    _animation = Tween<double>(
      begin: 0,
      end: 2 * math.pi,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.linear,
    ));

    // Start the animation
    _animationController.repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

// we are definig container here
//will be pulled latter in below portion
  Widget container() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Water Level', // Updated to use the variable
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Current Status',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  double _getWaterLevelValue() {
    String cleanValue = widget.waterLevel.replaceAll('%', '').trim();
    double level = double.tryParse(cleanValue) ?? 0.0;
    return (level / 100.0).clamp(0.0, 1.0);
  }

  Color _getOuterCircleColor(String waterLevel) {
    String cleanValue = waterLevel.replaceAll('%', '').trim();
    double level = double.tryParse(cleanValue) ?? 0.0;
    level = level.clamp(0.0, 100.0);

    if (level <= 50) {
      return Color.lerp(
          const Color.fromARGB(255, 2, 252, 11), Colors.orange, level / 50)!;
    } else {
      return Color.lerp(Colors.orange, Colors.red, (level - 50) / 50)!;
    }
  }

  Color _getInnerCircleColor(String waterLevel) {
    String cleanValue = waterLevel.replaceAll('%', '').trim();
    double level = double.tryParse(cleanValue) ?? 0.0;
    level = level.clamp(0.0, 100.0);

    // Interpolate between grey and white based on water level
    return Color.lerp(Colors.grey.shade500, Colors.white, level / 100)!;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          // main container
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.transparent,
                  width: 2,
                ),
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)),
              ),
              //a row containing text and Outer circle
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // text
                  container(),
                  // Outer circle
                  Padding(
                    padding: const EdgeInsets.only(top: 8, right: 8),
                    child: Container(
                      width: 175,
                      height: 175,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _getOuterCircleColor(widget.waterLevel),
                        border: Border.all(
                          color: Colors.transparent,
                          width: 2,
                        ),
                      ),
                      // Inner circle
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _getInnerCircleColor(widget.waterLevel),
                            ),
                            // code for water
                            child: Stack(
                              children: [
                                CustomPaint(
                                  size: const Size(150, 150),
                                  painter: WaterPainter(
                                    waterLevel: _getWaterLevelValue(),
                                    animation: _animation,
                                  ),
                                ),
                                // code for text
                                Center(
                                  child: AnimatedSwitcher(
                                    duration:
                                        const Duration(microseconds: 1200),
                                    transitionBuilder: (child, animation) {
                                      return ScaleTransition(
                                        scale: animation,
                                        child: child,
                                      );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10, left: 10),
                                      child: Text(
                                        "${widget.waterLevel.trim()}%",
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 70,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
