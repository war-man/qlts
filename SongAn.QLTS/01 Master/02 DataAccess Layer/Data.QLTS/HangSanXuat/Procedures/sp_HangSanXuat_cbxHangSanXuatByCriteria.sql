USE [QLTS]
GO
/****** Object:  StoredProcedure [dbo].[sp_HangSanXuat_cbxHangSanXuatByCriteria]    Script Date: 08/23/2017 08:41:08 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROC [dbo].[sp_HangSanXuat_cbxHangSanXuatByCriteria]
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

	SELECT a.HangSanXuatId,a.MaHangSanXuat,a.TenHangSanXuat
	FROM HangSanXuat a LEFT JOIN [QLTS_MAIN].[dbo].[NguoiDung] b on a.NguoiTao=b.NhanVienId 
	

	

-----------------------------------------------------
SET NOCOUNT OFF
END

USE [QLTS]
GO
/****** Object:  StoredProcedure [dbo].[sp_HangSanXuat_cbxHangSanXuatByCriteria]    Script Date: 08/23/2017 08:41:08 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROC [dbo].[sp_HangSanXuat_cbxHangSanXuatByCriteria]
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

	SELECT a.HangSanXuatId,a.MaHangSanXuat,a.TenHangSanXuat
	FROM HangSanXuat a LEFT JOIN [QLTS_MAIN].[dbo].[NguoiDung] b on a.NguoiTao=b.NhanVienId 
	

	

-----------------------------------------------------
SET NOCOUNT OFF
END

