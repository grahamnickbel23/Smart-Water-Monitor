#include <Adafruit_Sensor.h>
#include <DHT.h>

// Define the DHT sensor type and pin
#define DHTPIN1 4       // GPIO4 for the 1st sensor
#define DHTTYPE DHT11 

// defining global veriable
extern float humidity1;
extern float temperature1;

// Create instances for 1st sensor
DHT dht1(DHTPIN1, DHTTYPE);

void weatherSenstorSetup1stSensor() {
  Serial.println("DHT11 1st Sensor Test!");
   dht1.begin();
}

void weatherSensorData1stSensor() {
  // define veriables
  humidity1 = dht1.readHumidity();
  temperature1 = dht1.readTemperature();  // Default is Celsius

  // fire up to get values
 if (isnan(humidity1) || isnan(temperature1)) {
    Serial.println("Failed to read from DHT Sensor 1!");
    return;
  }

  Serial.print("[Sensor 1] Humidity: ");
  Serial.print(humidity1);
  Serial.print("%  Temperature: ");
  Serial.print(temperature1);
  Serial.println("°C");
}
