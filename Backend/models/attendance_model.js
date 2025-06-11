const mongoose = require("mongoose");


const attendanceModel = mongoose.Schema({
    deviceId : String,
    student : {
        type : mongoose.Schema.Types.ObjectId,
        ref : "students",
    },
    myClass : {
        type : mongoose.Schema.Types.ObjectId,
        ref : "Classes"
    }
});

module.exports = mongoose.model("attendance", attendanceModel);