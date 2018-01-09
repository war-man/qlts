USE [MSSQL_QLDN_QLNS_DEMO]
GO
/****** Object:  StoredProcedure [dbo].[sp_KD_PhuongXa_cbxPhuongXaByQuanId]    Script Date: 12/19/2017 10:06:51 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[sp_KD_PhuongXa_cbxPhuongXaByQuanId]
( 
	  @UserId		    nvarchar(500)	= NULL
    , @NhanVienId	    nvarchar(500)	= null
	, @Search			nvarchar(500)   = null
	, @FunctionCode		nvarchar(500)   = null
	, @QuanHuyenId		INT				= 0
	, @PhuongXaId		INT				= 0
	
)
AS  
BEGIN
SET NOCOUNT ON  
-------------------------------------------------- 	
	DECLARE @MaQuanHuyen NVARCHAR(50)
	SET @QuanHuyenId = ISNULL(@QuanHuyenId,0)
	SELECT @MaQuanHuyen = MaQuanHuyen FROM dbo.QuanHuyen WHERE QuanHuyenId = @QuanHuyenId
	SET @PhuongXaId = ISNULL(@PhuongXaId,0)
	SET @MaQuanHuyen = ISNULL(@MaQuanHuyen,'')

	SELECT TOP 100 PhuongXaId, MaPhuongXa, TenPhuongXa
	FROM dbo.PhuongXa H
	JOIN dbo.QuanHuyen tp ON tp.MaQuanHuyen = H.MaQuanHuyen
	WHERE (@PhuongXaId = 0 OR PhuongXaId = @PhuongXaId)
	AND (@MaQuanHuyen = '' OR H.MaQuanHuyen = @MaQuanHuyen)

--------------------------------------------------
SET NOCOUNT OFF
END
