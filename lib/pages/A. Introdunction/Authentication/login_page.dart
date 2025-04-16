import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:myapp/components/my_button.dart';
import 'package:myapp/components/my_dialog.dart';
import 'package:myapp/components/my_textfield.dart';
import 'package:myapp/pages/A.%20Introdunction/Authentication/components/auth_service.dart';
import 'package:myapp/pages/D.%20Settings/components/components/otp_diolog.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  // defining text controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // deining auth instances
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Log in title
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      'Log In',
                      style: TextStyle(
                        fontSize: 35,
                        color: Colors.grey.shade800,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),

                  // Animation
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Lottie.asset(
                      'assets/jason/Auth Animation.json',
                      width: 300,
                      height: 300,
                    ),
                  ),

                  // Email field
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: MyTextfield(
                      text: 'Email',
                      obscureText: false,
                      textInputType: TextInputType.emailAddress,
                      controller: emailController,
                    ),
                  ),

                  // Password field
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: MyTextfield(
                      text: 'Password',
                      obscureText: true,
                      textInputType: TextInputType.visiblePassword,
                      controller: passwordController,
                    ),
                  ),

                  // Login button
                  const SizedBox(height: 20),
                  MyButton(
                    text: 'Log In',
                    width: 0.85,
                    height: 25,
                    padding: 10,
                    function: () {
                      // for password log in
                      _authService.login(context, emailController.text,
                          passwordController.text);
                    },
                  ),

                  // Register now section
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // not member hidden switch
                      GestureDetector(
                          onDoubleTap: () {
                            // dilog for otp number change
                            OtpDiolog.show(context);
                          },
                          child: Text(
                            'Not a member?',
                            style: TextStyle(color: Colors.grey.shade600),
                          )),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: () {
                          debugPrint("Register now has been pressed");
                          // error message for registration
                          MyDialog.show(
                            context,
                            titleText: 'Registration Failed',
                            contentText:
                                'New user registration is currently unavailable. Our Teams are working to make it available soon',
                            buttonText: 'login',
                          );
                        },
                        child: const Text(
                          'Register now',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
