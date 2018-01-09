
GO
/****** Object:  StoredProcedure [dbo].[sp_KD_ChiTieuChiTiet_GetChiTieuChiTietByChiTieuId]    Script Date: 12/19/2017 9:47:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROC [dbo].[sp_KD_ChiTieuChiTiet_GetChiTieuChiTietByChiTieuId]
( 
	  @ChiTieuId NVARCHAR(500)	= null			
)
AS  
BEGIN
SET NOCOUNT ON  
------------------------------------------------  

	SELECT [ChiTieuChiTietId]
		  ,[ChiTieuId]
		  ,CAST(L.[NhanVienId] AS VARCHAR)NhanVienId
		  ,CONCAT(nv.Ho, ' ', nv.Ten) TenNhanVien
		  ,[Thang1]
		  ,[Thang2]
		  ,[Thang3]
		  ,[Thang4]
		  ,[Thang5]
		  ,[Thang6]
		  ,[Thang7]
		  ,[Thang8]
		  ,[Thang9]
		  ,[Thang10]
		  ,[Thang11]
		  ,[Thang12]
		  ,CONVERT(VARCHAR, [NgayCapNhat],103)NgayCapNhat
	FROM [dbo].[KDChiTieuChiTiet] L
	LEFT JOIN dbo.NhanVien nv ON nv.NhanVienId = L.NhanVienId
	WHERE ChiTieuId = @ChiTieuId
-----------------------------------------------------
SET NOCOUNT OFF
END



