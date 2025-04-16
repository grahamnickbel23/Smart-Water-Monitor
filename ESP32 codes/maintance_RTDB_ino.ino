// Miantance
// function to upload indevisual sensor data for easy mintance later on
void maintananceDataUpload(float temperature01, float temperature02, float humidity01, float humidity02, float ultrasound, float waterLevel01, float waterLevel02, float waterLevel03){
  
  // intro to maintance
  Serial.println("Start uploading Mentainance data to firebase");
  
  // temp data from 1st DHT11 sensor
   if (Firebase.RTDB.setFloat(&fbdo, "/Maintance/1st_DHT11/TEMPRATURE", temperature01)) {
    Serial.println("Temp Maintance Data 1st DHT11 Uploaded Successfully");
    Serial.println("Data saved to: " + fbdo.dataPath());
  } else {
    Serial.println("FAILED (temp): " + fbdo.errorReason());
  }
  
  // temp data from 2nd DHT11 sensor
   if (Firebase.RTDB.setFloat(&fbdo, "/Maintance/2nd_DHT11/TEMPRATURE", temperature02)) {
    Serial.println("Temp Maintance Data 2nd DHT11 Uploaded Successfully");
    Serial.println("Data saved to: " + fbdo.dataPath());
  } else {
    Serial.println("FAILED (temp): " + fbdo.errorReason());
  }

  //himidity data from 1st DHT11 sensor
   if (Firebase.RTDB.setFloat(&fbdo, "/Maintance/1st_DHT11/HUMIDITY", humidity01)) {
    Serial.println("Humidity Maintance Data 1st DHT11 Uploaded Successfully");
    Serial.println("Data saved to: " + fbdo.dataPath());
  } else {
    Serial.println("FAILED (temp): " + fbdo.errorReason());
  }

  // humidity data from 2nd DHT11 sensor
   if (Firebase.RTDB.setFloat(&fbdo, "/Maintance/2nd_DHT11/HUMIDITY", humidity02)) {
    Serial.println("Humidity Maintance Data 2nd DHT11 Uploaded Successfully");
    Serial.println("Data saved to: " + fbdo.dataPath());
  } else {
    Serial.println("FAILED (temp): " + fbdo.errorReason());
  }

  // ultrasonic sensor
   if (Firebase.RTDB.setFloat(&fbdo, "/Maintance/ULTRASOUND", ultrasound)) {
    Serial.println("Depth Maintance Data HC-SR04 Uploaded Successfully");
    Serial.println("Data saved to: " + fbdo.dataPath());
  } else {
    Serial.println("FAILED (temp): " + fbdo.errorReason());
  }

  // 1st water level sensor
   if (Firebase.RTDB.setFloat(&fbdo, "/Maintance/Water_Level_Sensor/1st_sensor", waterLevel01)) {
    Serial.println("1st water level Maintance Data Uploaded Successfully");
    Serial.println("Data saved to: " + fbdo.dataPath());
  } else {
    Serial.println("FAILED (temp): " + fbdo.errorReason());
  }

  // 2nd water level sensor
   if (Firebase.RTDB.setFloat(&fbdo, "/Maintance/Water_Level_Sensor/2nd_sensor", waterLevel02)) {
    Serial.println("2nd water level Maintance Data Uploaded Successfully");
    Serial.println("Data saved to: " + fbdo.dataPath());
  } else {
    Serial.println("FAILED (temp): " + fbdo.errorReason());
  }

  // 3rd water level sensor
   if (Firebase.RTDB.setFloat(&fbdo, "/Maintance/Water_Level_Sensor/3rd_sensor", waterLevel03)) {
    Serial.println("3rd water level Maintance Data Uploaded Successfully");
    Serial.println("Data saved to: " + fbdo.dataPath());
  } else {
    Serial.println("FAILED (temp): " + fbdo.errorReason());
  }

  // completion of data upload
  Serial.println("Completed uploading Mentainance data to firebase");
}
