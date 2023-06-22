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

router.get('/forgotPassword/request/response', (req, res) => {
    res.status(200).send(
        `<!doctype html>
        <html lang="en" data-bs-theme="light">
        
        <head>
            <!-- Required meta tags -->
            <meta charset="utf-8">
            <meta name="viewport" content="width=device-width, initial-scale=1">
        
            <!-- Bootstrap CSS -->
            <link rel="stylesheet" href="/style.css">
            <link rel="icon" type="images/x-icon" href="/minilogo.png" />
            <title>Response</title>
        </head>
        <body>
            <div style="display: flex; height: 100vh; align-items: center; justify-content: center; flex-direction: column;">
                <h1 class="display-4 row">Controlla la tua casella per visualizzare la nuova password</h1>
            </div>
        </html>`
    );
})

router.get('/changePassword', authController.isLoggedIn, async (req, res) =>{
    let decodedToken =  await promisify(jwt.verify)(req.cookies['token'], process.env.JWT_SECRET)
    res.render('passwordForm', {message: "", user: decodedToken['name']});
});
router.post('/changePassword/upload', authController.isLoggedIn, authController.changePassword);   

module.exports = router;