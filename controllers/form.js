const sql = require("mssql");
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

//Updates the tabel with a new row and returns the corresponding ID when a post request is made to /upload/sendForm
exports.sendForm = async (req, res) => {
    try {
        console.log("Form sent")

        //fetches the varibales from the form submission
        let posizione = req.body.posizione
        let descrizione = req.body.descrizione
        let decodedToken =  await promisify(jwt.verify)(req.cookies['token'], process.env.JWT_SECRET)

        await sql.connect(config)

        let request = new sql.Request();

        let query = `INSERT INTO tb_OdL (ID_Posizione, DescrizioneLavori, ID_Richiedente) OUTPUT INSERTED.ID VALUES ('${posizione}', '${descrizione}', '${decodedToken['username']}')`

        await request.query(query, function (err, results) {
            console.log(err)
            res.render('response', {id: results.recordset[0].ID})   //renders response page and outputs id of the database row that has just been input
        })
    } catch (err) {console.log(err)}
}