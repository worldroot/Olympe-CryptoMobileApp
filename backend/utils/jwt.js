require('dotenv').config()
const jwt = require('jsonwebtoken')

function generateAccessToken(hash) {
    return jwt.sign(hash, process.env.ACCESS_TOKEN_SECRET)
}

function authenticateToken(req, res, next) {
    const authHeader = req.headers['authorization']
    const token = authHeader && authHeader.split(' ')[1]
    if (token == null) return res.status(401).send(JSON.stringify({ msg: "no token in headers" }))

    jwt.verify(token, process.env.ACCESS_TOKEN_SECRET, (err, user) => {
        if (err) return res.status(403).send(JSON.stringify({ msg: "erreur in token" }))
        req.user = user
        next()
    })
}

module.exports = { generateAccessToken, authenticateToken }