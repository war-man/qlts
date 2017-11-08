ALTER PROC [dbo].[sp_GhiGiam_DeleteGhiGiamById]
( 
	  @GhiGiamId	        nvarchar(500)	= null			

)
AS  
BEGIN
SET NOCOUNT ON  
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
------------------------------------------------  

	Delete GhiGiam where GhiGiamId = @GhiGiamId
	select @@ROWCOUNT
-----------------------------------------------------
SET NOCOUNT OFF
END

