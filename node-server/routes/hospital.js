const express = require("express");
const routes = express.Router();
const image = require("../models/image.js");
const multer = require("multer");
var imgbbUploader = require("imgbb-uploader");

const Hospital = require("../models/hospital.js");
const Appointment = require("../models/appointmentModel");

const {
  Unauthorized,
  SomethingWentWrong,
  BadRequest,
  Success,
} = require("../response_helpers/responseHelpers");
const { parse } = require("path");

const apiKey = "d280e1203b0c1c3b9f00013d8580227c";

var storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, "upload");
  },
  filename: function (req, file, cb) {
    cb(null, file.fieldname + "-" + Date.now());
  },
});

var upload = multer({ storage: storage });

routes.get("/", (req, res) => {
  res.render("hospital", { message: "", flag: "0" });
});

routes.get("/getAllHospitalsByCity", async (req, res, next) => {
  try {
    const { city } = req.body;
    if (!city) {
      return BadRequent(res, "Invalid Request!!! - City Field unspecified");
    }
    var hospitals = await Hospital.find({ city });
    return Success(res, hospitals);
  } catch (err) {
    return SomethingWentWrong(res);
  }
});

routes.get("/getAllHospitalsByState", async (req, res, next) => {
  try {
    const { state } = req.body;
    if (!state) {
      return BadRequent(res, "Invalid Request!!!  - State Field unspecified");
    }
    var hospitals = await Hospital.find({ state });
    return Success(res, hospitals);
  } catch (err) {
    return SomethingWentWrong(res);
  }
});

routes.get("/getAllHospitals", async (req, res, next) => {
  try {
    var hospitals = await Hospital.find();
    return Success(res, hospitals);
  } catch (err) {
    return SomethingWentWrong(res);
  }
});

routes.get("/getPatientList", async (req, res, next) => {
  try {
    const { id } = req.body;
    const appointments = await Appointment.find({ hospitalId: id }).populate(
      "patientId"
    );
    console.log(appointments);
    return Success(res, appointments);
  } catch (err) {
    return SomethingWentWrong(res);
  }
});

// meetLink,
routes.post(
  "/registerHospital",
  upload.single("image"),
  async (req, res, next) => {
    try {
      const {
        name,
        city,
        state,
        specs,
        meetLink,
        startTime,
        endTime,
        hospitalUrl,
      } = req.body;

      if (
        !name ||
        !city ||
        !state ||
        !specs ||
        !req.file ||
        !meetLink ||
        !startTime ||
        !endTime ||
        !hospitalUrl
      ) {
        return BadRequest(res, "One or more field unspecified");
      }
      var st_time = startTime.split(":");
      var en_time = endTime.split(":");
      var start = new Date();
      var end = new Date();
      start.setHours(
        parseInt(st_time[0], 10),
        parseInt(st_time[1], 10),
        parseInt(st_time[2], 10)
      );
      end.setHours(
        parseInt(en_time[0], 10),
        parseInt(en_time[1], 10),
        parseInt(en_time[2], 10)
      );
      const timings = [];
      var tmp1 = start;
      var tmp2 = new Date(tmp1.getTime() + 30 * 60000);
      while (tmp1 <= end) {
        timings.push({
          timeslotStart: tmp1.toString().split(" ")[4],
          timeslotEnd: tmp2.toString().split(" ")[4],
          status: false,
        });
        tmp1 = new Date(tmp1.getTime() + 35 * 60000);
        tmp2 = new Date(tmp1.getTime() + 30 * 60000);
      }
      var imgUploaderResponse = await imgbbUploader(apiKey, req.file.path);
      var newHospital = new Hospital({
        name,
        city,
        state,
        imageUrl: imgUploaderResponse.url,
        specs,
        meetLink,
        timings,
        hospitalUrl,
      });

      var response = await newHospital.save();
      return Success(res, response);
    } catch (err) {
      console.log(err);
      return SomethingWentWrong(res);
    }
  }
);

module.exports = routes;
