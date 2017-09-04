USE [QLTS]
GO
/****** Object:  StoredProcedure [dbo].[sp_NuocSanXuat_cbxNuocSanXuatByCriteria]    Script Date: 08/23/2017 08:50:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROC [dbo].[sp_NuocSanXuat_cbxNuocSanXuatByCriteria]
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

	SELECT a.NuocSanXuatId,a.MaNuocSanXuat,a.TenNuocSanXuat
	FROM NuocSanXuat a LEFT JOIN [QLTS_MAIN].[dbo].[NguoiDung] b on a.NguoiTao=b.NhanVienId 
	

	

-----------------------------------------------------
SET NOCOUNT OFF
END

