const express = require("express");
const authController = require("../controllers/auth.js");
const jwt = require('jsonwebtoken');
const { promisify } = require("util");
let cookieParser = require('cookie-parser');

const router = express.Router();

router.post('/login', authController.login);    //When the user makes a post request to /auth/login the function will be called
router.get('/logout', authController.logout)    //When the user makes a get request to /auth/logout the cookie will be cleared

router.get('/forgotPassword', (req, res) => {
    res.render('emailForm', {message: ''})
}); 
router.post('/forgotPassword/request', authController.forgotPassword);

router.get('/changePassword', async (req, res) =>{
    let decodedToken =  await promisify(jwt.verify)(req.cookies['token'], process.env.JWT_SECRET)
    res.render('passwordForm', {message: "", user: decodedToken['name']});
});
router.post('/changePassword/upload', authController.isLoggedIn, authController.changePassword);   

module.exports = router;