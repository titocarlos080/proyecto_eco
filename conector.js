// conector.js
const mysql = require("mysql");

function createConnection() {
  return mysql.createConnection({
    host: "localhost",
    user: "root",
    password: "root123",
    database: "proyecto_eco",
  });
}

module.exports = createConnection;
