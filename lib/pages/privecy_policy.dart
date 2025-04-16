import 'package:flutter/material.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Privacy Policy',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.redAccent,
      ),
      backgroundColor: Colors.grey[200],
      body: const SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Privacy Policy',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'We value your privacy and are committed to protecting your personal data. This Privacy Policy outlines how we collect, use, and safeguard your information.',
            ),
            SizedBox(height: 15),
            Text(
              '1. Information We Collect',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(
              """- Personal information such as name, email, and contact details.
- Usage data including app interactions and preferences.
- Device information such as IP address and device type.""",
            ),
            SizedBox(height: 15),
            Text(
              '2. How We Use Your Information',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(
              """- To provide and improve our services.
- To communicate with you regarding updates or support.
- To ensure security and prevent fraud.""",
            ),
            SizedBox(height: 15),
            Text(
              '3. Sharing of Information',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(
              """- We do not sell your personal data.
- Information may be shared with third-party services for analytics and security.
- Legal obligations may require us to disclose information.""",
            ),
            SizedBox(height: 15),
            Text(
              '4. Data Security',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(
              'We implement strict security measures to protect your data against unauthorized access or loss.',
            ),
            SizedBox(height: 15),
            Text(
              '5. Changes to This Policy',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(
              'We may update this Privacy Policy from time to time. Please review it periodically.',
            ),
            SizedBox(height: 15),
            Text(
              '6. Contact Us',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(
              'If you have any questions about this Privacy Policy, feel free to contact us at dipanlahiriofficial207@gmail.com.',
            ),
          ],
        ),
      ),
    );
  }
}
