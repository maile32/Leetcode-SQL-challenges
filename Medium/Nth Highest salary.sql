-- Question 50
-- Write a SQL query to get the nth highest salary from the Employee table.

-- +----+--------+
-- | Id | Salary |
-- +----+--------+
-- | 1  | 100    |
-- | 2  | 200    |
-- | 3  | 300    |
-- +----+--------+
-- For example, given the above Employee table, the nth highest salary where n = 2 is 200. If there is no nth highest salary, then the query should return null.

-- +------------------------+
-- | getNthHighestSalary(2) |
-- +------------------------+
-- | 200                    |
-- +------------------------+

-- Solution
DELIMITER $$
create function getNthHighestSalary (N integer)
returns integer
DETERMINISTIC
begin
return (select distinct salary
        from (select salary, dense_rank() over(order by salary desc) as rnk
              from employee) as e
        where e.rnk = N);
END$$
DELIMITER ;
