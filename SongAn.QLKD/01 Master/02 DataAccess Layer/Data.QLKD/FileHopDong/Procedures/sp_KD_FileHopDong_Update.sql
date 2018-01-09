USE [MSSQL_QLDN_QLNS_DEMO]
GO
/****** Object:  StoredProcedure [dbo].[sp_KD_FileHopDong_Update]    Script Date: 12/19/2017 9:59:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/***************************************************
1. Create Date	: 2017.11.13
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: 
4. Function		: 
5. Example		: 
					DECLARE @MESSAGE	NVARCHAR(MAX)
					EXEC sp_KD_FileHopDong_Update
						 @FileHopDongId			=	'1'
						,@MaFileHopDong			=	'DB001'
						,@TenFileHopDong			=	N'Quận 12'
						,@ViTri				=	N'gò vấp'
						,@FileDinhKem		=	'122345'
						,@NguoiTao			=	NULL
						,@NgayTao			=	NULL
						,@CtrVersion		=	0
	
						,@USER_ID			=	NULL
						,@NHANVIEN_ID		=	6
						,@MESSAGE			=	@MESSAGE	OUTPUT

					SELECT	@MESSAGE MESSAGE
6. Precaution	:
7. History		:
				  2017.11.13 (NGUYỄN THANH BÌNH) - Tạo mới
***************************************************/
ALTER PROCEDURE [dbo].[sp_KD_FileHopDong_Update]
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
DECLARE @V_FileHopDongID INT = NULL
	,@V_CTRVERSION INT = NULL

SET @USER_ID = ISNULL(@USER_ID,0)
SET @NHANVIEN_ID = ISNULL(@NHANVIEN_ID,0)
SET @MESSAGE = ''

SET @FileHopDongId = ISNULL(@FileHopDongId,0)
SET @CtrVersion = ISNULL(@CtrVersion,-1)

SELECT @V_FileHopDongID = FileHopDongId
	,@V_CTRVERSION = CtrVersion
FROM KDFileHopDong WHERE FileHopDongId = @FileHopDongId

if @V_FileHopDongID IS NULL
BEGIN
	SET @MESSAGE = N'FileHopDongId|1|Không tìm thấy thông tin';
	THROW 51000, @MESSAGE, 1;
END

if @V_CTRVERSION <> @CtrVersion
BEGIN
	SET @MESSAGE = N'CtrVersion|1|Có người dùng khác thay đổi thông tin';
	THROW 51000, @MESSAGE, 1;
END

UPDATE KDFileHopDong
SET  HopDongId = @HopDongId
	,DaLam = @DaLam
	,NguoiLam = @NguoiLam
	,DaChuyen = @DaChuyen
	,NguoiChuyen = @NguoiChuyen
	,NgayChuyen = @NgayChuyen
	,NguoiNhan = @NguoiNhan
	,NgayNhan = @NgayNhan
	,FileMem = @FileMem
	,FileCung = @FileCung
	,GhiChu = @GhiChu
	,CtrVersion = CtrVersion + 1
WHERE FileHopDongId = @FileHopDongId
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