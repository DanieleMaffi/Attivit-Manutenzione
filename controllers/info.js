const sql = require("mssql");
const { promisify } = require("util");
const path = require("path")
const ejs = require('ejs')

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

        let query = `SELECT * FROM vw_OdL_WEB WHERE ID = ${req.params.id}`

        await request.query(query, function (err, results) {
            console.log(results, err)
            res.render("info", { root: './views/', results: results.recordset})
        })
    } catch (err) {console.log(err)}
}