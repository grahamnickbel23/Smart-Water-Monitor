import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
 final String text;
  final num width;
  final double height;
  final double padding;
  final void Function()? function;

  const MyButton({
    super.key,
    required this.text,
    required this.width,
    required this.height,
    required this.padding,
    required this.function,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: padding),
        child: Container(
          width:
              MediaQuery.of(context).size.width * width, // 85% of screen width
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: EdgeInsets.symmetric(vertical: height),
          alignment: Alignment.center,
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
