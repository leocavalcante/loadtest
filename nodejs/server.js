const fs = require('fs')
const http = require('http')

const data = fs.readFileSync('mockdata.json', { encoding: 'utf8' })

http.createServer((req, res) => {
  res.write(data)
  res.end()
}).listen(8080)
