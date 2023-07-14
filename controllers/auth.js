const sql = require("mssql");
const crypto = require('crypto')
const { promisify } = require("util");
const path = require("path")
const ejs = require('ejs')
const jwt = require('jsonwebtoken');
let cookieParser = require('cookie-parser');
const { request } = require("http");

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
        //Getting the parameters from the form names
        username = req.body.username;
        password = req.body.password;

        console.log(`Trying to log in as ${username} with password: ${password}`);

        if (!username || !password) { //Check if email and password are empty
            return res.status(400).render("login", {    //Renders the login page with the error message sento as an ejs variable
                message: 'Inserire username e password'
            })
        }

        //Encoding the password to compare it to the one in the database
        password = await crypto.createHash('md5').update(password).digest('hex').toUpperCase()

        // Create a SQL Server connection pool
        const pool = await sql.connect(config);

        let query = `SELECT * FROM tb_risorse WHERE Username = @username AND Password = @password`

        //Creating reqquest object and adding parsed parameters
        let request = await pool.request()
        request.input('username', sql.NVarChar, username)
        request.input('password', sql.NVarChar, password)

        // query to the database and get the records
        await request.query(query, function (err, results) {
            if (err) console.log(err)

            let dbPassword = results.recordset[0]?.Password;    //? is an optional chaining operator that checks if th value exists in the recordset before acceesing it

            if (results.recordset.length == 0 || !(password === dbPassword)) {   //Check if the password is correct

                //Closes the connection
                pool.close().then(() => {console.log('Closed pool')})
                return res.status(401).render('login', {
                    message: 'Username o password non corretti'
                })

            } else {
                //If email and password match
                console.log("Logged in");

                console.log('Genereating token...');

                //Creating the paylod to place in the token
                let payload = { 
                    id: results.recordset[0]?.ID, 
                    name: results.recordset[0]?.Nome + ' ' + results.recordset[0]?.Cognome
                }

                //Creating the token
                let token = jwt.sign(payload, process.env.JWT_SECRET, { expiresIn: '1h' });
                console.log('Token:' + token);

                //PLacing the token in the cookies
                res.cookie('token', token, { path: '/' })

                //Redirecting to home
                res.status(201).redirect('/home');

                pool.close()
                    .then(() => {console.log('Closed pool')})
                    .catch((err) => {console.log(err)})
            }
        })
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
    //Cleargin the cookies to remove the stored token
    res.clearCookie('token');

    console.log('Logged out')

    res.redirect('/');
}

//If both given passwords are equal then it updates the password in the database
exports.changePassword = async (req, res) => {
    let decodedToken =  await promisify(jwt.verify)(req.cookies['token'], process.env.JWT_SECRET)
    let firstPassword = req.body.firstPassword;
    let secondPassword = req.body.secondPassword;

    //If passwords don't match gives error message
    if (firstPassword !== secondPassword) {
        return res.status(400).render('passwordForm', {
            message: 'Le password devono coincidere',
            user: decodedToken['name']
        })
    }

    //Gives error message if one of the fileds is empty
    if (!firstPassword && !secondPassword) { 
        return res.status(400).render('passwordForm', {
            message: 'Inserisci una password valida',
            user: decodedToken['name']
        })
    }

    let encodedPsw = await crypto.createHash('md5').update(firstPassword).digest('hex').toUpperCase()

    // connect to your database
    const pool = await sql.connect(config)

    let query = "UPDATE tb_risorse SET Password = @password WHERE ID = "+ decodedToken['id']

    let request = pool.request()
    request.input('password', sql.NVarChar, encodedPsw)

    await request.query(query, function (err, results) {
        if (err) console.log(err)
        res.status(201).redirect('/home');

        pool.close()
            .then(() => {console.log('Closed pool')})
            .catch((err) => {console.log(err)})
    })
}

//Checks if a user with the given email exists and if it does, returns a message and sends an email
exports.forgotPassword = async (req, res) => {
    let email = req.body.email;
    let id = null

    if (!email) {
        return res.status(400).render('emailForm', {
            message: 'Inserisci un indirizzo valido'
        })
    }

    const pool = await sql.connect(config)
    //Check if the email exists
    let query = "SELECT * FROM tb_risorse WHERE Email = @email";

    let request = pool.request()
    request.input('email', sql.NVarChar, email)

    await request.query(query, function (err, results) {
        if (err) console.log(err)

        //Gives an error if the email addres is not associated with an account
        if (results.recordset.length == 0) {
            pool.close()
                .then(() => {console.log('Closed pool')})
                .catch((err) => {console.log(err)})

            return res.status(404).render('emailForm', {
                message: 'Non esiste un account associato a questo indirizzo'
            })
        } else {
            id = results.recordset[0]?.ID

            query = "INSERT INTO tb_cambioPassword (ID_Richiedente) VALUES (@id)";

            request = pool.request()
            request.input('id', sql.BigInt, id)

            request.query(query, function (err, results) {
                if (err) console.log(err)
                res.redirect('/auth/forgotPassword/request/response')

                pool.close()
                    .then(() => {console.log('Closed pool')})
                    .catch((err) => {console.log(err)})
            })
        }
    })
}