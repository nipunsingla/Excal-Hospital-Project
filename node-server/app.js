const express = require("express");
const mongoose = require("mongoose");
const cors = require("cors");
const cookieParser = require("cookie-parser");
const dbURI = require("./config/key").URL;
const symptomsData = require('./seeder/symptoms_seeder');
const patientRoutes = require("./routes/patient");
const hospitalRoutes = require("./routes/hospital");
const appointmentRoutes = require("./routes/appointment");
const authRoutes = require("./routes/authRouter");
const blogRoutes = require("./routes/blogRoutes");
const consultantRoutes = require("./routes/consultantRoutes");

const bodyParser = require("body-parser");
const { verifyToken, authUser } = require("./routes/verify");
const { PageNotFound } = require("./response_helpers/responseHelpers");

mongoose
  .connect(dbURI, { useNewUrlParser: true, useUnifiedTopology: true })
  .then(() => console.log("connected"))
  .catch((err) => {
    console.log(err);
  });
const app = express();
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));
app.use(express.urlencoded({ extended: false }));
app.set("view engine", "ejs");

app.use(cookieParser());
app.use(cors());

// app.use("/static", express.static("./public")); // * Probably not needed in our case
// app.get("/", (req, res) => {
//   res.render("index");
// });

app.use("/", authRoutes);
app.use("/", verifyToken, authUser);
app.use("/appointment", appointmentRoutes);
app.use("/patient", patientRoutes);
app.use("/hospital", hospitalRoutes);
app.use("/blog", blogRoutes);
app.use("/consultant", consultantRoutes);

app.get('/getSymptomsList', (req, res) => {
  console.log("working");
  return res.json({
    "flag": 1,
    "message": "success",
    "payload": symptomsData
  });
});

// * 404 Page
app.use("/", (req, res, next) => {
  return PageNotFound(res);
});


const PORT = process.env.PORT || 3001; // TODO: No env file setup
app.listen(PORT, () => {
  console.log("hello word", PORT);
});
