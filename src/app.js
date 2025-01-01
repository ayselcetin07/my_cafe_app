const express = require("express");
const mongoose = require("mongoose");
const orderRoutes = require('./routes/orderRoutes');
const categoryRoutes = require('./routes/categoryRoutes');
const menuRoutes = require('./routes/menuRoutes');
const userRoutes = require('./routes/userRoutes');

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

app.use('/orders', orderRoutes);
app.use('/api/categories', categoryRoutes);
app.use('/api/menu', menuRoutes);
app.use('/api/users', userRoutes);


module.exports = app;
