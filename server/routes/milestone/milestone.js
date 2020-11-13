const express = require('express');
const router = express.Router();
const milestoneService = require('../../services/milestone');
const authService = require('../../services/auth');

// 조회
router.get(
  '/api/milestoneList',
  authService.isAuth,
  milestoneService.getMilestoneList
);

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

router.put(
  '/api/milestone/:milestone_no',
  authService.isAuth,
  milestoneService.updateMilestone
);

router.delete(
  '/api/milestone/:milestone_no',
  authService.isAuth,
  milestoneService.deleteMilestone
);

module.exports = router;
