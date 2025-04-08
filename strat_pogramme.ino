#define LED_PIN 21         // Define the LED pin

// Global variable to control all systems
extern int turnOn; 

// Function to initialize pinMode for LED
void initControl() {
  pinMode(LED_PIN, OUTPUT);
}

// Function to read LED_STATUS and control D13 accordingly
int startAndControl() {
  String ledStatus = readValueFromRealtimeDB("/LED_STATUS"); // Read LED_STATUS

  if (ledStatus == "1") {
    digitalWrite(LED_PIN, HIGH); // Turn ON LED
    turnOn = 1;
    // upload data for notification
    sendFeedbackPower(turnOn);
  } else if (ledStatus == "0") {
    digitalWrite(LED_PIN, LOW);  // Turn OFF LED
    turnOn = 0;
    // upload data for notification
    sendFeedbackPower(turnOn);
  } else {
    Serial.println("Invalid or failed LED_STATUS read. Keeping previous state.");
  }

  return turnOn;
}
