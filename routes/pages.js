const express = require("express");
const authController = require("../controllers/auth");
const router = express.Router();
router.get('/', (req, res) => {     //when the home page is requested the login .ejs file will be loaded
    res.render("login", { root: './views/', message: ""})
});
router.get('/login', (req, res) => {    //If the user makes a get request the main page is rendered, if not logged in will prompt an error
    res.render("main", { root: './views/' })
});
module.exports = router;