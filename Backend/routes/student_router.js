const express = require("express");

const {registerStudent, loginStudent} = require("../controllers/student_controller/auth_controller");
const {courseRegistration, getCourses} = require("../controllers/student_controller/course_controller");
const {getClasses} = require("../controllers/student_controller/class_controller");
const {markAttendance, getAttendances} = require("../controllers/student_controller/attendance_controller");
const {getLocation} = require("../controllers/student_controller/location_controller");

const router = express.Router();

router.get("/", function(req, res) {
    res.status(200).send("Hey! Working fine!");
});


router.post("/register", registerStudent);
router.post("/login", loginStudent);
router.post("/registercourse", courseRegistration);
router.post("/getcourses", getCourses);
router.post("/getclasses", getClasses);
router.post("/markattendance", markAttendance);
router.post("/getattendances", getAttendances);
router.post("/getlocation", getLocation);



module.exports = router;
