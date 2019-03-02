const express = require('express');
const PORT = process.env.PORT || 8081;
const URL = process.env.URL || '10.26.245.117';
const app = express();
const morgan = require('morgan');
const knex = require('./db/knex');
const bodyParser = require('body-parser');

app.use(express.static('./public'));

app.use(morgan('short'));

app.use(bodyParser.urlencoded({ extended: false }));

function formatUser (data) {
    const result = {
        firstname: data.firstname,
        lastname: data.lastname
    }
    return result
}

app.get('/api/users', (request, response) => {
    knex.select().from('User')
        .then(function (result) {
            console.log(result);
            response.send(result);
        })
        .catch(err => {
            console.log(err);
        })
});

app.get('/user/:id', (request, response) => {
    var userId = request.params.id;
    console.log("Fetching User id:" + userId);
    knex.select().from('User').where('user_id', userId)
        .then(function (result) {
            console.log(result[0])
            response.send(result[0]);
        })
        .catch(err => {
            console.log(err);
        })
});

app.post('/user', (request, response) => {
    knex('User').insert({
        firstname: 'Peem',
        lastname: 'Pussii'
    })
        .catch(err => {
            console.log(err);
        })
        .then(function () {
            knex.select().from('User')
                .then(function (result) {
                    response.send(result);
                })
                .catch(err => {
                    console.log(err);
                })
        })
});

app.post('/user-api', (request, response) => {
    const firstname = request.body.first_name;
    const lastname = request.body.last_name;
    console.log("Trying to create a new User");
    console.log("Firstname: " + firstname);
    console.log("lastname: " + lastname);
    response.end();
});

app.get('/', (request, response) => {
    response.render('./public/form');
    response.send('Hello This is my application.');
})


app.listen(PORT, URL, () => {
    console.log(`Listening on port: ${PORT}`);
});