const express = require("express");
const mongoose = require("mongoose");
const categoryRoutes = require('./routes/categoryRoutes');
const menuRoutes = require('./routes/menuRoutes');
const userRoutes = require('./routes/userRoutes');
const bodyParser = require('body-parser');

const app = express();

// Middleware
app.use(express.json());

// MongoDB Atlas bağlantısı
const uri =
  "mongodb+srv://ayselcetin:Btrm24@cluster0.wrzks.mongodb.net/app?retryWrites=true&w=majority&appName=Cluster0";
mongoose.connect(uri);

const db = mongoose.connection;
db.on("error", console.error.bind(console, "MongoDB bağlantı hatası:"));
db.once("open", () => {
  console.log("MongoDB bağlantısı başarılı");
});

// Routes

app.use(bodyParser.json());
app.use('/users', userRoutes);
app.use('/api/categories', categoryRoutes);
app.use('/api/menu', menuRoutes);



module.exports = app;
