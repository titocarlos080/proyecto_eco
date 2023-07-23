// controlador.js
const express = require("express");
const router = express.Router();
const createConnection = require("./conector");

router.get("/gestionar", (req, res) => {
  const connection = createConnection();
  let categorias = null; // Use 'let' instead of 'const' for reassignment
  const gastos = null;

  connection.query("SELECT * FROM categoria", (err, categoriass) => {
    if (err) {
      console.error("Error executing query:", err);
      res.status(500).send("Error executing query");
    } else {
      categorias = categoriass; // Assign the value to 'categorias'
      // After receiving the 'categorias' value, proceed to the next query
      connection.query("SELECT * FROM gastos", (err, gastos) => {
        if (err) {
          console.error("Error executing query:", err);
          res.status(500).send("Error executing query");
        } else {
          // Render the 'index' view with the received data
          connection.query(" select calcular_saldo() as saldo", (err, results) => {
            if (err) {
              console.error("Error executing query:", err);
              res.status(500).send("Error executing query");
            } else {
              connection.query(" select * from movcuenta", (err, ingresos) => {
                if (err) {
                  console.error("Error executing query:", err);
                  res.status(500).send("Error executing query");
                } else {


                  res.render("gestionar", { gastos: gastos, categorias: categorias, saldo: results[0].saldo, ingresos: ingresos });
                  connection.end(); // Close the connection after the second query is executed
                }
              })
            }
          })

        }
      });
    }
  });
});

router.post("/agregar_pago", (req, res) => {
  console.log(req.body)
  const monto = req.body.monto
  const categoriaId = req.body.categoriaId
  const asunto = req.body.asunto
  const sql = "INSERT INTO gastos (monto,fecha,asunto,id_categoria) VALUES(?, NOW(),?,?)";
  const values = [monto, asunto, categoriaId];

  // Execute the SQL query to insert the data into the database
  const connection = createConnection();
  connection.query(sql, values, (err, result) => {
    if (err) {
      console.error("Error inserting data:", err);
      // Handle the error, e.g., show an error page or send an error response
    } else {
      console.log("Data inserted successfully!");
      // Optionally, you can redirect the user to another page after successful insertion
      res.redirect("/gestionar");
      connection.end(); // Close the connection after the second query is executed

    }
  });
})
router.post("/registrar_ingreso", (req, res) => {
  console.log(req.body)
  const ingreso = req.body.ingreso
  const sql = "INSERT INTO movcuenta (fecha,monto,id_cuenta) VALUES( NOW()," + ingreso + ",1)";

  // Execute the SQL query to insert the data into the database
  const connection = createConnection();
  connection.query(sql, (err, result) => {
    if (err) {
      console.error("Error inserting data:", err);
      // Handle the error, e.g., show an error page or send an error response
    } else {
      console.log("Data inserted successfully!");
      // Optionally, you can redirect the user to another page after successful insertion
      res.redirect("/gestionar");
      connection.end(); // Close the connection after the second query is executed

    }
  });
})

router.post("/nueva_categoria", (req, res) => {
  console.log(req.body)
  const nombre = req.body.nueva_categoria;
  const sql = "INSERT INTO categoria values (null,?)";
  const connection = createConnection();
  connection.query(sql, [nombre], (err, result) => {
    if (err) {
      console.error("Error inserting data:", err);
      // Handle the error, e.g., show an error page or send an error response
    } else {
      console.log("Data inserted successfully!");
      // Optionally, you can redirect the user to another page after successful insertion
      connection.end(); // Close the connection after the second query is executed
      res.redirect("/gestionar");

    }

  })

})

router.get("/", (req, res) => {
  res.render("inicio")
})
router.get("/planes_de_ahorro", (req, res) => {
  res.render("planes_de_ahorro")
})
router.get("/contacto", (req, res) => {
  res.render("contacto")
})
router.get("/restart", (req, res) => {
  const sql = "DELETE FROM gastos where id>0";
  const sql2 = " DELETE FROM movcuenta where id>0";
  const connection = createConnection();
  connection.query(sql, (err, result1) => {
    if (err) {
      console.error("Error inserting data:", err);
      // Handle the error, e.g., show an error page or send an error response
    } else {
      // Optionally, you can redirect the user to another page after successful insertion
      connection.query(sql2, (err, result2) => {
        if (err) {
          console.error("Error inserting data:", err);
        } else {
          console.log("Data reset successfully!");
          connection.end(); // Close the connection after the second query is executed
          res.redirect("/gestionar");

        }
      })
    }
  })
})



module.exports = router;
