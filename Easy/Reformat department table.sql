-- Question 44
-- Table: Department

-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | id            | int     |
-- | revenue       | int     |
-- | month         | varchar |
-- +---------------+---------+
-- (id, month) is the primary key of this table.
-- The table has information about the revenue of each department per month.
-- The month has values in ["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"].
 

-- Write an SQL query to reformat the table such that there is a department id column and a revenue column for each month.

-- The query result format is in the following example:

-- Department table:
-- +------+---------+-------+
-- | id   | revenue | month |
-- +------+---------+-------+
-- | 1    | 8000    | Jan   |
-- | 2    | 9000    | Jan   |
-- | 3    | 10000   | Feb   |
-- | 1    | 7000    | Feb   |
-- | 1    | 6000    | Mar   |
-- +------+---------+-------+

-- Result table:
-- +------+-------------+-------------+-------------+-----+-------------+
-- | id   | Jan_Revenue | Feb_Revenue | Mar_Revenue | ... | Dec_Revenue |
-- +------+-------------+-------------+-------------+-----+-------------+
-- | 1    | 8000        | 7000        | 6000        | ... | null        |
-- | 2    | 9000        | null        | null        | ... | null        |
-- | 3    | null        | 10000       | null        | ... | null        |
-- +------+-------------+-------------+-------------+-----+-------------+

-- Note that the result table has 13 columns (1 for the department id + 12 for the months).

-- Solution
select id, (select sum(revenue)
            from department as d1
            where d1.id = d.id
            and d1.month = "Jan") as Jan_revenue,
            (select sum(revenue)
            from department as d1
            where d1.id = d.id
            and d1.month = "Feb") as Feb_revenue,
            (select sum(revenue)
            from department as d1
            where d1.id = d.id
            and d1.month = "Mar") as Mar_revenue,
            (select sum(revenue)
            from department as d1
            where d1.id = d.id
            and d1.month = "Apr") as Apr_revenue,
            (select sum(revenue)
            from department as d1
            where d1.id = d.id
            and d1.month = "May") as May_revenue,
            (select sum(revenue)
            from department as d1
            where d1.id = d.id
            and d1.month = "Jun") as Jun_revenue,
            (select sum(revenue)
            from department as d1
            where d1.id = d.id
            and d1.month = "Jul") as Jul_revenue,
            (select sum(revenue)
            from department as d1
            where d1.id = d.id
            and d1.month = "Aug") as Aug_revenue,
            (select sum(revenue)
            from department as d1
            where d1.id = d.id
            and d1.month = "Sep") as Sep_revenue,
            (select sum(revenue)
            from department as d1
            where d1.id = d.id
            and d1.month = "Oct") as Oct_revenue,
            (select sum(revenue)
            from department as d1
            where d1.id = d.id
            and d1.month = "Nov") as Nov_revenue,
            (select sum(revenue)
            from department as d1
            where d1.id = d.id
            and d1.month = "Dec") as Dec_revenue
from department as d
group by id;
