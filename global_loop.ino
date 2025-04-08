#define LED_PIN 2  // GPI02 (D2) on ESP32

// defining values for the go ahed function
int regularUploadGoAhead = 10;
int readDatabaseGoAhead = 10;
int randomResetGoAhead = 10;

int emergencyUplloadGoAhead = 10;
int forcedUplloadGoAhead = 10;

int firebaseESPReset = 10;

void globalLoopSetup() {
  pinMode(LED_PIN, OUTPUT);
}

void globalLoopRun(int turnOn) {
  if(turnOn == 1){



    // loop for firebase data read
    if(readDatabaseGoAhead == 1){
      // motor related oparation
      checkPowerStatus(); 
     // datarelated oparation
      emergencyDataUploadRTDB();
     // forced data upload related databse reading oparation
      forcedDataUploadRTDB();
     // ESP reset from firebase related database reading opataion
      FirebaseESPReset();  
    // stop multiple data upload
    readDatabaseGoAhead = 0;
    }else{
      Serial.println("Cheack Power: Time is yet not there");
    }



    // loop for regular firebase data upload
    if(regularUploadGoAhead == 1 || emergencyUplloadGoAhead == 1 || forcedUplloadGoAhead == 1){
      // Turn LED ON
      digitalWrite(LED_PIN, HIGH);
      // weight so that all equipment start by assepting power
      delay(10);
      // main data upload function
     uploadWeatherAndWaterData(); 
     // stop multiple data upload
     regularUploadGoAhead = 0;
     // stop multiple data aupload for emergency data upload
     emergencyUplloadGoAhead = 0;
     // turn off led
      digitalWrite(LED_PIN, LOW);  // Turn LED ON
    }else{
      Serial.println("Regulr Upload: Time is yet not there");
    }


    
    //function to reset esp32 in every 15 min or inf instructed from firebase
    if(randomResetGoAhead == 1 || firebaseESPReset == 1){
       esp32Reset(); // function to reset esp
    }

    
    
  }else{
    // print for off from app
    Serial.println("Power Switch is off from App");
  }
}
