/*
Problem statement 
❓. A company wants to hire new employees. The budget of the company for the salaries is $70000. The company’s criteria for hiring are:
1. Keep hiring the senior with smallest salary until you cannot hire anymore seniors.
2. Use the remaining budget to hire the junior with the smallest salary.
3. Keep hiring the junior with the smallest salary until you cannot hire anymore juniors.

Write an SQL query to find the juniors and seniors hired under the mentioned category.
*/

use analytical_db;
create table emp_salary
(
 eid int,
 salary int,
 type char(10)
);

insert into emp_salary values(1,30000,'S');
insert into emp_salary values(2,20000,'S');
insert into emp_salary values(3,50000,'S');

insert into emp_salary values(4,5000,'J');
insert into emp_salary values(5,7000,'J');
insert into emp_salary values(6,10000,'J');
insert into emp_salary values(7,15000,'J');
commit;

/* SOLUTION */
with emp as (
	select eid,salary,type,sum(salary) over (partition by type order by salary asc) running_sal
	from emp_salary
)
,emp1 as /* get the list of seniors where total salary is below threshold */
(
	select *, sum(salary) over() total_Sal
	from emp
	where type='S' and running_sal<=70000
)
select  e.eid,e.salary,type
from emp e, (select total_Sal from emp1 limit 1) r
where  type='J' and running_sal+r.total_Sal <=70000 /* Get the list of Juniors where total sal is below threshold */
union  /* Union it with list of seniors */
select eid,salary,type from emp1
order by type desc,salary;


select * from  emp_salary;