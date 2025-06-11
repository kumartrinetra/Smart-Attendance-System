const courseModel = require("../../models/course_model");
const studentModel = require("../../models/student_model");

module.exports.courseRegistration = async function (req, res) {
  try {
    const { studentId, courseId } = req.body;
    const course = await courseModel.findOne({ courseId: courseId });
    if (!course) {
      return res.status(404).send("Course does not exist");
    }
    if (course.students.includes(studentId)) {
      return res
        .status(409)
        .send("You have already registered for this course");
    }
    course.students.push(studentId);
    await course.save();
    const student = await studentModel.findOne({ _id: studentId });
    student.courses.push(course._id);
    await student.save();
    res.status(201).send({ "Course": course, "course_list": student.courses });
  } catch (err) {
    res.status(500).send(err.message);
  }
};

module.exports.getCourses = async function (req, res) {
  try {
    const {courses} = req.body;
    if(!courses || courses.length === 0)
    {
      return res.status(404).send("No course found");
    }
    const course = await courseModel.find({_id : {$in : courses}});
    if(!course || course.length === 0)
    {
      return res.status(404).send("No course found");
    }
    res.status(201).send({"Success" : true, "Courses" : course});

  } catch (err) {
    res.status(500).send(err.message);
  }
};
