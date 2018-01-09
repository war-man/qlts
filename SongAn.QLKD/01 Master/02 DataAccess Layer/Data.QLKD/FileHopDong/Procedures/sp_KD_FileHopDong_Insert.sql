USE [MSSQL_QLDN_QLNS_DEMO]
GO
/****** Object:  StoredProcedure [dbo].[sp_KD_FileHopDong_Insert]    Script Date: 12/19/2017 9:59:46 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/***************************************************
1. Create Date	: 2017.11.14
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: 
4. Function		: 
5. Example		: 
					DECLARE @MESSAGE	NVARCHAR(MAX)
					EXEC sp_KD_FileHopDong_Insert
						 @FileHopDongId			=	NULL
						,@MaFileHopDong			=	'DB001'
						,@TenFileHopDong			=	N'Quận 12'
						,@ViTri				=	N'gò vấp'
						,@FileDinhKem		=	N'gò vấp'

						,@NguoiTao			=	NULL
						,@NgayTao			=	NULL
						,@CtrVersion		=	NULL
	
						,@USER_ID			=	NULL
						,@NHANVIEN_ID		=	6
						,@FUNCTIONCODE		=	''
						,@MESSAGE			=	@MESSAGE	OUTPUT

					SELECT	@MESSAGE MESSAGE
6. Precaution	:
7. History		:
				  2017.11.14 (NGUYỄN THANH BÌNH) - Tạo mới
***************************************************/
ALTER PROCEDURE [dbo].[sp_KD_FileHopDong_Insert]
	 @FileHopDongId		INT					=	NULL
	,@HopDongId			VARCHAR(MAX)		=	NULL
	,@DaLam				VARCHAR(MAX)		=	NULL
	,@NguoiLam			NVARCHAR(MAX)		=	NULL
	,@DaChuyen			VARCHAR(MAX)		=	NULL
	,@NguoiChuyen		NVARCHAR(MAX)		=	NULL
	,@NgayChuyen		NVARCHAR(MAX)		=	NULL
	,@NguoiNhan			NVARCHAR(MAX)		=	NULL
	,@NgayNhan			NVARCHAR(MAX)		=	NULL
	,@FileMem			NVARCHAR(MAX)		=	NULL
	,@FileCung			NVARCHAR(MAX)		=	NULL
	,@GhiChu			NVARCHAR(MAX)		=	NULL


	,@NguoiTao			INT					=	NULL
	,@NgayTao			DATETIME			=	NULL
	,@CtrVersion		INT					=	NULL
	
	,@USER_ID			INT					=	NULL
	,@NHANVIEN_ID		INT					=	NULL
	,@FUNCTIONCODE		VARCHAR(MAX)		=	NULL
	,@MESSAGE			NVARCHAR(MAX)		OUTPUT
AS
BEGIN
SET NOCOUNT ON;
BEGIN TRY
--------------------------------------------------
SET @USER_ID = ISNULL(@USER_ID,0)
SET @NHANVIEN_ID = ISNULL(@NHANVIEN_ID,0)
SET @MESSAGE = ''

SET @FileHopDongId = ISNULL(@FileHopDongId,0)
SET @NgayTao = ISNULL(@NgayTao,GETDATE())
SET @NguoiTao = ISNULL(@NguoiTao,@NHANVIEN_ID)
SET @CtrVersion = ISNULL(@CtrVersion,0)


INSERT INTO KDFileHopDong
	(HopDongId	,DaLam	,NguoiLam	,DaChuyen	,NguoiChuyen	,NgayChuyen	,NguoiNhan, NgayNhan,FileMem,FileCung,GhiChu,NguoiTao,NgayTao,CtrVersion)
VALUES 
	(@HopDongId	,@DaLam	,@NguoiLam	,@DaChuyen	,@NguoiChuyen	,@NgayChuyen	,@NguoiNhan, @NgayNhan,@FileMem,@FileCung,@GhiChu,@NguoiTao,@NgayTao,@CtrVersion)

SET @FileHopDongId = @@IDENTITY

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

	IF @MESSAGE = ''
		RAISERROR (@ErrorMessage,@ErrorSeverity,@ErrorState);
END CATCH

SELECT * FROM KDFileHopDong WHERE FileHopDongId = @FileHopDongId

SET NOCOUNT OFF;
END