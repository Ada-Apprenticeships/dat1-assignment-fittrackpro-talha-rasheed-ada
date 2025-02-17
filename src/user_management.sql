-- Initial SQLite setup
.open fittrackpro.db
.mode column

-- Enable foreign key support
PRAGMA foreign_keys = ON;
-- User Management Queries

-- 1. Retrieve all members
-- TODO: Write a query to retrieve all members
SELECT * FROM members;

-- 2. Update a member's contact information
-- TODO: Write a query to update a member's contact information
UPDATE members SET phone_number = '123-456-7890', email = 'john.doe.updated@example.com' 
WHERE member_id = (SELECT member_id FROM members WHERE first_name = 'John' AND last_name = 'Doe');

-- 3. Count total number of members
-- TODO: Write a query to count the total number of members
SELECT COUNT(*) AS total_members FROM members;

-- 4. Find member with the most class registrations
-- TODO: Write a query to find the member with the most class registrations
SELECT m.member_id, m.first_name, m.last_name, COUNT(ca.member_id) AS total_registrations
FROM members m LEFT JOIN class_attendance ca ON m.member_id = ca.member_id
GROUP BY m.member_id, m.first_name, m.last_name
ORDER BY total_registrations DESC LIMIT 1;

-- 5. Find member with the least class registrations
-- TODO: Write a query to find the member with the least class registrations
SELECT m.member_id, m.first_name, m.last_name, COUNT(ca.member_id) AS total_registrations
FROM members m LEFT JOIN class_attendance ca ON m.member_id = ca.member_id
GROUP BY m.member_id, m.first_name, m.last_name
ORDER BY total_registrations ASC LIMIT 1;

-- 6. Calculate the percentage of members who have attended at least one class
-- TODO: Write a query to calculate the percentage of members who have attended at least one class
SELECT CAST(SUM(CASE WHEN total_classes_attended > 0 THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(*) AS percentage_members_attended_class
FROM (SELECT m.member_id, COUNT(ca.class_attendance_id) AS total_classes_attended
      FROM members m LEFT JOIN class_attendance ca ON m.member_id = ca.member_id
      GROUP BY m.member_id) AS member_attendance; 