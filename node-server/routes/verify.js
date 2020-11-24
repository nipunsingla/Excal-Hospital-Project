const jwt = require("jsonwebtoken");
const {
  Unauthorized,
  SomethingWentWrong,
} = require("../response_helpers/responseHelpers");
const secret = require("../config/key").secret;
const Patient = require("../models/patient");

const generateToken = (email, _id) => {
  const token = jwt.sign({ email, _id }, secret);
  console.log(token);
  return token;
};

const getUsername = async (req) => {}; // * Unspecified method

const verifyToken = (req, res, next) => {
  try {
    const token = req.headers["authorization"];
    if (!token) {
      return Unauthorized(res);
    }
    const decrypt = jwt.verify(token, secret);
    req.user = {
      email: decrypt.email,
      _id: decrypt._id,
    };
    next();
  } catch (err) {
    return SomethingWentWrong(res);
  }
};

const authUser = async (req, res, next) => {
  try {
    if (!req.user._id) {
      return Unauthorized(res);
    }
    const patient = await Patient.findOne({ _id: req.user._id });
    if (!patient) {
      return Unauthorized(res);
    }
    next();
  } catch (err) {
    return SomethingWentWrong(res);
  }
};

module.exports = { generateToken, verifyToken, getUsername, authUser };
