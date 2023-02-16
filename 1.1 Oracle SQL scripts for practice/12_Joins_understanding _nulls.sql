create table a1 (col1 char(2));
create table a2 (col1 char(2));


insert into a1 values(null);
insert into a1 values(null);
insert into a1 values(null);
insert into a2 values(null);
insert into a2 values(null);

commit;

select * from a1,a2; -- cross join 6 rows 

select * from a1 inner join a2 on (a1.col1=a2.col1); -- zero rows 

select * from a1 left outer join a2 on (a1.col1=a2.col1); -- 3 rows 


select * from a1 right outer join a2 on (a1.col1=a2.col1); -- 2 rows


select * from a1 left outer join a2 on (a1.col1=a2.col1)
union 
select * from a1 right outer join a2 on (a1.col1=a2.col1); -- 1 row

select * from a1 left outer join a2 on (a1.col1=a2.col1)
union all
select * from a1 right outer join a2 on (a1.col1=a2.col1); -- 5 rows

select col1 from a1
 where col1 in (
select col2 from a2 ); -- not running 

select * from a1 inner join a2 on (a1.col1=a2.col1)
where a1.col1 is null; -- no data 

select * from a1 where col1 is null;

/*------------------------------------------------ */

create table a3 (col1 char(2));
create table a4 (col1 char(2));
insert into a3 values('a');
insert into a3 values(null);
insert into a3 values(null);
insert into a4 values('a');
insert into a4 values(null);
commit;

select * from a3,a4; -- 6 rows 

select * from a3 inner join a4
on a3.col1=a4.col1; -- 1 rows 


select * from a3 left outer join a4
on a3.col1=a4.col1; -- 3 rows  2 nulls will come 


select * from a3 left outer join a4
on a3.col1=a4.col1
where a3.col1 is null; -- 2 nulls will come 


select * from a3 left outer join a4
on a3.col1=a4.col1
and a3.col1 is null; -- 3 rows will come 

select * from a3 left outer join a4
on a3.col1=a4.col1
and a3.col1 is not null; -- 3 rows will come 