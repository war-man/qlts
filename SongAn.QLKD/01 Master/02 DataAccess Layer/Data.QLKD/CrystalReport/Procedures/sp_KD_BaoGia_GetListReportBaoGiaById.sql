
GO
/****** Object:  StoredProcedure [dbo].[sp_KD_BaoGia_GetListReportBaoGiaById]    Script Date: 12/19/2017 9:44:51 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROC [dbo].[sp_KD_BaoGia_GetListReportBaoGiaById]
( 
	@BaoGiaId INT
)
AS  
BEGIN
SET NOCOUNT ON  
	--SELECT * FROM dbo.KDBaoGia
	--SELECT * FROM dbo.KDBaoGiaChiTiet

	DECLARE @ThanhTienVAT NUMERIC(18,4)
	SELECT @ThanhTienVAT = SUM(L.SoLuong * L.DonGia) + SUM(L.SoLuong * L.DonGia) * 10 / 100
	FROM dbo.KDBaoGiaChiTiet L WHERE L.BaoGiaId = @BaoGiaId

	SELECT H.KhachHangId, KH.TenKhachHang, H.NguoiNhan, H.DienThoai, H.TenBaoGia,
			CONCAT(KH.SoNha,', ',PX.TenPhuongXa,', ',QH.TenQuanHuyen, ', ', TT.TenTT) DiaChiKH,
			KH.Fax, KH.Email,
			CONCAT(nvkd.Ho , ' ', nvkd.Ten) TenNhanVienKD, nvkd.Ma MaNVKD,
			nvkd.DienThoai, '' SoTrang, H.NgayBaoGia, nvkd.Email,
			HH.TenHangHoa, HH.DonViTinh, HH.ThoiGianBaoHanh, HH.CauHinh, l.SoLuong, l.DonGia, l.SoLuong * l.DonGia ThanhTien,
			dbo.Num2Text(@ThanhTienVAT) DocSo
	FROM dbo.KDBaoGia H
	JOIN dbo.KDBaoGiaChiTiet l ON l.BaoGiaId = H.BaoGiaId
	LEFT JOIN dbo.KDKhachHang KH ON KH.KhachHangId = H.KhachHangId
	LEFT JOIN dbo.TinhThanhPho TT ON TT.TinhThanhPhoId = KH.TinhThanhPhoId
	LEFT JOIN dbo.QuanHuyen QH ON QH.QuanHuyenId = KH.QuanHuyenId
	LEFT JOIN dbo.PhuongXa PX ON PX.PhuongXaId = KH.PhuongXaId
	LEFT JOIN dbo.NhanVien nvkd ON nvkd.NhanVienId = H.NhanVienId
	LEFT JOIN dbo.KhoHangHoa HH ON HH.HangHoaId = l.HangHoaId
	WHERE H.BaoGiaId = @BaoGiaId
END
