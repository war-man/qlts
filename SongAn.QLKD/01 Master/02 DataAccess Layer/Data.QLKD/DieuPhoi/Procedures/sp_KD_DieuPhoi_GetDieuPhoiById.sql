
GO
/****** Object:  StoredProcedure [dbo].[sp_KD_DieuPhoi_GetDieuPhoiById]    Script Date: 12/19/2017 9:49:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROC [dbo].[sp_KD_DieuPhoi_GetDieuPhoiById]
( 
	  @DieuPhoiId NVARCHAR(500)	= null			
)
AS  
BEGIN
SET NOCOUNT ON  
------------------------------------------------  

	
	SELECT [DieuPhoiId]
		  ,CAST([DonHangId] AS VARCHAR) [DonHangId]
		  ,CONVERT(VARCHAR, [NgayDieuPhoi],103)NgayDieuPhoi
		  ,CAST([NhanVienDieuPhoi] AS VARCHAR)[NhanVienDieuPhoi]
		  ,[NguoiTao]
		  ,[NgayTao]
		  ,[CtrVersion]
	FROM dbo.KDDieuPhoi
	WHERE DieuPhoiId = @DieuPhoiId
-----------------------------------------------------
SET NOCOUNT OFF
END



