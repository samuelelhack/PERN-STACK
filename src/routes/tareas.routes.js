// aqui vamos a definir las url que el frontend va a poder acceder
const { Router } = require('express');
const  pool  = require('../db');
const router = Router()  ; //este objeto nos permite definir las rutas de nuestra aplicacion
const { obtenerUsuarios, registrarUsuario, eliminarTarea, actualizarTarea, obtenerUnUsuario } = require('../controllers/tareas.controler');

// esto seria un CRUD de tareas
// CRUD: Create, Read, Update, Delete


// se utiliza async y await para hacer consultas a la base de datos porque devuelve una promesa
// y para que no se vea tan feo el codigo se utiliza async y await
router.get('/tareas', obtenerUsuarios) // este es para retornar todas las tareas

// este es para retornar una tarea en especifico
// el :id es un parametro que se puede enviar en la url
router.get('/tareas/:id',obtenerUnUsuario) // :id es un parametro que se puede enviar en la url
// basicamente es una variable el cual no sabes cual es su valor pero esperas que te lo envien

// las peticiones get son aquellas que se hacen a traves de la url del navegador


// para hacer las peticiones post, put y delete necesitamos una herramienta que nos permita hacer peticiones http
// una de ellas es postman o thunder client

router.post('/tareas', registrarUsuario)
router.delete('/tareas/:id',eliminarTarea)

router.put('/tareas/:id',actualizarTarea)

// en el metodo http existen distintas formas de enviar informacion, una de ellas es a traves de la url
// get para obtener informacion
// put para actualizar informacion
// delete para eliminar informacion
// post para crear informacion

module.exports = router; //exportamos el objeto router para que pueda ser utilizado en otros archivos


