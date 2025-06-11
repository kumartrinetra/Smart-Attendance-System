const mongoose = require("mongoose");

const classModel = mongoose.Schema({
  name: String,
  date: String,
  duration: String,
  attendance: [
    {
      type: mongoose.Schema.Types.ObjectId,
      ref: "attendance",
    },
  ],
  location: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "Locations",
  },
  course: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "Courses",
  },
  lower : Number,
  mid : Number,
  higher: Number,
});

module.exports = mongoose.model("Classes", classModel);
