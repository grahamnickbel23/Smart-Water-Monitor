import 'package:flutter/material.dart';
import 'package:myapp/pages/B.%20Home%20Page/home_page.dart';

class AppHistory extends StatelessWidget {
  const AppHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return // 1st version of the app
        GestureDetector(
      onDoubleTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const HomePage()));
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
                'First App Version',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
