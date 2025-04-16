import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:myapp/components/my_button.dart';
import 'package:myapp/pages/A.%20Introdunction/Authentication/components/auth_service.dart';
import 'package:pinput/pinput.dart';

class OtpPage extends StatefulWidget {
  final String vid;
  const OtpPage({super.key, required this.vid});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  var code = '';
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade400,
        body: SafeArea(
            child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 15),
                      // Intro text
                      Text(
                        'OTP Authentication',
                        style: TextStyle(
                          fontSize: 35,
                          color: Colors.grey.shade800,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                        ),
                      ),

                      // Animation
                      const SizedBox(height: 15),
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Lottie.asset(
                          'assets/jason/Auth Animation.json',
                          width: 300,
                          height: 300,
                        ),
                      ),

                      // Textfield
                      const SizedBox(height: 25),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Pinput(
                          length: 6,
                          showCursor: true,
                          defaultPinTheme: PinTheme(
                              width: 55,
                              height: 55,
                              textStyle: const TextStyle(
                                fontSize: 30,
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Colors.grey))),
                          focusedPinTheme: PinTheme(
                              width: 55,
                              height: 55,
                              textStyle: const TextStyle(
                                fontSize: 30,
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(8),
                                  border:
                                      Border.all(color: Colors.grey.shade700))),
                          onChanged: (value) {
                            code = value;
                          },
                        ),
                      ),

                      // Verify and login button
                      const SizedBox(height: 25),
                      MyButton(
                          text: 'verify & login',
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: 25,
                          padding: 25,
                          function: () {

                            // otp verification
                            _authService.signIn(context, code, widget.vid);
                          })
                    ],
                  ),
                ))));
  }
}
