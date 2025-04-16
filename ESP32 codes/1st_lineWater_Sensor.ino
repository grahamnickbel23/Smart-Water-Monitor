// Defining pin for the 1st water level sensor
#define WATER_LEVEL_PIN_1st 32  // Connect sensor to GPIO21

// Global variable to store water level
extern float water_level_percentage_1st_sensor;

void lineWaterLevelSensorSetup_1st() {
  pinMode(WATER_LEVEL_PIN_1st, INPUT);
  Serial.println("1st Water Level Sensor Setup Completed!");
}

void linearDistance1stSensor_1st() {
  int sensorValue_1st = analogRead(WATER_LEVEL_PIN_1st);  // Read analog value (0-4095 on ESP32)

  // Convert to percentage (assuming 0 = empty, 4095 = full for 12-bit ADC)
  water_level_percentage_1st_sensor = (sensorValue_1st / 4095.0) * 100.0;

  // Print the water level percentage
  Serial.print("[Sensor 1] Water Level: ");
  Serial.print (water_level_percentage_1st_sensor);
  Serial.println(" %");
}
