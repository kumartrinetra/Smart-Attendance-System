const mongoose = require("mongoose");

mongoose
  .connect(process.env.MONGOOSE_ID, {
    useNewUrlParser: true,
    useUnifiedTopology: true,
  })
  .then(function () {
    console.log("Connected to DB");
  })
  .catch(function (err) {
    console.log(err);
  });

  module.exports = mongoose.connection;