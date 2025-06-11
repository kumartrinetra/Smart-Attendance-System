const locationModel = require("../../models/location_model");

module.exports.getLocation = async function (req, res) {
    try{
        const {location} = req.body;
        const myLocation = await locationModel.findOne({_id : location});
        if(!myLocation)
        {
            return res.status(404).send("Location does not exist.");
        }
        res.status(201).send({"location" : myLocation});
    }catch(err)
    {
        res.status(500).send(err.message);
    }
}