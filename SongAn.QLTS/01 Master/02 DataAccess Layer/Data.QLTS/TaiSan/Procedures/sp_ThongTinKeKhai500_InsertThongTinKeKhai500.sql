USE [QLTS]
GO
/****** Object:  StoredProcedure [dbo].[sp_ThongTinKeKhai500_InsertThongTinKeKhai500]    Script Date: 11/8/2017 8:55:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**************************************************
1. Create Date	: 2017.09.09
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: 
4. Function		: 
5. Example		: 
					DECLARE @MESSAGE	NVARCHAR(MAX)
					EXEC [sp_ThongTinKeKhai500_InsertThongTinKeKhai500]
						 @TaiSanId				=	NULL
						,@KyHieu				=	NULL
						,@HienTrangSuDung		=	NULL

						,@CoSoId				=	NULL
						,@NhanVienId			=	NULL
						,@MESSAGE					OUTPUT
					SELECT	@MESSAGE MESSAGE
6. Precaution	:
7. History		:
				  2017.09.09 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
ALTER PROCEDURE [dbo].[sp_ThongTinKeKhai500_InsertThongTinKeKhai500]
	 @TaiSanId				INT				=	NULL
	,@KyHieu				NVARCHAR(MAX)	=	NULL
	,@HienTrangSuDung		INT				=	NULL

	,@CoSoId				INT				=	NULL
	,@NhanVienId			INT				=	NULL
	,@MESSAGE				NVARCHAR(MAX)		OUTPUT
AS
BEGIN
	SET NOCOUNT ON;

	-- BIẾN NỘI BỘ

	-- INPUT DEFAULT
	SET @TaiSanId			=	ISNULL(@TaiSanId, 0)
	SET @KyHieu				=	ISNULL(@KyHieu, '')
	SET @HienTrangSuDung	=	ISNULL(@HienTrangSuDung, 0)

	SET @CoSoId				=	ISNULL(@CoSoId, 0)
	SET @NhanVienId			=	ISNULL(@NhanVienId, 0)
	SET @MESSAGE			=	ISNULL(@MESSAGE, '')

BEGIN TRY
	IF @TaiSanId = 0
	BEGIN
		SET @MESSAGE = N'INPUT|1|Không tìm thấy thông tin tài sản';
		THROW 51000, @MESSAGE, 1;
	END

BEGIN TRANSACTION TTKK_500_INSERT
	-- INSERT DỮ LIỆU
	DELETE ThongTinKeKhai_Tren500 WHERE TaiSanId = @TaiSanId
	INSERT INTO ThongTinKeKhai_Tren500	(	TaiSanId	,KyHieu		,HienTrangSuDung	)
	VALUES								(	@TaiSanId	,@KyHieu	,@HienTrangSuDung	)

	COMMIT TRANSACTION TTKK_500_INSERT
END TRY
BEGIN CATCH
	IF @@TRANCOUNT > 0
		ROLLBACK TRANSACTION TTKK_500_INSERT

	DECLARE @ErrorMessage NVARCHAR(MAX);
    DECLARE @ErrorSeverity INT;
    DECLARE @ErrorState INT;

    SELECT 
        @ErrorMessage = ERROR_MESSAGE(),
        @ErrorSeverity = ERROR_SEVERITY(),
        @ErrorState = ERROR_STATE();

    RAISERROR (@ErrorMessage, -- Message text.
               @ErrorSeverity, -- Severity.
               @ErrorState -- State.
               );
END CATCH
	SELECT * FROM ThongTinKeKhai_Tren500 WHERE TaiSanId = @TaiSanId
	SET NOCOUNT OFF;
END
