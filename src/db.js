// pool nos permite hacer la conexion a la base de datos
const { Pool } = require('pg');
const {db} = require('./config')

const pool = new Pool({
    user: db.user,
    host: db.host,
    database: db.datebase,
    password: db.password,
    port: db.port
});

//esto me va a devolver un objeto que me va a permitir hacer la conexion a la base de datos, el
//cula me va a permitir hacer las consultas a la base de datos

module.exports = pool;

