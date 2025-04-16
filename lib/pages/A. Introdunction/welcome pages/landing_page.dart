import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:myapp/components/my_button.dart';
import 'package:myapp/pages/A.%20Introdunction/welcome%20pages/learning_page01.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // welcome text
              const Text(
                'Welcome !!',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // landing page animation
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Lottie.asset(
                  'assets/jason/Landing Page Animation.json',
                  width: 300,
                  height: 300,
                ),
              ),

              // Introductary statement
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  'Water Controller, a smart home water management system',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontStyle: FontStyle.italic,
                    color: Colors.black,
                  ),
                ),
              ),

              // Start Button
              const SizedBox(height: 25),

              MyButton(
                  text: 'Get Started',
                  width: 0.85,
                  height: 25,
                  padding: 10,
                  function:() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LearningPage01()),
                    );
                  },
              )
            ],
          ),
        ));
  }
}
