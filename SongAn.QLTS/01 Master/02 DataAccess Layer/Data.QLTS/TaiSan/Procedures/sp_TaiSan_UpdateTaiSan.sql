/**************************************************
1. Create Date	: 2017.08.31
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: UPDATE THÔNG TIN TÀI SẢN
4. Function		: 
5. Example		: 
					DECLARE @NguyenGiaList dbo.NguyenGiaType
					INSERT INTO @NguyenGiaList VALUES(0,1,121212121)

					DECLARE @MESSAGE	NVARCHAR(MAX)
					EXEC [sp_TaiSan_UpdateTaiSan]
						 @TaiSanId			=	34
						,@MaTaiSan			=	'test'
						,@TenTaiSan			=	N'KHÔNG BIẾT'
						,@DonViTinh			=	'CÁI'
						,@LoaiId			=	1
						,@PhuongThucId		=	1
						,@NamSanXuat		=	2015
						,@NuocSanXuatId		=	1
						,@HangSanXuatId		=	2
						,@SoQDTC			=	'QDTC'
						,@NhanHieu			=	'SAMSUNG'
						,@DuAnId			=	1
						,@NgayMua			=	'2018-08-31'
						,@NgayGhiTang		=	'2018-08-31'
						,@NgayBDHaoMon		=	'2018-08-31'
						,@SoNamSuDung		=	1
						,@TyLeHaoMon		=	1.1
						,@HaoMonLuyKe		=	1.1
						,@NgayBDKhauHao		=	'2018-08-31'
						,@KyTinhKhauHao		=	N'KỲ KH'
						,@GiaTriKhauHao		=	1
						,@SoKyKhauHao		=	1
						,@TyLeKhauHao		=	1.1
						,@KhauHaoLuyKe		=	1.1
						,@LoaiKeKhai		=	1
						,@NguoiTao			=	NULL
						,@NgayTao			=	NULL
						,@CtrVersion		=	NULL

						,@NguyenGiaList		=	@NguyenGiaList

						,@CoSoId			=	1
						,@NhanVienId		=	6
						,@MESSAGE			=	@MESSAGE OUTPUT
					SELECT	@MESSAGE MESSAGE
6. Precaution	:
7. History		:
				  2017.08.31 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
ALTER PROCEDURE [dbo].[sp_TaiSan_UpdateTaiSan]
	 @TaiSanId			INT				=	NULL
    ,@MaTaiSan			NVARCHAR(MAX)	=	NULL
    ,@TenTaiSan			NVARCHAR(MAX)	=	NULL
    ,@DonViTinh			NVARCHAR(MAX)	=	NULL
    ,@LoaiId			INT				=	NULL
    ,@PhuongThucId		INT				=	NULL
    ,@NamSanXuat		NUMERIC(4,0)	=	NULL
    ,@NuocSanXuatId		INT				=	NULL
    ,@HangSanXuatId		INT				=	NULL
    ,@SoQDTC			NVARCHAR(MAX)	=	NULL
    ,@NhanHieu			NVARCHAR(MAX)	=	NULL
    ,@DuAnId			INT				=	NULL
    ,@NgayMua			DATETIME		=	NULL
    ,@NgayGhiTang		DATETIME		=	NULL
    ,@NgayBDHaoMon		DATETIME		=	NULL
    ,@SoNamSuDung		INT				=	NULL
    ,@TyLeHaoMon		NUMERIC(5,2)	=	NULL
    ,@HaoMonLuyKe		NUMERIC(18,4)	=	NULL
    ,@NgayBDKhauHao		DATETIME		=	NULL
    ,@KyTinhKhauHao		NVARCHAR(MAX)	=	NULL
    ,@GiaTriKhauHao		NUMERIC(18,4)	=	NULL
    ,@SoKyKhauHao		NUMERIC(5,0)	=	NULL
    ,@TyLeKhauHao		NUMERIC(5,2)	=	NULL
    ,@KhauHaoLuyKe		NUMERIC(18,4)	=	NULL
    ,@LoaiKeKhai		INT				=	NULL
    ,@NguoiTao			INT				=	NULL
    ,@NgayTao			DATETIME		=	NULL
    ,@CtrVersion		INT				=	NULL

	,@NguyenGiaList		NguyenGiaType		READONLY

	,@CoSoId			INT				=	NULL
	,@NhanVienId		INT				=	NULL
	,@MESSAGE			NVARCHAR(MAX)		OUTPUT
AS
BEGIN
	SET NOCOUNT ON;

	-- BIẾN NỘI BỘ
	DECLARE	@V_CTRVERSION	INT		=	NULL
			,@V_ERROR		BIT		=	0
	-- INPUT DEFAULT
	SET	@CtrVersion	=	ISNULL(@CtrVersion, '')
	IF @CtrVersion = ''
		SET	@CtrVersion	=	-1

	-- KIỂM TRA @CtrVersion
	SET @V_CTRVERSION = (SELECT CtrVersion FROM TaiSan WHERE TaiSanId = @TaiSanId)
	IF @V_ERROR = 0 AND @V_CTRVERSION <> @CtrVersion
	BEGIN
		SET @MESSAGE = N'CTR_VERSION|1|Phiếu này đã có người thay đổi thông tin'
		SET @V_ERROR = 1
	END

	IF @V_ERROR = 1
	BEGIN
		SELECT * FROM TaiSan WHERE TaiSanId = @TaiSanId
		RETURN
	END

BEGIN TRANSACTION TAISAN_UPDATE
BEGIN TRY
	-- INSERT DỮ LIỆU
	UPDATE	TaiSan
	SET		 MaTaiSan		=	@MaTaiSan
			,TenTaiSan		=	@TenTaiSan
			,DonViTinh		=	@DonViTinh
			,LoaiId			=	@LoaiId
			,PhuongThucId	=	@PhuongThucId
			,NamSanXuat		=	@NamSanXuat
			,NuocSanXuatId	=	@NuocSanXuatId
			,HangSanXuatId	=	@HangSanXuatId
			,SoQDTC			=	@SoQDTC
			,NhanHieu		=	@NhanHieu
			,DuAnId			=	@DuAnId
			,NgayMua		=	@NgayMua
			,NgayGhiTang	=	@NgayGhiTang
			,NgayBDHaoMon	=	@NgayBDHaoMon
			,SoNamSuDung	=	@SoNamSuDung
			,TyLeHaoMon		=	@TyLeHaoMon
			,HaoMonLuyKe	=	@HaoMonLuyKe
			,NgayBDKhauHao	=	@NgayBDKhauHao
			,KyTinhKhauHao	=	@KyTinhKhauHao
			,GiaTriKhauHao	=	@GiaTriKhauHao
			,SoKyKhauHao	=	@SoKyKhauHao
			,TyLeKhauHao	=	@TyLeKhauHao
			,KhauHaoLuyKe	=	@KhauHaoLuyKe
			,LoaiKeKhai		=	@LoaiKeKhai
			,CtrVersion		=	CtrVersion + 1
	 WHERE TaiSanId = @TaiSanId

	 -- DELETE NguyenGia
	 DELETE NguyenGia WHERE TaiSanId = @TaiSanId

	-- INSERT NguyenGia
	INSERT INTO NguyenGia (	TaiSanId	,NguonNganSachId	,GiaTri )
	SELECT					@TaiSanId	,NguonNganSachId	,GiaTri
	FROM @NguyenGiaList

	COMMIT TRANSACTION TAISAN_UPDATE
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION TAISAN_UPDATE
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
	SELECT * FROM TaiSan WHERE TaiSanId = @TaiSanId

	SET NOCOUNT OFF;
END
