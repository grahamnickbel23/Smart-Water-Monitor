import 'package:flutter/material.dart';
import 'package:myapp/components/my_dialog.dart';

class NothingPannel extends StatelessWidget {
  const NothingPannel({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () {
        MyDialog.show(context,
            titleText: 'no power',
            contentText:
                'Please connect machine to the power source to acess the control pannel',
            buttonText: 'OK'
          );
      },
      child: Container(
          width: double.infinity * 0.8,
          height: MediaQuery.of(context).size.height * 0.42,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: const Center(
            child: Column(children: [
              const Padding(
                // Heading
                padding: EdgeInsets.only(top: 10, right: 200),
                child: Text(
                  'Motor Control',
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              ),

              // Body Text
              Padding(
                padding: EdgeInsets.only(top: 85),
                child: Text(
                  'Nothing to show Here',
                  style: TextStyle(fontSize: 25, color: Colors.black),
                ),
              ),
            ]),
          )),
    );
  }
}
