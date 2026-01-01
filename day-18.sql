-- SQL Advent Calendar - Day 18
-- Title: 12 Days of Data - Progress Tracking
-- Difficulty: hard
--
-- Question:
-- Over the 12 days of her data challenge, Data Dawn tracked her daily quiz scores across different subjects. Can you find each subject's first and last recorded score to see how much she improved?
--
-- Over the 12 days of her data challenge, Data Dawn tracked her daily quiz scores across different subjects. Can you find each subject's first and last recorded score to see how much she improved?
--

-- Table Schema:
-- Table: daily_quiz_scores
--   subject: VARCHAR
--   quiz_date: DATE
--   score: INTEGER
--

-- My Solution:

SELECT subject,  quiz_date, score, 
  CASE WHEN rank_asc = 1 THEN 'First' ELSE 'Last' END AS score_category
FROM 
(SELECT subject, quiz_date, score, 
  ROW_NUMBER() OVER(PARTITION BY subject ORDER BY quiz_date) AS rank_asc, 
  ROW_NUMBER() OVER(PARTITION BY subject ORDER BY quiz_date DESC) AS rank_desc
FROM daily_quiz_scores) ranked_scores
WHERE rank_asc = 1 OR rank_desc = 1;
