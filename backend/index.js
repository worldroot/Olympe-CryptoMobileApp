const express = require('express')
const morgan = require('morgan');
const cors = require('cors')
const twig = require('twig');
const path = require('path')
const createError = require('http-errors')

const connectDB = require('./dB/connection.js')


const app = express()



app.use(cors())
app.use(morgan('tiny'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));

app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'twig');


//routes
app.use('/', require('./routes/navigation'))


//rest controllers 
app.use('/uploads', express.static(__dirname + '/public'));
app.use('/api/users', require('./Controllers/usersController'))

//404 error handling
app.use(function(req,res,next) {
    next(createError(404))
})

// 500 error handling
app.use(function(err,req,res,next) {
    res.locals.message = err.message;
    res.locals.error = err;

    res.status(err.status || 500);
    res.render('error/404')
})


connectDB();
app.listen(process.env.PORT || 5000)
console.log("server started on port 5000")