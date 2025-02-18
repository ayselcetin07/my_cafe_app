const express = require('express');
const router = express.Router();
const menuController = require('../controllers/menuController');

router.get('/:category', menuController.getMenuItemsByCategory);

module.exports = router;