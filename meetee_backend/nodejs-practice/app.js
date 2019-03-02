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
app.use(bodyParser.json());

function formatUser(data) {
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

app.get('/api/user/:id', (request, response) => {
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

app.post('/api/create-user', (request, response) => {
    if (request.body.first_name == null || 
        request.body.last_name == null) {
        return response.sendStatus(400);
    }
    const firstname = request.body.first_name;
    const lastname = request.body.last_name;
    knex('User').insert({
        firstname: firstname,
        lastname: lastname
    })
        .catch(err => {
            console.log(err);
        })
    response.send("You've successfully created the user.")
    response.end();
});

app.get('/', (request, response) => {
    response.send('Hello, This is Meetee API.');
})

app.listen(PORT, URL, () => {
    console.log(`Listening on port: ${PORT}`);
});