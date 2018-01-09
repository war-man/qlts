USE [MSSQL_QLDN_QLNS_DEMO]
GO
/****** Object:  StoredProcedure [dbo].[sp_KD_DonHangChiTiet_GetDonHangChiTietByDonHangId]    Script Date: 12/19/2017 9:52:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROC [dbo].[sp_KD_DonHangChiTiet_GetDonHangChiTietByDonHangId]
( 
	  @DonHangId NVARCHAR(500)	= null			
)
AS  
BEGIN
SET NOCOUNT ON  
------------------------------------------------  

	SELECT [DonHangChiTietId]
		  ,[DonHangId]
		  ,CAST(KH.[HangHoaId] AS VARCHAR)[HangHoaId]
		  ,HH.MaHangHoa
		  ,HH.TenHangHoa
		  ,HH.DonViTinh
		  ,[SoLuong]
		  ,[DonGia]
		  ,CONVERT(VARCHAR, [NgayYeuCau],103)NgayYeuCau
		  ,CONVERT(VARCHAR, [NgayNhanHang],103)NgayNhanHang
	FROM dbo.KDDonHangChiTiet KH
	LEFT JOIN dbo.KhoHangHoa HH ON HH.HangHoaId = KH.HangHoaId
	WHERE DonHangId = @DonHangId
-----------------------------------------------------
SET NOCOUNT OFF
END



