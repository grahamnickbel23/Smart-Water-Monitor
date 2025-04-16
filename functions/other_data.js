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
  const rootRef = rtdb.ref("/");
  const snapshot = await rootRef.once("value");
  const data = snapshot.val();


  const app_opend = data?.APP_RUNNING ?? null;

  const machine_running = data?.LED_STATUS ?? null;

  const motor_POWER = data?.MOTOR ?? null;

  const direct_power = data?.POWER_STSTUS ?? null;
  

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


  await db.collection("Other Data").doc(docId).set({

    // other importain data
    app_opend,
    machine_running,
    motor_POWER,
    direct_power,

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
const copyAppOpenedDataToFirestore = onValueWritten("/APP_RUNNING", async () => {
  await saveSnapshotToFirestore();
});

const copyMachinePowerDataToFirestore = onValueWritten("/LED_STATUS", async () => {
  await saveSnapshotToFirestore();
});

const copyMotorPowerDataToFirestore = onValueWritten("/MOTOR", async () => {
  await saveSnapshotToFirestore();
});

const copyDirectPowerDataToFirestore = onValueWritten("/POWER_STSTUS", async () => {
  await saveSnapshotToFirestore();
});

// Export all functions
module.exports = {

  // other imporatin data
  copyAppOpenedDataToFirestore,
  copyMachinePowerDataToFirestore,
  copyMotorPowerDataToFirestore,
  copyDirectPowerDataToFirestore,
};
