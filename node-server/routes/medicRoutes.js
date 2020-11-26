const express = require("express");
const router = express.Router();
const CryptoJS = require("crypto-js");
const axios = require("axios");
const Patient = require("../models/patient");

const {
    Unauthorized,
    BadRequest,
    Success,
    SomethingWentWrong,
} = require("../response_helpers/responseHelpers");

router.post("/getIssues", async (req, res, next) => {
    try {
        console.log("in issue")
        const { symptoms } = req.body;
        const { _id } = req.user;
        const user = await Patient.findById(_id);
        var computedHash = CryptoJS.HmacMD5(process.env.SYMP_URI, process.env.SYMP_SECRET_KEY);
        var computedHashString = computedHash.toString(CryptoJS.enc.Base64);
        var authValue = "Bearer " + process.env.SYMP_API_KEY + ":" + computedHashString;
        var config = {
            method: 'post',
            url: process.env.SYMP_URI,
            headers: { 
              'Authorization': authValue, 
              'Cookie': 'ASP.NET_SessionId=1g0haj4hy3ki03laownw1gxr'
            }
        };
        var response = await axios(config);
        const token = response.data.Token;
        var medicUrl = 'https://healthservice.priaid.ch/diagnosis?';
        medicUrl += 'token=' + token;
        medicUrl += '&';
        medicUrl += 'language=' + "en-gb";
        medicUrl += '&';
        medicUrl += 'symptoms=' + symptoms;
        medicUrl += '&';
        medicUrl += 'gender=' + "male";
        medicUrl += '&';
        medicUrl += 'year_of_birth=' + '1998';  
        config = {
            method: 'get',
            url: medicUrl,
            headers: { 
              'Cookie': 'ASP.NET_SessionId=3sssd2gxip11rfjuxph3lniu'
            }
        };
        response = await axios(config);
        return Success(res, response.data);

    } catch (err) {
        console.log(err);
        return SomethingWentWrong(res);
    }
});

module.exports = router;