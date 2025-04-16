// Defining pins for the HC-SR04 Ultrasonic Sensor to measue water depth
#define TRIG_PIN 18  // Trigger pin connected to D18
#define ECHO_PIN 19  // Echo pin connected to D19

// Global variable to store distance
extern float distance;

void ultrasonicSensorSetup() {
  pinMode(TRIG_PIN, OUTPUT);
  pinMode(ECHO_PIN, INPUT);
  Serial.println("Ultrasonic Sensor Setup Completed!");
}

void ultrasoundDistance() {
  // Send a 10µs pulse to trigger pin
  digitalWrite(TRIG_PIN, LOW);
  delayMicroseconds(2);
  digitalWrite(TRIG_PIN, HIGH);
  delayMicroseconds(10);
  digitalWrite(TRIG_PIN, LOW);

  // Read the echo pin and calculate distance
  long duration = pulseIn(ECHO_PIN, HIGH);
  // spped of sound in air is assumed to be 0.034 m/s
  distance = (duration * 0.034) / 2;  // Convert to cm

  // Print the distance
  Serial.print("Distance: ");
  Serial.print(distance);
  Serial.println(" cm");
}
