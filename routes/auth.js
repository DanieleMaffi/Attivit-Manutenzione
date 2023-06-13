const express = require("express");
const authController = require("../controllers/auth.js");

const router = express.Router();

router.post('/login', authController.login);    //When the user makes a post requesto to /auth/login the function will be called

module.exports = router;