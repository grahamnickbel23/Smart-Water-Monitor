import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class MyLoading {
  static void show(BuildContext context) {
    showDialog(
      context: context,
      //barrierDismissible: false, // Prevents dismissing by tapping outside
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.6,
              height: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Loading...
                  const SizedBox(height: 15),
                  Text(
                    'Loading',
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.grey.shade800,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  
                  // Loading Animation
                  Container(
                    width: 230,
                    height: 230,
                    child: Lottie.asset(
                      'assets/jason/Loading Animation.json',
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static void hide(BuildContext context) {
    Navigator.pop(context);
  }
}
