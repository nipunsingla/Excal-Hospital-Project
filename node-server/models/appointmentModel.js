const { duration } = require("moment");
const mongoose = require("mongoose");
const Schema = mongoose.Schema;

const appointmentSchema = new Schema({
  hospitalId: {
    type: Schema.Types.ObjectId,
    required: true,
  },
  patientId: {
    type: Schema.Types.ObjectId,
    required: true,
  },
  appointmentDateAndTime: {
    type: String,
    required: true,
  },
  duration: {
    type: Number,
    default: 30 * 60, // * 30 mins = 30 * 60 seconds
  },
  delay: {
    type: Number,
    default: 0,
  },
  status: {
    type: Boolean,
  },
});

module.exports = mongoose.model("appointment", appointmentSchema);
