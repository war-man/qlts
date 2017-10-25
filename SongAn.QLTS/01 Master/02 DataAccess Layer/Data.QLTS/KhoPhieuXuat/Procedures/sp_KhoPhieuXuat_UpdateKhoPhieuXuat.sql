/**************************************************
1. Create Date	: 2017.10.25
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: 
4. Function		: 
5. Example		: 
					DECLARE @ChiTiet KhoPhieuXuatChiTietTableType
					INSERT INTO @ChiTiet	 (KhoPhieuXuatChiTietId	,KhoPhieuXuatId	,TaiSanId	,SoLuong	,DonGia	,GiaMua	,GiaBan	,NguonNganSachId	,NhaCungCapId	,HangDung	,LoSanXuat	)
								VALUES		 (0						,0				,1061		,1			,20000	,10		,20		,1					,1				,N'1'		,N'1'		)

					DECLARE @MESSAGE	NVARCHAR(MAX)
					EXEC [sp_KhoPhieuXuat_UpdateKhoPhieuXuat]
						@KhoPhieuXuatId			=	NULL
						,@SoPhieu				=	N'121212'
						,@NgayXuat				=	'2017-10-24 00:00:00'
						,@Loai					=	N'CK'
						,@KhoXuatId				=	1
						,@KhoNhanId				=	4
						,@NguoiNhanHang			=	N'21212'
						,@LyDo					=	NULL
						,@CoSoId				=	0
						,@NguoiTao				=	0
						,@NgayTao				=	'2017-10-24 04:18:30.687'
						,@CtrVersion			=	0

						,@ChiTiet				=	@ChiTiet

						,@COSO_ID				=	1
						,@NHANVIEN_ID			=	6

						,@MESSAGE				=	@MESSAGE OUTPUT
					SELECT	@MESSAGE MESSAGE
6. Precaution	:
7. History		:
				  2017.10.25 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
create PROCEDURE [dbo].[sp_KhoPhieuXuat_UpdateKhoPhieuXuat]
	@KhoPhieuXuatId			INT				=	NULL
	,@SoPhieu				VARCHAR(MAX)	=	NULL
	,@NgayXuat				DATETIME		=	NULL
	,@Loai					VARCHAR(MAX)	=	NULL
	,@KhoXuatId				INT				=	NULL
	,@KhoNhanId				INT				=	NULL
	,@NguoiNhanHang			NVARCHAR(MAX)	=	NULL
	,@LyDo					NVARCHAR(MAX)	=	NULL
	,@CoSoId				INT				=	NULL
	,@NguoiTao				INT				=	NULL
	,@NgayTao				DATETIME		=	NULL
	,@CtrVersion			INT				=	NULL

	,@ChiTiet				KhoPhieuXuatChiTietTableType		READONLY

	,@COSO_ID				INT				=	NULL
	,@NHANVIEN_ID			INT				=	NULL
	,@MESSAGE				NVARCHAR(MAX)		OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
--------------------------------------------------
-- BIẾN NỘI BỘ
DECLARE  @V_TRANS_NAME		NVARCHAR(MAX)	=	N'KPX_INSERT'

-- INPUT DEFAULT
SET @NHANVIEN_ID	= ISNULL(@NHANVIEN_ID,0)
SET @COSO_ID	= ISNULL(@COSO_ID,0)
SET @MESSAGE	= ISNULL(@MESSAGE,'')

SET @NgayTao	= ISNULL(@NgayTao, GETDATE())

SET @NguoiTao	= ISNULL(@NguoiTao, 0)
IF @NguoiTao = 0
	SET @NguoiTao	= @NHANVIEN_ID

SET @CoSoId	= ISNULL(@CoSoId, 0)
IF @CoSoId = 0
	SET @CoSoId	= @COSO_ID

BEGIN TRY
	--SET @MESSAGE	=	N'MA_TAI_SAN|1|MÃ NÀY ĐÃ TỒN TẠI';
	--THROW 51000, @MESSAGE, 1;

	IF EXISTS (SELECT 1 FROM KhoPhieuXuat WHERE SoPhieu = @SoPhieu AND KhoPhieuXuatId <> @KhoPhieuXuatId)
	BEGIN
		SET @MESSAGE	=	N'SOPHIEU|1|Số phiếu đã tồn tại';
		THROW 51000, @MESSAGE, 1;
	END

	BEGIN TRANSACTION @V_TRANS_NAME

	UPDATE	KhoPhieuXuat
	SET		 SoPhieu		=	@SoPhieu
			,NgayXuat		=	@NgayXuat
			,Loai			=	@Loai
			,KhoXuatId		=	@KhoXuatId
			,KhoNhanId		=	@KhoNhanId
			,NguoiNhanHang	=	@NguoiNhanHang
			,LyDo			=	@LyDo
			,CoSoId			=	@CoSoId
			,NguoiTao		=	@NguoiTao
			,NgayTao		=	@NgayTao
			,CtrVersion		=	@CtrVersion
	WHERE	KhoPhieuXuatId	=	@KhoPhieuXuatId

	DELETE KhoPhieuXuatChiTiet WHERE KhoPhieuXuatId = @KhoPhieuXuatId

	INSERT INTO	KhoPhieuXuatChiTiet
			(
				 KhoPhieuXuatId		,TaiSanId		,SoLuong
				,DonGia				,GiaMua			,GiaBan
				,NguonNganSachId	,NhaCungCapId	,HanDung
				,LoSanXuat
			)
	SELECT		 @KhoPhieuXuatId	,TaiSanId		,SoLuong
				,DonGia				,GiaMua			,GiaBan
				,NguonNganSachId	,NhaCungCapId	,HanDung
				,LoSanXuat
	FROM		@ChiTiet

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
