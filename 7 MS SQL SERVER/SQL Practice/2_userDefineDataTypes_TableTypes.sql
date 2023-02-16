/*
User defined data type 
https://www.sqlshack.com/an-overview-of-user-defined-sql-server-types/
*/

--user defined data ypes 
Create type PhoneNumberType from varchar(14) null; 


Create table PersonNewinfo
( PersonId int,
 Phonenumber dbo.PhoneNumberType	,

);

CREATE DEFAULT PhoneNumber
AS 'Unknown'
GO
    
USE AdventureWorks2019
GO
    
CREATE RULE Rule_PhoneNumber
AS
(@phone='Unknown')	
OR (LEN(@phone)=14
AND SUBSTRING(@phone,1,1)= '+'
AND SUBSTRING(@phone,4,1)= '-')
GO


--bind above rule to UDT

USE [AdventureWorks2019]
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[Rule_PhoneNumber]', @objname=N'[dbo].[PhoneNumberType]' 
GO
USE [AdventureWorks2019]
GO
EXEC sys.sp_bindefault @defname=N'[dbo].[PhoneNumber]', @objname=N'[dbo].[PhoneNumberType]' 
GO


insert into PersonNewinfo values(1,'123231');
/*
This will give an error as it violate the rule 
Msg 513, Level 16, State 0, Line 49
A column insert or update conflicts with a rule imposed by a previous CREATE RULE statement. 
The statement was terminated. 
The conflict occurred in database 'AdventureWorks2019', table 'dbo.PersonNewinfo', column 'Phonenumber'.
The statement has been terminated.
Below will be success
*/


insert into PersonNewinfo values(1,'+91-1234567890');
select * from PersonNewinfo;

-----------------------------------

--User defined table type 
--similar to record type / collection in oracle 
CREATE TYPE ProductTableType AS TABLE (
    ProductName VARCHAR(50),
    Cost INT);

--now in procedure you can fetch a data in this record type which can be further use for processing 
-- or send as a collection paramter 
--Example within proc you insert data in aboev record type


CREATE PROCEDURE GetProducts
    @p ProductTableType READONLY
as
SELECT ProductName,COST
    FROM @P
    RETURN 0
;
GO

/* execute below as a one session */
DECLARE @p as ProductTableType
INSERT @p
    VALUES ('AC', 123)
        , ('CA', 345)
        , ('DB', 543)
; 
select * from @p;
or     
exec GetProducts @p


select 