const classModel = require("../../models/class_model");
const attendanceModel = require("../../models/attendance_model");

module.exports.markAttendance = async function (req, res) {
  try {
    const { deviceId,  student, myClass } = req.body;

    const newAttendance = await attendanceModel.create({
      deviceId,
      student,
      myClass: myClass.toString(),
    });
    const meraClass = await classModel.findOne({ _id: myClass.toString() });
     
    meraClass.attendance.push(newAttendance._id);
    await meraClass.save();
    res.status(201).send({
      attendance_list: meraClass.attendance,
      attendance: newAttendance,
    });
  } catch (err) {
    res.status(500).send(err.message);
  }
};

module.exports.getAttendances = async function (req, res) {
  try {
    const { attendances } = req.body;
    if (!attendances || attendances.length === 0) {
      return res.status(404).send("No attendance is available");
    }
    const myAttendance = await attendanceModel.find({
      _id: { $in: attendances.map(id => id.toString()) },
    });
    if (!myAttendance || myAttendance.length === 0) {
      return res.status(404).send("No attendance is available");
    }
    res.status(201).send({"list" : myAttendance});
  } catch (err) {
    res.status(500).send(err.message);
  }
};