const express = require("express");
const formController = require("../controllers/form.js");

const router = express.Router();

router.post('/sendForm', formController.sendForm);  //When a post request is made to /upload/sendForm the formController.sendForm function is called.

module.exports = router;