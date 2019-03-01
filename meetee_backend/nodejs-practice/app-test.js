const express = require('express');
const { port } = require('./config');

var db = require('mysql');
// var knex = require('knex')({
//     client: 'mysql',
//     connection: {
//         host: process.env.HOSTNAME,
//         user: process.env.USERNAME,
//         password: process.env.PASSWORD,
//         database: process.env.DATABASE
//     }
// });
const port = 3000;
const hostname = 'localhost';

var app = express();
// var db = mysql();

app.use(express.static(__dirname + '/public'));

app.get('/', (req, res) => {
    res.send('Hello Express v2')
});

app.get('/users', (req, res) => {
    res.send(records)
});

app.listen(port, hostname, () => {
    console.log(`App is running at Port: ${port} Hostname: ${hostname}`)
    console.log("App is running at Port: %s Hostname: %s %d", port, hostname, 155)
}) ;

var con = db.createConnection({
    host: 'sl-us-south-1-portal.48.dblayer.com',
    port: process.env.PORT_NUMBER,
    user: 'admin',
    password: "HFUCWLYVURVEGPOU"
});

var records;
con.connect(function(err) {
    if(err) throw err;
    console.log("Connected!");
    sql = "select * from compose.User";
    con.query(sql, function(err, result){
        if(err) throw err;
        records = result;
        console.log(records);
    });
});