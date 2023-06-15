const express = require("express");
const authController = require("../controllers/auth.js");

const router = express.Router();

router.post('/login', authController.login);    //When the user makes a post request to /auth/login the function will be called
router.get('/logout', authController.logout)    //When the user makes a get request to /auth/logout the cookie will be cleared

module.exports = router;