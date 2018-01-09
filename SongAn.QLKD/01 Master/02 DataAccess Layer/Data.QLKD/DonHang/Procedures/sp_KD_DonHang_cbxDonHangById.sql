USE [MSSQL_QLDN_QLNS_DEMO]
GO
/****** Object:  StoredProcedure [dbo].[sp_KD_DonHang_cbxDonHangById]    Script Date: 12/19/2017 9:51:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


ALTER PROCEDURE [dbo].[sp_KD_DonHang_cbxDonHangById]
( 
	  @UserId		    nvarchar(500)	= NULL
    , @NhanVienId	    nvarchar(500)	= null
	, @Search			nvarchar(500)   = null
	, @FunctionCode		nvarchar(500)   = null
	, @DonHangId		INT				= 0
	, @SoPhieu			NVARCHAR(50)   
	
)
AS  
BEGIN
SET NOCOUNT ON  
--------------------------------------------------  
	SET @DonHangId = ISNULL(@DonHangId,0)
	SET @SoPhieu = ISNULL(@SoPhieu,'')

	SELECT DonHangId, SoPhieu, TenDonHang
	FROM dbo.KDDonHang
	WHERE (@DonHangId = 0 OR DonHangId = @DonHangId)
	AND (@SoPhieu = '' OR SoPhieu = @SoPhieu)
	AND TrangThai = 0

--------------------------------------------------
SET NOCOUNT OFF
END
