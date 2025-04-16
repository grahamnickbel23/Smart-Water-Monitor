// Defining pin for the 3rd water level sensor
#define WATER_LEVEL_PIN_3rd 34  // Connect sensor to GPIO23

// Global variable to store water level
extern float water_level_percentage_3rd_sensor;

void lineWaterLevelSensorSetup_3rd() {
  pinMode(WATER_LEVEL_PIN_3rd, INPUT);
  Serial.println("3rd Water Level Sensor Setup Completed!");
}

void linearDistance1stSensor_3rd(){
  int sensorValue_3rd = analogRead(WATER_LEVEL_PIN_3rd);  // Read analog value (0-4095 on ESP32)

  // Convert to percentage (assuming 0 = empty, 4095 = full for 12-bit ADC)
  water_level_percentage_3rd_sensor = (sensorValue_3rd / 4095.0) * 100.0;

  // Print the water level percentage
  Serial.print("[Sensor 3] Water Level: ");
  Serial.print (water_level_percentage_3rd_sensor);
  Serial.println(" %");
}
