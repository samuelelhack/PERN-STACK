const {config} = require('dotenv') //importamos el modulo para manejar las variables de entorno
config()

module.exports = {
    db: {
        user: process.env.DB_USER,
        password: process.env.DB_PASSWORD,
        host: process.env.DB_HOST,
        port: process.env.DB_PORT,
        datebase: process.env.DB_DATEBASE
    }
}