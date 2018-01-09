USE [MSSQL_QLDN_QLNS_DEMO]
GO
/****** Object:  StoredProcedure [dbo].[sp_KD_NhomKhachHang_GetNhomKhachHangById]    Script Date: 12/19/2017 10:06:08 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROC [dbo].[sp_KD_NhomKhachHang_GetNhomKhachHangById]
( 
	  @NhomKhachHangId NVARCHAR(500)	= null			
)
AS  
BEGIN
SET NOCOUNT ON  
------------------------------------------------  

	SELECT NhomKhachHangId, MaNhom, TenNhom, NguoiTao, CONVERT(VARCHAR, NgayTao, 103)NgayTao 
	FROM dbo.KDNhomKhachHang H
	
	WHERE NhomKhachHangId = @NhomKhachHangId
-----------------------------------------------------
SET NOCOUNT OFF
END



