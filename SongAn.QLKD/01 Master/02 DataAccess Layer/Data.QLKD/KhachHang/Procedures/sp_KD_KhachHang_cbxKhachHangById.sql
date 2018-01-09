USE [MSSQL_QLDN_QLNS_DEMO]
GO
/****** Object:  StoredProcedure [dbo].[sp_KD_KhachHang_cbxKhachHangById]    Script Date: 12/19/2017 10:02:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


ALTER PROCEDURE [dbo].[sp_KD_KhachHang_cbxKhachHangById]
( 
	  @UserId		    nvarchar(500)	= NULL
    , @NhanVienId	    nvarchar(500)	= null
	, @Search			nvarchar(500)   = null
	, @FunctionCode		nvarchar(500)   = null
	, @KhachHangId	INT				= 0
	
)
AS  
BEGIN
SET NOCOUNT ON  
--------------------------------------------------  
	SET @KhachHangId = ISNULL(@KhachHangId,0)

	SELECT KhachHangId, MaKhachHang, TenKhachHang
	FROM dbo.KDKhachHang
	WHERE (@KhachHangId = 0 OR KhachHangId = @KhachHangId)

--------------------------------------------------
SET NOCOUNT OFF
END
