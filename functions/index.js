// index.js
const admin = require("firebase-admin");
admin.initializeApp();

// Import and merge all function groups
module.exports = {
  ...require("./weather_data"),
  ...require("./maintance_data"),
  ...require("./feedback_data"),
  ...require("./other_data")
};
