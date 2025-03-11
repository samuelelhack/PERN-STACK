const { json } = require('express');
const pool = require('../db');

const obtenerUsuarios = async (req, res) => {
    try {
    const tareas = await pool.query('SELECT * FROM usuarios') //esto es para hacer una consulta a la base de datos
    
    res.json(tareas.rows)
    
    } catch (error) {
        console.log(error.message) //esto es bueno solo en desarrollo, en produccion no se debe mostrar el error
    }
}

const obtenerUnUsuario = async (req, res) => { //esto es para obtener un usuario en especifico
    const {id} = req.params //esto es para ver los parametros que se envian en la url
    try {
        const result = await pool.query('SELECT * FROM usuarios WHERE id = $1', [id])
        if (result.rows.length === 0) {
            return res.status(404).json({message: 'No se encontro el usuario'})
        }else{
            res.json(result.rows[0])
        }
        
    } catch (error) {
        console.log(error.message)   
    }
};

const registrarUsuario = async (req, res) => {
   // const tarea = req.body //esto es para obtener los datos que se envian en el body de la peticion
    const { nombre, correo, rol, clave} = req.body //esto es para obtener los datos haciendo destructuracion, trayendo solo los datos que necesitamos
    try{
        const result = await pool.query('INSERT INTO usuarios (nombre, correo, rol, clave) VALUES ($1, $2, $3, $4) RETURNING *', [ nombre, correo, rol, clave])
        // el values ($1, $2) es para que se inserten los valores en el orden que se colocan en el array
        // $1 y $2 hacen referencia a los valores que se colocan en el array
        // EL RETURNING * es para que nos retorne los datos que se insertaron en la base de datos
        res.json(result.rows[0]); //esto es para que nos retorne el primer elemento del array que nos retorna la base de datos
    
    }catch(error){
    
        res.json({error: error.message}); //esto es bueno solo en desarrollo, en produccion no se debe mostrar el error
    }
    
};

const actualizarTarea = (req, res) => {
    res.send('actualizando una tarea');
};

const eliminarTarea = (req, res) => {
    res.send('eliminando una tarea');
};

module.exports = {
    // getAllTareas : getAllTareas //tambien se puede hacer de esta forma
    obtenerUsuarios, //esto es lo mismo que la linea de arriba
    obtenerUnUsuario,
    registrarUsuario,
    actualizarTarea,
    eliminarTarea
}
