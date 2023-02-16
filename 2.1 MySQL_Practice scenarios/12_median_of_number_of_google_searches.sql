https://datalemur.com/questions/median-search-freq


with recursive cte1 as (
select searches, num_users 
from search_frequency
UNION ALL
select cte1.searches,cte1.num_users-1
from cte1
where cte1.num_users>1
)
select  
--expected output for this use case
PERCENTILE_CONT(0.5) within group (order by searches) as rn ,
-- if we want exact number from searches column
PERCENTILE_DISC(0.5) within group (order by searches) as rn1 
from cte1;
