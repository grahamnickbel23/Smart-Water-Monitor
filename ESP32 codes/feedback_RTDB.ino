// Function to upload feedback response to firebase

 // power on Feedback Status
void sendFeedbackPower(int POWER){
  if (Firebase.RTDB.setInt(&fbdo, "/Feedback/MACHINE_POWER", POWER)) {
    Serial.println("Turn ON/OFF Data Uploaded Successfully");
    Serial.println("Data saved to: " + fbdo.dataPath());
  } else {
    Serial.println("FAILED (Turn ON Feedback Status): " + fbdo.errorReason());
  }
}

 // Motor ON / OFF Feedback Status
void sendFeedbackMotor(int MOTOR_POWER){
  if (Firebase.RTDB.setInt(&fbdo, "/Feedback/MOTOR_POWER", MOTOR_POWER)) {
    Serial.println("Motor ON/OFF Data Uploaded Successfully");
    Serial.println("Data saved to: " + fbdo.dataPath());
  } else {
    Serial.println("FAILED (Motor ON Feedback Status): " + fbdo.errorReason());
  }
}