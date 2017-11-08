USE [QLTS]
GO

/**************************************************
1. Create Date	: 2017.09.14
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: 
4. Function		: 
5. Example		: 
					DECLARE @MESSAGE	NVARCHAR(MAX)
					EXEC [sp_ThayDoiThongTinOto_InsertThayDoiThongTinOto]
						 @CoSoId				=	NULL
						,@NhanVienId			=	NULL
						,@MESSAGE				=	@MESSAGE	OUTPUT

						-- THAY ĐỔI THÔNG TIN
						,@ThayDoiThongTinId		=	NULL
						,@TaiSanId				=	NULL
						,@Ngay					=	NULL
						,@TenTaiSanCu			=	NULL
						,@LyDo					=	NULL
						,@DuyetId				=	NULL
						,@NguoiDuyet			=	NULL
						,@NguoiTao				=	NULL
						,@NgayTao				=	NULL
						,@CtrVersion			=	NULL

						-- THÔNG TIN TÀI SẢN MỚI
						,@TenTaiSanMoi			=	NULL

						-- THÔNG TIN KÊ KHAI MỚI
						,@NhanHieu				=	NULL
						,@BienKiemSoat			=	NULL
						,@CongSuatXe			=	NULL
						,@TrongTai				=	NULL
						,@ChucDanh				=	NULL
						,@NguonGocXe			=	NULL
						,@LoaiXe				=	NULL
						,@HienTrangSuDung		=	NULL

					SELECT	@MESSAGE MESSAGE
6. Precaution	:
7. History		:
				  2017.09.14 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
ALTER PROCEDURE [dbo].[sp_ThayDoiThongTinOto_InsertThayDoiThongTinOto]
	 @CoSoId				INT				=	NULL
	,@NhanVienId			INT				=	NULL
	,@MESSAGE				NVARCHAR(MAX)		OUTPUT

	-- THAY ĐỔI THÔNG TIN
	,@ThayDoiThongTinId		INT				=	NULL
	,@TaiSanId				INT				=	NULL
	,@Ngay					DATETIME		=	NULL
	,@TenTaiSanCu			NVARCHAR(MAX)	=	NULL
	,@LyDo					NVARCHAR(MAX)	=	NULL
	,@DuyetId				INT				=	NULL
	,@NguoiDuyet			INT				=	NULL
	,@NguoiTao				INT				=	NULL
	,@NgayTao				DATETIME		=	NULL
	,@CtrVersion			INT				=	NULL

	-- THÔNG TIN TÀI SẢN MỚI
	,@TenTaiSanMoi			NVARCHAR(MAX)	=	NULL

	-- THÔNG TIN KÊ KHAI MỚI
	,@NhanHieu				NVARCHAR(MAX)	=	NULL
	,@BienKiemSoat			NVARCHAR(MAX)	=	NULL
	,@CongSuatXe			NUMERIC(4,0)	=	NULL
	,@TrongTai				NUMERIC(4,0)	=	NULL
	,@ChucDanh				NVARCHAR(MAX)	=	NULL
	,@NguonGocXe			NVARCHAR(MAX)	=	NULL
	,@LoaiXe				INT				=	NULL
	,@HienTrangSuDung		INT				=	NULL

AS
BEGIN
	SET NOCOUNT ON;
--------------------------------------------------
---------- BIẾN NỘI BỘ
	-- BIẾN NỘI BỘ
	DECLARE	@V_TRANS_NAME		NVARCHAR(500)	=	N'TDTT_OTO_INSERT'
	
	-- THAY ĐỔI THÔNG TIN OTO
	,@NhanHieuCu			NVARCHAR(MAX)	=	NULL
	,@BienKiemSoatCu		NVARCHAR(MAX)	=	NULL
	,@CongSuatXeCu			NUMERIC(4,0)	=	NULL
	,@TrongTaiCu			NUMERIC(4,0)	=	NULL
	,@ChucDanhCu			NVARCHAR(MAX)	=	NULL
	,@NguonGocXeCu			NVARCHAR(MAX)	=	NULL
	,@LoaiXeCu				INT				=	NULL
	,@HienTrangSuDungCu		INT				=	NULL

	-- INPUT DEFAULT
	SET	@CoSoId			=	ISNULL(@CoSoId, 0)
	SET	@NhanVienId		=	ISNULL(@NhanVienId, 0)
	SET	@MESSAGE		=	ISNULL(@MESSAGE, '')

	SET	@LyDo			=	ISNULL(@LyDo, '')
	SET	@TaiSanId		=	ISNULL(@TaiSanId, 0)
	SET @NguoiDuyet		=	@NhanVienId
	SET @NguoiTao		=	@NhanVienId
	SET @NgayTao		=	GETDATE()
	SET @CtrVersion		=	1

BEGIN TRY
	-- KIỂM TRA @TaiSanId
	IF @TaiSanId = 0
	BEGIN
		SET @MESSAGE = N'INPUT|1|Không tìm thấy thông tin tài sản';
		THROW 51000, @MESSAGE, 1;
	END

	-- LẤY THÔNG TIN KÊ KHAI CŨ
	SELECT		 @NhanHieuCu		=	NhanHieu
				,@BienKiemSoatCu	=	BienKiemSoat	
				,@CongSuatXeCu		=	CongSuatXe	
				,@TrongTaiCu		=	TrongTai
				,@ChucDanhCu		=	ChucDanh
				,@NguonGocXeCu		=	NguonGocXe
				,@LoaiXeCu			=	LoaiXe
				,@HienTrangSuDungCu	=	HienTrangSuDung
	FROM		ThongTinKeKhai_Oto
	WHERE		TaiSanId = @TaiSanId

	SELECT @TenTaiSanCu = TenTaiSan FROM TaiSan WHERE TaiSanId = @TaiSanId

	-- SET THÔNG TIN BỊ THAY ĐỔI
	IF @TenTaiSanCu			= @TenTaiSanMoi		SET @TenTaiSanCu		= NULL
	IF @NhanHieuCu			= @NhanHieu			SET @NhanHieuCu			= NULL
	IF @BienKiemSoatCu		= @BienKiemSoat		SET @BienKiemSoatCu		= NULL
	IF @CongSuatXeCu		= @CongSuatXe		SET @CongSuatXeCu		= NULL
	IF @TrongTaiCu			= @TrongTai			SET @TrongTaiCu			= NULL
	IF @ChucDanhCu			= @ChucDanh			SET @ChucDanhCu			= NULL
	IF @NguonGocXeCu		= @NguonGocXe		SET @NguonGocXeCu		= NULL
	IF @LoaiXeCu			= @LoaiXe			SET @LoaiXeCu			= NULL
	IF @HienTrangSuDungCu	= @HienTrangSuDung	SET @HienTrangSuDungCu	= NULL

BEGIN TRANSACTION @V_TRANS_NAME
/*
	- Lưu bảng ThayDoiThongTin
		- Tên tài sản cũ là tên tài sản hiện tại
	- Update tên tài sản mới vào bảng TaiSan
	- Lấy thông tin từ bảng ThongTinKeKhai lưu vào bảng ThayDoiThongTin
	- Lưu thông tin kê khai mới vào bảng ThongTinKeKhai
*/
	-- INSERT THAY ĐỔI THÔNG TIN
	INSERT INTO ThayDoiThongTin	(	TaiSanId	,Ngay	,TenTaiSanCu	,LyDo	,DuyetId	,NguoiDuyet		,CoSoId		,NguoiTao	,NgayTao	,CtrVersion		)
	VALUES						(	@TaiSanId	,@Ngay	,@TenTaiSanCu	,@LyDo	,@DuyetId	,@NguoiDuyet	,@CoSoId	,@NguoiTao	,@NgayTao	,@CtrVersion	)

	SET @ThayDoiThongTinId = @@IDENTITY

	-- UPDATE TÊN TÀI SẢN MỚI
	UPDATE	TaiSan
	SET		TenTaiSan	=	@TenTaiSanMoi
	WHERE	TaiSanId = @TaiSanId

	-- INSERT THAY ĐỔI THÔNG TIN
	INSERT INTO ThayDoiThongTin_Oto	(	ThayDoiThongTinId	,NhanHieuCu		,BienKiemSoatCu		,CongSuatXeCu	,TrongTaiCu		,ChucDanhCu		,NguonGocXeCu	,LoaiXeCu	,HienTrangSuDungCu	)
	VALUES							(	@ThayDoiThongTinId	,@NhanHieuCu	,@BienKiemSoatCu	,@CongSuatXeCu	,@TrongTaiCu	,@ChucDanhCu	,@NguonGocXeCu	,@LoaiXeCu	,@HienTrangSuDungCu	)

	-- UPDATE THÔNG TIN KE KHAI
	UPDATE		ThongTinKeKhai_Oto
	SET			NhanHieu		=	@NhanHieu
			   ,BienKiemSoat	=	@BienKiemSoat
			   ,CongSuatXe		=	@CongSuatXe
			   ,TrongTai		=	@TrongTai
			   ,ChucDanh		=	@ChucDanh
			   ,NguonGocXe		=	@NguonGocXe
			   ,LoaiXe			=	@LoaiXe
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
--------------------------------------------------
	SET NOCOUNT OFF;
END
