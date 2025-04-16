extern int emergencyDataUpload;
extern int forcedDataUpload;

// upload data when user open app
void emergencyDataUploadRTDB(){
  // Read data from the database
    String AppStatus = readValueFromRealtimeDB("/APP_RUNNING"); // Read APP status
  if (AppStatus == "1"){
     Serial.println("Emergency Data upload");
     emergencyDataUpload = 1;
  }else{
    emergencyDataUpload = 0;
  }
}

// upload data when user forced to upload data
void forcedDataUploadRTDB(){
  // Read Data from Database
  String ForcedData = readValueFromRealtimeDB("/Maintance/FORCED_DATA"); // forced data retreval status
  if(ForcedData == "1"){
    Serial.println("Forced Data upload");
    forcedDataUpload = 1;
  }else{
    forcedDataUpload = 0;
  }
}