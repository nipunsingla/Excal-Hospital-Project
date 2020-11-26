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


router.get("/getAll", async(req, res, next) => {
    try {
        return Success(res, consultantData);
    } catch (err) {
        return SomethingWentWrong(res);
    }
});

module.exports = router;