USE [MSSQL_QLDN_QLNS_DEMO]
GO
/****** Object:  StoredProcedure [dbo].[sp_KD_NhanVien_cbxNhanVienByPhongBanId]    Script Date: 12/19/2017 10:05:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


ALTER PROCEDURE [dbo].[sp_KD_NhanVien_cbxNhanVienByPhongBanId]
( 
	  @UserId		    nvarchar(500)	= null
	, @Search			nvarchar(500)   = null
	, @FunctionCode		nvarchar(500)   = null
	, @PhongBanId		INT				= 0
	, @NhanVienId		INT				= 0
	
)
AS  
BEGIN
SET NOCOUNT ON  
--------------------------------------------------  
	SET @PhongBanId = ISNULL(@PhongBanId,0)
	SET @NhanVienId = ISNULL(@NhanVienId,0)

	SELECT *, NV.Ten TenNhanVien, NV.Ma MaNhanVien
	FROM dbo.NhanVien NV 
	JOIN dbo.PhongBan PB ON PB.PhongBanId = NV.PhongBanId
	WHERE (@PhongBanId = 0 OR NV.PhongBanId = @PhongBanId)
	AND (@NhanVienId = 0 OR NV.NhanVienId = @NhanVienId)

--------------------------------------------------
SET NOCOUNT OFF
END
