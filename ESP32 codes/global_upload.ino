// defining initial values
float avarage_humidity = 0;
float avarage_temperature = 0;
float avarage_water_level_percentage = 0;

// defining initial value for maintance veriable
float humidity1 = 0;
float temperature1 = 0;

float humidity2 = 0;
float temperature2 = 0;

float distance = 0.0;

float water_level_percentage_1st_sensor = 0.0;
float water_level_percentage_2nd_sensor = 0.0;
float water_level_percentage_3rd_sensor = 0.0;


// function to upload all weather & waterLevel data into RTDB
void uploadWeatherAndWaterData(){
  // getting weather data
  weatherSensorData();
  // geting water data
  waterLevelData();
  // upload data realtime database
  sendDataToRealtimeDB(avarage_temperature,  avarage_humidity, avarage_water_level_percentage);
  // upload meaintance data to realtime database
  if(emergencyDataUpload == 1){
    Serial.println("No need for maintance Data in Emergency");
  }else{
    maintananceDataUpload(temperature1, temperature2, humidity1, humidity2, distance, water_level_percentage_1st_sensor, water_level_percentage_2nd_sensor, water_level_percentage_3rd_sensor);
  }
}

// currently not in use (below)
// function to upload only to RTDB on request
void uploadToRealtimeDBonRequest(){
   // getting weather data
  weatherSensorData();
  // geting water data
  waterLevelData();
  // uploade data realtime database
  sendDataToRealtimeDB(avarage_temperature,  avarage_humidity, avarage_water_level_percentage);
}