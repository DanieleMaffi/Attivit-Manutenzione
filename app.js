const express = require("express");
const path = require("path")
const sql = require("mssql");
const app = express();
const dotenv = require("dotenv").config();
const cookieParser = require("cookie-parser");
const jwt = require('jsonwebtoken');

app.use(express.static("views"));
app.use(express.urlencoded({ extended: false }))
app.use(express.json());
app.use(cookieParser());
app.set('view engine', 'ejs');

//Configuration file for the server

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

/* connect to your database
sql.connect(config, function (err) {

    if (err) console.log(err);

    // create Request object
    var request = new sql.Request();

    // query to the database and get the records
    request.query('select * from tb_risorse', function (err, results) {

        if (err) console.log(err)
    });


})*/

console.log(`\r\n      ___           ___                    ___           ___           ___           ___           ___     \r\n     \/\\  \\         \/\\  \\                  \/\\  \\         \/\\  \\         \/\\  \\         \/\\__\\         \/\\  \\    \r\n    \/::\\  \\       \/::\\  \\                \/::\\  \\       \/::\\  \\       \/::\\  \\       \/:\/  \/        \/::\\  \\   \r\n   \/:\/\\:\\  \\     \/:\/\\:\\  \\              \/:\/\\:\\  \\     \/:\/\\:\\  \\     \/:\/\\:\\  \\     \/:\/  \/        \/:\/\\:\\  \\  \r\n  \/::\\~\\:\\  \\   \/::\\~\\:\\  \\            \/:\/  \\:\\  \\   \/::\\~\\:\\  \\   \/:\/  \\:\\  \\   \/:\/  \/  ___   \/::\\~\\:\\  \\ \r\n \/:\/\\:\\ \\:\\__\\ \/:\/\\:\\ \\:\\__\\          \/:\/__\/_\\:\\__\\ \/:\/\\:\\ \\:\\__\\ \/:\/__\/ \\:\\__\\ \/:\/__\/  \/\\__\\ \/:\/\\:\\ \\:\\__\\\r\n \\:\\~\\:\\ \\\/__\/ \\\/__\\:\\ \\\/__\/          \\:\\  \/\\ \\\/__\/ \\\/_|::\\\/:\/  \/ \\:\\  \\ \/:\/  \/ \\:\\  \\ \/:\/  \/ \\\/__\\:\\\/:\/  \/\r\n  \\:\\ \\:\\__\\        \\:\\__\\             \\:\\ \\:\\__\\      |:|::\/  \/   \\:\\  \/:\/  \/   \\:\\  \/:\/  \/       \\::\/  \/ \r\n   \\:\\ \\\/__\/         \\\/__\/              \\:\\\/:\/  \/      |:|\\\/__\/     \\:\\\/:\/  \/     \\:\\\/:\/  \/         \\\/__\/  \r\n    \\:\\__\\                               \\::\/  \/       |:|  |        \\::\/  \/       \\::\/  \/                 \r\n     \\\/__\/                                \\\/__\/         \\|__|         \\\/__\/         \\\/__\/                  \r\n`)                                                                                                                                                                                  

// Define Routes
app.use('/auth', require('./routes/auth'));
app.use('/upload', require('./routes/upload'))
app.use('/', require('./routes/pages'));

app.listen(80)
