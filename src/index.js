const express = require('express');
const morgan = require('morgan');
const tareasRoutes = require('./routes/tareas.routes');
const cors = require('cors'); // este se importa para hacer la comunicacion entre el backend y el frontend

const app = express();

app.use(cors()); //comunica ambos servidores de manera simple
app.use(morgan('dev')); // esto sirve para ver las peticiones que se hacen al servidor
app.use(express.json()) // esto es para que el servidor entienda el formato json

app.use(tareasRoutes)


// esta funcion lo que hace es identificar un error y devolverlo
app.use((err, req, res, next) => {
    return res.json({
        message: err.message
    })
})

app.listen(4000)
console.log('Server corriendo en el puerto 4000')