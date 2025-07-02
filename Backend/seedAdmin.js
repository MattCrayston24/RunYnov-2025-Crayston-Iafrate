// Backend/seedAdmin.js
const bcrypt = require("bcryptjs");
const db = require("./src/config/db");

const hash = bcrypt.hashSync("admin123", 10);

const checkSql = "SELECT * FROM users WHERE email = ?";
const insertSql = `
  INSERT INTO users (username, email, password, role, verified)
  VALUES (?, ?, ?, ?, ?)
`;

db.query(checkSql, ["admin@runynov.com"], (err, results) => {
  if (err) {
    console.error("❌ Erreur vérification admin :", err);
    process.exit();
  }

  if (results.length > 0) {
    console.log("ℹ️ Admin déjà existant.");
    process.exit();
  }

  db.query(insertSql, ["admin", "admin@runynov.com", hash, "admin", 1], (err2) => {
    if (err2) {
      console.error("❌ Erreur insertion admin :", err2);
    } else {
      console.log("✅ Admin inséré avec succès !");
    }
    process.exit();
  });
});
