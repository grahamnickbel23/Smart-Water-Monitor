import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void signOut() {
    print('Sign Out');
    FirebaseAuth.instance.signOut();
    // back to landig
  }

  void turnOn() async {
    print('ON Button has pressed');
    
    DatabaseReference ref = FirebaseDatabase.instance.ref();
    await ref.update({"LED_STATUS": 1});
  }

  void turnOff() async{
    print('OFF Button has pressed');

     DatabaseReference ref = FirebaseDatabase.instance.ref();
    await ref.update({"LED_STATUS": 0});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        title: const Text('Home Page',
            style: TextStyle(color: Colors.white, fontSize: 23)),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
              onPressed: signOut,
              icon: const Icon(
                Icons.logout,
                color: Colors.white,
              ))
        ],
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, 
        children: [
          const Text(
            'Press to turn on and off LED',
            style: TextStyle(fontSize: 20),
          ),

          // sized box
          const SizedBox(
            height: 20,
          ),

          // Container containing ON Button
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Text(
              'Press to turn LED on:',
              style: TextStyle(fontSize: 20),
            ),

            // sized Box
            const SizedBox(width: 65),

            // ON Button
            SizedBox(
              width: 105,
              height: 75,
              child: ElevatedButton(
                  onPressed: turnOn,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                  ).copyWith(
                    backgroundColor: WidgetStateProperty.resolveWith<Color>(
                        (Set<WidgetState> states) {
                      if (states.contains(WidgetState.pressed)) {
                        return Colors
                            .red; // Background color when the button is pressed
                      }
                      return Colors.white; // Default background color
                    }),
                  ),
                  child: const Text(
                    'ON',
                    style: TextStyle(fontSize: 25, color: Colors.blue),
                  )),
            )
          ]),

          // sized Box
          const SizedBox(height: 30),

          // Container containing OFF Button
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Text(
              'Press to turn LED off:',
              style: TextStyle(fontSize: 20),
            ),

            // sized Box
            const SizedBox(width: 65),

            // OFF Button
            SizedBox(
              width: 105,
              height: 75,
              child: ElevatedButton(
                  onPressed: turnOff,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                  ).copyWith(
                    backgroundColor: WidgetStateProperty.resolveWith<Color>(
                        (Set<WidgetState> states) {
                      if (states.contains(WidgetState.pressed)) {
                        return Colors
                            .red; // Background color when the button is pressed
                      }
                      return Colors.white; // Default background color
                    }),
                  ),
                  child: const Text(
                    'OFF',
                    style: TextStyle(fontSize: 25, color: Colors.blue),
                  )),
            )
          ])
        ]),
      ),
    );
  }
}
