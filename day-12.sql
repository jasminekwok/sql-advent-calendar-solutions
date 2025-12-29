-- SQL Advent Calendar - Day 12
-- Title: North Pole Network Most Active Users
-- Difficulty: hard
--
-- Question:
-- The North Pole Network wants to see who's the most active in the holiday chat each day. Write a query to count how many messages each user sent, then find the most active user(s) each day. If multiple users tie for first place, return all of them.
--
-- The North Pole Network wants to see who's the most active in the holiday chat each day. Write a query to count how many messages each user sent, then find the most active user(s) each day. If multiple users tie for first place, return all of them.
--

-- Table Schema:
-- Table: npn_users
--   user_id: INT
--   user_name: VARCHAR
--
-- Table: npn_messages
--   message_id: INT
--   sender_id: INT
--   sent_at: TIMESTAMP
--

-- My Solution:

SELECT day, user_name, total_messages
FROM (
SELECT DATE(sent_at) AS day, user_name, COUNT(sender_id) AS total_messages,
  RANK() OVER(PARTITION BY DATE(sent_at) ORDER BY COUNT(sender_id) DESC) AS active_ranking
FROM npn_users u
JOIN npn_messages m
  ON u.user_id = m.sender_id
GROUP BY DATE(sent_at), user_name ) aggregated_user_messages
WHERE active_ranking = 1;
