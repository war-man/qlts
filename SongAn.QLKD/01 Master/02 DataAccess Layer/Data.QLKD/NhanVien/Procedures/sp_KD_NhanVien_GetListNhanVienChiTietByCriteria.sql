USE [MSSQL_QLDN_QLNS_DEMO]
GO
/****** Object:  StoredProcedure [dbo].[sp_KD_NhanVien_GetListNhanVienChiTietByCriteria]    Script Date: 12/19/2017 10:05:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROC [dbo].[sp_KD_NhanVien_GetListNhanVienChiTietByCriteria]
( 
	 @NhanVienId				nvarchar(500)	= null			
)
AS  
BEGIN
SET NOCOUNT ON  
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
------------------------------------------------  

Select b.TenNhomKinhDoanh,a.CachLamViec,a.TinhCach,a.SoThich,a.ThoiQuen,a.GhiChu from KDNhanVienChiTiet a left join KDNhomKinhDoanh b on a.NhomKinhDoanhId=b.NhomKinhDoanhId where a.NhanVienId=@NhanVienId

-----------------------------------------------------
SET NOCOUNT OFF
END



