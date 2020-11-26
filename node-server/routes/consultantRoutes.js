const { Router } = require("express");
const express = require("express");
const router = express.Router();

const {
    SomethingWentWrong,
    BadRequest,
    Unauthorized,
    Success,
} = require("../response_helpers/responseHelpers");

const consultantData = require("../seeder/consultant_seeder.js");


router.get("/getAll", (req, res, next) => {
    console.log("i am in get all")
    try {
        console.log("i am in success");
        return Success(res, consultantData);
    } catch (err) {
        console.log("mksmlfk");
        return SomethingWentWrong(res);
    }
});

module.exports = router;