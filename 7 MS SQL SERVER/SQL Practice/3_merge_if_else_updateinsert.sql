create table employee( eid int , name varchar(40));

begin transaction
insert into employee values(1,'abc');
commit transaction ;
Go
select * from employee;


-- Approach 1 using if exists

begin transaction 
declare @eid int =1;
declare @ename varchar(20)= 'def';

IF EXISTS (select * from employee with(UPDLOCK, SERIALIZABLE)
where eid=@eid )
update employee 
set name=@ename
where eid =@eid;
Else
insert into employee values(@eid,@ename);

commit transaction;
SELECT @@ROWCOUNT;
select * from employee;

---Appraoch 2 

begin transaction 
declare @eid int =2;
declare @ename varchar(20)= 'xyz';

MERGE  employee WITH(holdlock ) AS Target
using (values(@eid,@ename)) as Source( Eid,Ename)
on target.eid=source.eid
when matched then
update set Target.name=source.ename
when not matched then insert (eid,name) values(source.eid,source.ename);
commit transaction ;

select  * from employee;


begin transaction 
declare @eid int =2;
declare @ename varchar(20)= 'xyz1111';

MERGE  employee WITH(holdlock ) AS Target
using (values(@eid,@ename)) as Source( Eid,Ename)
on target.eid=source.eid
when matched then
update set Target.name=source.ename
when not matched then insert (eid,name) values(source.eid,source.ename);
commit transaction ;

select  * from employee;


--Approach 3  delete the target table entry if not found in source 

create table employeesource (eid int , name varchar(30));
insert into employeesource values(3,'333');
insert into employeesource values(1,'aaa');
select * from employeesource;

merge employee as Target
using Employeesource as source
on source.eid=target.eid
when not matched then
	insert values(source.eid,source.name)
when matched
	AND ( source.name<>target.name) 
	then
	update set target.name=source.name
when not matched by Source 
	then 
		delete;

		select * from employee; ---2 got deleted 
