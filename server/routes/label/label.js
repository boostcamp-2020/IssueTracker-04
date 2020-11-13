const express = require('express');
const router = express.Router();

const labelService = require('../../services/label');
const authService = require('../../services/auth');

// 조회
router.get('/api/labelList', authService.isAuth, labelService.getLabelList);

// 추가
/**
 * body
 * {
  "label_title": "string",
  "label_color": "string",
  "label_description": "string"
  }
 */
router.post('/api/label', authService.isAuth, labelService.createLabel);

router.put(
  '/api/label/:label_no',
  authService.isAuth,
  labelService.updateLabel
);

router.delete(
  '/api/label/:label_no',
  authService.isAuth,
  labelService.deleteLabel
);

module.exports = router;
