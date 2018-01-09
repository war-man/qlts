USE [MSSQL_QLDN_QLNS_DEMO]
GO
/****** Object:  StoredProcedure [dbo].[sp_KD_NhomKinhDoanh_cbxNhomKinhDoanhByCriteria]    Script Date: 12/19/2017 10:06:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[sp_KD_NhomKinhDoanh_cbxNhomKinhDoanhByCriteria]
( 
	  @USER_ID		    nvarchar(500)	= NULL
    , @NHANVIEN_ID	    nvarchar(500)	= null
	, @Search			nvarchar(500)   = null
	, @FunctionCode		nvarchar(500)   = null
	, @NhomKinhDoanhId		INT				= 0
	
)
AS  
BEGIN
SET NOCOUNT ON  
-------------------------------------------------- 	
	Select * from KDNhomKinhDoanh where
	 (@NhomKinhDoanhId = 0 OR NhomKinhDoanhId = @NhomKinhDoanhId)
		AND (@Search = '' 
			OR MaNhomKinhDoanh LIKE @Search
			OR TenNhomKinhDoanh LIKE @Search
		)
--------------------------------------------------
SET NOCOUNT OFF
END
