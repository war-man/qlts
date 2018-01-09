
GO
/****** Object:  StoredProcedure [dbo].[sp_KD_ChiTieu_GetChiTieuById]    Script Date: 12/19/2017 9:46:08 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROC [dbo].[sp_KD_ChiTieu_GetChiTieuById]
( 
	  @ChiTieuId NVARCHAR(500)	= null			
)
AS  
BEGIN
SET NOCOUNT ON  
------------------------------------------------  

	SELECT [ChiTieuId]
		  ,CAST([Nam] AS INT) Nam
		  ,[NguoiTao]
		  ,[NgayTao]
		  ,[CtrVersion]
	FROM [dbo].[KDChiTieu]
	WHERE ChiTieuId = @ChiTieuId
-----------------------------------------------------
SET NOCOUNT OFF
END



