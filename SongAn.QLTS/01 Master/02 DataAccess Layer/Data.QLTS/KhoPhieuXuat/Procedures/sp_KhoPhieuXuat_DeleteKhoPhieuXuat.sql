/**************************************************
1. Create Date	: 2017.10.25
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: 
4. Function		: 
5. Example		: 
					DECLARE @MESSAGE	NVARCHAR(MAX)
					EXEC [sp_KhoPhieuXuat_DeleteKhoPhieuXuat]
						@KhoPhieuXuatId			=	21

						,@COSO_ID				=	1
						,@NHANVIEN_ID			=	6

						,@MESSAGE				=	@MESSAGE OUTPUT
					SELECT	@MESSAGE MESSAGE
6. Precaution	:
7. History		:
				  2017.10.25 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
ALTER PROCEDURE [dbo].[sp_KhoPhieuXuat_DeleteKhoPhieuXuat]
	@KhoPhieuXuatId			INT				=	NULL

	,@COSO_ID				INT				=	NULL
	,@NHANVIEN_ID			INT				=	NULL
	,@MESSAGE				NVARCHAR(MAX)		OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
--------------------------------------------------
-- BIẾN NỘI BỘ
DECLARE  @V_TRANS_NAME		NVARCHAR(MAX)	=	N'KPX_DELETE'

-- INPUT DEFAULT
SET @NHANVIEN_ID	= ISNULL(@NHANVIEN_ID,0)
SET @COSO_ID	= ISNULL(@COSO_ID,0)
SET @MESSAGE	= ISNULL(@MESSAGE,'')

BEGIN TRY
print @KhoPhieuXuatId
	IF @KhoPhieuXuatId = 0
	BEGIN
		SET @MESSAGE	=	N'PHIEUXUATID|1|Không tìm thấy thông tin';
		THROW 51000, @MESSAGE, 1;
	END
	BEGIN TRANSACTION @V_TRANS_NAME

	SELECT * FROM KhoPhieuXuat WHERE KhoPhieuXuatId = @KhoPhieuXuatId

	DELETE KhoPhieuXuatChiTiet WHERE KhoPhieuXuatId = @KhoPhieuXuatId
	DELETE KhoPhieuXuat WHERE KhoPhieuXuatId = @KhoPhieuXuatId

	COMMIT TRANSACTION @V_TRANS_NAME
END TRY
BEGIN CATCH
	IF @@TRANCOUNT > 0
		ROLLBACK TRANSACTION @V_TRANS_NAME
	
	DECLARE  @ErrorMessage	NVARCHAR(MAX)	=	ERROR_MESSAGE()
			,@ErrorSeverity INT				=	ERROR_SEVERITY()
			,@ErrorState	INT				=	ERROR_STATE()

	IF @MESSAGE = ''
		RAISERROR (@ErrorMessage,@ErrorSeverity,@ErrorState);
END CATCH
	SELECT * FROM KhoPhieuXuat WHERE KhoPhieuXuatId = @KhoPhieuXuatId
--------------------------------------------------
	SET NOCOUNT OFF;
END
