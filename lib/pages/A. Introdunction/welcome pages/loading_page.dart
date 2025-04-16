import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:myapp/pages/A.%20Introdunction/Authentication/login_page.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  
  @override
  void initState() {
    super.initState();
    // Navigate to the next page after 2 seconds
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPage(),
        ), // Change this to your next page
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // loading...
            const Text(
              'Loading....',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color.fromARGB(255, 88, 86, 86),
                fontSize: 30,
              ),
            ),

            // loading animation
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.only(right: 35),
              child: Lottie.asset(
                  'assets/jason/Connecting to server animation.json',
                  width: 250,
                  height: 250),
            ),

            // text
            const SizedBox(height: 25),
            const Text(
              'connecting to server...',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color.fromARGB(255, 54, 51, 51),
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
