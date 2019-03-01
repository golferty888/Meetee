const express = require('express');
var app = express();

var knex = require('knex')({
    client: 'mysql',
    connection: {
        host: 'sl-us-south-1-portal.48.dblayer.com',
        port: 16847,
        user: 'admin',
        password: 'HFUCWLYVURVEGPOU',
        database: 'compose'
    }
});

module.exports = knex;