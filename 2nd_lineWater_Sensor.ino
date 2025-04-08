// Defining pin for the 2nd water level sensor
#define WATER_LEVEL_PIN_2nd 33  // Connect sensor to GPIO22

// Global variable to store water level
extern float water_level_percentage_2nd_sensor;

void lineWaterLevelSensorSetup_2nd() {
  pinMode(WATER_LEVEL_PIN_2nd, INPUT);
  Serial.println("2nd Water Level Sensor Setup Completed!");
}

void linearDistance1stSensor_2nd(){
  int sensorValue_2nd = analogRead(WATER_LEVEL_PIN_2nd);  // Read analog value (0-4095 on ESP32)

  // Convert to percentage (assuming 0 = empty, 4095 = full for 12-bit ADC)
  water_level_percentage_2nd_sensor = (sensorValue_2nd / 4095.0) * 100.0;

  // Print the water level percentage
  Serial.print("[Sensor 2] Water Level: ");
  Serial.print (water_level_percentage_2nd_sensor);
  Serial.println(" %");
}
