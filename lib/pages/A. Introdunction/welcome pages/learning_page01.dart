import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:myapp/components/my_button.dart';
import 'package:myapp/pages/A.%20Introdunction/welcome%20pages/learning_page02.dart';

class LearningPage01 extends StatefulWidget {
  const LearningPage01({super.key});

  @override
  State<LearningPage01> createState() => _LearningPage01State();
}

class _LearningPage01State extends State<LearningPage01> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Welcome text
            const Text(
              'How does it work ?',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color.fromARGB(255, 94, 92, 92),
                fontSize: 30,
              ),
            ),
            // learning page 01 animation (rocket)
            Lottie.asset('assets/jason/Rocket Man Animation.json',
              width: 300,
              height: 300,
            ),
            // How does it work ?
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'app measure water level inside bucket using sensor, and upon reaching a level it sends a notification',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontStyle: FontStyle.italic,
                  color: Color.fromARGB(255, 70, 67, 67),
                ),
              ),
            ),

            // Next button
            const SizedBox(height: 20),
            MyButton(
                  text: 'Next',
                  width: 0.85,
                  height: 25,
                  padding: 10,
                  function: () => {
                        // Navigetting to next page
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LearningPage02())),
                        print('Button has pressed'),
                      })
          ],
        ),
      ),
    );
  }
}
