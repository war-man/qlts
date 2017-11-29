﻿/***************************************************
1. Create Date	: 2017.11.16
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: 
4. Function		: 
5. Example		: 
					DECLARE @MESSAGE	NVARCHAR(MAX)
					EXEC [sp_KD_HopDong_Delete]
						 @HopDongIds	=	2
						,@CtrVersion	=	0
	
						,@USER_ID		=	NULL
						,@NHANVIEN_ID	=	70
						,@FUNCTIONCODE		=	''
						,@MESSAGE		=	@MESSAGE	OUTPUT

					SELECT	@MESSAGE MESSAGE
6. Precaution	:
7. History		:
				  2017.11.16 (NGUYỄN THANH BÌNH) - Tạo mới
***************************************************/
ALTER PROCEDURE [dbo].[sp_KD_HopDong_Delete]
	 @HopDongIds		VARCHAR(MAX)		=	NULL
	,@CtrVersion	INT					=	NULL
	
	,@USER_ID		INT					=	NULL
	,@NHANVIEN_ID	INT					=	NULL
	,@FUNCTIONCODE	VARCHAR(MAX)		=	NULL
	,@MESSAGE		NVARCHAR(MAX)		OUTPUT
AS
BEGIN
SET NOCOUNT ON;
BEGIN TRY
--------------------------------------------------
DECLARE @V_DIABANID INT = NULL
	,@V_CTRVERSION INT = NULL

SET @USER_ID = ISNULL(@USER_ID,0)
SET @NHANVIEN_ID = ISNULL(@NHANVIEN_ID,0)
SET @MESSAGE = ''

SET @HopDongIds = ISNULL(@HopDongIds,'')
SET @CtrVersion = ISNULL(@CtrVersion,-1)

--SELECT @V_DIABANID = HopDongId
--	,@V_CTRVERSION = CtrVersion
--FROM KDHopDong WHERE HopDongId = @HopDongId

--if @V_DIABANID IS NULL
--BEGIN
--	SET @MESSAGE = N'HopDongId|1|Không tìm thấy thông tin';
--	THROW 51000, @MESSAGE, 1;
--END

--if @V_CTRVERSION <> @CtrVersion
--BEGIN
--	SET @MESSAGE = N'CtrVersion|1|Có người dùng khác thay đổi thông tin';
--	THROW 51000, @MESSAGE, 1;
--END

SELECT * FROM KDHopDong WHERE CHARINDEX('|' + CAST(HopDongId AS VARCHAR(10)) + '|', '|' + @HopDongIds + '|') > 0

DELETE KDHopDong
WHERE CHARINDEX('|' + CAST(HopDongId AS VARCHAR(10)) + '|', '|' + @HopDongIds + '|') > 0

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