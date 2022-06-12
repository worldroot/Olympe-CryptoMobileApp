require('dotenv').config()

const express = require('express');

const User = require('../Models/User');

const bcrypt = require('bcryptjs')
const { generateAccessToken } = require('../utils/jwt');


const multer = require("multer");
const path = require("path");
const { UserRole } = require('../utils/enum');

const storageData = multer.diskStorage({
    destination: (req, file, clb) => {
        clb(null, './public/images/users/');
    },
    filename: (req, file, cb) => {
        const newFileName = new Date().getTime().toString() + "_" + file.originalname;
        cb(null, newFileName);
    }
});
const upload = multer({ storage: storageData })


const route = express.Router();

const index = (req, res, next) => {
    User.find()
        .then(users => {
            res.json(users)
        })
        .catch(error => {
            res.json({
                message: "an error occured when displaying users"
            })
        })
}

//authentification
const register = (req, res, next) => {
    bcrypt.hash(req.body.password, 10, function (err, hashedPass) {

        if (err) {
            console.log('erreur password hash');
            return res.json({
                message: err
            })
        }

        User.findOne({ $or: [{ phone: req.body.phone, username: req.body.username }] })
            .then(user => {
                if (user) {//user found
                    res.status(201).send(JSON.stringify({
                        message: 'User exist'
                    }))
                } else {//no user found
                    let user = new User({
                        name: req.body.name,
                        username: req.body.username,
                        password: hashedPass,
                        phone: req.body.phone,
                        avatar: (req.file) ? "/images/users/" + req.file.filename : "default"
                    })
                    user.save().then(user => {
                        const hash = { id: user._id }
                        const accessToken = generateAccessToken(hash)
                        return res.status(200).send(JSON.stringify({ //200 OK
                            _id: user._id,
                            name: user.name,
                            username: user.username,
                            password: user.password,
                            phone: user.phone,
                            avatar: user.avatar,
                            token: accessToken,
                        }))
                    })
                        .catch(error => {
                            return res.status(500).send(JSON.stringify({
                                statusCode: 500,
                                message: error
                            }))
                        })
                }//end else
            })//end then 
    })//end hash
}

const login = (req, res, next) => {
    const { username, password } = req.body;
    User.findOne({ $or: [{ username: username }] })
        .then(user => {
            if (user) {
                bcrypt.compare(password, user.password, function (err, result) {
                    if (err) {
                        res.status(200).send(JSON.stringify({
                            message: err
                        }))
                    }
                    if (result) {
                        const hash = { id: user._id }
                        const accessToken = generateAccessToken(hash)

                        res.status(200).send({ //200 OK
                            _id: user._id,
                            name: user.name,
                            username: user.username,
                            password: user.password,
                            phone: user.phone,
                            avatar: user.avatar,
                            token: accessToken,
                        })

                    } else {
                        res.status(201).send(JSON.stringify({ //201 incorrect password
                            message: "incorrect password"
                        }))
                    }
                })
            } else {
                res.status(202).send(JSON.stringify({ //202 user not found
                    message: "user not found"
                }))
            }
        })
}



//display uploads folder
const displayUploads = (req, res) => {
    var uploadFiles = []
    const testFolder = './public/users/';
    fs.readdir(testFolder, (err, files) => {
        files.forEach(file => {
            uploadFiles.push(file)
        });
        res.json(files)
    });
}






route.get('/', index)

//authentification
route.post('/login', login) //email,password
route.post('/register'/*, upload.single("avatar")*/, register)


//uploads
route.get('/displayUploads', displayUploads)


module.exports = route;