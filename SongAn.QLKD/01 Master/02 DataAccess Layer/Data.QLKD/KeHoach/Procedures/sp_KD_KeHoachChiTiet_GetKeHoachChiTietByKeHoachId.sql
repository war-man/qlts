USE [MSSQL_QLDN_QLNS_DEMO]
GO
/****** Object:  StoredProcedure [dbo].[sp_KD_KeHoachChiTiet_GetKeHoachChiTietByKeHoachId]    Script Date: 12/19/2017 10:02:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROC [dbo].[sp_KD_KeHoachChiTiet_GetKeHoachChiTietByKeHoachId]
( 
	  @KeHoachId NVARCHAR(500)	= null			
)
AS  
BEGIN
SET NOCOUNT ON  
------------------------------------------------  

	SELECT KH.KeHoachChiTietId,
			KH.KeHoachId,
			KH.HangHoaId,
			HH.MaHangHoa,
			HH.TenHangHoa,
			HH.DonViTinh,
			CAST(KH.LoaiHangHoa AS VARCHAR)LoaiHangHoa,
			LHH.TenLoai,
			KH.SoLuong,
			KH.DonGia,
			CONVERT(VARCHAR, KH.NgayDuKien,103)NgayDuKien,
			CAST(KH.TrangThai AS VARCHAR)TrangThai,
			CASE WHEN KH.TrangThai = 0 THEN N'Mới tạo' 
				 WHEN KH.TrangThai = 1 THEN N'Đang báo giá' 
				 WHEN KH.TrangThai = 2 THEN N'Đang làm hợp đồng' 
				 WHEN KH.TrangThai = 3 THEN N'Hoàn thành' 
				 ELSE N'!' END TenTrangThai,
			CONVERT(VARCHAR, KH.NgayTao,103)NgayTao
	FROM dbo.KDKeHoachChiTiet KH
	LEFT JOIN dbo.KhoHangHoa HH ON HH.HangHoaId = KH.HangHoaId
	LEFT JOIN dbo.KDLoaiHangHoa LHH ON LHH.LoaiHangHoaId = KH.LoaiHangHoa
	WHERE KH.KeHoachId = @KeHoachId
-----------------------------------------------------
SET NOCOUNT OFF
END



