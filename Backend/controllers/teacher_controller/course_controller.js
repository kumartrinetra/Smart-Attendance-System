const courseModel = require("../../models/course_model");
const teacherModel = require("../../models/teacher_model");

module.exports.createCourse = async function (req, res) {
  try {
    const { name, courseId, duration, teacher } = req.body;
    // Validate and sanitize input data
    if (typeof courseId !== 'string' || typeof teacher !== 'string') {
      return res.status(400).send("Invalid input data");
    }
    const myCourse = await courseModel.findOne({ courseId: courseId });
    if (myCourse) {
      return res.status(409).send("Course ID already exists");
    }
    const course = await courseModel.create({
      name,
      courseId,
      duration,
      teacher,
    });
    const myTeacher = await teacherModel.findOne({ _id: teacher });
    myTeacher.courses.push(course._id);
    await myTeacher.save();
    
    res.status(201).send({ "New Course": course, "Teacher": myTeacher.courses });
  } catch (err) {
    res.status(500).send(err.message);
  }
};

module.exports.getCourse = async function (req, res) {
  try {
    const { courses } = req.body;
    if (!courses || courses.length === 0) {
      return res.status(404).json("No courses found");
    }
    // Validate and sanitize input data
    if (!Array.isArray(courses) || courses.some(course => typeof course !== 'string')) {
      return res.status(400).send("Invalid input data");
    }
    const myCourses = await courseModel.find({ _id: { $in: courses } });
    if (myCourses.length === 0) {
      return res.status(404).json("No courses found");
    }
    res.status(201).send({ "Success": true, "courses": myCourses });
  } catch (err) {
    res.status(500).send(err.message);
  }
};