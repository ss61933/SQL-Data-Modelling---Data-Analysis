drop function swap_table_value_f;

create function swap_table_value_f( @p_mstatus char(10))
returns  TABLE
as
return
select  [NationalIDNumber]
      from HumanResources.Employee
	  where MaritalStatus=@p_mstatus;



select * from swap_table_value_f('S')



