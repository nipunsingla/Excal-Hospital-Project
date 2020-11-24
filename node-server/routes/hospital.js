const express = require("express");
const routes = express.Router();
const Hosptial = require("../models/hospital.js");
const image = require("../models/image.js");
const multer = require("multer");
var imgbbUploader = require("imgbb-uploader");

const {
  Unauthorized,
  SomethingWentWrong,
  BadRequent,
  Success,
} = require("../response_helpers/responseHelpers");

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

routes.post(
  "/registerHospital",
  upload.single("image"),
  async (req, res, next) => {
    const { name, city, state, specs } = req.body;
    try {
      if (!name || !city || !state || !specs || !req.file) {
        return BadRequent(res, "One or more field unspecified");
      }

      var imgUploaderResponse = await imgbbUploader(apiKey, req.file.path);
      var newHospital = new Hosptial({
        name,
        city,
        state,
        Url: imgUploaderResponse.url,
        specs,
      });

      var response = await newHospital.save();
      return Success(res, response);
    } catch (err) {
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
