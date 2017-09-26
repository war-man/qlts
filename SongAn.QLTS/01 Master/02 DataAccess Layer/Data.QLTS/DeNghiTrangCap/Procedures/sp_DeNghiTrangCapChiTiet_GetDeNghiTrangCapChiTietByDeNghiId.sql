﻿USE [QLTS]
GO
/****** Object:  StoredProcedure [dbo].[sp_DeNghiTrangCapChiTiet_GetDeNghiTrangCapChiTietByDeNghiId]    Script Date: 9/7/2017 2:51:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROC [dbo].[sp_DeNghiTrangCapChiTiet_GetDeNghiTrangCapChiTietByDeNghiId]
	@DeNghiId INT
AS  
BEGIN
SET NOCOUNT ON  
	
	SELECT CT.DeNghiChiTietId,
			CT.DeNghiId,
			ct.LoaiId,
			LTS.TenLoai,
			CT.TenTaiSan,
			CT.MoTa,
			LTS.TenLoai,
			CT.SoLuong,
			CT.DonViTinh,
			CAST(ct.PhuongThucId AS VARCHAR)PhuongThucId,
			PT.TenPhuongThuc,
			CONVERT(VARCHAR, CT.NgayDeNghi,103) NgayDeNghi,
			CT.DuToan,
			CT.DuToanDuocDuyet,
			CT.GhiChu
	FROM dbo.DeNghiTrangCapChiTiet CT
	LEFT JOIN dbo.LoaiTaiSan LTS ON LTS.LoaiId = CT.LoaiId
	LEFT JOIN dbo.PhuongThuc PT ON PT.PhuongThucId = CT.PhuongThucId
	WHERE CT.DeNghiId = @DeNghiId
	
SET NOCOUNT OFF
END