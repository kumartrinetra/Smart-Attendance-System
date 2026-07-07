const jwt = require("jsonwebtoken");
const studentModel = require("../models/student_model");
const teacherModel = require("../models/teacher_model");

const isLoggedIn = async function(req, res, next){
    if(!req.cookies.token)
    {
        return res.status(502).send("Kindly log in again");
    }
    try{
        let decoded = jwt.verify(req.cookies.token, process.env.JWT_KEY);
        if(decoded.isTeacher)
        {
            let teacher  = await teacherModel.findOne({email: decoded.email}).select(" -password");
            req.teacher = teacher;
        }
        else{
            let student  = await studentModel.findOne({email: decoded.email}).select(" -password");
            req.student = student;
        }
        next();
    }
    catch(err)
    {
        res.status(500).send(err.message);
    }
}
module.exports = isLoggedIn;