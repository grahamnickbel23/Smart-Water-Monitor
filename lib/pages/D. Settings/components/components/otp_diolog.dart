import 'package:flutter/material.dart';
import 'package:myapp/components/my_button.dart';
import 'package:myapp/services/detabase_services.dart';

class OtpDiolog {
  static final _database = MyDatabase();
  static String val = 'Loading...';
  static const String settings = '69';

  static void show(
    BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            final TextEditingController _phoneController =
                TextEditingController();

            // Fetch data on load
            _database.readData('phoneNumber').then((value) {
              if (value != null && value != val) {
                setState(() {
                  val = value;
                });
              }
            });

            return AlertDialog(
              title: const Text(
                "OTP verification Number",
                textAlign: TextAlign.center,
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Current Number',
                        style: TextStyle(fontSize: 15),
                      ),
                      Text(
                        val,
                        style: const TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _phoneController,
                    keyboardType: TextInputType.number,
                    maxLength: 10,
                    decoration: const InputDecoration(
                      hintText: "Enter new 10-digit number",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
              actions: [
                MyButton(
                  text: "submit",
                  width: 150,
                  height: 12,
                  padding: 5,
                  function: () async {
                    String newPhone = _phoneController.text.trim();

                    if (newPhone.length == 10 &&
                        RegExp(r'^[0-9]+$').hasMatch(newPhone)) {
                      await _database.writeData('phoneNumber', newPhone);
                      // otp upload verifer from settings
                      await _database.writeData('settings', settings);
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content:
                                Text("Please enter a valid 10-digit number")),
                      );
                    }
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}
