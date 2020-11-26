const mongoose = require("mongoose");
const Schema = mongoose.Schema;

const hospital = new Schema({
  name: {
    type: String,
    required: true,
  },
  city: {
    type: String,
    required: true,
  },
  state: {
    type: String,
    required: true,
  },
  hospitalUrl: {
    type: String,
  },
  specs: {
    type: String,
  },
  imageUrl: {
    type: String,
  },
  meetLink: {
    type: String,
  },
  delay: {
    type: Number,
    default: 0,
  },
  timings: [
    {
      type: Object,
    },
  ],
});

hospital.methods.bookTimeSlot = function (time) {
  var found = false;
  this.timings.map((slot) => {
    if (slot.timeslotStart === time) {
      slot.status = !slot.status;
      found = true;
    }
  });
  return found;
};

module.exports = mongoose.model("hospital", hospital);
