const express = require('express');
const morgan = require('morgan');
const tareasRoutes = require('./routes/tareas.routes');

const app = express();
app.use(morgan('dev')); // esto sirve para ver las peticiones que se hacen al servidor
app.use(express.json()) // esto es para que el servidor entienda el formato json

app.use(tareasRoutes)

app.listen(3000)
console.log('Server corriendo en el puerto 3000')