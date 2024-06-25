const mysql = require('mysql');

const db = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: '',
  database: 'safal'
});

db.connect((err) => {
  if (err) {
    console.error('Error connecting to MySQL database:', err);
    // return;
  } else{
  console.log('Connected to MySQL database');
  }
});

module.exports = db;
