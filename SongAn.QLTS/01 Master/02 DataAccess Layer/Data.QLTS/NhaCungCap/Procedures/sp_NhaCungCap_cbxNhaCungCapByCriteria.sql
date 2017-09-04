USE [QLTS]
GO
/****** Object:  StoredProcedure [dbo].[sp_NhaCungCap_cbxNhaCungCapByCriteria]    Script Date: 08/23/2017 08:47:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROC [dbo].[sp_NhaCungCap_cbxNhaCungCapByCriteria]
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

	SELECT a.NhaCungCapId,a.MaNhaCungCap,a.TenNhaCungCap
	FROM NhaCungCap a LEFT JOIN [QLTS_MAIN].[dbo].[NguoiDung] b on a.NguoiTao=b.NhanVienId 
	Where a.CoSoId = @CoSoId

	

-----------------------------------------------------
SET NOCOUNT OFF
END

