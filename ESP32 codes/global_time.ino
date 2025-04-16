// defining time veriable
unsigned long previousRegularUpload = 0;
unsigned long previousEmergencyUpload = 0;
unsigned long cheackAppOpenOrNot = 0;
unsigned long regularInstructionExecution = 0;
unsigned long randomResetVeriable = 0;
extern unsigned long currentTime;

// defining interval
const long regularUploadInterval = 15000;
const long emergencyUploadInterval = 3000;
const long appOpenOrNotInterval = 10;

const long instructionExecutionInterval = 100;
const long randomResetInterval = 900000;

// assigning values to the time veriable
unsigned long currentTime = 0;

// toggle veriable
bool updateRegularUpload = false;
bool updateEmergencyUpload = false;
bool updateReadDatabase = false;
bool updateExecuteDatabase = false;
bool updateESPResate = false;

//defining go ahed function
extern int regularUploadGoAhead;
extern int emergencyUplloadGoAhead;
extern int forcedUplloadGoAhead;
extern int readDatabaseGoAhead;
extern int executeDatabseGoAhead;
extern int randomResetGoAhead;

// defining values o the go ahed function
int executeDatabseGoAhead = 10;

// defining emergency time upload initiator function
int emergencyDataUpload = 10;
int forcedDataUpload = 10;
int instantDataUpload = 10;

// global time function
void genaralGlobalTimeFunction(){
  if(turnOn == 1){
    currentTime = millis();
    
   Serial.println("Time Meachine has started");

   // regular data Upload
    regularUploadTime();
    
   // determining emergency or forced data and upload emergency data
   if(emergencyDataUpload == 1 || forcedDataUpload == 1){
    emergencyUploadTime();
   }
   // read database time function
   readDatabaseTime();
   // execute databse time function
   executeDatabaseTime();
   // execute reset in every 15 min
   randomReset();
  }else{
     Serial.println("Time Meachine hasn't started yet");
  }
}

// regular upload time function
void regularUploadTime(){
  if((currentTime - previousRegularUpload) >= regularUploadInterval){
    
    // toggle for dicission
    updateRegularUpload = !updateRegularUpload ;
    // updating value of previousUpload
    previousRegularUpload = currentTime;
    
    // go ahed for this function
    if(updateRegularUpload){
      regularUploadGoAhead = 1;
    }else{
      regularUploadGoAhead = 0;
    }
  }
}
// emergency or forced upload time function
void emergencyUploadTime(){
  if((currentTime - previousEmergencyUpload) >= emergencyUploadInterval){
    
    // toggle for dicission
    updateEmergencyUpload = !updateEmergencyUpload ;
    // updating value of previousUpload
    previousEmergencyUpload = currentTime;
    
    // go ahed for this function
    if(updateEmergencyUpload){

    // determining emergency or forced data
      if(emergencyDataUpload == 1){
        emergencyUplloadGoAhead = 1;
      }
      if(forcedDataUpload == 1){
        forcedUplloadGoAhead = 1;
      }

    }else{

      // determining emergency or forced data
      if(emergencyDataUpload == 1){
        emergencyUplloadGoAhead = 0;
      }
      if(forcedDataUpload == 1){
        forcedUplloadGoAhead = 0;
      }

    }
  }
}
// regular read database function
void readDatabaseTime(){
  if((currentTime - cheackAppOpenOrNot) >= appOpenOrNotInterval){

    // toggle for dicission
    updateReadDatabase = !updateReadDatabase;
    // updeating value for previous cheak time
    cheackAppOpenOrNot = currentTime;
    
    // go ahed for this function
    if(updateReadDatabase){
     readDatabaseGoAhead = 1; 
    }else{
     readDatabaseGoAhead = 0;
    }
  }
}
// execute instruction from database function
void executeDatabaseTime(){
  if((currentTime - regularInstructionExecution) >= instructionExecutionInterval){

    // toggle dicission
    updateExecuteDatabase = !updateExecuteDatabase;
    // updeating value of previous state
    regularInstructionExecution = currentTime;
    
    // go ahed for this function
    if(updateExecuteDatabase){
      executeDatabseGoAhead = 1; 
    }else{
      executeDatabseGoAhead = 0;
    }
  }
}
// triggering reset every 15 min
void randomReset(){
  if((currentTime -  randomResetVeriable) >= randomResetInterval){

    // toggle dicission
    updateESPResate = !updateESPResate;
    // update the previous value
    randomResetVeriable = currentTime;
    
    // go ahed for this function
    if(updateESPResate){
     randomResetGoAhead = 1; 
    }else{
     randomResetGoAhead = 0;
    }
  }
}