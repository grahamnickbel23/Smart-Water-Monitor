import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myapp/pages/A.%20Introdunction/welcome%20pages/landing_page.dart';
import 'package:myapp/pages/B.%20Home%20Page/darling_page.dart';
import 'package:myapp/services/detabase_services.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  _AuthGateState createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  // definign instances for local detabase
  final database = MyDatabase();
  late Future<Map<String, dynamic>> _initData;

  // get all deta
  Future<Map<String, dynamic>> _initialize() async {
    final callCount = await database.readData('callCount');
    final user = FirebaseAuth.instance.currentUser;
    return {
      'callCount': int.tryParse(callCount ?? '') ?? 0,
      'user': user,
    };
  }

  @override
  void initState() {
    super.initState();
    _initData = _initialize();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: _initData,
      builder: (context, snapshot) {
        // handel error for delay in loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // hadle error for error from firebase
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // heading
                const Text(
                  'An Error Occured',
                  style: TextStyle(color: Colors.black, fontSize: 25),
                  textAlign: TextAlign.center,
                ),
                // error message
                Text(
                  'Error: ${snapshot.error}',
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                )
              ],
            )),
          );
        }

        // get defining veriable
        final int callCount = snapshot.data!['callCount'];
        final User? user = snapshot.data!['user'];

        // logic for UI building
        if (user != null && callCount >= 2) {
          return const DarlingPage();
        } else {
          return const LandingPage();
        }
      },
    );
  }
}
