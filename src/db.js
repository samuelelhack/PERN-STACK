// pool nos permite hacer la conexion a la base de datos
const { Pool } = require('pg');

const pool = new Pool({
    user: 'postgres',
    host: 'localhost',
    database: 'servicio_tecnico',
    password: 'Samuel19',
    port: 5432
});

//esto me va a devolver un objeto que me va a permitir hacer la conexion a la base de datos, el
//cula me va a permitir hacer las consultas a la base de datos

module.exports = pool;

