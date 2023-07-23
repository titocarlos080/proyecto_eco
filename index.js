// app.js
const express = require("express");
const mysql = require("mysql");
const path = require("path");
const mime = require("mime");
const bodyParser = require("body-parser");
const routes= require('./controlador')
const app = express();
app.use(express.static(__dirname + '/public'));
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());
app.set("view engine", "ejs");
 
const port = 3000; // Puedes cambiar el puerto si es necesario





// Ruta de ejemplo para obtener datos de la base de datos
app.use("/", routes);


// Iniciar el servidor
app.listen(port, () => {
  console.log(`Servidor en ejecución en http://localhost:${port}`);
});
