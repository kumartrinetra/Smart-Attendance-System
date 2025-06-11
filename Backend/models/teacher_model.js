const mongoose = require("mongoose");

const teacherModel = mongoose.Schema({
  name: String,
  email: String,
  contact: Number,
  password: String,
  profilePic: String,
  isTeacher:{
    type: Boolean,
    default: true
  },
  locations: [
    {
      type: mongoose.Schema.Types.ObjectId,
      ref: "Locations",
    },
  ],
  courses: [
    {
      type: mongoose.Schema.Types.ObjectId,
      ref: "Courses",
    },
  ],
});

module.exports = mongoose.model("Teachers", teacherModel);
