const sql = require("mssql");
const crypto = require('crypto')
const { promisify } = require("util");
const path = require("path")
const ejs = require('ejs')
const jwt = require('jsonwebtoken');
let cookieParser = require('cookie-parser');

let results = null;
let { email, password } = "";

//Token variables
let secret = process.env.JWT_SECRET;


//Database configuration file
var config = {
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    server: process.env.DB_SERVER,
    database: process.env.DB,
    options: {
        encrypt: false,
        trustServerCertificate: false
    }
};

//This function is called from the /auth/login post request and handles the login process
exports.login = async (req, res) => {
    try {

        email = req.body.email;
        password = req.body.password;
        console.log(`Trying to log in as ${email} with password: ${password}`);
        let oneStepBack = path.join(__dirname, '../');
        if (!email || !password) { //Check if email and password are empty

            return res.status(400).render(oneStepBack + "views/login", {    //Renders the login page with the error message sento as an ejs variable
                message: 'Inserire email e password'
            })

        }

        // connect to your database
        await sql.connect(config)

        // create Request object
        var request = new sql.Request();

        password = await crypto.createHash('md5').update(password).digest('hex').toUpperCase()

        // query to the database and get the records
        await request.query("SELECT * FROM tb_risorse WHERE Email = '" + email + "' AND Password = '" + password + "'", function (err, results) {
            if (err) console.log(err)

            let dbPassword = results.recordset[0]?.Password;    //? is an optional chaining operator that checks if th value exists in the recordset before acceesing it

            if (results.recordset.length == 0 || !(password === dbPassword)) {   //Check if the password is correct

                return res.status(401).render(oneStepBack + 'views/login', {
                    message: 'Email o password non corretti'
                })

            } else {
                //If email and password match
                console.log("Logged in");

                console.log('Genereating token...');
                let payload = { 
                    id: results.recordset[0]?.ID, 
                    name: results.recordset[0]?.Nome + ' ' + results.recordset[0]?.Cognome
                }
                let token = jwt.sign(payload, process.env.JWT_SECRET, { expiresIn: '1h' });
                console.log('Token:' + token);

                res.cookie('token', token, { path: '/' })
                res.status(201).redirect('/home');
            }
        });
    } catch (err) { }
}

//Check id the token is still valid
exports.isLoggedIn = async (req, res, next) => {
    if (req.cookies['token']) {
        try {
            //Verifying the token
            let decoded = await promisify(jwt.verify)(req.cookies['token'], process.env.JWT_SECRET);
            console.log(decoded);
        } catch (err) {
            console.log(err)
            return res.status(401).redirect('/')
        }
    } else {
        return res.status(401).redirect('/')
    }
    return next();
}

exports.logout = (req, res) => {
    res.clearCookie('token');
    console.log('Logged out')
    res.redirect('/');
}

//If both given passwords are equal then it updates the password in the database
exports.changePassword = async (req, res) => {
    // connect to your database
    await sql.connect(config)

    // create Request object
    var request = new sql.Request();

    let decodedToken =  await promisify(jwt.verify)(req.cookies['token'], process.env.JWT_SECRET)
    let firstPassword = req.body.firstPassword;
    let secondPassword = req.body.secondPassword;

    if (firstPassword !== secondPassword) {
        return res.status(400).render('passwordForm', {
            message: 'Le password devono coincidere',
            user: decodedToken['name']
        })
    }

    if (!firstPassword && !secondPassword) { 
        return res.status(400).render('passwordForm', {
            message: 'Inserisci una password valida',
            user: decodedToken['name']
        })
    }

    let encodedPsw = await crypto.createHash('md5').update(firstPassword).digest('hex').toUpperCase()

    let query = "UPDATE tb_risorse SET Password = '" + encodedPsw + "' WHERE ID = " + decodedToken['id']

    await request.query(query, function (err, results) {
        if (err) console.log(err)
        res.status(201).redirect('/home');
    });
}

//Checks if a user with the given email exists and if it does, returns a message and sends an email
exports.forgotPassword = async (req, res) => {
    await sql.connect(config)

    var request = new sql.Request();

    let email = req.body.email;
    let id = null

    //Check id the email exists
    let query = "SELECT * FROM tb_risorse WHERE Email = '" + email + "'";

    await request.query(query, function (err, results) {
        if (err) console.log(err)
        if (results.recordset.length == 0) {
            return res.status(404).render('emailForm', {
                message: 'Non esiste un account associato a questo indirizzo'
            })
        } else {
            id = results.recordset[0]?.ID
            query = "INSERT INTO tb_cambioPassword (ID_Richiedente) VALUES (" + id + ")";

            request.query(query, function (err, results) {
                if (err) console.log(err)
                res.status(200).send(
                    `<!doctype html>
                    <html lang="en" data-bs-theme="light">
                    
                    <head>
                        <!-- Required meta tags -->
                        <meta charset="utf-8">
                        <meta name="viewport" content="width=device-width, initial-scale=1">
                    
                        <!-- Bootstrap CSS -->
                        <link rel="stylesheet" href="/style.css">
                    
                        <title>Response</title>
                    </head>
                    <body>
                        <div style="display: flex; height: 100vh; align-items: center; justify-content: center; flex-direction: column;">
                            <h1 class="display-4 row">Controlla la tua casella per visualizzare la nuova password</h1>
                        </div>
                    </html>`
                );
            })
        }
    })
}