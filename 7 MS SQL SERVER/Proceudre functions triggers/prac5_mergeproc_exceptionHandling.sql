alter procedure swap_ETL_Employee
AS
BEGIN
	declare @ReturnError int;
begin try
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

end try

begin catch
set @ReturnError = -101;
SELECT
   ERROR_NUMBER() AS ErrorNumber,
    ERROR_STATE() AS ErrorState,
    ERROR_SEVERITY() AS ErrorSeverity,
    ERROR_PROCEDURE() AS ErrorProcedure,
    ERROR_LINE() AS ErrorLine,
    ERROR_MESSAGE() AS ErrorMessage;
end catch;

END;

GO;

--executing prc\oc

drop table employee;
drop table employeesource;
create table employee( eid int , name varchar(3));
create table employeesource (eid int , name varchar(4));
insert into employeesource values(4,'444');
insert into employeesource values(1,'aaa');


execute swap_ETL_Employee;

select  * from employeesource;
select  * from employee;