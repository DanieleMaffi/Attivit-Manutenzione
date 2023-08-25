const express = require("express");
const authController = require("../controllers/auth.js");
const infoController = require("../controllers/info.js");
const formController = require("../controllers/form.js");
const router = express.Router();

router.get('/', (req, res) => {     //when the home page is requested the login .ejs file will be loaded
    res.render("login", { root: './views/', message: "" })
});

router.get('/odlInfo/:id', authController.isLoggedIn, infoController.getInfo)   //When odlInfo is requested the info.ejs file will be loaded and the id from URL is passed to the info.ejs file

router.get('/home', authController.isLoggedIn, formController.loadMain)  
router.get('/closed', authController.isLoggedIn, formController.loadClosed) 

router.get('*', (req, res) => {res.status(404).render('notfound')})

module.exports = router;