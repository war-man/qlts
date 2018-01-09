USE [MSSQL_QLDN_QLNS_DEMO]
GO
/****** Object:  StoredProcedure [dbo].[sp_KD_KeHoach_GetKeHoachById]    Script Date: 12/19/2017 10:02:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROC [dbo].[sp_KD_KeHoach_GetKeHoachById]
( 
	  @KeHoachId NVARCHAR(500)	= null			
)
AS  
BEGIN
SET NOCOUNT ON  
------------------------------------------------  

	SELECT KH.KeHoachId,
			KH.KyKeHoach,
			CAST(KH.Nam AS INT)Nam,
			KH.SoPhieu,
			KH.KhachHangId,
			KH.NguoiTao,
			KH.NgayTao
	FROM dbo.KDKeHoach KH
	WHERE KeHoachId = @KeHoachId
-----------------------------------------------------
SET NOCOUNT OFF
END



