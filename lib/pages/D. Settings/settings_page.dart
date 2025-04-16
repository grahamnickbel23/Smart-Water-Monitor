import 'package:flutter/material.dart';
import 'package:myapp/pages/D.%20Settings/components/my_Admin_action.dart';
import 'package:myapp/pages/D.%20Settings/components/my_maintance.dart';
import 'package:myapp/pages/D.%20Settings/components/my_toggle.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade500,
        appBar: AppBar(
          title: const Text(
            'Settings Page',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.redAccent,
        ),
        body: const SingleChildScrollView(
          child: Column(
            children: [
              // free space
              SizedBox(height: 15),


              // froced data input toggle switch
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: MyToggle(
                  text: "Force Data Input",
                  filePathInFirebase: "/Maintance/FORCED_DATA",
                ),
              ),


              SizedBox(height: 10),


              // maintance
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: MyMaintance(),
              ),

              SizedBox(height: 15),

              // Admin Action Pannel
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: MyAdminAction(),
              ),

              SizedBox(height: 15),
            ],
          ),
        ));
  }
}
