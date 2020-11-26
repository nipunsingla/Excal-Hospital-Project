const express = require("express");
const router = express.Router();
const CryptoJS = require("crypto-js");
const axios = require("axios");

const {
    Unauthorized,
    BadRequest,
    Success,
    SomethingWentWrong,
} = require("../response_helpers/responseHelpers");

router.get("/getIssues", async (req, res, next) => {
    try {
        const { symptoms } = req.body;
        var computedHash = CryptoJS.HmacMD5(process.env.SYMP_URI, process.env.SYMP_SECRET_KEY);
        var computedHashString = computedHash.toString(CryptoJS.enc.Base64);
        var authValue = "Bearer " + process.env.SYMP_API_KEY + ":" + computedHashString;
        var response = await axios.post(process.env.SYMP_URI, {
            headers: {
                Authorization : authValue.toString()
            }  
        });
        // console.log(response);
        return Success(res);

    } catch (err) {
        console.log(err.response.data);
        return SomethingWentWrong(res);
    }
});

module.exports = router;