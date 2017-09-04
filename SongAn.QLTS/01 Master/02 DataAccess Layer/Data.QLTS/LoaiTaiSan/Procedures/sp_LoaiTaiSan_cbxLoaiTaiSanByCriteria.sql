USE [QLTS]
GO
/****** Object:  StoredProcedure [dbo].[sp_LoaiTaiSan_cbxLoaiTaiSanByCriteria]    Script Date: 08/23/2017 08:45:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROC [dbo].[sp_LoaiTaiSan_cbxLoaiTaiSanByCriteria]
( 
	  @CoSoId	        nvarchar(500)	= null			
	, @NhanVienId	    nvarchar(500)	= null		
	, @Search			nvarchar(500)   = null	
	
)
AS  
BEGIN
SET NOCOUNT ON  
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
------------------------------------------------  

	SELECT a.LoaiId,a.MaLoai,a.TenLoai
	FROM LoaiTaiSan a LEFT JOIN [QLTS_MAIN].[dbo].[NguoiDung] b on a.NguoiTao=b.NhanVienId 


	

-----------------------------------------------------
SET NOCOUNT OFF
END

