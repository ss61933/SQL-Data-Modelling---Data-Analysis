DROP procedure swap_cursor_Person;
go

create procedure swap_cursor_Person
@BID int,
@TID char(10)
as

begin

DECLARE CURSOR_SALESPERSON CURSOR
FOR 
SELECT BusinessEntityID,TerritoryID
from Sales.SalesPerson;

OPEN CURSOR_SALESPERSON;

FETCH NEXT FROM CURSOR_SALESPERSON INTO 
@BID ,
@TID ;

WHILE @@FETCH_STATUS = 0 

BEGIN
		PRINT 'EMPLOYEE IS - ' +CAST(@BID  AS VARCHAR)+ CAST(@TID AS varchar);
        FETCH NEXT FROM CURSOR_SALESPERSON INTO 
          @BID ,
			@TID ;

			select * from sales.SWAP_TABLE_VALUE_F1( @BID);

END;

CLOSE CURSOR_SALESPERSON;

DEALLOCATE CURSOR_SALESPERSON;
end;


USE [AdventureWorks2019]
GO

DECLARE @RC int
DECLARE @BID int
DECLARE @TID char(10)

-- TODO: Set parameter values here.

EXECUTE @RC = [dbo].[swap_cursor_Person] 
   @BID
  ,@TID
GO


