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

exports.getInfo = async (req, res) => {
    try {
        await sql.connect(config)

        let request = new sql.Request();

        let decodedToken =  await promisify(jwt.verify)(req.cookies['token'], process.env.JWT_SECRET)

        let query = `SELECT * FROM vw_OdL_WEB WHERE ID = ${req.params.id}`

        await request.query(query, function (err, results) {
            console.log(results, err)
            if (results.recordset[0]?.Richiedente == decodedToken['id']) 
                res.render("info", { root: './views/', results: results.recordset, user: decodedToken['name']})
            else
                res.send("Non hai accesso a questo ordine")
        })
    } catch (err) {console.log(err)}
}