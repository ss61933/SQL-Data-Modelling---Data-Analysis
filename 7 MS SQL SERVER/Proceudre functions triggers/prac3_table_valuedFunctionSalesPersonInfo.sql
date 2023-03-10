USE [AdventureWorks2019]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
DROP FUNCTION sales.SWAP_TABLE_VALUE_F1;
GO
CREATE FUNCTION	sales.SWAP_TABLE_VALUE_F1 (@bid INT)
	RETURNS @tabletype TABLE
	(BID  INT NOT NULL, RID INT
)
AS

BEGIN
	IF @bid IS NOT NULL 
		BEGIN
			
			IF EXISTS(  SELECT BusinessEntityID,TerritoryID FROM sALES.SalesPerson
						  WHERE BusinessEntityID=@BID)
				INSERT  into @tabletype
				SELECT BusinessEntityID,TerritoryID FROM sALES.SalesPerson
						  WHERE BusinessEntityID=@BID;


		END;

RETURN;

END;


select * from 
sales.SWAP_TABLE_VALUE_F1(274);