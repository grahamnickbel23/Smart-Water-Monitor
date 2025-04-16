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
  const rootRef = rtdb.ref("/Feedback");
  const snapshot = await rootRef.once("value");
  const data = snapshot.val();


  const machine_power = data?.MACHINE_POWER ?? null;

  const motor_power = data?.MOTOR_POWER ?? null;

  const motor_reset = data?.MOTOR_RESET ?? null;

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


  await db.collection("Feedback History").doc(docId).set({

    // feed back data
    machine_power,
    motor_power,
    motor_reset,

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
const copyMachinePowerFeedbackToFirestore = onValueWritten("/Feedback/MACHINE_POWER", async () => {
  await saveSnapshotToFirestore();
});

const copyMotorPowerFeedbackToFirestore = onValueWritten("/Feedback/MOTOR_POWER", async () => {
  await saveSnapshotToFirestore();
});

const copyMotorResetFeedbackToFirestore = onValueWritten("/Feedback/MOTOR_RESET", async () => {
  await saveSnapshotToFirestore();
});

// Export all functions
module.exports = {

  // feed back data
  copyMachinePowerFeedbackToFirestore,
  copyMotorPowerFeedbackToFirestore,
  copyMotorResetFeedbackToFirestore
};
