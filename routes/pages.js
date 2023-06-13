const express = require("express");
const authController = require("../controllers/auth.js");
const infoController = require("../controllers/info.js");
const router = express.Router();

router.get('/', (req, res) => {     //when the home page is requested the login .ejs file will be loaded
    res.render("login", { root: './views/', message: ""})
});

router.get('/odlInfo/:id', infoController.getInfo)   //Whem odlInfo is requested the info.ejs file will be loaded and the id from URL is passed to the info.ejs file

router.get('/login', (req, res) => {    //If the user makes a get request the main page is rendered, if not logged in will prompt an error
    res.render("main", { root: './views/' })
});
module.exports = router;