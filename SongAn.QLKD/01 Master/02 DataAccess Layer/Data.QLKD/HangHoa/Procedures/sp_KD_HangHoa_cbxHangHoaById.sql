USE [MSSQL_QLDN_QLNS_DEMO]
GO
/****** Object:  StoredProcedure [dbo].[sp_KD_HangHoa_cbxHangHoaById]    Script Date: 12/19/2017 10:00:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


ALTER PROCEDURE [dbo].[sp_KD_HangHoa_cbxHangHoaById]
( 
	  @UserId		    nvarchar(500)	= NULL
    , @NhanVienId	    nvarchar(500)	= null
	, @Search			nvarchar(500)   = null
	, @FunctionCode		nvarchar(500)   = null
	, @HangHoaId		INT				= 0
	, @MaHangHoa		nvarchar(50)   
	
)
AS  
BEGIN
SET NOCOUNT ON  
--------------------------------------------------  
	SET @HangHoaId = ISNULL(@HangHoaId,0)
	SET @MaHangHoa = ISNULL(@MaHangHoa,'')

	SELECT HangHoaId, MaHangHoa, TenHangHoa, DonViTinh, ISNULL(GiaMua, 0)GiaMua, ISNULL(GiaBan, 0)GiaBan
	FROM dbo.KhoHangHoa
	WHERE (@HangHoaId = 0 OR HangHoaId = @HangHoaId)
	AND (@MaHangHoa = '' OR MaHangHoa = @MaHangHoa)
	AND XoaYN = 'N'

--------------------------------------------------
SET NOCOUNT OFF
END
