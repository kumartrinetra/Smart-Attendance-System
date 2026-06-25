const studentModel = require("../../models/student_model");
const {generateToken} = require("../../utils/generate_token");
const bcrypt = require("bcrypt");

module.exports.registerStudent = async function (req, res) {
    try {
      let { name, roll, email, contact, password } = req.body;
      email = String(email);
      let students = await studentModel.findOne({email: email});
      if(students)
      {
          return res.status(502).send("Email already exists");
      }
      bcrypt.genSalt(10, function(err, salt) {
          bcrypt.hash(password, salt, async function(err, hash){
              if(err)
              {
                  return res.status(500).send(err.message);
              }
              let student = await studentModel.create({
                  email,
                  roll,
                  name,
                  contact,
                  password: hash,
              });
              
              const token = generateToken(student);
              res.cookie("token", token);
              return res.status(201).send(student);
          });
      })
      
    } catch (e) {
      res.status(500).send(e.message);
    }
  }

module.exports.loginStudent = async function (req, res) {
    try {
      const { email, password } = req.body;
      const student = await studentModel.findOne({ email: String(email) });
      if (!student) {
        return res.status(502).send("Email doesn't exists");
      }
      bcrypt.compare(password, student.password, function (err, result) {
        if(err)
        {
          return res.status(500).send(err.message);
        }
        if(result)
        {
          let token = generateToken(student);
          res.cookie("token", token);
          return res.status(201).send(student);
        }
        return res.status(501).send("Incorrect Password");
      });
    } catch (err) {
      res.status(500).send(err.message);
    }
  }