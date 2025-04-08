// here is the function for global importin function
void essentialStartUp(){
   // setup for wifi
  setupWiFi();
  //connect firebase
  setupFirebase();
  // connect start function
  initControl();
}

// here is the function for the global start ups functions
void globalCasualStartUp(){
  //set up for global loop
  globalLoopSetup();
  // setup for DHT11 sensors
  weatherSensorSetup();
  //setup for water Level sensor
  waterLevelSensorSetup() ;
  // setups for mtor
  motorPowerPins();
  // setups for reset Notification
  resetNotificationComplete();
}