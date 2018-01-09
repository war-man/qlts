USE [MSSQL_QLDN_QLNS_DEMO]
GO
/****** Object:  StoredProcedure [dbo].[sp_KD_HopDong_GetListChiTietByCriteria]    Script Date: 12/19/2017 10:01:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[sp_KD_HopDong_GetListChiTietByCriteria]
	 @HopDongId			NVARCHAR(MAX)		=	NULL
	
AS
BEGIN
SET NOCOUNT ON;
Select hd.HopDongChiTietId,hd.HopDongId,hd.HangHoaId,lhh.TenLoai,hh.MaHangHoa,hh.TenHangHoa,hd.LoaiHangHoa,hd.SoLuong,hd.DonGia,hd.DaTrienKhai,hd.NguoiGiao,hd.NguoiNhan,
CONVERT(VARCHAR(10),hd.NgayThucHien,103) as NgayThucHien,CONVERT(VARCHAR(10),hd.NgayKetThuc,103) as NgayKetThuc,hd.GhiChu
 from KDHopDongChiTiet hd inner join KhoHangHoa hh on hd.HangHoaId=hh.HangHoaId
 left join KDLoaiHangHoa lhh on hd.LoaiHangHoa=lhh.LoaiHangHoaId
 
  where hd.HopDongId = @HopDongId

SET NOCOUNT OFF;
END