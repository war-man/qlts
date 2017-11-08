USE [QLTS]
GO

/**************************************************
1. Create Date	: 2017.09.08
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: 
4. Function		: 
5. Example		: 
					DECLARE @MESSAGE	NVARCHAR(MAX)
					EXEC [sp_ThongTinKeKhaiOto_InsertThongTinKeKhaiOto]
						 @TaiSanId				=	NULL
						,@NhanHieu				=	NULL
						,@BienKiemSoat			=	NULL
						,@CongSuatXe			=	NULL
						,@TrongTai				=	NULL
						,@ChucDanh				=	NULL
						,@NguonGocXe			=	NULL
						,@LoaiXe				=	NULL
						,@HienTrangSuDung		=	NULL

						,@CoSoId				=	NULL
						,@NhanVienId			=	NULL
						,@MESSAGE					OUTPUT
					SELECT	@MESSAGE MESSAGE
6. Precaution	:
7. History		:
				  2017.09.08 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
ALTER PROCEDURE [dbo].[sp_ThongTinKeKhaiOto_InsertThongTinKeKhaiOto]
	 @TaiSanId				INT				=	NULL
	,@NhanHieu				NVARCHAR(MAX)	=	NULL
	,@BienKiemSoat			NVARCHAR(MAX)	=	NULL
	,@CongSuatXe			NUMERIC(18,4)	=	NULL
	,@TrongTai				NUMERIC(18,4)	=	NULL
	,@ChucDanh				NVARCHAR(MAX)	=	NULL
	,@NguonGocXe			NVARCHAR(MAX)	=	NULL
	,@LoaiXe				INT				=	NULL
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
	SET @NhanHieu			=	ISNULL(@NhanHieu, '')
	SET @BienKiemSoat		=	ISNULL(@BienKiemSoat, '')
	SET @CongSuatXe			=	ISNULL(@CongSuatXe, 0)
	SET @TrongTai			=	ISNULL(@TrongTai, 0)
	SET @ChucDanh			=	ISNULL(@ChucDanh, '')
	SET @NguonGocXe			=	ISNULL(@NguonGocXe, '')
	SET @LoaiXe				=	ISNULL(@LoaiXe, 0)
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

BEGIN TRANSACTION TTKK_OTO_INSERT
	-- INSERT DỮ LIỆU
	DELETE ThongTinKeKhai_Oto WHERE TaiSanId = @TaiSanId
	INSERT INTO ThongTinKeKhai_Oto	(	TaiSanId	,NhanHieu	,BienKiemSoat	,CongSuatXe		,TrongTai	,ChucDanh	,NguonGocXe		,LoaiXe		,HienTrangSuDung	)
	VALUES							(	@TaiSanId	,@NhanHieu	,@BienKiemSoat	,@CongSuatXe	,@TrongTai	,@ChucDanh	,@NguonGocXe	,@LoaiXe	,@HienTrangSuDung	)

	COMMIT TRANSACTION TTKK_OTO_INSERT
END TRY
BEGIN CATCH
	IF @@TRANCOUNT > 0
		ROLLBACK TRANSACTION TTKK_OTO_INSERT

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
	SELECT * FROM ThongTinKeKhai_Oto WHERE TaiSanId = @TaiSanId
	SET NOCOUNT OFF;
END
