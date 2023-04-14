const express = require('express');
const bodyParser = require('body-parser');
const mysql = require('mysql');

const app = express();
const router = express.Router();

const port = process.env.SERVICE_PORT || 3000;

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));
console.log(process.env.MYSQL_HOST);
const db = mysql.createConnection({
    host: process.env.MYSQL_HOST,
    user: process.env.MYSQL_USER,
    password: process.env.MYSQL_PASSWORD,
    database: process.env.MYSQL_DB,
    port: process.env.MYSQL_PORT
});

db.connect();

router.post('/', function (req, res) {
    db.query(`INSERT INTO ${process.env.MYSQL_DB} SET ?`,
        { ...req.body, ip: req.ip },
        function (err, result) {
            if (err) {
                console.log(err);
                res.status(500).send({ error: 'Error saving data' });
            } else {
                console.log('Saved.');
                res.send({ message: 'Data saved successfully' });
            }
        }
    );
});

router.get('/results', function (req, res) {
    db.query('SELECT preference, COUNT(*) AS qtd FROM preferences GROUP BY preference ORDER BY qtd DESC', function (err, results, fields) {
        if (err) {
            console.log(err);
            res.status(500).send({ error: 'Error fetching data' });
        } else {
            res.send({ data: results });
        }
    });
});

app.use('/', router);
app.listen(port);

console.log(`Running on port ${port}`);
