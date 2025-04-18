import 'package:flutter/material.dart';
import 'package:myapp/pages/E.%20Accounts/full_Image_page.dart';
import 'package:url_launcher/url_launcher.dart';

class AccountsPage extends StatelessWidget {
  const AccountsPage({super.key});

  // Function to launch URLs
  void _launchURL(String url) async {
    if (!await launchUrl(Uri.parse(url),
        mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accounts', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.redAccent,
      ),
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 15),
            GestureDetector(
              onDoubleTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const FullImagePage()),
                );
              },
              child: const CircleAvatar(
                radius: 100,
                backgroundImage:
                    AssetImage('assets/pictures/My Face Photo.jpg'),
              ),
            ),
            const SizedBox(height: 10),

            // Row of social/email icons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // linkdin image with link of my profile
                IconButton(
                  icon: Image.network(
                    'https://cdn-icons-png.flaticon.com/512/174/174857.png',
                    width: 45,
                    height: 45,
                  ),
                  onPressed: () {
                    _launchURL('https://www.linkedin.com/in/dipan-lahiri/');
                  },
                ),

                // github image with link of my profile
                const SizedBox(width: 15),
                IconButton(
                  icon: Image.network(
                    'https://cdn-icons-png.flaticon.com/512/25/25231.png',
                    width: 45,
                    height: 45,
                  ),
                  onPressed: () {
                    _launchURL('https://github.com/grahamnickbel23');
                  },
                ),

                // gitlab image with link of ESP32 codebase
                const SizedBox(width: 15),
                IconButton(
                  icon: Image.network(
                    'https://cdn-icons-png.flaticon.com/512/5968/5968853.png', // GitLab logo
                    width: 45,
                    height: 45,
                  ),
                  onPressed: () {
                    _launchURL(
                        'https://gitlab.com/web-devolopment1/water-management'); // Dummy link
                  },
                ),

                // gmail image with link of my email
                const SizedBox(width: 15),
                IconButton(
                  icon: Image.network(
                    'https://cdn-icons-png.flaticon.com/512/732/732200.png',
                    width: 45,
                    height: 45,
                  ),
                  onPressed: () {
                    _launchURL('mailto:dipanlahiri207official@gmail.com');
                  },
                ),
              ],
            ),

            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                width: MediaQuery.of(context).size.width *
                    0.95, // 85% of screen width
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // devoloper Identity
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Devoloper Name:',
                            style: TextStyle(
                                fontSize: 19,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Dipan Lahiri',
                            style: TextStyle(fontSize: 19, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    // project description
                    Text(
                      'Project Description',
                      style: TextStyle(
                          fontSize: 19,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    // details project description
                    Text(
                      'This app was developed by Dipan Lahiri between Jan 2025 and April 2025.\n\n'
                      'It\'s an ESP32-based project that notifies users if the water level crosses a certain threshold — '
                      'especially useful for detecting overflow issues in single-door fridges.',
                      style: TextStyle(fontSize: 17, color: Colors.black87),
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(height: 20),
                    // project details
                    Text(
                      'Project Details',
                      style: TextStyle(
                          fontSize: 19,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    // main text of project details
                    Text(
                      'This project was intiated as an small project in between break of two semester of 1st year of B.Tech at UEM. Project was started at the 2nd week of Jan 2025. \n'
                      'Initialy project was though to be completed in 2 weeks but with increasing number of fleature and complexity of the devolopemtent it take almost 3 monts. \n'
                      'This is uptill now leargest project devoloped by my with dedicated 3 monts of regrous coading and numerious faliure. \n \n'
                      'For Info, if user get stuck in login page and can not log in due to otp number related issue user can tap not a member 6 or 7 times. \n'
                      'this will result opening of a popup that then can be used to chnage otp number',
                      style: TextStyle(fontSize: 17, color: Colors.black87),
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(height: 20),
                    // technical details
                    Text(
                      'Technical Details',
                      style: TextStyle(
                          fontSize: 19,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    // main text
                    Text(
                      'Front-End app is devoloped using Flutter Framework and backend was devoloped using Firebase as it is no code backend so as a new bee I do not need to spend time learning backend devolopment. \n '
                      'In harwere as main mainagement devise ESP32 of DevkitV1 been used and may sensors. \n',
                      style: TextStyle(fontSize: 17, color: Colors.black87),
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(height: 05),
                    Text(
                      'Mianly 3 capacitor based water level sensor , 1 HC-SR04 ultrasound sensor and 2 DHT-11 sensor been used. Reason for uses of multiple sensor to avoid error due to sensor faliure \n',
                      style: TextStyle(fontSize: 17, color: Colors.black87),
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}