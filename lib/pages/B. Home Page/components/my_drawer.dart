import 'package:flutter/material.dart';
import 'package:myapp/pages/A.%20Introdunction/Authentication/components/auth_gate.dart';
import 'package:myapp/pages/A.%20Introdunction/Authentication/components/auth_service.dart';
import 'package:myapp/pages/D.%20Settings/settings_page.dart';
import 'package:myapp/pages/accounts_page.dart';
import 'package:myapp/pages/C.%20Motor%20Page/modified_motor.dart';
import 'package:myapp/pages/privecy_policy.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    AuthService _authService = AuthService();

    return Drawer(
      backgroundColor: Colors.grey[600],
      child: Center(
        child: Column(
          children: [
            // get the logo
            DrawerHeader(
                child: Center(
              child: Container(
                width: 150,
                height: 150,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.grey),
                child: const Center(
                  child: Icon(
                    Icons.person,
                    size: 100,
                    color: Colors.white,
                  ),
                ),
              ),
            )),

            // Home list tile
            Padding(
              padding: const EdgeInsets.only(top: 55, left: 65),
              child: ListTile(
                title: const Text(
                  'H O M E ',
                  style: TextStyle(color: Colors.white),
                ),
                leading: const Icon(
                  Icons.home,
                  color: Colors.white,
                ),
                onTap: () {
                  // Pop the drawer
                  Navigator.pop(context);
                },
              ),
            ),

            // Motor list tile
            Padding(
              padding: const EdgeInsets.only(left: 60),
              child: ListTile(
                title: const Text(
                  'M O T O R  ',
                  style: TextStyle(color: Colors.white),
                ),
                leading: const Icon(
                  Icons.electric_bolt,
                  color: Colors.white,
                ),
                onTap: () {
                  // Pop the drawer
                  Navigator.pop(context);

                  // Navigate to motor page
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ModifiedMotor(),
                      ));
                },
              ),
            ),

            // Settingd list tile
            Padding(
              padding: const EdgeInsets.only(left: 60),
              child: ListTile(
                title: const Text(
                  'S E T T I N G S  ',
                  style: TextStyle(color: Colors.white),
                ),
                leading: const Icon(
                  Icons.settings,
                  color: Colors.white,
                ),
                onTap: () {
                  // Pop the drawer
                  Navigator.pop(context);

                  // Navigate to settings page
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SettingsPage(),
                      ));
                },
              ),
            ),

            // Account list tile
            Padding(
              padding: const EdgeInsets.only(left: 60),
              child: ListTile(
                title: const Text(
                  'A C C O U N T  ',
                  style: TextStyle(color: Colors.white),
                ),
                leading: const Icon(
                  Icons.person,
                  color: Colors.white,
                ),
                onTap: () {
                  // Pop the drawer
                  Navigator.pop(context);
                  // Navigate to Accounts page
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AccountsPage(),
                      ));
                },
              ),
            ),

            // Privecy Policy list tile
            Padding(
              padding: const EdgeInsets.only(left: 60),
              child: ListTile(
                title: const Text(
                  'Privecy Policy  ',
                  style: TextStyle(color: Colors.white),
                ),
                leading: const Icon(
                  Icons.security,
                  color: Colors.white,
                ),
                onTap: () {
                  // Pop the drawer
                  Navigator.pop(context);
                  // Navigate to Privecy Policy page
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PrivacyPolicy(),
                      ));
                },
              ),
            ),

            // Logout list tile
            Padding(
              padding: const EdgeInsets.only(top: 90, left: 60),
              child: ListTile(
                title: const Text(
                  'L O G O U T   ',
                  style: TextStyle(color: Colors.white),
                ),
                leading: const Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
                onTap: () {
                  // Pop the drawer
                  Navigator.pop(context);
                  // log out
                  _authService.logout(context);
                  // Navigate to Auth Gate
                  if (_authService.callCount == 0) {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AuthGate()),
                        (route) => false
                      );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
