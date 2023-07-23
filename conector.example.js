// conector.js
const mysql = require("mysql");

function createConnection() {
  return mysql.createConnection({
    host: "localhost",
    user: "root",
    password: "*****",
    database: "proyecto_eco",
  });
}

module.exports = createConnection;
