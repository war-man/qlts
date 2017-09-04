USE [QLTS]
GO
/****** Object:  StoredProcedure [dbo].[sp_LoaiTaiSan_GetLoaiTaiSanById]    Script Date: 08/23/2017 08:45:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROC [dbo].[sp_LoaiTaiSan_GetLoaiTaiSanById]
( 
	  @LoaiId	        nvarchar(500)	= null			

)
AS  
BEGIN
SET NOCOUNT ON  
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
------------------------------------------------  

	SELECT a.LoaiId,a.MaLoai,a.TenLoai,b.NhomId,b.MaNhom,b.TenNhom,a.GhiChu,a.CtrVersion
	FROM LoaiTaiSan a Inner join NhomTaiSan b on a.NhomId=b.NhomId where a.LoaiId = @LoaiId
-----------------------------------------------------
SET NOCOUNT OFF
END

