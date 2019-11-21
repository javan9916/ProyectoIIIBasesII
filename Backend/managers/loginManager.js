var sql = require('mssql');
var connectionSQL = require('../config/connectionSQL');

exports.Login = async (req) => {
    try {
        let config = {
            user: req.User,
            password: req.Password,
            database: req.database,
            server: req.Server,
            
        };
        let pool = await sql.connect(config);
        let result = await pool.request()
            .input('Usuario', sql.VarChar(25), req.Usuario)
            .input('Contraseña', sql.VarChar(25), req.Contraseña)
            .execute('LOGEO');
            
        sql.close();
        console.log(result);
        return result;

    } catch (err) {
        console.log(err);
        sql.close();
        return "Error en " + err;
    }
}

exports.getEsclavos = async (req) => {
    try {
        let pool = await sql.connect(connectionSQL);
        let result = await pool.request()
            .input('latitud', sql.Float, req.latitud)
            .input('longitud', sql.Float, req.longitud)
            .execute('Buscar_Esclavo_Cercano');

        sql.close();

        return result;

    } catch (err) {
        console.log(err)
        sql.close();
        return "Error en " + err;
    }
}
