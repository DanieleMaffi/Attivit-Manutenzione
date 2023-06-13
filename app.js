const express = require("express");
const path = require("path")
const sql = require("mssql");
const app = express();
const dotenv = require("dotenv").config();
const cookieParser = require("cookie-parser");

app.use(express.static("views"));
app.use(express.urlencoded({ extended: false }))
app.use(express.json());
app.use(cookieParser());
app.set('view engine', 'ejs');

//Configuration file for the server

var config = {
    user: 'manutenzione',
    password: 'manutenzione',
    server: '192.168.1.61',
    database: 'attivitàmanutenzione',
    options: {
        encrypt: false,
        trustServerCertificate: false
    }
};

// connect to your database
sql.connect(config, function (err) {

    if (err) console.log(err);

    // create Request object
    var request = new sql.Request();

    // query to the database and get the records
    request.query('select * from tb_risorse', function (err, results) {

        if (err) console.log(err)
        console.log(results.recordset)
    });


});

// Define Routes
app.use('/', require('./routes/pages'));
app.use('/auth', require('./routes/auth'));
app.use('/upload', require('./routes/upload'))

app.listen(80)
