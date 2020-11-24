const mongoose = require("mongoose");
const bcrypt = require("bcrypt");

const Schema = new mongoose.Schema({
  email: {
    type: String,
    required: true,
  },
  password: {
    type: String,
    required: true,
  },
  name: {
    type: String,
    required: true,
  },
  contact: {
    type: String,
    required: true,
  },
  age: {
    type: Number,
    required: true,
  },
  gender: {
    type: String,
    required: true,
  },
  validEmail: {
    type: Number,
    // required: true,
  },
});

Schema.methods.comparePassword = function (pass) {
  return bcrypt.compareSync(pass, this.password);
};

Schema.methods.savePatient = async function () {
  const hashedPass = bcrypt.hashSync(this.password, 10);
  this.password = hashedPass.toString();
  return await this.save();
};

module.exports = mongoose.model("Patient", Schema);
