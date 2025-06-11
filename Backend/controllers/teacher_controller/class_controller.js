const classModel = require("../../models/class_model");
const courseModel = require("../../models/course_model");

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
    const myCourse = await courseModel.findOne({ _id: course });
    myCourse.classes.push(myClass._id);
    await myCourse.save();
    res.status(201).send({ class_list: myCourse.classes, class: myClass });
  } catch (err) {
    
    res.status(500).send(err.message);
  }
};

module.exports.getClasses = async function (req, res) {
  try {
    const { classes } = req.body;
    if (!classes || classes.length === 0) {
      return res.status(404).send("No classes");
    }
    const myClasses = await classModel.find({ _id: { $in: classes } });
    if (!myClasses || myClasses.length === 0) {
      return res.status(404).send("No classes");
    }
    res.status(201).send({"Success" : true, "classes" : myClasses});
  } catch (err) {
    res.status(500).send(err.message);
  }
};


