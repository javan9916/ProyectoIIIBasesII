var sql = require('mssql');

exports.Login = async (req) => {
    try {
        let config = {
            user: req.User,
            password: req.Password,
            server: req.Server,
            database: 'master',
            port: req.port
        };
        let pool = await sql.connect(config);
        let result = await pool.request()
            .output('Resultado', sql.Bit)
            .execute('CONECTADO');
            
        sql.close();
        console.log(result);
        return result;

    } catch (err) {
        console.log(err);
        sql.close();
        return "Error en " + err;
    }
}