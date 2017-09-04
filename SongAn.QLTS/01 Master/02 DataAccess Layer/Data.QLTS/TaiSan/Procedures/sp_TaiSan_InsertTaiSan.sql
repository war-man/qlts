/**************************************************
1. Create Date	: 2017.08.31
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: THÊM THÔNG TIN TÀI SẢN
4. Function		: 
5. Example		: 
					DECLARE @NguyenGiaList dbo.NguyenGiaType
					INSERT INTO @NguyenGiaList VALUES(0,1,222222)

					DECLARE @MESSAGE	NVARCHAR(MAX)
					EXEC [sp_TaiSan_InsertTaiSan]
						 @MaTaiSan			=	'TS001'
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
/*
DROP TYPE NguyenGiaType
CREATE TYPE NguyenGiaType AS TABLE
( 
	TaiSanId			INT,
	NguonNganSachId		INT,
	GiaTri				numeric(18, 4)
)
*/
ALTER PROCEDURE [dbo].[sp_TaiSan_InsertTaiSan]
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

	-- INPUT DEFAULT
	SET	@TaiSanId	=	ISNULL(@TaiSanId, 0)
	SET	@NgayTao	=	ISNULL(@NgayTao, GETDATE())
	SET	@CtrVersion	=	ISNULL(@CtrVersion, 1)
	SET	@NhanVienId	=	ISNULL(@NhanVienId, 0)
	SET @NguoiTao	=	ISNULL(@NguoiTao, @NhanVienId)

BEGIN TRANSACTION TAISAN_INSERT
BEGIN TRY
	-- INSERT DỮ LIỆU
	INSERT INTO TaiSan	(	MaTaiSan	,TenTaiSan	,DonViTinh	,LoaiId		,PhuongThucId	,NamSanXuat		,NuocSanXuatId	,HangSanXuatId	,SoQDTC		,NhanHieu	,DuAnId		,NgayMua	,NgayGhiTang	,NgayBDHaoMon	,SoNamSuDung	,TyLeHaoMon		,HaoMonLuyKe	,NgayBDKhauHao	,KyTinhKhauHao	,GiaTriKhauHao	,SoKyKhauHao	,TyLeKhauHao	,KhauHaoLuyKe	,LoaiKeKhai		,CoSoId		,NguoiTao	,NgayTao	,CtrVersion		)
	VALUES				(	@MaTaiSan	,@TenTaiSan	,@DonViTinh	,@LoaiId	,@PhuongThucId	,@NamSanXuat	,@NuocSanXuatId	,@HangSanXuatId	,@SoQDTC	,@NhanHieu	,@DuAnId	,@NgayMua	,@NgayGhiTang	,@NgayBDHaoMon	,@SoNamSuDung	,@TyLeHaoMon	,@HaoMonLuyKe	,@NgayBDKhauHao	,@KyTinhKhauHao	,@GiaTriKhauHao	,@SoKyKhauHao	,@TyLeKhauHao	,@KhauHaoLuyKe	,@LoaiKeKhai	,@CoSoId	,@NguoiTao	,@NgayTao	,@CtrVersion	)

	SET @TaiSanId	=	@@IDENTITY

	-- INSERT
	INSERT INTO NguyenGia (	TaiSanId	,NguonNganSachId	,GiaTri )
	SELECT					@TaiSanId	,NguonNganSachId	,GiaTri
	FROM @NguyenGiaList

	COMMIT TRANSACTION TAISAN_INSERT
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION TAISAN_INSERT
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
