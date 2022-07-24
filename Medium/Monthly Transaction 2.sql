-- Question 95
-- Table: Transactions

-- +----------------+---------+
-- | Column Name    | Type    |
-- +----------------+---------+
-- | id             | int     |
-- | country        | varchar |
-- | state          | enum    |
-- | amount         | int     |
-- | trans_date     | date    |
-- +----------------+---------+
-- id is the primary key of this table.
-- The table has information about incoming transactions.
-- The state column is an enum of type ["approved", "declined"].
-- Table: Chargebacks

-- +----------------+---------+
-- | Column Name    | Type    |
-- +----------------+---------+
-- | trans_id       | int     |
-- | charge_date    | date    |
-- +----------------+---------+
-- Chargebacks contains basic information regarding incoming chargebacks from some transactions placed in Transactions table.
-- trans_id is a foreign key to the id column of Transactions table.
-- Each chargeback corresponds to a transaction made previously even if they were not approved.
 

-- Write an SQL query to find for each month and country, the number of approved transactions and their total amount, the number of chargebacks and their total amount.

-- Note: In your query, given the month and country, ignore rows with all zeros.

-- The query result format is in the following example:

-- Transactions table:
-- +------+---------+----------+--------+------------+
-- | id   | country | state    | amount | trans_date |
-- +------+---------+----------+--------+------------+
-- | 101  | US      | approved | 1000   | 2019-05-18 |
-- | 102  | US      | declined | 2000   | 2019-05-19 |
-- | 103  | US      | approved | 3000   | 2019-06-10 |
-- | 104  | US      | approved | 4000   | 2019-06-13 |
-- | 105  | US      | approved | 5000   | 2019-06-15 |
-- +------+---------+----------+--------+------------+

-- Chargebacks table:
-- +------------+------------+
-- | trans_id   | trans_date |
-- +------------+------------+
-- | 102        | 2019-05-29 |
-- | 101        | 2019-06-30 |
-- | 105        | 2019-09-18 |
-- +------------+------------+

-- Result table:
-- +----------+---------+----------------+-----------------+-------------------+--------------------+
-- | month    | country | approved_count | approved_amount | chargeback_count  | chargeback_amount  |
-- +----------+---------+----------------+-----------------+-------------------+--------------------+
-- | 2019-05  | US      | 1              | 1000            | 1                 | 2000               |
-- | 2019-06  | US      | 3              | 12000           | 1                 | 1000               |
-- | 2019-09  | US      | 0              | 0               | 1                 | 5000               |
-- +----------+---------+----------------+-----------------+-------------------+--------------------+

-- Solution
select cb_month as month, table2.country, coalesce(approved_count,0) as approved_count, coalesce(approved_amount,0) as approved_amount, chargeback_count, chargeback_amount
from
(select app_month, country, sum(approved) as approved_count, sum(approved_amt) as approved_amount
from (select *, date_format(trans_date,"%Y-%m") as app_month,
      case when state = "approved" then 1 else 0 end as approved,
      case when state = "approved" then amount else 0 end as approved_amt
      from transactions) as t1
group by app_month, country) as t2

right join

(select *
from (select country, date_format(c.trans_date,"%Y-%m") as cb_month, 
        count(c.trans_id) over(partition by trans_id) as chargeback_count,
        sum(amount) over(partition by trans_id) as chargeback_amount
      from chargebacks as c
      left join transactions as t
      on c.trans_id = t.id) as table1
group by cb_month, country) as table2

on t2. app_month = table2.cb_month
and t2. country = table2.country
