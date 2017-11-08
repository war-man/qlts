USE [QLTS]
GO

/**************************************************
1. Create Date	: 2017.09.07
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: 
4. Function		: 
5. Example		: 
					DECLARE @MESSAGE	NVARCHAR(MAX)
					EXEC [sp_ThongTinCongKhai_InsertThongTinCongKhai]
						 @TaiSanId				=	NULL
						,@MoTa					=	NULL
						,@MucDich				=	NULL
						,@HienTrangSuDungId		=	NULL
						,@DonGia				=	NULL
						,@NopNganSach			=	NULL
						,@DeLaiDonVi			=	NULL
						,@HHCK					=	NULL
						,@NhaCungCapId			=	NULL

						,@CoSoId				=	NULL
						,@NhanVienId			=	NULL
						,@MESSAGE			=	@MESSAGE OUTPUT
					SELECT	@MESSAGE MESSAGE
6. Precaution	:
7. History		:
				  2017.09.07 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
ALTER PROCEDURE [dbo].[sp_ThongTinCongKhai_InsertThongTinCongKhai]
	 @TaiSanId				INT				=	NULL
	,@MoTa					NVARCHAR(MAX)	=	NULL
	,@MucDich				NVARCHAR(MAX)	=	NULL
	,@HienTrangSuDungId		INT				=	NULL
	,@DonGia				NUMERIC(18,4)	=	NULL
	,@NopNganSach			NUMERIC(18,4)	=	NULL
	,@DeLaiDonVi			NUMERIC(18,4)	=	NULL
	,@HHCK					NUMERIC(18,4)	=	NULL
	,@NhaCungCapId			INT				=	NULL

	,@CoSoId				INT				=	NULL
	,@NhanVienId			INT				=	NULL
	,@MESSAGE				NVARCHAR(MAX)		OUTPUT
AS
BEGIN
	SET NOCOUNT ON;

	-- BIẾN NỘI BỘ

	-- INPUT DEFAULT
	SET	@TaiSanId		=	ISNULL(@TaiSanId, 0)
	SET	@MoTa			=	ISNULL(@MoTa, '')
	SET	@MucDich		=	ISNULL(@MucDich, '')
	SET	@DonGia			=	ISNULL(@DonGia, 0)
	SET	@NopNganSach	=	ISNULL(@NopNganSach, 0)
	SET	@DeLaiDonVi		=	ISNULL(@DeLaiDonVi, 0)
	SET	@HHCK			=	ISNULL(@HHCK, 0)

	SET	@NhanVienId		=	ISNULL(@NhanVienId, 0)
	SET	@MESSAGE		=	ISNULL(@MESSAGE, '')

BEGIN TRY
	IF @TaiSanId = 0
	BEGIN
		SET @MESSAGE = N'INPUT|1|Không tìm thấy thông tin tài sản';
		THROW 51000, @MESSAGE, 1;
	END

BEGIN TRANSACTION TTCK_INSERT
	-- INSERT DỮ LIỆU
	DELETE ThongTinCongKhai WHERE TaiSanId = @TaiSanId
	INSERT INTO ThongTinCongKhai	(	TaiSanId	,MoTa	,MucDich	,HienTrangSuDungId	,DonGia		,NopNganSach	,DeLaiDonVi		,HHCK	,NhaCungCapId	)
	VALUES							(	@TaiSanId	,@MoTa	,@MucDich	,@HienTrangSuDungId	,@DonGia	,@NopNganSach	,@DeLaiDonVi	,@HHCK	,@NhaCungCapId	)

	COMMIT TRANSACTION TTCK_INSERT
END TRY
BEGIN CATCH
	IF @@TRANCOUNT > 0
		ROLLBACK TRANSACTION TTCK_INSERT

	DECLARE @ErrorMessage NVARCHAR(MAX);
    DECLARE @ErrorSeverity INT;
    DECLARE @ErrorState INT;

    SELECT 
        @ErrorMessage = ERROR_MESSAGE(),
        @ErrorSeverity = ERROR_SEVERITY(),
        @ErrorState = ERROR_STATE();

	IF @MESSAGE = ''
	BEGIN
		RAISERROR	(@ErrorMessage, -- Message text.
					 @ErrorSeverity, -- Severity.
					 @ErrorState -- State.
					);
	END
END CATCH
	SELECT * FROM ThongTinCongKhai WHERE TaiSanId = @TaiSanId
	SET NOCOUNT OFF;
END
