const express = require('express');
const jwt = require('jsonwebtoken');
const secret = require('../config/key').secret
const generateToken =  (email, _id) => {
    const token = jwt.sign({ email, _id }, secret);
    console.log(token);
    return token;
};
const getUsername = async (req) => {


}
const verifyToken = async (req, res, next) => {
    console.log(req.headers)
    const token = req.headers['authorization'];
    console.log(token);
    try {
        if (!token) {
            return res.json({
                message:'Token is Not Correct',
                flag:0,
            })
        }
        const decrypt = await jwt.verify(token, secret);
        req.user = {
            email: decrypt.email,
            _id: decrypt._id,
        };
        next();
    } catch (err) {
        return res.json({
            message:'You need to Re Login',
            flag:0,
        })
    }
};
module.exports = { generateToken, verifyToken ,getUsername}