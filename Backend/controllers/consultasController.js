var express = require('express');
var router = express.Router();
var loginManager = require('../managers/consultasManager');

router.get('/verCursosEstudiantes', function(req, res, next){
    try{
        loginManager.verCursosEstudiantes(req.query).then(
            (data) => {
                let response = {
                    content: data.recordset,
                    success: data.output,
                    code: 200
                };
                res.send(JSON.stringify(response));
            }
        );
    }
    catch (err) {
        let response = {
            content: err,
            code: 500
        };
        res.send(JSON.stringify(response));
    }
})

router.get('/verCursosProfesores', function(req, res, next){
    try{
        loginManager.verCursosProfesores(req.query).then(
            (data) => {
                let response = {
                    content: data.recordset,
                    success: data.output,
                    code: 200
                };
                res.send(JSON.stringify(response));
            }
        );
    }
    catch (err) {
        let response = {
            content: err,
            code: 500
        };
        res.send(JSON.stringify(response));
    }
})

router.get('/verEstudiantesCursos', function(req, res, next){
    try{
        loginManager.verEstudiantesCursos(req.query).then(
            (data) => {
                let response = {
                    content: data.recordset,
                    success: data.output,
                    code: 200
                };
                res.send(JSON.stringify(response));
            }
        );
    }
    catch (err) {
        let response = {
            content: err,
            code: 500
        };
        res.send(JSON.stringify(response));
    }
})

router.get('/verProfesorCursos', function(req, res, next){
    try{
        loginManager.verProfesorCursos(req.query).then(
            (data) => {
                let response = {
                    content: data.recordset,
                    success: data.output,
                    code: 200
                };
                res.send(JSON.stringify(response));
            }
        );
    }
    catch (err) {
        let response = {
            content: err,
            code: 500
        };
        res.send(JSON.stringify(response));
    }
})

router.get('/buscarEsclavo', function(req, res, next){
    try{
        loginManager.buscarEsclavo(req.query).then(
            (data) => {
                let response = {
                    content: data.recordset,
                    success: data.output,
                    code: 200
                };
                res.send(JSON.stringify(response));
            }
        );
    }
    catch (err) {
        let response = {
            content: err,
            code: 500
        };
        res.send(JSON.stringify(response));
    }
})

router.get('/InsertarMensajeEE', function(req, res, next){
    try{
        loginManager.InsertarMensajeEE(req.query).then(
            (data) => {
                let response = {
                    content: data.recordset,
                    success: data.output,
                    code: 200
                };
                res.send(JSON.stringify(response));
            }
        );
    }
    catch (err) {
        let response = {
            content: err,
            code: 500
        };
        res.send(JSON.stringify(response));
    }
})

router.get('/InsertarMensajeEP', function(req, res, next){
    try{
        loginManager.InsertarMensajeEP(req.query).then(
            (data) => {
                let response = {
                    content: data.recordset,
                    success: data.output,
                    code: 200
                };
                res.send(JSON.stringify(response));
            }
        );
    }
    catch (err) {
        let response = {
            content: err,
            code: 500
        };
        res.send(JSON.stringify(response));
    }
})

router.get('/InsertarMensajePE', function(req, res, next){
    try{
        loginManager.InsertarMensajePE(req.query).then(
            (data) => {
                let response = {
                    content: data.recordset,
                    success: data.output,
                    code: 200
                };
                res.send(JSON.stringify(response));
            }
        );
    }
    catch (err) {
        let response = {
            content: err,
            code: 500
        };
        res.send(JSON.stringify(response));
    }
})

router.get('/InsertarMensajeEG', function(req, res, next){
    try{
        loginManager.InsertarMensajeEG(req.query).then(
            (data) => {
                let response = {
                    content: data.recordset,
                    success: data.output,
                    code: 200
                };
                res.send(JSON.stringify(response));
            }
        );
    }
    catch (err) {
        let response = {
            content: err,
            code: 500
        };
        res.send(JSON.stringify(response));
    }
})

router.get('/InsertarMensajePG', function(req, res, next){
    try{
        loginManager.InsertarMensajePG(req.query).then(
            (data) => {
                let response = {
                    content: data.recordset,
                    success: data.output,
                    code: 200
                };
                res.send(JSON.stringify(response));
            }
        );
    }
    catch (err) {
        let response = {
            content: err,
            code: 500
        };
        res.send(JSON.stringify(response));
    }
})

module.exports = router; 