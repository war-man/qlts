USE [MSSQL_QLDN_QLNS_DEMO]
GO
/****** Object:  StoredProcedure [dbo].[sp_KD_QuanHuyen_cbxQuanHuyenByTinhId]    Script Date: 12/19/2017 10:06:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[sp_KD_QuanHuyen_cbxQuanHuyenByTinhId]
( 
	  @UserId		    nvarchar(500)	= NULL
    , @NhanVienId	    nvarchar(500)	= null
	, @Search			nvarchar(500)   = null
	, @FunctionCode		nvarchar(500)   = null
	, @QuanHuyenId	INT				= 0
	, @TinhId		INT				= 0
	
)
AS  
BEGIN
SET NOCOUNT ON  
--------------------------------------------------  
	DECLARE @MaTinh NVARCHAR(50)
	SET @TinhId = ISNULL(@TinhId,0)
	SELECT @MaTinh = MaTT FROM dbo.TinhThanhPho WHERE TinhThanhPhoId = @TinhId
	SET @QuanHuyenId = ISNULL(@QuanHuyenId,0)	
	SET @MaTinh = ISNULL(@MaTinh,'')

	SELECT TOP 100 QuanHuyenId, MaQuanHuyen, TenQuanHuyen
	FROM dbo.QuanHuyen H
	JOIN dbo.TinhThanhPho tp ON tp.MaTT = H.MaTT
	WHERE (@QuanHuyenId = 0 OR QuanHuyenId = @QuanHuyenId)
	AND (@MaTinh = '' OR H.MaTT = @MaTinh)

--------------------------------------------------
SET NOCOUNT OFF
END
