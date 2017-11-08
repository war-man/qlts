USE [QLTS]
GO
/****** Object:  StoredProcedure [dbo].[sp_ThayDoiThongTin500_InsertThayDoiThongTin500]    Script Date: 11/8/2017 8:41:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**************************************************
1. Create Date	: 2017.09.14
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: 
4. Function		: 
5. Example		: 
					DECLARE @MESSAGE	NVARCHAR(MAX)
					EXEC [sp_ThayDoiThongTin500_InsertThayDoiThongTin500]
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
						,@KyHieu				=	NULL
						,@HienTrangSuDung		=	NULL

						-- THÔNG TIN KÊ KHAI CŨ
						,@KyHieuCu				=	NULL
						,@HienTrangSuDungCu		=	NULL

					SELECT	@MESSAGE MESSAGE
6. Precaution	:
7. History		:
				  2017.09.14 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
ALTER PROCEDURE [dbo].[sp_ThayDoiThongTin500_InsertThayDoiThongTin500]
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
	,@KyHieu				NVARCHAR(MAX)	=	NULL
	,@HienTrangSuDung		INT				=	NULL

AS
BEGIN
SET NOCOUNT ON;
--------------------------------------------------
---------- BIẾN NỘI BỘ
	DECLARE	 @V_TRANS_NAME		NVARCHAR(500)	=	N'TDTT_INSERT'
			-- THAY ĐỔI THÔNG TIN KÊ KHAI
			,@KyHieuCu				NVARCHAR(MAX)	=	NULL
			,@HienTrangSuDungCu		INT				=	NULL
----------/ BIẾN NỘI BỘ

---------- INPUT DEFAULT
	SET	@CoSoId			=	ISNULL(@CoSoId, 0)
	SET	@NhanVienId		=	ISNULL(@NhanVienId, 0)
	SET	@MESSAGE		=	ISNULL(@MESSAGE, '')

	SET	@LyDo			=	ISNULL(@LyDo, '')
	SET	@TaiSanId		=	ISNULL(@TaiSanId, 0)
	SET @NguoiDuyet		=	@NhanVienId
	SET @NguoiTao		=	@NhanVienId
	SET @NgayTao		=	GETDATE()
	SET @CtrVersion		=	1
----------/ INPUT DEFAULT

BEGIN TRY
	-- KIỂM TRA @TaiSanId
	IF @TaiSanId = 0
	BEGIN
		SET @MESSAGE = N'INPUT|1|Không tìm thấy thông tin tài sản';
		THROW 51000, @MESSAGE, 1;
	END

	-- LẤY THÔNG TIN KÊ KHAI CŨ
	SELECT		 @HienTrangSuDungCu	=	TTKK_500.HienTrangSuDung
				,@KyHieuCu			=	TTKK_500.KyHieu
	FROM		ThongTinKeKhai_Tren500 TTKK_500
	WHERE		TaiSanId = @TaiSanId

	SELECT @TenTaiSanCu = TenTaiSan FROM TaiSan WHERE TaiSanId = @TaiSanId

	-- SO SÁNH THÔNG TIN KÊ KHAI CŨ VÀ MỚI
	IF @TenTaiSanCu			= @TenTaiSanMoi			SET @TenTaiSanCu		= NULL
	IF @KyHieuCu			= @KyHieu				SET @KyHieuCu			= NULL
	IF @HienTrangSuDungCu	= @HienTrangSuDung		SET @HienTrangSuDungCu	= NULL

BEGIN TRANSACTION @V_TRANS_NAME
/*
	- Lưu bảng ThayDoiThongTin
		- Tên tài sản cũ là tên tài sản hiện tại
	- Update tên tài sản mới vào bảng TaiSan
	- Lấy thông tin từ bảng ThongTinKeKhai_Dat lưu vào bảng ThayDoiThongTin_Dat
	- Lưu thông tin kê khai mới vào bảng ThongTinKeKhai_Dat
*/
	-- INSERT THAY ĐỔI THÔNG TIN
	INSERT INTO ThayDoiThongTin	(	TaiSanId	,Ngay	,TenTaiSanCu	,LyDo	,DuyetId	,NguoiDuyet		,CoSoId		,NguoiTao	,NgayTao	,CtrVersion		)
	VALUES						(	@TaiSanId	,@Ngay	,@TenTaiSanCu	,@LyDo	,@DuyetId	,@NguoiDuyet	,@CoSoId	,@NguoiTao	,@NgayTao	,@CtrVersion	)

	SET @ThayDoiThongTinId = @@IDENTITY

	-- UPDATE TÊN TÀI SẢN MỚI
	UPDATE	TaiSan
	SET		TenTaiSan	=	@TenTaiSanMoi
	WHERE	TaiSanId = @TaiSanId

	-- INSERT THAY ĐỔI THÔNG TIN ĐẤT
	INSERT INTO ThayDoiThongTin_Tren500	(	ThayDoiThongTinId	,KyHieuCu	,HienTrangSuDungCu	)
	VALUES								(	@ThayDoiThongTinId	,@KyHieuCu	,@HienTrangSuDungCu	)

	-- UPDATE THÔNG TIN KE KHAI ĐẤT
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
--------------------------------------------------
SET NOCOUNT OFF;
END
