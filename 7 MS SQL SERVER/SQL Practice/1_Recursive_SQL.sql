USE [AdventureWorks2019]
GO

DECLARE	@increment int =100;

With REC_BLOCK 
as (
SELECT  e.BusinessEntityID,LoginID 
FROM [HumanResources].[Employee] e
WHERE  e.BusinessEntityID +1<=@increment
)
SELECT * FROM REC_BLOCK
ORDER BY 1 DESC
OPTION(MAXRECURSION 1);
