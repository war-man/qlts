USE [MSSQL_QLDN_QLNS_DEMO]
GO
/****** Object:  StoredProcedure [dbo].[sp_KD_FileHopDong_GetById]    Script Date: 12/19/2017 9:59:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/***************************************************
1. Create Date	: 2017.11.15
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: 
4. Function		: 
5. Example		: 
					DECLARE @MESSAGE	NVARCHAR(MAX)
					EXEC sp_KD_FileHopDong_GetById
						 @FileHopDongId		=	3
	
						,@USER_ID		=	NULL
						,@NHANVIEN_ID	=	6
						,@MESSAGE		=	@MESSAGE	OUTPUT

					SELECT	@MESSAGE MESSAGE
6. Precaution	:
7. History		:
				  2017.11.15 (NGUYỄN THANH BÌNH) - Tạo mới
***************************************************/
ALTER PROCEDURE [dbo].[sp_KD_FileHopDong_GetById]
	 @FileHopDongId		INT					=	NULL
	
	,@USER_ID		INT					=	NULL
	,@NHANVIEN_ID	INT					=	NULL
	,@FUNCTIONCODE	VARCHAR(MAX)		=	NULL
	,@MESSAGE		NVARCHAR(MAX)		OUTPUT
AS
BEGIN
SET NOCOUNT ON;
BEGIN TRY
--------------------------------------------------
DECLARE @V_ROWCOUNT INT = NULL

SET @USER_ID = ISNULL(@USER_ID,0)
SET @NHANVIEN_ID = ISNULL(@NHANVIEN_ID,0)
SET @MESSAGE = ''

SET @FileHopDongId = ISNULL(@FileHopDongId,0)

SELECT DL.FileHopDongId,DL.HopDongId,DL.DaLam,DL.NguoiLam,DL.DaChuyen,DL.NguoiChuyen,CONVERT(VARCHAR(10),DL.NgayChuyen,103) as NgayChuyen,DL.NguoiNhan,CONVERT(VARCHAR(10),DL.NgayNhan,103) as NgayNhan
	,DL.FileMem,DL.FileCung,DL.GhiChu,DL.NguoiTao,DL.NgayTao,DL.CtrVersion FROM KDFileHopDong DL WHERE DL.FileHopDongId = @FileHopDongId

SET @V_ROWCOUNT = @@ROWCOUNT

IF @V_ROWCOUNT = 0
BEGIN
	SET @MESSAGE = N'FileHopDongId|1|Không tìm thấy thông tin';
	THROW 51000, @MESSAGE, 1;
END

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

SET NOCOUNT OFF;
END