USE [MSSQL_QLDN_QLNS_DEMO]
GO
/****** Object:  StoredProcedure [dbo].[sp_KD_LoaiHangHoa_cbxLoaiHangHoaById]    Script Date: 12/19/2017 10:03:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


ALTER PROCEDURE [dbo].[sp_KD_LoaiHangHoa_cbxLoaiHangHoaById]
( 
	  @UserId		    nvarchar(500)	= NULL
    , @NhanVienId	    nvarchar(500)	= null
	, @Search			nvarchar(500)   = null
	, @FunctionCode		nvarchar(500)   = null
	, @LoaiHangHoaId	INT				= 0
	
)
AS  
BEGIN
SET NOCOUNT ON  
--------------------------------------------------  
	SET @LoaiHangHoaId = ISNULL(@LoaiHangHoaId,0)

	SELECT LoaiHangHoaId, MaLoai, TenLoai
	FROM dbo.KDLoaiHangHoa
	WHERE (@LoaiHangHoaId = 0 OR LoaiHangHoaId = @LoaiHangHoaId)
	

--------------------------------------------------
SET NOCOUNT OFF
END
