const app = require('express')()
const db = require('../config/db')
const consign = require('consign')

const PORT = 3000;

consign()
    .then('./config/middlewares.js')
    .then('./api')
    .then('./src/routes.js')
    .into(app)

app.db = db

app.listen(PORT, () => {
    console.log(`Server started on port ${PORT}`)
})