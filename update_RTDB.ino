// Function to send weather & water level data to Realtime Database
void sendDataToRealtimeDB(float temperature, float humidity, float waterLevel) {
  
  // temperature
  float roundedTemp = round( temperature * 10) / 10.0;
  if (Firebase.RTDB.setFloat(&fbdo, "/TEMPERATURE", roundedTemp)) {
    Serial.println("Temp Data Uploaded Successfully");
    Serial.println("Data saved to: " + fbdo.dataPath());
  } else {
    Serial.println("FAILED (temp): " + fbdo.errorReason());
  }

  // Humidity
  float roundedHumidity = round( humidity * 10) / 10.0;
  if (Firebase.RTDB.setFloat(&fbdo, "/HUMIDITY", roundedHumidity)) {
    Serial.println("Humidity Data Uploaded Successfully");
    Serial.println("Data saved to: " + fbdo.dataPath());
  } else {
    Serial.println("FAILED (humidity): " + fbdo.errorReason());
  }

  // water level
  float roundedWaterLevel = round(  waterLevel * 10) / 10.0;
  if (Firebase.RTDB.setFloat(&fbdo, "/WATER_LEVEL", roundedWaterLevel)) {
    Serial.println("WaterLevel Data Uploaded Successfully");
    Serial.println("Data saved to: " + fbdo.dataPath());
  } else {
    Serial.println("FAILED (water Level): " + fbdo.errorReason());
  }
}

// Function to upload motor pin power to firebase
void sendPowerStatus(int POWER_STSTUS){
    // Power Status
  if (Firebase.RTDB.setInt(&fbdo, "/POWER_STSTUS", POWER_STSTUS)) {
    Serial.println("Power Status Data Uploaded Successfully");
    Serial.println("Data saved to: " + fbdo.dataPath());
  } else {
    Serial.println("FAILED (Power Status): " + fbdo.errorReason());
  }
}

// Function to read a specific value from the Realtime Database
String readValueFromRealtimeDB(const String &key) {
  String path = key; // Construct the path dynamically

  if (Firebase.RTDB.getString(&fbdo, path.c_str())) {
    Serial.print("Value of ");
    Serial.print(key);
    Serial.print(": ");
    Serial.println(fbdo.stringData());
    return fbdo.stringData();
  } else {
    Serial.print("Failed to read ");
    Serial.print(key);
    Serial.print(": ");
    Serial.println(fbdo.errorReason());
    return "";
  }
}