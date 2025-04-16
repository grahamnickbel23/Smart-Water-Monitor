import 'package:flutter/material.dart';
import 'package:myapp/components/my_button.dart';

class MyDialog {
  static void show(
    BuildContext context,
    {required String titleText, 
    required String contentText,
    required String buttonText,
    }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
           titleText,
            textAlign: TextAlign.center,
          ),
          content: Text(
            contentText,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 15,
              color: Colors.black,
            ),
          ),
          actions: [
            MyButton(
                text: buttonText,
                width: 150,
                height: 12,
                padding: 5,
                function: () {
                  Navigator.pop(context);
                })
          ],
        );
      },
    );
  }
}
