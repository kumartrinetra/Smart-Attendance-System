const locationModel = require("../../models/location_model");
const teacherModel = require("../../models/teacher_model");

module.exports.setLocation = async function (req, res) {
  try {
    const { longitude, latitude, name, teacher } = req.body;
    const location = await locationModel.create({
      longitude,
      latitude,
      name,
      teacher,
    });
    
    
    const myTeacher = await teacherModel.findOne({ _id: teacher });
    myTeacher.locations.push(location._id);
    await myTeacher.save();
    res.status(201).send({ "location": location, "Teacher" :  myTeacher.locations});
  } catch (err) {
    res.status(500).send(err.message);
  }
};

module.exports.getLocation = async function (req, res) {
  try {
    const { locations } = req.body;
    
    if (!locations || locations.length === 0) {
      return res.status(404).send("No locations found");
    }
    const myLocations = await locationModel.find({ _id: { $in: locations } });
    if (!myLocations || myLocations.length === 0) {
      return res.status(404).send("No locations found");
    }
    return res.status(201).send({
      Success: true,
      locations: myLocations,
    });
  } catch (err) {
    res.status(500).send(err.message);
  }
};
