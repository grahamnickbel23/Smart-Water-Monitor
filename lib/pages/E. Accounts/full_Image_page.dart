import 'package:flutter/material.dart';
import 'package:no_screenshot/no_screenshot.dart';

class FullImagePage extends StatefulWidget {
  const FullImagePage({super.key});

  @override
  State<FullImagePage> createState() => _FullImagePageState();
}

class _FullImagePageState extends State<FullImagePage> {
  final NoScreenshot _noScreenshot = NoScreenshot.instance;

  @override
  void initState() {
    super.initState();
    _enableScreenshotBlock();
  }

  @override
  void dispose() {
    _disableScreenshotBlock();
    super.dispose();
  }

  void _enableScreenshotBlock() async {
    await _noScreenshot.screenshotOff();
  }

  void _disableScreenshotBlock() async {
    await _noScreenshot.screenshotOn();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onDoubleTap: () => Navigator.pop(context),
        child: Center(
          child: InteractiveViewer(
            child: Image.asset('assets/pictures/My Face Photo.jpg'),
          ),
        ),
      ),
    );
  }
}