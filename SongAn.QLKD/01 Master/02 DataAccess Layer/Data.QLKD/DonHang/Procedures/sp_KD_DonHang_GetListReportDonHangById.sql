USE [MSSQL_QLDN_QLNS_DEMO]
GO
/****** Object:  StoredProcedure [dbo].[sp_KD_DonHang_GetListReportDonHangById]    Script Date: 12/19/2017 9:52:09 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*

EXEC 

*/

ALTER PROC [dbo].[sp_KD_DonHang_GetListReportDonHangById]
( 
	@DonHangId INT
)
AS  
BEGIN
SET NOCOUNT ON  
------------------------------------------------  
	--SELECT * FROM dbo.KDDonHang
	--SELECT * FROM dbo.KDDonHangChiTiet
	--SELECT * FROM dbo.KhoHangHoa

	SELECT H.SoPhieu, H.TenDonHang, H.BoPhanNhan, H.NguoiNhan, H.NgayLap, H.NgayDuyet,H.DiaChiNhan,
			KH.MaKhachHang, KH.TenKhachHang, KH.MaSoThue,  CONCAT(KH.SoNha,', ',PX.TenPhuongXa,', ',QH.TenQuanHuyen, ', ', TT.TenTT) DiaChiKH,
			KHH.TenHangHoa, KHH.CauHinh ThongSoKyThuat, KHH.ThoiGianBaoHanh, KHH.DonViTinh, L.DonGia, L.SoLuong, L.DonGia * L.SoLuong ThanhTien,
			L.NgayNhanHang,
			L.NgayYeuCau,
			CASE WHEN H.TrangThai = 0 THEN N'Chưa thanh toán'	-- dag  tao
				 WHEN H.TrangThai = 1 THEN N'Đã thanh toán'		
				 WHEN H.TrangThai = 2 THEN N'Hủy'				 
				 ELSE N'!' END TenThanhToan
	FROM dbo.KDDonHang H
	JOIN dbo.KDDonHangChiTiet L ON L.DonHangId = H.DonHangId
	LEFT JOIN dbo.KDKhachHang KH ON KH.KhachHangId = H.KhachHangId
	LEFT JOIN dbo.TinhThanhPho TT ON TT.TinhThanhPhoId = KH.TinhThanhPhoId
	LEFT JOIN dbo.QuanHuyen QH ON QH.QuanHuyenId = KH.QuanHuyenId
	LEFT JOIN dbo.PhuongXa PX ON PX.PhuongXaId = KH.PhuongXaId
	LEFT JOIN dbo.KhoHangHoa KHH ON KHH.HangHoaId = L.HangHoaId
	WHERE H.DonHangId = @DonHangId
	

	--DECLARE @TableLoaiBaoDuong TABLE
	--(
	--	 _type INT,
	--	 _name NVARCHAR(100)
	--)

	--insert @TableLoaiBaoDuong
	--select 1,N'Thay thế'
	--union
	--select 2,N'Bảo dưỡng'
	--union
	--select 3,N'Sửa chữa'


-----------------------------------------------------
SET NOCOUNT OFF
END
