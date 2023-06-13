const sql = require("mssql");
const { promisify } = require("util");
const path = require("path")
const ejs = require('ejs')

let results = null

var config = {
    user: 'manutenzione',
    password: 'manutenzione',
    server: '192.168.1.61',
    database: 'attivitàmanutenzione',
    options: {
        encrypt: false,
        trustServerCertificate: false
    }
}

//Updates the tabel with a new row and returns the corresponding ID when a post request is made to /upload/sendForm
exports.sendForm = async (req, res) => {
    try {
        console.log("Form sent")

        //fetches the varibales from the form submission
        let posizione = req.body.posizione
        let descrizione = req.body.descrizione
        let richiedente = req.body.richiedente

        await sql.connect(config)

        let request = new sql.Request();

        let query = `INSERT INTO tb_OdL (ID_Posizione, DescrizioneLavori, ID_Richiedente) OUTPUT INSERTED.ID VALUES ('${posizione}', '${descrizione}', '${richiedente}')`

        await request.query(query, function (err, results) {
            console.log(err)
            res.render('response', {id: results.recordset[0].ID})   //renders response page and outputs id of the database row that has just been input
        })
    } catch (err) {console.log(err)}
}