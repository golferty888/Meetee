const express = require('express');
const PORT = process.env.PORT || 3000;
const app = express();
const morgan = require('morgan');
const knex = require('./db/knex');
const bodyParser = require('body-parser');

app.use(express.static('./public'));

app.use(morgan('short'));

app.use(bodyParser.urlencoded({ extended: false }));

app.get('/users', (request, response) => {
    knex.select().from('User')
        .then(function (result) {
            console.log()
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
            console.log()
            response.send(result);
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
    var firstname = request.body.first_name;
    var lastname = request.body.last_name;
    console.log("Trying to create a new User");
    console.log("Firstname: " + firstname);
    console.log("lastname: " + lastname);
    response.end(); 

    // knex('User').insert({
    //     firstname: 'Peem',
    //     lastname: 'Pussii'
    // })
    // .catch( err => {
    //     console.log(err);
    // })
    // .then(function() {
    //     knex.select().from('User')
    //         .then(function(user_result) {
    //             response.send(user_result);
    //         })
    //         .catch( err => {
    //             console.log(err);
    //         })
    // })

});

app.get('/', (request, response) => {
    response.render('./public/form');
    response.send('Hello This is my application.');
})


app.listen(PORT, () => {
    console.log(`Listening on port: ${PORT}`);
});