USE [QLTS]
GO
/****** Object:  StoredProcedure [dbo].[sp_NhanVien_cbxNhanVienByCriteria]    Script Date: 08/23/2017 08:48:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROC [dbo].[sp_NhanVien_cbxNhanVienByCriteria]
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

	SELECT a.NhanVienId,a.MaNhanVien,a.TenNhanVien
	FROM NhanVien a LEFT JOIN [QLTS_MAIN].[dbo].[NguoiDung] b on a.NguoiTao=b.NhanVienId inner join PhongBan c on a.PhongBanId=c.PhongBanId
	Where c.CoSoId = @CoSoId

	

-----------------------------------------------------
SET NOCOUNT OFF
END

