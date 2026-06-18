const express = require("express");
const teacherRouter = require("./routes/teacher_router");
const studentRouter = require("./routes/student_router");
const cors = require("cors");
const cookieParser = require("cookie-parser");
const app = express();
app.disable("x-powered-by");
require("dotenv").config();
const db = require("./config/mongoose_connection");

app.use(express.json());
app.use(cookieParser());
app.use(express.urlencoded({extended: true}));
app.use(cors({
    origin: "*",   // ✅ Allow access from any origin
    methods: "GET,HEAD,PUT,PATCH,POST,DELETE",
    credentials: true
}));

app.use("/teacher", teacherRouter);
app.use("/student", studentRouter);

app.listen(3000, () => {
    console.log("Server is listening on port 3000");
});
