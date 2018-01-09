
GO
/****** Object:  StoredProcedure [dbo].[sp_KD_BaoGiaChiTiet_GetBaoGiaChiTietByBaoGiaId]    Script Date: 12/19/2017 9:45:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROC [dbo].[sp_KD_BaoGiaChiTiet_GetBaoGiaChiTietByBaoGiaId]
( 
	  @BaoGiaId NVARCHAR(500)	= null			
)
AS  
BEGIN
SET NOCOUNT ON  
------------------------------------------------  

	SELECT [BaoGiaChiTietId]
		  ,[BaoGiaId]
		  ,CAST(KH.[HangHoaId] AS VARCHAR)[HangHoaId]
		  ,HH.MaHangHoa
		  ,HH.TenHangHoa
		  ,HH.DonViTinh
		  ,[SoLuong]
		  ,[DonGia]
		  ,CONVERT(VARCHAR, KH.NgayBao,103)NgayBao
		  ,CONVERT(VARCHAR, KH.NgayNhan,103)NgayNhan
	FROM dbo.KDBaoGiaChiTiet KH
	LEFT JOIN dbo.KhoHangHoa HH ON HH.HangHoaId = KH.HangHoaId
	WHERE BaoGiaId = @BaoGiaId
-----------------------------------------------------
SET NOCOUNT OFF
END

