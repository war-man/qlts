USE [MSSQL_QLDN_QLNS_DEMO]
GO
/****** Object:  StoredProcedure [dbo].[sp_KD_DonHang_GetDonHangById]    Script Date: 12/19/2017 9:51:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROC [dbo].[sp_KD_DonHang_GetDonHangById]
( 
	  @DonHangId NVARCHAR(500)	= null			
)
AS  
BEGIN
SET NOCOUNT ON  
------------------------------------------------  

	SELECT [DonHangId]
		  ,[SoPhieu]
		  ,[TenDonHang]
		  ,CONVERT(VARCHAR, [NgayLap],103)NgayLap
		  ,CAST([KhachHangId] AS VARCHAR) [KhachHangId]
		  ,[LyDo]
		  ,CAST([HopDongId] AS VARCHAR) [HopDongId]
		  ,CAST([NhanVienId] AS VARCHAR) [NhanVienId]
		  ,DiaChiNhan
		  ,[BoPhanNhan]
		  ,[NguoiNhan]
		  ,[GhiChu]
		  ,CAST([TrangThai] AS VARCHAR)TrangThai
		  ,CASE WHEN [NgayDuyet] IS NULL THEN NULL ELSE CONVERT(VARCHAR, KH.NgayDuyet, 103) END NgayDuyet
		  ,[NguoiTao]
		  ,[NgayTao]
		  ,[CtrVersion]
	FROM dbo.KDDonHang KH
	WHERE DonHangId = @DonHangId
-----------------------------------------------------
SET NOCOUNT OFF
END



