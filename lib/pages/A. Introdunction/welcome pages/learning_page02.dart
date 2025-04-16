import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:myapp/components/my_button.dart';
import 'package:myapp/pages/A.%20Introdunction/welcome%20pages/learning_page03.dart';

class LearningPage02 extends StatefulWidget {
  const LearningPage02({super.key});

  @override
  State<LearningPage02> createState() => _LearningPage02State();
}

class _LearningPage02State extends State<LearningPage02> {
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
              'What do I need to do ?',
              textAlign: TextAlign.center,
              style: TextStyle(
                color:Color.fromARGB(255, 90, 88, 88),
                fontSize: 30,
              ),
            ),

            // animation for learning page 02
            Lottie.asset('assets/jason/Women with laptop Animation.json',
              width: 300,
              height: 300,
            ),

            // What do I need to do ?
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'when you get notification, please connect the external plug to the socket and press the power switch on app',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontStyle: FontStyle.italic,
                  color: Color.fromARGB(255, 70, 67, 67),
                ),
              ),
            ),

            // next button
            const SizedBox(height: 35),

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
                                builder: (context) => const LearningPage03())),
                        print('Button has pressed'),
                        
                        // unnder active devolopment , feature not working, Digitally singed on 10th April 2025, 22:55
                        // // notification permission
                        // requestNotificationPermission()
                      })
          ],
        ),
      ),
    );
  }
}
