USE [MSSQL_QLDN_QLNS_DEMO]
GO
/****** Object:  StoredProcedure [dbo].[sp_KD_KhachHang_GetKhachHangById]    Script Date: 12/19/2017 10:03:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROC [dbo].[sp_KD_KhachHang_GetKhachHangById]
( 
	  @KhachHangId NVARCHAR(500)	= null			
)
AS  
BEGIN
SET NOCOUNT ON  
------------------------------------------------  

	SELECT KH.KhachHangId, KH.MaKhachHang, CAST(KH.NhomKhachHangId AS VARCHAR)NhomKhachHangId, KH.TenKhachHang, CAST(KH.GioiTinh AS VARCHAR)GioiTinh, KH.HinhAnh
		  , KH.SoNha, CAST(KH.TinhThanhPhoId AS VARCHAR)TinhThanhPhoId, CAST(KH.QuanHuyenId AS VARCHAR)QuanHuyenId, CAST(KH.PhuongXaId AS VARCHAR)PhuongXaId
		  , KH.DienThoai, KH.FaceBook, KH.Email, KH.NgheNghiep, KH.CoQuan, KH.MaSoThue
		  , KH.EmailCoQuan, KH.Fax, KH.DiaChiCoQuan, KH.TheoDoi, KH.Khac
		  , KH.NguoiPhuTrach, KH.CachLamViec, KH.TinhCach, KH.SoThich, KH.ThoiQuen
		  , KH.GhiChu, KH.NguoiTao, KH.NgayTao,
		   CONVERT(NVARCHAR, NgaySinh, 103) NgaySinh, 
		   CONVERT(NVARCHAR, KH.NgayThanhLap, 103) NgayThanhLap,
		   CASE WHEN GioiTinh = 1 THEN 'Nam' ELSE N'Nữ' END TenGioiTinh, 
		   NKH.TenNhom,
		   TP.TenTT TenTinh
	FROM dbo.KDKhachHang KH
	LEFT JOIN dbo.KDNhomKhachHang NKH ON NKH.NhomKhachHangId = KH.NhomKhachHangId
	LEFT JOIN dbo.TinhThanhPho TP ON TP.TinhThanhPhoId = KH.TinhThanhPhoId
	WHERE KhachHangId = @KhachHangId
-----------------------------------------------------
SET NOCOUNT OFF
END



