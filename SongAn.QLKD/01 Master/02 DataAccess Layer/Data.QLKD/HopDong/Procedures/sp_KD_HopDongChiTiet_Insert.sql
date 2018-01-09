USE [MSSQL_QLDN_QLNS_DEMO]
GO
/****** Object:  StoredProcedure [dbo].[sp_KD_HopDongChiTiet_Insert]    Script Date: 12/19/2017 10:01:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[sp_KD_HopDongChiTiet_Insert]
	 @HopDongChiTietId  INT					=	NULL
	,@HopDongId			INT					=	NULL
	,@HangHoaId			INT					=	NULL
	,@LoaiHangHoa		INT					=	NULL
	,@SoLuong			NVARCHAR(MAX)		=	NULL
	,@DonGia			NVARCHAR(MAX)		=	NULL
	,@DaTrienKhai		NVARCHAR(MAX)		=	NULL
	,@NguoiGiao			NVARCHAR(MAX)		=	NULL
	,@NguoiNhan			NVARCHAR(MAX)		=	NULL
	,@NgayThucHien		NVARCHAR(MAX)		=	NULL
	,@NgayKetThuc		NVARCHAR(MAX)		=	NULL
	,@GhiChu			NVARCHAR(MAX)		=	NULL
	
AS
BEGIN
SET NOCOUNT ON;
BEGIN TRY
--------------------------------------------------





INSERT INTO KDHopDongChiTiet
	(HopDongId			,HangHoaId		,LoaiHangHoa	,SoLuong		,DonGia	,DaTrienKhai
	,NguoiGiao		,NguoiNhan			,NgayThucHien		,NgayKetThuc		,GhiChu)
VALUES
	(@HopDongId			,@HangHoaId	,@LoaiHangHoa	,@SoLuong	,@DonGia	,@DaTrienKhai
	,@NguoiGiao		,@NguoiNhan		,@NgayThucHien	,@NgayKetThuc	,@GhiChu)

SET @HopDongId = @@IDENTITY

--------------------------------------------------
END TRY
BEGIN CATCH
	DECLARE @ErrorMessage NVARCHAR(MAX);
    DECLARE @ErrorSeverity INT;
    DECLARE @ErrorState INT;

    SELECT 
        @ErrorMessage = ERROR_MESSAGE(),
        @ErrorSeverity = ERROR_SEVERITY(),
        @ErrorState = ERROR_STATE();
END CATCH

SELECT * FROM KDHopDongChiTiet WHERE HopDongId = @HopDongId

SET NOCOUNT OFF;
END