const bcrypt = require("bcrypt");
const teacherModel = require("../../models/teacher_model");
const { generateToken } = require("../../utils/generate_token");

module.exports.registerTeacher = async function (req, res) {
  try {
    let { name, email, contact, password } = req.body;
    let teacher = await teacherModel.findOne({ email: email });
    if (teacher) {
      return res.status(502).send("Email already exists");
    }
    bcrypt.genSalt(10, function (err, salt) {
      bcrypt.hash(password, salt, async function (err, hash) {
        try {
          teacher = await teacherModel.create({
            email,
            name,
            contact,
            password: hash,
          });
          const token = generateToken(teacher);
          res.cookie("token", token);
          res.status(201).send(teacher);
        } catch (err) {
          res.status(500).send(err.message);
        }
      });
    });
  } catch (err) {
    res.status(500).send(err.message);
  }
}

module.exports.loginTeacher = async function (req, res) {
    try {
      const { email, password } = req.body;
      const teacher = await teacherModel.findOne({ email: email });
      if (!teacher) {
        return res.status(502).send("Email doesn't exists");
      }
      bcrypt.compare(password, teacher.password, function (err, result) {
        if(err)
        {
          return res.status(500).send(err.message);
        }
        if(result)
        {
          let token = generateToken(teacher);
          res.cookie("token", token);
          return res.status(201).send(teacher);
        }
        return res.status(501).send("Incorrect Password");
      });
    } catch (err) {
      res.status(500).send(err.message);
    }
  }