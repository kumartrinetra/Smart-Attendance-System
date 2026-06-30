const attendanceModel = require("../../models/attendance_model");
const studentModel = require("../../models/student_model");

module.exports.getStudents = async function (req, res) {
  try {
    const { attendance } = req.body;
    
    if(!attendance || attendance.length === 0)
    {
        return res.status(404).send("No attendances found.");
    }
    const attendances = await attendanceModel.find({
      _id: { $in: attendance.map(String) },
    }).populate("student", "name roll").exec();

    const students = attendances.map((record) => record.student);
    
    res.status(200).send({Success : true, Students : students});
    
  } catch (err) {
    res.status(500).send(err.message);
  }
};