import 'package:flutter/material.dart';

class MotorPage extends StatelessWidget {
  const MotorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade600,
      body: Center(
        child: Column(
          children: [
            // get the connectio tab
            Padding(
              padding: const EdgeInsets.only(top: 35, left: 15, right: 15),
              child: Container(
                  width: double.infinity,
                  height: 95,
                  decoration: BoxDecoration(
                      color: Colors.orangeAccent,
                      border: Border.all(color: Colors.transparent, width: 2),
                      borderRadius: BorderRadius.circular(15)),
                  // get the text
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Center(
                      child: Text(
                        'Get the wire connected as it will be green',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  )),
            ),

            // speacing
            const SizedBox(height: 20),

            // Battery section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Container(
                  width: double.infinity,
                  height: 150,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.transparent,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(15)),

                  // heading {battery}
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 5, right: 150),
                        child: Text(
                          'Battery Status',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 25,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),

                    // row for visual battery status and percentage
                    Row(
                      // 1st visual battery status
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top:25,left: 15),
                          child: Container(
                            width: 155,
                            height: 55,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade400,
                              border: Border.all(
                                color: Colors.black,
                                width: 2,
                              )
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 25,
                                  height: 45,
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 1
                                    ),
                                    borderRadius: BorderRadius.circular(5)
                                  ),
                                ),
                                Container(
                                  width: 25,
                                  height: 45,
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 1
                                    ),
                                    borderRadius: BorderRadius.circular(5)
                                  ),
                                ),
                                Container(
                                  width: 25,
                                  height: 45,
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 1
                                    ),
                                    borderRadius: BorderRadius.circular(5)
                                  ),
                                ),
                                Container(
                                  width: 25,
                                  height: 45,
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 1
                                    ),
                                    borderRadius: BorderRadius.circular(5)
                                  ),
                                ),
                                 Container(
                                  width: 25,
                                  height: 45,
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 1
                                    ),
                                    borderRadius: BorderRadius.circular(5)
                                  ),
                                ),
                                 Container(
                                  width: 25,
                                  height: 45,
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 2
                                    ),
                                    borderRadius: BorderRadius.circular(5)
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                      // battery statys in percentage
                     
                    ),
                    ],
                  )

                  // row that would contain a battery sign and percentage
                  ),
            ),

            // specing
            const SizedBox(height: 20),

            // portion of motor
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Container(
                width: double.infinity,
                height: 300,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color:Colors.transparent
                  ),
                  borderRadius: BorderRadius.circular(15)
                ),

                // heading {Motor}
                child: const Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 5, right: 150),
                      child: Text(
                        'Motor Control',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 25,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),

                    // pumping button
                    // MyButton(
                    //   onTap:() => {
                    //     print('Button has pressed');
                    //   },
                    //   heading: 'Press to turn ON'
                    // )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
