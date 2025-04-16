const { onValueWritten } = require("firebase-functions/v2/database");
const admin = require("firebase-admin");

// Helper to get IST timestamp
const getISTTimestamp = () => {
  const nowUTC = new Date();
  const istOffset = 5.5 * 60 * 60 * 1000;
  const istDate = new Date(nowUTC.getTime() + istOffset);

  const pad = (n) => n.toString().padStart(2, '0');
  const hours = pad(istDate.getHours());
  const minutes = pad(istDate.getMinutes());
  const seconds = pad(istDate.getSeconds());
  const day = pad(istDate.getDate());
  const month = pad(istDate.getMonth() + 1);
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

// Save snapshot to Firestore
const saveSnapshotToFirestore = async () => {
  try {
    const rtdb = admin.database();
    const rootRef = rtdb.ref("/");
    const snapshot = await rootRef.once("value");
    const data = snapshot.val();

    const humidity = data?.HUMIDITY ?? null;
    const temperature = data?.TEMPERATURE ?? null;
    const waterLevel = data?.WATER_LEVEL ?? null;

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
    
    await db.collection("Weather History").doc(docId).set({
      humidity,
      temperature,
      waterLevel,
      timestampIST,
      formattedTime,
      hrs,
      mins,
      secs,
      date
    }, { merge: true });    

    console.log("Saved full snapshot to Firestore:", docId);
  } catch (err) {
    console.error("Error saving to Firestore:", err);
  }
};

// Triggers for each RTDB path
const copyHumidityToFirestore = onValueWritten("/HUMIDITY", async () => {
  await saveSnapshotToFirestore();
});

const copyTempToFirestore = onValueWritten("/TEMPERATURE", async () => {
  await saveSnapshotToFirestore();
});

const copyWaterLevelToFirestore = onValueWritten("/WATER_LEVEL", async () => {
  await saveSnapshotToFirestore();
});

// Exports
module.exports = {
  copyHumidityToFirestore,
  copyTempToFirestore,
  copyWaterLevelToFirestore,
};
