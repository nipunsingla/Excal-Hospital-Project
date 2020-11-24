const express = require("express");
const routes = express.Router();
const image = require("../models/image.js");
const multer = require("multer");
var imgbbUploader = require("imgbb-uploader");

const Hosptial = require("../models/hospital.js");
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
    var hospitals = await Hosptial.find({ city });
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
    var hospitals = await Hosptial.find({ state });
    return Success(res, hospitals);
  } catch (err) {
    return SomethingWentWrong(res);
  }
});

routes.get("/getAllHospitals", async (req, res, next) => {
  try {
    var hospitals = await Hosptial.find();
    return Success(res, hospitals);
  } catch (err) {
    return SomethingWentWrong(res);
  }
});

routes.get("/getPatientList", async (req, res, next) => {
  try {
    const { id } = req.body;
    const appointments = await Appointment.find({ hospitalId: id });
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
    try {
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
      var newHospital = new Hosptial({
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

// routes.post("/", upload.single("image"), (req, res) => {
//   var { name, city, state, specs } = req.body;
//   name = name.toLowerCase();
//   city = city.toLowerCase();
//   state = state.toLowerCase();
//   specs = specs.toLowerCase();
//   // console.log(name, city, state, specs)
//   // console.log(specs)
//   if (!req.file) {
//     res.render("hospital", { message: "some detail is missing", flag: "1" });
//   }
//   const file = req.file.path;
//   var file_name = req.file.originalname.split(".")[1];
//   var target_path = "upload/" + name + "." + file_name;
//   // console.log(req.file.path)
//   //console.log(file_name);
//   imgbbUploader("d280e1203b0c1c3b9f00013d8580227c", req.file.path)
//     .then((response) => {
//       //   console.log(response)
//       if (!name || !city || !state) {
//         res.render("hospital", {
//           message: "some detail is missing",
//           flag: "1",
//         });
//       } else {
//         Hosptial.findOne({ name: name, city: city, state: state }).then(
//           (user) => {
//             if (user) {
//               res.render("hospital", { message: "hospital exists", flag: "1" });
//             } else {
//               const a = new image();
//               //      console.log(req.file.path)
//               //a.img.data = fs.readFileSync(req.file.path)
//               //a.img.contentType = 'image/' + file_name;
//               const newHosptial = new Hosptial({
//                 name: name,
//                 city: city,
//                 state: state,
//                 Url: response.url,
//                 image: a,
//                 specs: specs,
//               });
//               newHosptial.save((err, user) => {
//                 if (err) {
//                   res.render("hospital", { message: "some error", flag: "1" });
//                 } else {
//                   //   console.log(user)
//                   //res.contentType(user.image.img.contentType)
//                   //res.send(user.image.img.data)
//                   res.render("hospital", {
//                     message: "succesfully added",
//                     flag: "2",
//                   });
//                 }
//               });
//             }
//           }
//         );
//       }
//     })
//     .catch((err) => {
//       res.render("hospital", { message: "some error", flag: "1" });
//     });
// });

module.exports = routes;
