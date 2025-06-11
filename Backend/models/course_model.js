const mongoose = require("mongoose");

const courseModel = mongoose.Schema({
    name : String,
    courseId: {
        type: String,
        
    },
    classes : [
        {
            type: mongoose.Schema.Types.ObjectId,
            ref: "Classes"
        }
    ],
    students : [
        {
            type: mongoose.Schema.Types.ObjectId,
            ref: "Students",
        }
    ],
    duration : String,
    teacher: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "Teachers",
    }
});

module.exports = mongoose.model("Courses", courseModel);
