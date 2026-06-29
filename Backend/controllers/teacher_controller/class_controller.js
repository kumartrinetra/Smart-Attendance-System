const classModel = require("../../models/class_model");
const courseModel = require("../../models/course_model");
const mongoose = require('mongoose');

module.exports.createClass = async function (req, res) {
  try {
    const { name, date, duration, location, lower, mid, higher, course } =
      req.body;
    const myClass = await classModel.create({
      name,
      date,
      duration,
      location,
      lower,
      mid,
      higher,
      course,
    });
    const myCourse = await courseModel.findOne({ _id: mongoose.Types.ObjectId(course) });
    myCourse.classes.push(myClass._id);
    await myCourse.save();
    res.status(201).send({ class_list: myCourse.classes, class: myClass });
  } catch (err) {
    // console.log(err);
    res.status(500).send(err.message);
  }
};

module.exports.getClasses = async function (req, res) {
  try {
    const classes = req.body.classes; // Changed to not destructure directly
    if (!classes || classes.length === 0) {
      return res.status(404).send("No classes");
    }
    // Using $in with an array of mongoose.Types.ObjectId to prevent NoSQL injection
    const myClasses = await classModel.find({
      _id: { $in: classes.map((id) => mongoose.Types.ObjectId(id.toString())) },
    });
    if (!myClasses || myClasses.length === 0) {
      return res.status(404).send("No classes");
    }
    res.status(201).send({"Success" : true, "classes" : myClasses});
  } catch (err) {
    res.status(500).send(err.message);
  }
};