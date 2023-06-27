const express = require("express");
const multer = require('multer');
const formController = require("../controllers/form.js");
const authController = require("../controllers/auth.js");
const storage = multer.memoryStorage(); // Store files in memory
const upload = multer({ storage });

const router = express.Router();

router.get('/form', authController.isLoggedIn, formController.loadForm)

router.post('/sendForm', authController.isLoggedIn, upload.single('allegato'), formController.sendForm);  //When a post request is made to /upload/sendForm the formController.sendForm function is called.

router.get('/sendForm/response/:id', authController.isLoggedIn, (req, res) => {res.render('response', {id: req.params.id})})

module.exports = router;