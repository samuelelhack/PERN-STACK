const { json } = require('express');
const pool = require('../db');

const listaEmpleados = async (req, res, next) => {
    try {
    const empleados = await pool.query('SELECT * FROM empleados') //esto es para hacer una consulta a la base de datos
    
    res.json(empleados.rows)

    if (empleados.rowCount === 0){
        throw new Error(`No hay empleados`); //esto crea un error manualmente y especializado
    }
    
    } catch (error) {
        next(error) //esto es bueno solo en desarrollo, en produccion no se debe mostrar el error
    }
}

const obtenerUnUsuario = async (req, res, next) => { //esto es para obtener un usuario en especifico
    const {id} = req.params //esto es para ver los parametros que se envian en la url
    try {
        const result = await pool.query('SELECT * FROM usuarios WHERE id = $1', [id])
        if (result.rows.length === 0) {
            return res.status(404).json({message: 'No se encontro el usuario'})
        }else{
            res.json(result.rows[0])
        }
        
    } catch (error) {
        next(error) 
    }
};

const registrarEmpleado = async (req, res, next) => {
   
    const { cedula, nombre, apellido, correo, telefono , cod_camisa, cod_pantalon, cod_zapato} = req.body //esto es para obtener los datos haciendo destructuracion, trayendo solo los datos que necesitamos
    try{
        const result = await pool.query('INSERT INTO empleados (cedula, nombre, apellido, correo, telefono , cod_camisa, cod_pantalon, cod_zapato) VALUES ($1, $2, $3, $4, $5, $6, $7, $8) RETURNING *', [ cedula, nombre, apellido, correo, telefono , cod_camisa, cod_pantalon, cod_zapato])
        // el values ($1, $2) es para que se inserten los valores en el orden que se colocan en el array
        // $1 y $2 hacen referencia a los valores que se colocan en el array
        // EL RETURNING * es para que nos retorne los datos que se insertaron en la base de datos
        res.json(result.rows[0]); //esto es para que nos retorne el primer elemento del array que nos retorna la base de datos
    
    }catch(error){
        next(error)
        //esto es bueno solo en desarrollo, en produccion no se debe mostrar el error
    }
    
};

const actualizarTarea = async (req, res, next) => {
    const {id} = req.params
    const { nombre, correo, rol, clave} = req.body
    try {
        const results = await pool.query('UPDATE usuarios SET nombre = $1, correo = $2, rol = $3, clave = $4 WHERE id = $5 RETURNING *', [nombre, correo, rol, clave, id])
        console.log(results)
        if (results.rowCount === 0){
            res.json({message: 'USUARIO NO EXISTE'});
        }else{
            res.json(results.rows[0]);
        }
    } catch (error) {
        next(error)
    }
};

const eliminarTarea = async (req, res, next) => {
    const {id} = req.params
    try {
        const eliminar  = await pool.query('DELETE FROM usuarios WHERE id = $1 RETURNING *', [id])
        console.log(eliminar.rows)
        if (eliminar.rowCount === 0) {
            return res.status(404).json({message: 'No se encontro el usuario'})
        }else{
            res.json({message: 'Usuario eliminado'})
            //res.sendStatus(204) //esto es para que nos retorne un status 204 que significa que se elimino correctamente, es decir manda el body vacio
        }
    } catch (error) {
        next(error)
    }
    
};

module.exports = {
    // getAllTareas : getAllTareas //tambien se puede hacer de esta forma
    listaEmpleados, //esto es lo mismo que la linea de arriba
    obtenerUnUsuario,
    registrarEmpleado,
    actualizarTarea,
    eliminarTarea
}
