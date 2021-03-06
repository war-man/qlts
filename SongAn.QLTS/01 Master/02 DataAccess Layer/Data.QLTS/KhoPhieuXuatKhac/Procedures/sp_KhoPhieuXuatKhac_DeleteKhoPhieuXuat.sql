USE [QLTS]
GO

/**************************************************
1. Create Date	: 2017.10.25
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: 
4. Function		: 
5. Example		: 
					DECLARE @MESSAGE	NVARCHAR(MAX)
					EXEC [sp_KhoPhieuXuatKhac_DeleteKhoPhieuXuat]
						@KhoPhieuXuatId			=	21

						,@COSO_ID				=	1
						,@NHANVIEN_ID			=	6

						,@MESSAGE				=	@MESSAGE OUTPUT
					SELECT	@MESSAGE MESSAGE
6. Precaution	:
7. History		:
				  2017.10.25 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
ALTER PROCEDURE [dbo].[sp_KhoPhieuXuatKhac_DeleteKhoPhieuXuat]
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
	declare @V_KhoaSoLieu bit
		,@V_KX_KhoTonKhoId int
		,@V_KN_KhoTonKhoId int
		,@CoSoId int
		,@KhoXuatId int
		,@KhoNhanId int
		,@V_ThangNam varchar(4)

	select @CoSoId = CoSoId
		,@KhoXuatId = KhoXuatId
		,@KhoNhanId = KhoNhanId
		,@V_ThangNam = format(NgayXuat,'MMyy')
	from KhoPhieuXuat
	where KhoPhieuXuatId = @KhoPhieuXuatId

	-- kiểm tra khóa số liệu kho xuất
	set @V_KhoaSoLieu = null

	select @V_KhoaSoLieu = TrangThai
		,@V_KX_KhoTonKhoId = KhoTonKhoId
	from KhoTonKho 
	where KhoTaiSanId = @KhoXuatId
		and CoSoId = @CoSoId
		and ThangNam = @V_ThangNam

	IF @V_KhoaSoLieu = 1
	BEGIN
		SET @MESSAGE	=	N'KHOASOLIEU|1|Đã khóa số liệu kho xuất. Không thể thay đổi thông tin phiếu xuất';
		THROW 51000, @MESSAGE, 1;
	END

	-- bảng tạm lưu chi tiết
	DECLARE @V_KhoPhieuXuatChiTiet TABLE
	(
		RowId int IDENTITY(1, 1),
		KhoPhieuXuatId int NULL,
		TaiSanId int NULL,
		SoLuong numeric(18, 4) NULL,
		DonGia numeric(18, 4) NULL,
		NguonNganSachId int NULL,
		NhaCungCapId int NULL,
		KhoNhanId int NULL,
		KhoXuatId int NULL
	)
	declare	 @V_RowId int
		,@V_TaiSanId int
		,@V_DonGia numeric (18, 4)
		,@V_SoLuong numeric (18, 4)
		,@V_TonCuoi numeric (18, 4)

print @KhoPhieuXuatId
	IF @KhoPhieuXuatId = 0
	BEGIN
		SET @MESSAGE	=	N'PHIEUXUATID|1|Không tìm thấy thông tin';
		THROW 51000, @MESSAGE, 1;
	END
	BEGIN TRANSACTION @V_TRANS_NAME

	SELECT * FROM KhoPhieuXuat WHERE KhoPhieuXuatId = @KhoPhieuXuatId

	-- rollback tồn kho xuất chi tiết
	DELETE @V_KhoPhieuXuatChiTiet
	INSERT @V_KhoPhieuXuatChiTiet
			(	KhoPhieuXuatId			,TaiSanId 				,SoLuong
				,DonGia					,NguonNganSachId		,NhaCungCapId
				,KhoNhanId				,KhoXuatId
			)
	SELECT		kpxct.KhoPhieuXuatId	,kpxct.TaiSanId			,kpxct.SoLuong
				,kpxct.DonGia			,kpxct.NguonNganSachId	,kpxct.NhaCungCapId
				,kpx.KhoNhanId			,kpx.KhoXuatId
	FROM KhoPhieuXuatChiTiet kpxct
		left join KhoPhieuXuat kpx on kpxct.KhoPhieuXuatId = kpx.KhoPhieuXuatId
	where kpx.KhoPhieuXuatId = @KhoPhieuXuatId

	SELECT @V_RowId=NULL,@V_TaiSanId=NULL,@V_DonGia=NULL,@V_SoLuong=NULL,@V_TonCuoi=NULL

	while EXISTS(SELECT 1 FROM @V_KhoPhieuXuatChiTiet)
	begin
		SELECT TOP 1 @V_RowId = RowId, @V_TaiSanId = TaiSanId, @V_SoLuong=SoLuong, @V_DonGia = DonGia
		FROM @V_KhoPhieuXuatChiTiet

		SELECT TOP 1 @V_TonCuoi = TonDau + SLNhap - SLXuat FROM KhoTonKhoChiTiet WHERE KhoTonKhoId = @V_KX_KhoTonKhoId AND TaiSanId = @V_TaiSanId AND DonGia = @V_DonGia

		if @V_TonCuoi is not null and @V_TonCuoi < @V_SoLuong
		begin
			SET @MESSAGE	=	N'SOLUONGXUAT|1|Số lượng xuất lớn hơn số lượng tồn';
			THROW 51000, @MESSAGE, 1;
		end

		if @V_TonCuoi is not null
		begin
			UPDATE dbo.KhoTonKhoChiTiet 
			SET SLXuat = SLXuat - @V_SoLuong 
			WHERE KhoTonKhoId = @V_KX_KhoTonKhoId AND TaiSanId = @V_TaiSanId AND DonGia = @V_DonGia
		end

		DELETE @V_KhoPhieuXuatChiTiet WHERE RowId = @V_RowId
		SELECT @V_RowId=NULL,@V_TaiSanId=NULL,@V_DonGia=NULL,@V_SoLuong=NULL,@V_TonCuoi=NULL
	end

	-- xóa thông tin phiếu xuất khác
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
