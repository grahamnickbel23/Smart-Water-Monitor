#include <Adafruit_Sensor.h>
#include <DHT.h>

// Define the DHT sensor type and pin
#define DHTPIN2 5       // GPIO5 for 2nd sensor
#define DHTTYPE DHT11 

// Create instances for 2nd sensor
DHT dht2(DHTPIN2, DHTTYPE);

// defining global veriable
extern float humidity2;
extern float temperature2;

void weatherSenstorSetup2ndSensor() {
  Serial.println("DHT11 2nd Sensor Test!");
   dht2.begin();
}

void weatherSensorData2ndSensor() {
  // define veriables
  humidity2 = dht2.readHumidity();
  temperature2 = dht2.readTemperature(); 

  // fire up to get values
  if (isnan(humidity2) || isnan(temperature2)) {
    Serial.println("Failed to read from DHT Sensor 2!");
    return;
  }

  Serial.print("[Sensor 2] Humidity: ");
  Serial.print(humidity2);
  Serial.print("%  Temperature: ");
  Serial.print(temperature2);
  Serial.println("°C");
}
