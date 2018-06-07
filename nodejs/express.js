const fs = require('fs')
const express = require('express')
const app = express()

const data = fs.readFileSync('mockdata.json', { encoding: 'utf8' })

app.get('/', (req, res) => res.send(data))

app.listen(8080)
