USE [QLTS]
GO

/**************************************************
1. Create Date	: 2017.09.15
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: 
4. Function		: 
5. Example		: 
					DECLARE @MESSAGE	NVARCHAR(MAX)
					EXEC [sp_ThayDoiThongTin500_UpdateThayDoiThongTin500]
						 @CoSoId				=	1
						,@NhanVienId			=	7
						,@MESSAGE				=	@MESSAGE	OUTPUT

						-- THAY ĐỔI THÔNG TIN
						,@ThayDoiThongTinId		=	75
						,@TaiSanId				=	1065
						,@Ngay					=	'2017-09-22'
						,@TenTaiSanCu			=	N'Bơm tiêm điện Terumo'
						,@LyDo					=	N'test'
						,@CtrVersion			=	1

						-- THÔNG TIN TÀI SẢN MỚI
						,@TenTaiSanMoi			=	N'Bơm tiêm điện Terumo'

						-- THÔNG TIN KÊ KHAI MỚI
						,@KyHieu				=	N'Skin LOL'
						,@HienTrangSuDung		=	4

					SELECT	@MESSAGE MESSAGE
6. Precaution	:
7. History		:
				  2017.09.15 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
ALTER PROCEDURE [dbo].[sp_ThayDoiThongTin500_UpdateThayDoiThongTin500]
	 @CoSoId				INT				=	NULL
	,@NhanVienId			INT				=	NULL
	,@MESSAGE				NVARCHAR(MAX)		OUTPUT

	-- THAY ĐỔI THÔNG TIN
	,@ThayDoiThongTinId		INT				=	NULL
	,@TaiSanId				int				=	NULL
	,@Ngay					datetime		=	NULL
	,@TenTaiSanCu			nvarchar(MAX)	=	NULL
	,@LyDo					nvarchar(MAX)	=	NULL
	,@DuyetId				int				=	NULL
	,@NguoiDuyet			int				=	NULL
	,@NguoiTao				int				=	NULL
	,@NgayTao				datetime		=	NULL
	,@CtrVersion			int				=	NULL

	-- THÔNG TIN TÀI SẢN MỚI
	,@TenTaiSanMoi			NVARCHAR(MAX)	=	NULL

	-- THÔNG TIN KÊ KHAI MỚI
	,@KyHieu				NVARCHAR(MAX)	=	NULL
	,@HienTrangSuDung		INT				=	NULL
AS
BEGIN
	SET NOCOUNT ON;
--------------------------------------------------
---------- BIẾN NỘI BỘ
	DECLARE	@V_TRANS_NAME		NVARCHAR(MAX)	=	N'TDTT_500_UPDATE'
			-- THAY ĐỔI THÔNG TIN KÊ KHAI
			,@KyHieuCu				NVARCHAR(MAX)	=	NULL
			,@HienTrangSuDungCu		INT				=	NULL
----------/ BIẾN NỘI BỘ

	-- INPUT DEFAULT
	SET	@CoSoId			=	ISNULL(@CoSoId, 0)
	SET	@NhanVienId		=	ISNULL(@NhanVienId, 0)
	SET	@MESSAGE		=	ISNULL(@MESSAGE, '')

	SET	@LyDo			=	ISNULL(@LyDo, '')
	SET	@TaiSanId		=	ISNULL(@TaiSanId, 0)

BEGIN TRY
	-- KIỂM TRA @TaiSanId
	IF @TaiSanId = 0
	BEGIN
		SET @MESSAGE = N'INPUT|1|Không tìm thấy thông tin tài sản';
		THROW 51000, @MESSAGE, 1;
	END

	-- LẤY THÔNG TIN KÊ KHAI CŨ
	SELECT		 @TenTaiSanCu		=	ISNULL(TenTaiSanCu, TS.TenTaiSan)
				,@HienTrangSuDungCu	=	ISNULL(TDTT_500.HienTrangSuDungCu, TTKK_500.HienTrangSuDung)
				,@KyHieuCu			=	ISNULL(TDTT_500.KyHieuCu, TTKK_500.KyHieu)
	FROM		ThayDoiThongTin TDTT
				LEFT JOIN ThayDoiThongTin_Tren500 TDTT_500 ON TDTT.ThayDoiThongTinId = TDTT_500.ThayDoiThongTinId
				LEFT JOIN TaiSan TS ON TDTT.TaiSanId = TS.TaiSanId
				LEFT JOIN ThongTinKeKhai_Tren500 TTKK_500 ON TDTT.TaiSanId = TTKK_500.TaiSanId
	WHERE		TDTT.ThayDoiThongTinId = @ThayDoiThongTinId
				
	-- SO SÁNH THÔNG TIN KÊ KHAI CŨ VÀ MỚI
	IF @TenTaiSanCu			= @TenTaiSanMoi			SET @TenTaiSanCu		= NULL
	IF @KyHieuCu			= @KyHieu				SET @KyHieuCu			= NULL
	IF @HienTrangSuDungCu	= @HienTrangSuDung		SET @HienTrangSuDungCu	= NULL

BEGIN TRANSACTION @V_TRANS_NAME
	-- UPDATE THAY ĐỔI THÔNG TIN
	UPDATE	 ThayDoiThongTin
	SET		 Ngay			=	@Ngay
			,TenTaiSanCu	=	@TenTaiSanCu
			,LyDo			=	@LyDo
			,CtrVersion		=	CtrVersion + 1
	WHERE ThayDoiThongTinId = @ThayDoiThongTinId

	UPDATE	 ThayDoiThongTin_Tren500
	SET		 HienTrangSuDungCu	=	@HienTrangSuDungCu
			,KyHieuCu			=	@KyHieuCu
	WHERE ThayDoiThongTinId = @ThayDoiThongTinId

	-- UPDATE TÊN TÀI SẢN MỚI
	UPDATE	TaiSan
	SET		TenTaiSan	=	@TenTaiSanMoi
	WHERE	TaiSanId = @TaiSanId

	-- UPDATE THÔNG TIN KÊ KHAI MỚI
	UPDATE		ThongTinKeKhai_Tren500
	SET			 KyHieu				=	@KyHieu
				,HienTrangSuDung	=	@HienTrangSuDung
	WHERE		TaiSanId = @TaiSanId

	COMMIT TRANSACTION @V_TRANS_NAME
END TRY
BEGIN CATCH
	IF @@TRANCOUNT > 0
		ROLLBACK TRANSACTION @V_TRANS_NAME

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
	SELECT * FROM ThayDoiThongTin WHERE ThayDoiThongTinId = @ThayDoiThongTinId
	SET NOCOUNT OFF;
END
