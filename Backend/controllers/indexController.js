var express = require('express');
var router = express.Router();

  /* Pagina de Inicio */
  router.get('/', function(req, res, next) {
    res.render('index', { title: 'Express' });
  });

  module.exports = router;