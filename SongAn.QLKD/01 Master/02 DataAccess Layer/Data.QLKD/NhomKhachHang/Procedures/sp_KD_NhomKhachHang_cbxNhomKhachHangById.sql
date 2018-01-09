USE [MSSQL_QLDN_QLNS_DEMO]
GO
/****** Object:  StoredProcedure [dbo].[sp_KD_NhomKhachHang_cbxNhomKhachHangById]    Script Date: 12/19/2017 10:05:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


ALTER PROCEDURE [dbo].[sp_KD_NhomKhachHang_cbxNhomKhachHangById]
( 
	  @UserId		    nvarchar(500)	= NULL
    , @NhanVienId	    nvarchar(500)	= null
	, @Search			nvarchar(500)   = null
	, @FunctionCode		nvarchar(500)   = null
	, @NhomKhachHangId	INT				= 0
	
)
AS  
BEGIN
SET NOCOUNT ON  
--------------------------------------------------  
	SET @NhomKhachHangId = ISNULL(@NhomKhachHangId,0)

	SELECT NhomKhachHangId, MaNhom MaNhomKhachHang, TenNhom TenNhomKhachHang
	FROM dbo.KDNhomKhachHang
	WHERE (@NhomKhachHangId = 0 OR NhomKhachHangId = @NhomKhachHangId)

--------------------------------------------------
SET NOCOUNT OFF
END
