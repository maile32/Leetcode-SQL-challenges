-- Question 37
-- Several friends at a cinema ticket office would like to reserve consecutive available seats.
-- Can you help to query all the consecutive available seats order by the seat_id using the following cinema table?
-- | seat_id | free |
-- |---------|------|
-- | 1       | 1    |
-- | 2       | 0    |
-- | 3       | 1    |
-- | 4       | 1    |
-- | 5       | 1    |
 

-- Your query should return the following result for the sample case above.
 

-- | seat_id |
-- |---------|
-- | 3       |
-- | 4       |
-- | 5       |
-- Note:
-- The seat_id is an auto increment int, and free is bool ('1' means free, and '0' means occupied.).
-- Consecutive available seats are more than 2(inclusive) seats consecutively available.

-- Solution
select seat_id from (select seat_id, case
                    when (select free from cinema as c2
                          where c2.seat_id = c1.seat_id - 1) = 1
                          or (select free from cinema as c2
                          where c2.seat_id = c1.seat_id + 1) = 1
                      then "conse"
                    else "non-conse"
                    end as conse
                    from cinema as c1
                    where c1.free = 1) as conse_seat
where conse = "conse"
                    
