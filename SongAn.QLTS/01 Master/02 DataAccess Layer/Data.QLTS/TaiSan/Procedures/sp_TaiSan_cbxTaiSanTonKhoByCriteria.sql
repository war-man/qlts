/**************************************************
1. Create Date	: 2017.10.23
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: 
4. Function		: 
5. Example		: 
					EXEC [sp_TaiSan_cbxTaiSanTonKhoByCriteria]
						 @COSO_ID		=	1
						,@NHANVIEN_ID	=	6
						,@FUNCTIONCODE	=	'CN0046'
						,@FIELD			=	''

						,@SEARCH		=	N''
						,@TAISANIDS		=	'27'
						,@KHOTAISANIDS	=	'1'
						,@DONGIA		=	null
						,@THANGNAM		=	'17'
6. Precaution	:
7. History		:
				  2017.10.23 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
ALTER PROCEDURE [dbo].[sp_TaiSan_cbxTaiSanTonKhoByCriteria]
( 
	 @COSO_ID		INT				=	NULL
	,@NHANVIEN_ID	INT				=	NULL
	,@FUNCTIONCODE	VARCHAR(MAX)	=	NULL
	,@FIELD			VARCHAR(MAX)	=	NULL

	,@SEARCH		NVARCHAR(MAX)	=	NULL
	,@TAISANIDS		VARCHAR(MAX)	=	NULL
	,@KHOTAISANIDS	VARCHAR(MAX)	=	NULL
	,@DONGIA		DECIMAL(18,4)	=	NULL
	,@THANGNAM		VARCHAR(MAX)	=	NULL
)
AS  
BEGIN
SET NOCOUNT ON
--------------------------------------------------
DECLARE  @V_ISVIEW		VARCHAR(MAX)	=	''
		,@V_SEARCH		NVARCHAR(MAX)	=	N''
		,@V_DELIMITER	VARCHAR(10)		=	'|'
		,@_COSO_IDS		VARCHAR(MAX)	=	''

SET @TAISANIDS = ISNULL(@TAISANIDS, '')
SET @KHOTAISANIDS = ISNULL(@KHOTAISANIDS, '')
SET @THANGNAM = ISNULL(@THANGNAM, '')

SET @SEARCH = ISNULL(@SEARCH, '')
SET @V_SEARCH = '%' + @SEARCH + '%'

SET @FIELD = ISNULL(@FIELD, '')

-- KIỂM TRA QUYỀN VIEW
EXEC [QLTS_MAIN].dbo.[sp_QuyenTacVu_CheckQuyenTacVuByChucNang]
	@NHAN_VIEN_ID = @NHANVIEN_ID,
	@CO_SO_ID = @COSO_ID,
	@CHUC_NANG = @FUNCTIONCODE,
	@QUYEN=@V_ISVIEW OUTPUT
--/ KIỂM TRA QUYỀN VIEW

-- DANH SÁCH CƠ SỞ TRƯC THUỘC
EXEC [dbo].[sp_CoSo_GetListCoSoTrucThuocById]
	@COSOID=@COSO_ID
	,@COSOID_OUT=@_COSO_IDS OUTPUT
SET @_COSO_IDS = REPLACE(@_COSO_IDS,',',@V_DELIMITER)
--/ DANH SÁCH CƠ SỞ TRƯC THUỘC

SELECT		TOP 10 COUNT(TS.TaiSanId) OVER () AS MAXCNT
			,TS.TaiSanId,TS.MaTaiSan,TS.TenTaiSan,TS.DonViTinh
			,KTS.KhoTaiSanId,KTS.MaKhoTaiSan,KTS.TenKhoTaiSan
			,KTK.ThangNam
			,KTKCT.DonGia,KTKCT.GiaMua,KTKCT.GiaBan,KTKCT.HanDung,KTKCT.LoSanXuat
			,CS.CoSoId,CS.MaCoSo,CS.TenCoSo
			,NCC.NhaCungCapId,NCC.TenNhaCungCap
			,NNS.NguonNganSachId,NNS.TenNguonNganSach
			,(KTKCT.TonDau + KTKCT.SLNhap - KTKCT.SLXuat) SoLuong
FROM		KhoTonKhoChiTiet KTKCT
			LEFT JOIN KhoTonKho KTK ON KTKCT.KhoTonKhoId = KTK.KhoTonKhoId
			LEFT JOIN TaiSan TS ON KTKCT.TaiSanId = TS.TaiSanId
			LEFT JOIN KhoTaiSan KTS ON KTK.KhoTaiSanId = KTS.KhoTaiSanId
			LEFT JOIN CoSo CS ON KTK.CoSoId = CS.CoSoId
			LEFT JOIN NhaCungCap NCC ON KTKCT.NhaCungCapId = NCC.NhaCungCapId
			LEFT JOIN NguonNganSach NNS ON KTKCT.NguonNganSachId = NNS.NguonNganSachId
WHERE		(
				@V_ISVIEW IN ('VA')
				OR (@V_ISVIEW IN ('VB','VR') AND CHARINDEX(@V_DELIMITER + CAST(CS.CoSoId AS VARCHAR(10)) + @V_DELIMITER,@V_DELIMITER + @_COSO_IDS + @V_DELIMITER) > 0)
				OR (@V_ISVIEW IN ('VE') AND KTK.NguoiTao = @NHANVIEN_ID)
			)
			AND (
				TS.MaTaiSan LIKE @V_SEARCH
				OR TS.TenTaiSan LIKE @V_SEARCH
			)
			AND (@TAISANIDS = '' OR CHARINDEX(@V_DELIMITER + CAST(TS.TaiSanId AS VARCHAR(10)) + @V_DELIMITER,@V_DELIMITER + @TAISANIDS + @V_DELIMITER) > 0)
			AND (@KHOTAISANIDS = '' OR CHARINDEX(@V_DELIMITER + CAST(KTS.KhoTaiSanId AS VARCHAR(10)) + @V_DELIMITER,@V_DELIMITER + @KHOTAISANIDS + @V_DELIMITER) > 0)
			AND (@DONGIA IS NULL OR KTKCT.DonGia = @DONGIA)
			AND (@THANGNAM = '' OR KTK.ThangNam = @THANGNAM)
			-- TỒN > 0
			AND (KTKCT.TonDau + KTKCT.SLNhap - KTKCT.SLXuat) > 0
--------------------------------------------------
SET NOCOUNT OFF
END

