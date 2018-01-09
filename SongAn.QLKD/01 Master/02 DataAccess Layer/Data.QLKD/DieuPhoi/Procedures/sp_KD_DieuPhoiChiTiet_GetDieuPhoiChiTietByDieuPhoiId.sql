
GO
/****** Object:  StoredProcedure [dbo].[sp_KD_DieuPhoiChiTiet_GetDieuPhoiChiTietByDieuPhoiId]    Script Date: 12/19/2017 9:50:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROC [dbo].[sp_KD_DieuPhoiChiTiet_GetDieuPhoiChiTietByDieuPhoiId]
( 
	  @DieuPhoiId NVARCHAR(500)	= NULL,
	  @DonHangId NVARCHAR(500)	= null			      
)
AS  
BEGIN
SET NOCOUNT ON  
------------------------------------------------  

	IF EXISTS (SELECT 1 FROM dbo.KDDieuPhoi H JOIN dbo.KDDieuPhoiChiTiet L ON  L.DieuPhoiId = H.DieuPhoiId WHERE H.DieuPhoiId = @DieuPhoiId)
	BEGIN
		SELECT H.DieuPhoiId 
				,CAST(L.[HangHoaId] AS VARCHAR)[HangHoaId]
				,HH.MaHangHoa
				,HH.TenHangHoa
				,HH.DonViTinh
				,DHCT.[SoLuong]
				,DHCT.[DonGia]
				,DHCT.[SoLuong] * DHCT.[DonGia] ThanhTien
				,CAST(DH.NhanVienId AS VARCHAR)NhanVienId, CONCAT(nvkd.Ho,' ', nvkd.Ten) TenNhanVienKD
				,CAST(DH.KhachHangId AS VARCHAR)KhachHangId, kh.TenKhachHang
				,CAST(L.DaChuyen AS VARCHAR)DaChuyen
				,CASE WHEN L.DaChuyen = 0 THEN '' ELSE 'X' END TenDaChuyen
				,L.NguoiChuyen
				,L.DiaChiGui
				,L.DiaChiNhan
				,L.NguoiNhan
				,CONVERT(VARCHAR, L.NgayNhan, 103)NgayNhan
				,CAST(L.TrangThai AS VARCHAR)TrangThai
				,CASE WHEN L.TrangThai = 0 THEN '' ELSE 'X' END TenTrangThai
		FROM dbo.KDDieuPhoi H
		JOIN dbo.KDDieuPhoiChiTiet L ON L.DieuPhoiId = H.DieuPhoiId
		LEFT JOIN dbo.KDDonHang DH ON DH.DonHangId = H.DonHangId
		LEFT JOIN dbo.KDDonHangChiTiet DHCT ON DHCT.DonHangId = DH.DonHangId AND DHCT.HangHoaId = L.HangHoaId
		LEFT JOIN dbo.KhoHangHoa HH ON HH.HangHoaId = DHCT.HangHoaId
		LEFT JOIN dbo.NhanVien nvkd ON nvkd.NhanVienId = L.NhanVienId
		LEFT JOIN dbo.KDKhachHang kh ON kh.KhachHangId = L.KhachHangId
		WHERE H.DieuPhoiId = @DieuPhoiId
	END
	ELSE
    BEGIN
		SELECT 0 DieuPhoiId 
				,CAST(DHCT.[HangHoaId] AS VARCHAR)[HangHoaId]
				,HH.MaHangHoa
				,HH.TenHangHoa
				,HH.DonViTinh
				,DHCT.[SoLuong]
				,DHCT.[DonGia]
				,DHCT.[SoLuong] * DHCT.[DonGia] ThanhTien
				,CAST(DH.NhanVienId AS VARCHAR)NhanVienId, CONCAT(nvkd.Ho,' ', nvkd.Ten) TenNhanVienKD
				,CAST(DH.KhachHangId AS VARCHAR)KhachHangId, kh.TenKhachHang
				,'0' DaChuyen
				,'' TenDaChuyen
				,'' NguoiChuyen
				,'' DiaChiGui
				,'' DiaChiNhan
				,'' NguoiNhan
				,NULL--CONVERT(VARCHAR, GETDATE(), 103)NgayNhan
				,'0' TrangThai
				,'' TenTrangThai
		FROM dbo.KDDonHang DH
		LEFT JOIN dbo.KDDonHangChiTiet DHCT ON DHCT.DonHangId = DH.DonHangId
		LEFT JOIN dbo.KhoHangHoa HH ON HH.HangHoaId = DHCT.HangHoaId
		LEFT JOIN dbo.NhanVien nvkd ON nvkd.NhanVienId = DH.NhanVienId
		LEFT JOIN dbo.KDKhachHang kh ON kh.KhachHangId = DH.KhachHangId
		WHERE DH.DonHangId = @DonHangId
	END

-----------------------------------------------------
SET NOCOUNT OFF
END



