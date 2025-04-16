// defining global veriable
extern float avarage_humidity;
extern float avarage_temperature;

void weatherSensorSetup(){
  Serial.println("DHT11 Sensor Test - Dual Sensors");
  // setup of 1st DHT11 sensor
  weatherSenstorSetup1stSensor();
  // setup of 2nd DHT11 sensor
  weatherSenstorSetup2ndSensor();
}

void weatherSensorData(){

  // getting value from 1st DHT11 sensor
  weatherSensorData1stSensor();

  delay(500);  // Wait 0.5 seconds before reading the next sensor

  // getting valuefrom 2nd DHT11 sensor
  weatherSensorData2ndSensor();

  // get the avarage of both the values
  avarage_temperature = (temperature1 + temperature2) * 0.5;
  avarage_humidity = (humidity1 + humidity2) * 0.5;

  // get the print
  Serial.print("[Avarage] Avarage Humidity: ");
  Serial.print(avarage_humidity);
  Serial.print("%  Avarage Temperature: ");
  Serial.print(avarage_temperature);
  Serial.println("°C");
}
