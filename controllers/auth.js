const sql = require("mssql");
const crypto = require('crypto')
const { promisify } = require("util");
const path = require("path")
const ejs = require('ejs')

let results = null;
let { email, password } = "";

//Database configuration file
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

//This function is called from the /auth/login post request and handles the login process
exports.login = async (req, res) => {
    try {

        email = req.body.email;
        password = req.body.password;
        console.log(`Trying to log in as ${email} with password: ${password}`);
        let oneStepBack = path.join(__dirname, '../');
        if (!email || !password) { //Check if email and password are empty

            console.log("Did not find email or password");

            return res.status(400).render(oneStepBack + "views/login", {    //Renders the login page with the error message sento as an ejs variable
                message: 'Inserire email e password'
            })

        }

        // connect to your database
        await sql.connect(config)

        // create Request object
        var request = new sql.Request();

        password = await crypto.createHash('md5').update(password).digest('hex').toUpperCase();

        // query to the database and get the records
        await request.query("SELECT * FROM tb_risorse WHERE Email = '" + email + "' AND Password = '" + password + "'", function (err, results) {
            if (err) console.log(err)

            let dbPassword = results.recordset[0]?.Password;    //? is an optional chaining operator that checks if th value exists in the recordset before acceesing it

            if (!results || !(password === dbPassword)) {   //Check if the password is correct

                console.log("invalid email or password");

                return res.status(401).render(oneStepBack + 'views/login', {
                    message: 'Email o password non corretti'
                })

            } else {
                //If email and password match
                console.log("Logged in");

                let stabilimenti, reparti, impianti, posizioni = null

                function queryPromise(queryString) {
                    return new Promise((resolve, reject) => {
                        request.query(queryString, function (err, data) {
                            if (err) {
                                reject(err);
                            } else {
                                resolve(data);
                            }
                        });
                    });
                }

                //Queries all the info to send to the main.ejs page
                const queries = [
                    queryPromise("SELECT * FROM tb_stabilimenti"),
                    queryPromise("SELECT * FROM tb_reparti"),
                    queryPromise("SELECT * FROM tb_impianti"),
                    queryPromise("SELECT * FROM tb_zone"),
                    queryPromise("SELECT * FROM tb_posizioni")
                ];

                Promise.all(queries)
                    .then(([stabilimenti, reparti, impianti, zone, posizioni]) => {
                        console.log(stabilimenti.recordset);
                        console.log(reparti.recordset);
                        console.log(impianti.recordset);
                        console.log(zone.recordset);
                        console.log(posizioni.recordset);

                        res.status(200).render(oneStepBack + "views/main", {    //All the variables are sent through a structure
                            user: results.recordset[0].Nome + " " + results.recordset[0].Cognome, 
                            id: results.recordset[0].ID,
                            stabilimenti: stabilimenti.recordset,
                            reparti: reparti.recordset,
                            impianti: impianti.recordset,
                            zone: zone.recordset,
                            posizioni: posizioni.recordset
                        });
                    })
            }
        });
    } catch (err) { }
}

