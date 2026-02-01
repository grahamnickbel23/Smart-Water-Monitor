#include <WiFi.h>  // ESP32 Wi-Fi Library

// Define Wi-Fi credentials
const char* ssid = "<put your wifi id />";       
const char* password = "<put your wifi password />";

void setupWiFi() {
  Serial.print("Connecting to Wi-Fi: ");
  Serial.println(ssid);

  WiFi.begin(ssid, password);  // Start Wi-Fi connection

  // Wait for connection
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }

  Serial.println("\nWi-Fi Connected!");
  Serial.print("IP Address: ");
  Serial.println(WiFi.localIP());  // Print ESP32's IP address
}
