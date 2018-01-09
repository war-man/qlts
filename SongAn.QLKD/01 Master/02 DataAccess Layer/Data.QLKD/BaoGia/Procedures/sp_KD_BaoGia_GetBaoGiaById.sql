
GO
/****** Object:  StoredProcedure [dbo].[sp_KD_BaoGia_GetBaoGiaById]    Script Date: 12/19/2017 9:44:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROC [dbo].[sp_KD_BaoGia_GetBaoGiaById]
( 
	  @BaoGiaId NVARCHAR(500)	= null			
)
AS  
BEGIN
SET NOCOUNT ON  
------------------------------------------------  

	SELECT [BaoGiaId]
		  ,[SoPhieu]
		  ,[TenBaoGia]
		  ,CONVERT(VARCHAR, KH.NgayBaoGia,103)NgayBaoGia
		  ,CAST([KhachHangId] AS VARCHAR) [KhachHangId]
		  ,[LyDo]
		  ,CAST([NhanVienId] AS VARCHAR) [NhanVienId]
		  ,[NguoiNhan]
		  ,KH.DienThoai
		  ,CAST(KH.DaNhan AS VARCHAR)DaNhan
		  ,CAST([TrangThai] AS VARCHAR)TrangThai
		  ,KH.GhiChu
		  ,[NguoiTao]
		  ,[NgayTao]
		  ,[CtrVersion]
	FROM dbo.KDBaoGia KH
	WHERE BaoGiaId = @BaoGiaId
-----------------------------------------------------
SET NOCOUNT OFF
END

SELECT * FROM dbo.KDBaoGia

