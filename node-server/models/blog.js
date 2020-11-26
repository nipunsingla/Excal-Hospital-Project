const mongoose = require("mongoose");
const Schema = mongoose.Schema;

const blogSchema = new Schema({
    userId: {
        type: Schema.Types.ObjectId,
        // required: true
    },
    userName: {
        type: String,
        // required: true
    },
    title: {
        type: String,
        // required: true
    },
    description: {
        type: String,
        // required: true
    },
    imageUrl: {
        type: String,
    }
});

module.exports = mongoose.model("blog", blogSchema);