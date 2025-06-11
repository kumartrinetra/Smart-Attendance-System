const express = require("express");
const {registerTeacher, loginTeacher} = require("../controllers/teacher_controller/auth_controller");
const {setLocation, getLocation} = require("../controllers/teacher_controller/location_controller");
const {createCourse, getCourse} = require("../controllers/teacher_controller/course_controller");
const {createClass, getClasses} = require("../controllers/teacher_controller/class_controller");
const{getStudents} = require("../controllers/teacher_controller/student_controller");
const router = express.Router();

router.post("/register", registerTeacher);
router.post("/login", loginTeacher);
router.post("/setlocation", setLocation);
router.post("/getlocation", getLocation);
router.post("/createcourse", createCourse);
router.post("/getcourse", getCourse);
router.post("/createclass", createClass);
router.post("/getclasses", getClasses);
router.post("/getclassstudents", getStudents);

module.exports = router;
