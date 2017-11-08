USE [QLTS]
GO
/**************************************************
1. Create Date	: 2017.09.09
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: 
4. Function		: 
5. Example		: 
					DECLARE @MESSAGE	NVARCHAR(MAX)
					EXEC [sp_ThongTinKeKhaiNha_InsertThongTinKeKhaiNha]
						 @TaiSanId				=	NULL
						,@ThuocDat				=	NULL
						,@DiaChi				=	NULL
						,@GiayTo				=	NULL
						,@CapHang				=	NULL
						,@SoTang				=	NULL
						,@NamSuDung				=	NULL
						,@DienTich				=	NULL
						,@TongDienTichSan		=	NULL
						,@LamTruSo				=	NULL
						,@CoSoHDSuNghiep		=	NULL
						,@NhaO					=	NULL
						,@ChoThue				=	NULL
						,@BoTrong				=	NULL
						,@BiLanChiem			=	NULL
						,@SuDungKhac			=	NULL
					
						,@CoSoId				=	NULL
						,@NhanVienId			=	NULL
						,@MESSAGE			=	@MESSAGE OUTPUT
					SELECT	@MESSAGE MESSAGE
6. Precaution	:
7. History		:
				  2017.09.09 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
ALTER PROCEDURE [dbo].[sp_ThongTinKeKhaiNha_InsertThongTinKeKhaiNha]
	 @TaiSanId				INT				=	NULL
	,@ThuocDat				INT				=	NULL
	,@DiaChi				NVARCHAR(MAX)	=	NULL
	,@GiayTo				NVARCHAR(MAX)	=	NULL
	,@CapHang				INT				=	NULL
	,@SoTang				INT				=	NULL
	,@NamSuDung				NUMERIC(4, 0)	=	NULL
	,@DienTich				NUMERIC(18,4)	=	NULL
	,@TongDienTichSan		NUMERIC(18,4)	=	NULL
	,@LamTruSo				NUMERIC(18,4)	=	NULL
	,@CoSoHDSuNghiep		NUMERIC(18,4)	=	NULL
	,@NhaO					NUMERIC(18,4)	=	NULL
	,@ChoThue				NUMERIC(18,4)	=	NULL
	,@BoTrong				NUMERIC(18,4)	=	NULL
	,@BiLanChiem			NUMERIC(18,4)	=	NULL
	,@SuDungKhac			NUMERIC(18,4)	=	NULL

	,@CoSoId				INT				=	NULL
	,@NhanVienId			INT				=	NULL
	,@MESSAGE				NVARCHAR(MAX)		OUTPUT
AS
BEGIN
	SET NOCOUNT ON;

	-- BIẾN NỘI BỘ

	-- INPUT DEFAULT
	SET	@TaiSanId			=	ISNULL(@TaiSanId, 0)
	SET	@ThuocDat			=	ISNULL(@ThuocDat, 0)
	SET	@DiaChi				=	ISNULL(@DiaChi, '')
	SET	@GiayTo				=	ISNULL(@GiayTo, '')
	SET	@CapHang			=	ISNULL(@CapHang, 0)
	SET	@SoTang				=	ISNULL(@SoTang, 0)
	SET	@NamSuDung			=	ISNULL(@SoTang, 0)
	SET	@DienTich			=	ISNULL(@DienTich, 0)
	SET	@TongDienTichSan	=	ISNULL(@DienTich, 0)
	SET	@LamTruSo			=	ISNULL(@LamTruSo, 0)
	SET	@CoSoHDSuNghiep		=	ISNULL(@CoSoHDSuNghiep, 0)
	SET	@NhaO				=	ISNULL(@NhaO, 0)
	SET	@ChoThue			=	ISNULL(@ChoThue, 0)
	SET	@BoTrong			=	ISNULL(@BoTrong, 0)
	SET	@BiLanChiem			=	ISNULL(@BiLanChiem, 0)
	SET	@SuDungKhac			=	ISNULL(@SuDungKhac, 0)

	SET	@NhanVienId			=	ISNULL(@NhanVienId, 0)
	SET	@MESSAGE			=	ISNULL(@MESSAGE, '')

BEGIN TRY
	IF @TaiSanId = 0
	BEGIN
		SET @MESSAGE = N'INPUT|1|Không tìm thấy thông tin tài sản';
		THROW 51000, @MESSAGE, 1;
	END

BEGIN TRANSACTION TTKK_NHA_INSERT
	-- INSERT DỮ LIỆU
	DELETE ThongTinKeKhai_Nha WHERE TaiSanId = @TaiSanId
	INSERT INTO ThongTinKeKhai_Nha	(	TaiSanId	,ThuocDat	,DiaChi		,GiayTo		,CapHang	,SoTang		,NamSuDung	,DienTich	,TongDienTichSan	,LamTruSo	,CoSoHDSuNghiep		,NhaO	,ChoThue	,BoTrong	,BiLanChiem		,SuDungKhac		)
	VALUES							(	@TaiSanId	,@ThuocDat	,@DiaChi	,@GiayTo	,@CapHang	,@SoTang	,@NamSuDung	,@DienTich	,@TongDienTichSan	,@LamTruSo	,@CoSoHDSuNghiep	,@NhaO	,@ChoThue	,@BoTrong	,@BiLanChiem	,@SuDungKhac	)

	COMMIT TRANSACTION TTKK_NHA_INSERT
END TRY
BEGIN CATCH
	IF @@TRANCOUNT > 0
		ROLLBACK TRANSACTION TTKK_NHA_INSERT

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
	SELECT * FROM ThongTinKeKhai_Nha WHERE TaiSanId = @TaiSanId
	SET NOCOUNT OFF;
END
