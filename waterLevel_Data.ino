// Define veriable for avarage
extern float avarage_water_level_percentage;

void waterLevelSensorSetup() {
   //setup for HC-SR04 sensor
  ultrasonicSensorSetup();
  //setup for 1st linear waterlevel sensor
  lineWaterLevelSensorSetup_1st();
  //setup for 2nd linear waterlevel sensor
  lineWaterLevelSensorSetup_2nd();
  //setup for 3rd linear waterlevel sensor
  lineWaterLevelSensorSetup_3rd();
}

void waterLevelData() {
  // Distance Measurement using ultrasound 
  ultrasoundDistance();
  delay(500);
  //Distance Measurement using 1st line water level sensor
  linearDistance1stSensor_1st();
  delay(500);
  //Distance Measurement using 2nd line water level sensor
  linearDistance1stSensor_2nd();
  delay(500);
  //Distance Measurement using 3rd line water level sensor
  linearDistance1stSensor_3rd();
  delay(500);

  // calculating Avarage
  avarage_water_level_percentage = (water_level_percentage_1st_sensor + water_level_percentage_2nd_sensor + water_level_percentage_3rd_sensor) * 0.3333;

   // Print the water level percentage
  Serial.print("[Avarage] Avarage Water Level: ");
  Serial.print (avarage_water_level_percentage);
  Serial.println(" %");
}
