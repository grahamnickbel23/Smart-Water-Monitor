// weather.js
const { onValueWritten } = require("firebase-functions/v2/database");
const admin = require("firebase-admin");

// Helper to get IST timestamp
const getISTTimestamp = () => {
  const nowUTC = new Date();
  const istOffset = 5.5 * 60 * 60 * 1000;
  const istDate = new Date(nowUTC.getTime() + istOffset);

  const hours = istDate.getHours().toString().padStart(2, '0');
  const minutes = istDate.getMinutes().toString().padStart(2, '0');
  const seconds = istDate.getSeconds().toString().padStart(2, '0');
  const day = istDate.getDate().toString().padStart(2, '0');
  const month = (istDate.getMonth() + 1).toString().padStart(2, '0');
  const year = istDate.getFullYear();

  return {
    timestampIST: istDate.toISOString(),
    formattedTime: istDate.toLocaleString("en-IN", {
      timeZone: "Asia/Kolkata",
      hour12: true,
    }),
    docId: istDate.toISOString().slice(0, 16).replace('T', ' '),
    hrs: hours,
    mins: minutes,
    secs: seconds,
    date: `${day}-${month}-${year}`,
  };
};


// function to save at Firestore
const saveSnapshotToFirestore = async () => {
  const rtdb = admin.database();
  const rootRef = rtdb.ref("/Maintance");
  const snapshot = await rootRef.once("value");
  const data = snapshot.val();


  const Sensor_01_Humidity = data?.["1st_DHT11"]?.HUMIDITY ?? null;
  const Sensor_01_Temperature = data?.["1st_DHT11"]?.TEMPRATURE ?? null;

  const Sensor_02_Humidity = data?.["2nd_DHT11"]?.HUMIDITY ?? null;
  const Sensor_02_Temperature = data?.["2nd_DHT11"]?.TEMPRATURE ?? null;

  const Sensor_01_waterLevel = data?.Water_Level_Sensor?.["1st_sensor"] ?? null;
  const Sensor_02_waterLevel = data?.Water_Level_Sensor?.["2nd_sensor"] ?? null;
  const Sensor_03_waterLevel = data?.Water_Level_Sensor?.["3rd_sensor"] ?? null;

  const ultrasound_sensor_data = data?.ULTRASOUND ?? null;

  const forced_data_transfer = data?.FORCED_DATA ?? null;

  const reset_ESP = data?.RESET_ESP ?? null;

  const db = admin.firestore();
  const {
    timestampIST,
    formattedTime,
    docId,
    hrs,
    mins,
    secs,
    date
  } = getISTTimestamp();


  await db.collection("Sensor History").doc(docId).set({

    // DHT11 sensor 01
    Sensor_01_Humidity,
    Sensor_01_Temperature,

    // DHT11 sensor 02
    Sensor_02_Humidity,
    Sensor_02_Temperature,

    // All waterlevel sensors
    Sensor_01_waterLevel,
    Sensor_02_waterLevel,
    Sensor_03_waterLevel,

    // ultrasound sensor
    ultrasound_sensor_data,

    // forced data transfer
    forced_data_transfer,

    // reset ESP
    reset_ESP,

    // Time split
    hrs,
    mins,
    secs,
    date,

    // Other data
    timestampIST,
    formattedTime,

  }, { merge: true });

  console.log("Saved full snapshot to Firestore:", docId);
};

// Triggers for each computed data
const copySensor01HumidityToFirestore = onValueWritten("/Maintance/1st_DHT11/HUMIDITY", async () => {
  await saveSnapshotToFirestore();
});

const copySensor01TempToFirestore = onValueWritten("/Maintance/1st_DHT11/TEMPRATURE", async () => {
  await saveSnapshotToFirestore();
});

const copySensor02HumidityToFirestore = onValueWritten("/Maintance/2nd_DHT11/HUMIDITY", async () => {
  await saveSnapshotToFirestore();
});

const copySensor02TempToFirestore = onValueWritten("/Maintance/2nd_DHT11/TEMPRATURE", async () => {
  await saveSnapshotToFirestore();
});


const copy1stWaterLevelToFirestore = onValueWritten("/Maintance/Water_Level_Sensor/1st_sensor", async () => {
  await saveSnapshotToFirestore();
});

const copy2ndWaterLevelToFirestore = onValueWritten("/Maintance/Water_Level_Sensor/2nd_sensor", async () => {
  await saveSnapshotToFirestore();
});

const copy3rdWaterLevelToFirestore = onValueWritten("/Maintance/Water_Level_Sensor/3rd_sensor", async () => {
  await saveSnapshotToFirestore();
});

const copyUltrasoundSensorDataToFirestore = onValueWritten("/Maintance/ULTRASOUND", async () => {
  await saveSnapshotToFirestore();
});

const copyForcedDataToFirestore = onValueWritten("/Maintance/FORCED_DATA", async () => {
  await saveSnapshotToFirestore();
});

const copyResetESPToFirestore = onValueWritten("/Maintance/reset_ESP", async () => {
  await saveSnapshotToFirestore();
});

// Export all functions
module.exports = {

  // DHT11 Sensor 01
  copySensor01HumidityToFirestore,
  copySensor01TempToFirestore,

  // DHT11 Sensor 02
  copySensor02HumidityToFirestore,
  copySensor02TempToFirestore,

  // 3 WaterLevel sensors
  copy1stWaterLevelToFirestore,
  copy2ndWaterLevelToFirestore,
  copy3rdWaterLevelToFirestore,

  //ultrasound sensor
  copyUltrasoundSensorDataToFirestore,

  // forced data transfer
  copyForcedDataToFirestore,

  // reset esp
  copyResetESPToFirestore,
};
