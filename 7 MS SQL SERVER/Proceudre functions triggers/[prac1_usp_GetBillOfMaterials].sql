USE [AdventureWorks2019]
GO
/****** Object:  StoredProcedure [dbo].[prac1_usp_GetBillOfMaterials]    Script Date: 1/10/2023 9:12:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Swapnil
-- Create date: 10-jan-2023
-- Description: Practice 1 
-- use ctrl shift m to fill the default params
-- =============================================
ALTER PROCEDURE [dbo].[prac1_usp_GetBillOfMaterials] 
	-- Add the parameters for the stored procedure here
	   @StartProductID [int],
    @CheckDate [datetime]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    SELECT b.[ProductAssemblyID], b.[ComponentID]
        FROM [Production].[BillOfMaterials] b 
		WHERE @CheckDate>=b.StartDate
		and @CheckDate<=ISnull(b.EndDate,@CheckDate)
		and b.ProductAssemblyID=@StartProductID


END;


exec
sys.sp_addextendedproperty
@Name=N'Description',
@Value=N'Store proc to demo how to pass params and select ',
@level0type=N'Schema',
@level0name=N'dbo',
@level1type=N'Procedure ',
@level1name=N'prac1_usp_GetBillOfMaterials';


//* Executing the proc 
USE [AdventureWorks2019]
GO

DECLARE	@return_value int

EXEC	@return_value = [dbo].[prac1_usp_GetBillOfMaterials]
		@StartProductID = 807,
		@CheckDate = N'2010-03-04'

SELECT	'Return Value' = @return_value

GO

*/

