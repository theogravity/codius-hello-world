const express = require('express')
const app = express()

app.get('/', (req, res) => res.send('Hello from Theo Gravity!'))

app.listen(3000, () => console.log('Hello world server is listening on port 3000'))
