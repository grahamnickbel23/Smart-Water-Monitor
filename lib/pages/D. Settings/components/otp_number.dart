import 'package:flutter/material.dart';
import 'package:myapp/pages/D.%20Settings/components/components/otp_diolog.dart';

class OtpNumber extends StatelessWidget {
  const OtpNumber({super.key});

  @override
  Widget build(BuildContext context) {
    return 
        GestureDetector(
      onDoubleTap: () {
        OtpDiolog.show(context);
      },
      child: Container(
        // dynamic width of container
        width: double.infinity * 0.8,
        height: 60,
        // decoration of the container
        decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(15)),
        // center widget inside container to arrage stuff at center
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 15),
              child: Text(
                'OTP Phone Number',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
