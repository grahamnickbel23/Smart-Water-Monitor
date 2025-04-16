import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class InternetCheckerService {
  static void initialize() {
    InternetConnection().onStatusChange.listen((InternetStatus status) {
      if (status == InternetStatus.disconnected) {
        // Show No Internet Dialog
        if (!(Get.isDialogOpen ?? false)) {
          Get.dialog(
            AlertDialog(
              title: const Text(
                "No Internet",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              content: const Text(
                "Please check your internet connection.",
                style: TextStyle(fontSize: 17),
                 textAlign: TextAlign.center
                ),
              actionsAlignment: MainAxisAlignment.center,
              actions: [
                SizedBox(
                  width: 250,
                  child: ElevatedButton(
                    onPressed: () => Get.back(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black, // button color
                      foregroundColor: Colors.white, // text color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text("OK",style: TextStyle(fontSize: 20),),
                  ),
                ),
              ],
            ),
            barrierDismissible: false,
          );
        }
      } else {
        // Close the dialog if internet is back
        if (Get.isDialogOpen ?? false) {
          Get.back();
        }
      }
    });
  }
}
