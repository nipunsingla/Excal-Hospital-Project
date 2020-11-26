const express = require("express");
const router = express.Router();

var imgbbUploader = require("imgbb-uploader");
const Blog = require("../models/blog.js");
const Patient = require("../models/patient.js");
const multer = require("multer");

const {
  Unauthorized,
  BadRequest,
  Success,
  SomethingWentWrong,
} = require("../response_helpers/responseHelpers");
const { response } = require("express");

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

router.post("/create", upload.single("image"), async (req, res, next) => {
  try {
    const { _id } = req.user;
    const { blogTitle, blogDesc } = req.body;
    if (!blogTitle || !blogDesc) {
      return BadRequest(res, "One or more fields Invalid");
    }
    const user = await Patient.findById(_id);
    const { name } = user;
    var imgUploaderResponse = await imgbbUploader(apiKey, req.file.path);
    const blog = new Blog({
      userId: _id,
      userName: name,
      title: blogTitle,
      description: blogDesc,
      imageUrl: imgUploaderResponse.url,
    });
    const response = await blog.save();
    return Success(res, response);
  } catch (err) {
    console.log(err);
    return SomethingWentWrong(res);
  }
});

router.get("/read", async (req, res, next) => {
  try {
    const { blogId } = req.body;
    const blog = await Blog.findById(blogId);
    if (!blog) {
      return BadRequest(res, "No blog found!");
    }
    return Success(res, blog);
  } catch (err) {
    console.log(err);
    return SomethingWentWrong(res);
  }
});

router.get("/readAll", async (req, res, next) => {
  try {
    const response = await Blog.find();
    return Success(res, response);
  } catch (err) {
    console.log(err);
    return SomethingWentWrong(res);
  }
});

router.patch("/update", upload.single("image"), async (req, res, next) => {
  try {
    const { blogId } = req.body;
    var blog = await Blog.findById(blogId);
    if (!blog) {
      return BadRequest(res, "No such Blog found!");
    }
    const { _id } = req.user;
    const { blogTitle, blogDesc } = req.body;
    if (!blogTitle || !blogDesc) {
      return BadRequest(res, "One or more fields Invalid!");
    }
    const user = await Patient.findById(_id);
    const { name } = user;
    var imgUploaderResponse = await imgbbUploader(apiKey, req.file.path);
    const response = await Blog.updateOne(
      { _id: blogId },
      {
        $set: {
          userId: _id,
          userName: name,
          title: blogTitle,
          description: blogDesc,
          imageUrl: imgUploaderResponse.url,
        },
      }
    );
    if (!response.nModified) {
      return BadRequest(res, "Not Modified, Something went wrong!");
    }
    return Success(res, response);
  } catch (err) {
    console.log(err);
    return SomethingWentWrong(res);
  }
});

router.delete("/delete", async (req, res, next) => {
  try {
    const { blogId } = req.body;
    const blog = await Blog.findOne({ _id: blogId });
    if (!blog) {
      return BadRequest(res, "No such Blog found!");
    }

    if (blod.userId.toString() !== req.user._id.toString()) {
      return Unauthorized(res, "You are not authorized to delete this blog");
    }

    const response = await Blog.deleteOne({ _id: blogId });
    return Success(res, response);
  } catch (err) {
    console.log(err);
    return SomethingWentWrong(res);
  }
});

module.exports = router;
