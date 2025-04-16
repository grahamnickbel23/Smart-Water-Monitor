#include <WiFi.h>
#include <Firebase_ESP_Client.h>
// Provide the token generation process info.
#include <addons/TokenHelper.h>


// Firebase credentials
#define API_KEY "AIzaSyCl1aMwPJcV-juRuxHP6Q11WVPOz1TyMwI"  // Found in Firebase Console -> Project Settings -> Web API Key
#define FIREBASE_PROJECT_ID "water-controlling"  // Found in Firebase Console -> Project Settings
#define USER_EMAIL "esp32@meachine.com"  // Used for authentication
#define USER_PASSWORD "Dipan@123"

FirebaseData fbdo;
FirebaseAuth auth;
FirebaseConfig config;

void setupFirebase(){
  Serial.println("Initializing Firebase...");

  // Set API Key
  config.api_key = API_KEY;

  // Set authentication credentials
  auth.user.email = USER_EMAIL;
  auth.user.password = USER_PASSWORD;

  // Set Database URL (VERY IMPORTANT)
  config.database_url = "https://water-controlling-default-rtdb.firebaseio.com/";

    /* Assign the callback function for the long running token generation task */
    config.token_status_callback = tokenStatusCallback; // see addons/TokenHelper.h

  // Large data transmission may require larger RX buffer, otherwise connection issue or data read time out can be occurred.
    fbdo.setBSSLBufferSize(4096 /* Rx buffer size in bytes from 512 - 16384 */, 1024 /* Tx buffer size in bytes from 512 - 16384 */);

  // Initialize Firebase
  Firebase.begin(&config, &auth);
  Firebase.reconnectWiFi(true);

  Serial.println("Firebase Connected!");
  
  // Check if authentication is successful
  if (auth.token.uid != "") {  // Check if the user UID is available
    Serial.println("Firebase authentication successful");
  } else {
    Serial.print("Firebase authentication failed: ");
    Serial.println(config.signer.signupError.message.c_str());
  }
}