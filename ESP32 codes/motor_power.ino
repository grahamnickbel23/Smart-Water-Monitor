// Define variables
int powerOn = 0;

// Define GPIO pins
#define POWER_PIN 22  // GPIO pin for power status
#define MOTOR_PIN 23  // GPIO pin for motor control

// Function to configure pin modes
void motorPowerPins() {
    pinMode(POWER_PIN, INPUT);
    pinMode(MOTOR_PIN, OUTPUT);
}

// Function to check power status at the motor pin socket
void checkPowerStatus() {
    int powerStatus = digitalRead(POWER_PIN);  // Read D12 state

    if (powerStatus == HIGH) {
        powerOn = 1;
        // Serial printing power data
        Serial.println("YES!!! Motor is powered");
        
        // Update info into the database
        sendPowerStatus(powerOn);
        
        // Check if the motor can be turned on
        powerMotor();
    } else {
        powerOn = 0;
        // Serial printing power data
        Serial.println("NO!!! No power at Motor");
        
        // Update info into the database
        sendPowerStatus(powerOn);
    }
}

// Function to turn the motor on/off based on database instruction
void powerMotor() {
    // Read data from the database
    String motorStatus = readValueFromRealtimeDB("/MOTOR"); // Read MOTOR status
    int motor_power = 10;
    
    if (motorStatus == "1") {
         motor_power = 1;
        Serial.println("Motor is ON");
        digitalWrite(MOTOR_PIN, HIGH);
      // upload to push notification
      sendFeedbackMotor(motor_power);
    } else {
        motor_power = 0;
        Serial.println("Motor is OFF");
        digitalWrite(MOTOR_PIN, LOW);
        sendFeedbackMotor(motor_power);
    }
}