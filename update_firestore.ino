// Function to send data to Firestore
void sendDataToFirestore(double temperature, double humidity , double waterLevel) {
    String documentPath = "Weather Data/L5Lc5dh4Vp6j1T8ES9h3";  // Fixed document path

    FirebaseJson content;
    content.set("fields/temperature/doubleValue", String(temperature).c_str());
    content.set("fields/humidity/doubleValue", String(humidity).c_str());
    content.set("fields/ waterLevel/doubleValue", String(waterLevel).c_str());
    
    // Firestore will set the timestamp automatically
    content.set("fields/timestamp/timestampValue", "REQUEST_TIME");

    if (Firebase.Firestore.createDocument(&fbdo, FIREBASE_PROJECT_ID, "", documentPath.c_str(), content.raw())) {
        Serial.println("Weather Data Uploaded to Firestore Successfully!");
    } else {
        Serial.print("Firestore Error: ");
        Serial.println(fbdo.errorReason());
    }
}
