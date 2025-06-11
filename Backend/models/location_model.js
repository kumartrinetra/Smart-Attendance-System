const mongoose = require("mongoose");

const locationModel = mongoose.Schema({
  name: String,
  latitude: Number,
  longitude: Number,
  teacher: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "Teachers",
  },
});

module.exports = mongoose.model("Locations", locationModel);
