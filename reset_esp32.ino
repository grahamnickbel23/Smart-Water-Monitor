#include "esp_system.h"

extern int firebaseESPReset;
int resetValueFirebase = 10;
int resetValueNotification = 10;
int resetNotificationOver = 10;

void FirebaseESPReset(){
   // Read data from the database
    String Reset_Status = readValueFromRealtimeDB("/Maintance/RESET_ESP"); // Read APP status
  if (Reset_Status == "1"){
    Serial.println("RESET ESP from Firebase");
    firebaseESPReset = 1;
  }else{
    firebaseESPReset = 0;
  }
}

void esp32Reset() {
    Serial.println("Restarting ESP32...");

    // updating value at firebase for notification
    resetValueNotification = 1;
    resetNotification(resetValueNotification);
    // updating value at firebase to prevent multiple reset
    resetValueFirebase = 0;
    preventMultipleReset(resetValueFirebase);

    // Soft reset
    esp_restart();
}

// update value to prevent repeted multiple reet in serease
void preventMultipleReset(int ESP_RESET){
    // Reset Status
  if (Firebase.RTDB.setInt(&fbdo, "/Maintance/RESET_ESP", ESP_RESET)) {
    Serial.println("Reset Initiated Successfully");
    Serial.println("Data updated to: " + fbdo.dataPath());
  } else {
    Serial.println("FAILED (Reset Status): " + fbdo.errorReason());
  }
} 

// update value for notification while reset
void resetNotification(int RESET_NOTIFICATION){
    // Reset Status
  if (Firebase.RTDB.setInt(&fbdo, "/Feedback/MOTOR_RESET", RESET_NOTIFICATION)) {
    Serial.println("Reset Initiated Successfully");
    Serial.println("Data updated to: " + fbdo.dataPath());
  } else {
    Serial.println("FAILED (Reset Status): " + fbdo.errorReason());
  }
}

// update value for notification while reset complete
void resetNotificationComplete(){
  resetNotificationOver = 0;
  resetNotification(resetNotificationOver);
}