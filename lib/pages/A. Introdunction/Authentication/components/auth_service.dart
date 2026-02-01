import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:myapp/components/my_dialog.dart';
import 'package:myapp/components/my_loading.dart';
import 'package:myapp/components/my_permission.dart';
import 'package:myapp/pages/A.%20Introdunction/Authentication/otp_page.dart';
import 'package:myapp/pages/B.%20Home%20Page/darling_page.dart';
import 'package:myapp/services/detabase_services.dart';

class AuthService {
  // definign veriables
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final MyDatabase _database = MyDatabase();
  String PhoneNumber = '9126375827'; // default number for otp
  int _callCount = 0;
  String result = '10';
  int get callCount => _callCount;

  // password based log in
  Future<void> login(
      BuildContext context, String email, String password) async {
    try {
      // Loading while authentication is going on
      MyLoading.show(context);

      await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      // 1st seving value of _callCount as initial veriable
      result = _callCount.toString();
      // save final computed value here
      initialSevings() async {
        await _database.writeData('callCount', result);
        String? val = await _database.readData('callCount');
        print('Local Database: $val');
      }

      // local database oparation
      await initialSevings() ;

      // saving defualt number for otp verification
      /* the reason for the cheaking is if there was any chnage in default number by 
      admin in that chase too default number should not be saved in local detabase*/
      String ? auth = await _database.readData('settings');
      if (auth != '69'){
        await _database.writeData('phoneNumber', PhoneNumber);
      }

      // increase the veriable count by one and save in local storage
      await register();
      result = _callCount.toString();
      // save final computed value here
      operation() async {
        await _database.writeData('callCount', result);
        String? val = await _database.readData('callCount');
        print('Local Database: $val');
      }

      // local database oparation
      await operation();

      // After successful login, trigger OTP verification
      await otpLogIn(context);
    } on FirebaseAuthException catch (e) {
      // pop loading
      Navigator.pop(context);

      // Show error dialog
      MyDialog.show(
        context,
        titleText: 'login failed !!',
        contentText: e.message ?? 'An error occurred',
        buttonText: 'Redo',
      );
    }
  }

  // otp based log in (calling otp)
  Future<void> otpLogIn(BuildContext context) async {
    try {
      // get otp verification number from local databse
      String callNumber = await _database.readData('phoneNumber') ?? '';

      // otp log in user
      await _auth.verifyPhoneNumber(
          phoneNumber: '+91' + callNumber,
          verificationCompleted: (PhoneAuthCredential credential) async {},
          verificationFailed: (FirebaseAuthException e) {
            MyDialog.show(context,
                titleText: 'something went wrong',
                contentText: e.code,
                buttonText: 'OK');
          },
          codeSent: (String vid, int? token) {
            // poping loading dialog
            Navigator.pop(context);

            // Navigetting to otp page
            Get.to(OtpPage(vid: vid));
          },
          codeAutoRetrievalTimeout: (vid) {});
    } catch (e) {
      MyDialog.show(
        context,
        titleText: 'incorrect otp',
        contentText: e.toString(),
        buttonText: 'Redo',
      );
    }
  }

  // submiting otp and moving to homepage or setings page
  Future<void> signIn(
      BuildContext context, String code, String verificationCode) async {
    try {
      // Loading while authentication is going on
      MyLoading.show(context);

      // Create a PhoneAuthCredential with the verification code
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationCode, smsCode: code);
      await _auth.signInWithCredential(credential);

      // Hide loading before navigation
      MyLoading.hide(context);

      // increase the veriable count by one and save in local storage
      await register();
      result = _callCount.toString();
      // save final computed value here
      oparation() async {
        await _database.writeData('callCount', result);
        String? val = await _database.readData('callCount');
        print('Local Database: $val');
      }

      // calling database oparation
      await oparation();

      // Navigate to HomePage after successful login
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => DarlingPage()),
          (route) => false);

      // ask for notification permission after homepage log in
      Future.delayed(const Duration(seconds: 2), () {
        requestNotificationPermission();
      });

      print("Sign-in successful!");
    } on FirebaseAuthException catch (e) {
      MyDialog.show(
        context,
        titleText: 'incorrect otp',
        contentText: e.message ?? 'An error occurred',
        buttonText: 'Redo',
      );
      print("Error during sign-in: $e");
    }
  }

  // Function to log out user
  Future<void> logout(context) async {
    try {
      // log out
      await _auth.signOut();
      print('signOut');

      // decrease vale to 0
      _callCount = 0;
      result = _callCount.toString();
      oparation() async {
        await _database.writeData('callCount', result);
        String? val = await _database.readData('callCount');
        print('Local Database: $val');
      }

      // calling database oparation
      await oparation();
    } on FirebaseAuthException catch (e) {
      // Errore Message
      MyDialog.show(
        context,
        titleText: 'failed to sign out',
        contentText: e.message ?? 'An error occurred',
        buttonText: 'Redo',
      );
    }
  }

  // Functio n to confirm password based registration
  register() async {
    // get the value from local database 1st
    String? val = await _database.readData('callCount');
    int _factor = int.tryParse(val ?? '') ?? 0;
    print("register initial value: $_factor");
    //now calculating
    _callCount = _factor + 1;
    print("register Executed: $_callCount");
  }
}
