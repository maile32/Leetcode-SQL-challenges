-- Question 56
-- Mary is a teacher in a middle school and she has a table seat storing students' names and their corresponding seat ids.

-- The column id is continuous increment.
 

-- Mary wants to change seats for the adjacent students.
 

-- Can you write a SQL query to output the result for Mary?
 

-- +---------+---------+
-- |    id   | student |
-- +---------+---------+
-- |    1    | Abbot   |
-- |    2    | Doris   |
-- |    3    | Emerson |
-- |    4    | Green   |
-- |    5    | Jeames  |
-- +---------+---------+
-- For the sample input, the output is:
 

-- +---------+---------+
-- |    id   | student |
-- +---------+---------+
-- |    1    | Doris   |
-- |    2    | Abbot   |
-- |    3    | Green   |
-- |    4    | Emerson |
-- |    5    | Jeames  |
-- +---------+---------+
-- Solution
select id, coalesce(case when mod(id,2) = 1 then lead(student,1) over()
                else lag(student,1) over() end, student) as student
from seat
