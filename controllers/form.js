const sql = require("mssql");
const multer = require('multer');
const { promisify } = require("util");
const path = require("path")
const ejs = require('ejs')
const jwt = require('jsonwebtoken');
let cookieParser = require('cookie-parser');

let results = null

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

function queryPromise(query) {
    return new Promise((resolve, reject) => {
        sql.query(query, (err, result) => {
            if (err) {
                reject(err);
            } else {
                resolve(result);
            }
        });

    });
}

exports.loadMain = async (req, res) => {
    let decodedToken = await promisify(jwt.verify)(req.cookies['token'], process.env.JWT_SECRET)

    //Queries all the info to send to the main.ejs page
    const queries = [
        queryPromise("SELECT * FROM vw_OdL_WEB WHERE Richiedente = " + decodedToken['id'])
    ];

    Promise.all(queries)
        .then(([odl]) => {

            res.status(200).render("main", {    //All the variables are sent through a structure
                odl: odl.recordset,
                user: decodedToken['name'],
            });
        })
}

//Updates the tabel with a new row and returns the corresponding ID when a post request is made to /upload/sendForm
exports.sendForm = async (req, res) => {
    try {
        console.log("Form sent")

        //fetches the varibales from the form submission
        let posizione = req.body.posizione
        let descrizione = req.body.descrizione
        let decodedToken = await promisify(jwt.verify)(req.cookies['token'], process.env.JWT_SECRET)

        // Create a SQL Server connection pool
        const pool = await sql.connect(config);

        console.log(req.file)

        let query = `INSERT INTO tb_OdL (ID_Posizione, DescrizioneLavori, ID_Richiedente) OUTPUT INSERTED.ID VALUES (@posizione, @descrizione, '${decodedToken['id']}')`

        let request = pool.request()
        request.input('posizione', sql.BigInt, posizione)
        request.input('descrizione', sql.NVarChar, descrizione)

        await request.query(query, async function (err, results) {
            console.log(err)
            let idOdl = results.recordset[0].ID
            if (req.file != null) {
                try {
                    let blobData = req.file.buffer;
                    let fileName = req.file.originalname

                    // Create a SQL Server connection pool
                    const pool = await sql.connect(config);

                    console.log(req.file)

                    // Define the SQL query to insert the BLOB data
                    query = 'INSERT INTO tb_AllegatiOdL (data, ID_OdL, NomeFile) VALUES (@blobData, @idOdl, @fileName)';
                    request = pool.request()
                    request.input('blobData', sql.VarBinary, blobData)
                    request.input('idOdl', sql.BigInt, idOdl)
                    request.input('fileName', sql.NVarChar, fileName)

                    // Execute the SQL query
                    await request.query(query);

                } catch (err) {
                    console.log(err)
                } //renders response page and outputs id of the database row that has just been input
            }
            res.redirect('/upload/sendForm/response/' + idOdl)
        })
    } catch (err) { console.log(err) }
}

exports.loadForm = async (req, res) => {
    let decodedToken = await promisify(jwt.verify)(req.cookies['token'], process.env.JWT_SECRET)

    //Queries all the info to send to the main.ejs page
    const queries = [
        queryPromise("SELECT * FROM tb_stabilimenti"),
        queryPromise("SELECT * FROM tb_reparti"),
        queryPromise("SELECT * FROM tb_impianti"),
        queryPromise("SELECT * FROM tb_zone"),
        queryPromise("SELECT * FROM tb_posizioni"),
    ];

    Promise.all(queries)
        .then(([stabilimenti, reparti, impianti, zone, posizioni]) => {
            res.status(200).render("form", {    //All the variables are sent through a structure
                stabilimenti: stabilimenti.recordset,
                reparti: reparti.recordset,
                impianti: impianti.recordset,
                zone: zone.recordset,
                posizioni: posizioni.recordset,
                user: decodedToken['name'],
            });
        })
}