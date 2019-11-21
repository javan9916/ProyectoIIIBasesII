var sql = require('mssql');

exports.verCursosEstudiantes = async (req) => {
    try {
        let config = {
            user: req.User,
            password: req.Password,
            database: req.database,
            server: req.Server,
            
        };
        let pool = await sql.connect(config);
        let result = await pool.request()
            .input('codigo_estudiante', sql.Int, req.Usuario)
            .input('activo', sql.Int, req.Contraseña)
            .execute('Mostrar_Cursos_Estudiantes');
            
        sql.close();
        console.log(result);
        return result;

    } catch (err) {
        console.log(err);
        sql.close();
        return "Error en " + err;
    }
}

exports.verCursosProfesores = async (req) => {
    try {
        let config = {
            user: req.User,
            password: req.Password,
            database: req.database,
            server: req.Server,
            
        };
        let pool = await sql.connect(config);
        let result = await pool.request()
            .input('codigo_profesor', sql.Int, req.Usuario)
            .input('activo', sql.Int, req.Contraseña)
            .execute('Mostrar_Cursos_Profesores');
            
        sql.close();
        console.log(result);
        return result;

    } catch (err) {
        console.log(err);
        sql.close();
        return "Error en " + err;
    }
}

exports.verEstudiantesCursos = async (req) => {
    try {
        let config = {
            user: req.User,
            password: req.Password,
            database: req.database,
            server: req.Server,
            
        };
        let pool = await sql.connect(config);
        let result = await pool.request()
            .input('codigo_curso', sql.Int, req.Usuario)
            .execute('Mostrar_Estudiantes_Curso');
            
        sql.close();
        console.log(result);
        return result;

    } catch (err) {
        console.log(err);
        sql.close();
        return "Error en " + err;
    }
}

exports.verProfesorCursos = async (req) => {
    try {
        let config = {
            user: req.User,
            password: req.Password,
            database: req.database,
            server: req.Server,
            
        };
        let pool = await sql.connect(config);
        let result = await pool.request()
            .input('codigo_curso', sql.Int, req.Usuario)
            .execute('Mostrar_Profesores_Curso');
            
        sql.close();
        console.log(result);
        return result;

    } catch (err) {
        console.log(err);
        sql.close();
        return "Error en " + err;
    }
}

exports.buscarEsclavo = async (req) => {
    try {
        let config = {
            user: req.User,
            password: req.Password,
            database: req.database,
            server: req.Server,
            
        };
        let pool = await sql.connect(config);
        let result = await pool.request()
            .input('codigo_curso', sql.Int, req.Usuario)
            .execute('Mostrar_Profesores_Curso');
            
        sql.close();
        console.log(result);
        return result;

    } catch (err) {
        console.log(err);
        sql.close();
        return "Error en " + err;
    }
}

exports.InsertarMensajeEE = async (req) => {
    try {
        let config = {
            user: req.User,
            password: req.Password,
            database: req.database,
            server: req.Server,
            
        };
        let pool = await sql.connect(config);
        let result = await pool.request()
        .input('emisor', sql.Int, req.emisor)
        .input('receptor', sql.Int, req.receptor)
        .input('mensaje', sql.VarChar(500), req.mensaje)
        .input('codigo_curso', sql.Int, req.codigo_curso)
            .execute('Insertar_Mensaje_E_E');
            
        sql.close();
        console.log(result);
        return result;

    } catch (err) {
        console.log(err);
        sql.close();
        return "Error en " + err;
    }
}
exports.InsertarMensajeEP = async (req) => {
    try {
        let config = {
            user: req.User,
            password: req.Password,
            database: req.database,
            server: req.Server,
            
        };
        let pool = await sql.connect(config);
        let result = await pool.request()
            .input('emisor', sql.Int, req.emisor)
            .input('receptor', sql.Int, req.receptor)
            .input('mensaje', sql.VarChar(500), req.mensaje)
            .input('codigo_curso', sql.Int, req.codigo_curso)input('codigo_curso', sql.Int, req.Usuario)
            .execute('Insertar_Mensaje_E_P');
            
        sql.close();
        console.log(result);
        return result;

    } catch (err) {
        console.log(err);
        sql.close();
        return "Error en " + err;
    }
}
exports.InsertarMensajePE = async (req) => {
    try {
        let config = {
            user: req.User,
            password: req.Password,
            database: req.database,
            server: req.Server,
            
        };
        let pool = await sql.connect(config);
        let result = await pool.request()
        .input('emisor', sql.Int, req.emisor)
        .input('receptor', sql.Int, req.receptor)
        .input('mensaje', sql.VarChar(500), req.mensaje)
        .input('codigo_curso', sql.Int, req.codigo_curso)
            .execute('Insertar_Mensaje_P_E');
            
        sql.close();
        console.log(result);
        return result;

    } catch (err) {
        console.log(err);
        sql.close();
        return "Error en " + err;
    }
}
exports.InsertarMensajeEG = async (req) => {
    try {
        let config = {
            user: req.User,
            password: req.Password,
            database: req.database,
            server: req.Server,
            
        };
        let pool = await sql.connect(config);
        let result = await pool.request()
        .input('emisor', sql.Int, req.emisor)
        .input('receptor', sql.Int, req.receptor)
        .input('mensaje', sql.VarChar(500), req.mensaje)
        .input('codigo_curso', sql.Int, req.codigo_curso)
            .execute('Insertar_Mensaje_E_G');
            
        sql.close();
        console.log(result);
        return result;

    } catch (err) {
        console.log(err);
        sql.close();
        return "Error en " + err;
    }
}
exports.InsertarMensajePG = async (req) => {
    try {
        let config = {
            user: req.User,
            password: req.Password,
            database: req.database,
            server: req.Server,
            
        };
        let pool = await sql.connect(config);
        let result = await pool.request()
            .input('emisor', sql.Int, req.emisor)
            .input('receptor', sql.Int, req.receptor)
            .input('mensaje', sql.VarChar(500), req.mensaje)
            .input('codigo_curso', sql.Int, req.codigo_curso)
            .execute('Insertar_Mensaje_P_G');
            
        sql.close();
        console.log(result);
        return result;

    } catch (err) {
        console.log(err);
        sql.close();
        return "Error en " + err;
    }
}
