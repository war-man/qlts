USE [MSSQL_QLDN_QLNS_DEMO]
GO
/****** Object:  StoredProcedure [dbo].[sp_KD_TinhThanhPho_cbxTinhThanhPhoById]    Script Date: 12/19/2017 10:07:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


ALTER PROCEDURE [dbo].[sp_KD_TinhThanhPho_cbxTinhThanhPhoById]
( 
	  @UserId		    nvarchar(500)	= NULL
    , @NhanVienId	    nvarchar(500)	= null
	, @Search			nvarchar(500)   = null
	, @FunctionCode		nvarchar(500)   = null
	, @TinhThanhPhoId	INT				= 0
	
)
AS  
BEGIN
SET NOCOUNT ON  
--------------------------------------------------  
	SET @TinhThanhPhoId = ISNULL(@TinhThanhPhoId,0)

	SELECT TinhThanhPhoId, MaTT MaTinh, TenTT TenTinh
	FROM dbo.TinhThanhPho
	WHERE (@TinhThanhPhoId = 0 OR TinhThanhPhoId = @TinhThanhPhoId)

--------------------------------------------------
SET NOCOUNT OFF
END
