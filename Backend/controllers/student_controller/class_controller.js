const classModel = require("../../models/class_model");


module.exports.getClasses = module.exports.getClasses = async function (req, res) {
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

