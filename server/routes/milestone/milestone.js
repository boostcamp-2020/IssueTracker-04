const express = require('express');
const router = express.Router();
const milestoneService = require('../../services/milestone');
const authService = require('../../services/auth');

// 조회
router.get('/api/milestoneList', milestoneService.getMilestoneList);

// 추가
/**
 * {
  "milestone_title": "string",
  "milestone_description": "string",
  "due_date": "string"
  }
 */
router.post(
  '/api/milestone',
  authService.isAuth,
  milestoneService.createMilestone
);

module.exports = router;
