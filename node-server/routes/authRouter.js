const express = require("express");
const {
  SomethingWentWrong,
  BadRequest,
  Unauthorized,
  Success,
} = require("../response_helpers/responseHelpers");
const Patient = require("../models/patient");
const { generateToken } = require("./verify");

const router = express.Router();

router.post("/login", async (req, res, next) => {
  try {
    const { email, password } = req.body;
    if (!email || !password) {
      return BadRequest(res, "One or more login fields are missing");
    }

    const user = await Patient.findOne({ email });
    if (!user) {
      return BadRequest(res, "Invalid email");
    }

    var response = user.comparePassword(password);
    if (!response) {
      return Unauthorized(res, "Incorrect Password");
    }

    const toAuthJSON = {
      email,
      id: user._id,
      token: generateToken(email, user._id),
    };

    return Success(res, toAuthJSON);
  } catch (err) {
    return SomethingWentWrong();
  }
});

router.post("/signup", async (req, res, next) => {
  try {
    const { email, password, name, contact, age, gender } = req.body;
    if (!email || !password || !name || !contact || !age || !gender) {
      return BadRequest(res, "One or more input fields are invalid");
    }

    const existingUser = await Patient.findOne({ email });
    if (existingUser) {
      return BadRequest(res, "User with that email already exists");
    }

    const newPatient = new Patient({
      email,
      password,
      name,
      contact,
      age,
      gender,
    });

    const user = await newPatient.savePatient();

    const toAuthJSON = {
      email,
      id: user._id,
      token: generateToken(email, user._id),
    };

    return Success(res, toAuthJSON);
  } catch (err) {
    console.log(err);
    return SomethingWentWrong(res);
  }
});

module.exports = router;
