


/* FIND OUT UNIQUE COUNT OF CUSTOMERS JOINED ON EACH DAY
Means if customer placed first order on Jan1 then it should be counted as 1 .
  If same customer places N number of orders on same day or any other day then should not be counted

*/

/*--Approach 1  if we need dates on which at least one user have actiivty */
SELECT orderdate, count(*)
FROM (
SELECT
      min(orderdate) OrderDate
     FROM orders
GROUP BY  Customerid )t
GROUP BY  OrderDate
ORDER BY OrderDate DESC;

/* Approach 2 - if we want all dates irrespective wether it has any record for given date or no */

select orderdate, sum(case when cnt=1 then 1 else 0 end )count_users
from (
SELECT   *, row_number() over(partition by CUSTOMERID order by ORDERDATE) cnt
FROM orders) t
group by orderdate
order by orderdate desc;