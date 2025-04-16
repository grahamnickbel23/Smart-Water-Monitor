// defining veriable
int turnOn = 10;

void setup() {
   Serial.begin(115200);
  // setup for importain stuff
   essentialStartUp();
  // connect global start function
  globalCasualStartUp();
}

void loop() {
  // 1st start meachine upon order from app
   startAndControl();
  // start Time meachine
   genaralGlobalTimeFunction();
  // loop for ledlight + weather data
   globalLoopRun(turnOn);
}
