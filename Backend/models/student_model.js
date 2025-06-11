const mongoose = require("mongoose");

const studentModel = mongoose.Schema({
  name: String,
  roll: Number,
  email: String,
  contact: Number,
  password: String,
  profilePic: String,
  isTeacher:{
    type: Boolean,
    default: false
  },
  courses: [
    {
      type: mongoose.Schema.Types.ObjectId,
      ref: "Courses",
    },
  ],
});

module.exports = mongoose.model("students", studentModel);
