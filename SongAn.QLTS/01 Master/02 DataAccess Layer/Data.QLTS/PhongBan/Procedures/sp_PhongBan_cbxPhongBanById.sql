/**************************************************
1. Create Date	: 2017.10.16
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: 
4. Function		: 
5. Example		: 
					EXEC [sp_PhongBan_cbxPhongBanById]
						 @CoSoId	        =	16
						,@NhanVienId	    =	10
						,@Search			=	NULL
						,@PhongBanId		=	NULL
						,@FunctionCode		=	'CN0024'
6. Precaution	:
7. History		:
				  2017.10.16 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
ALTER PROCEDURE [dbo].[sp_PhongBan_cbxPhongBanById]
( 
	 @CoSoId	        nvarchar(500)	= null
	,@NhanVienId	    nvarchar(500)	= null
	,@Search			nvarchar(500)   = null
	,@PhongBanId		nvarchar(500)   = null
	,@FunctionCode		nvarchar(500)   = null
	
)
AS  
BEGIN
SET NOCOUNT ON  
------------------------------------------------  
DECLARE		 @_COSO_IDS		VARCHAR(MAX)	=	NULL
			,@V_ISVIEW		VARCHAR(MAX)	=	NULL
			,@V_PHONGBAN_ID	VARCHAR(MAX)	=	NULL

SET @PhongBanId = ISNULL(@PhongBanId, '')
IF @PhongBanId = ''
	SET @PhongBanId = '0'

-- KIỂM TRA QUYỀN VIEW
EXEC [QLTS_MAIN].dbo.[sp_QuyenTacVu_CheckQuyenTacVuByChucNang]
	@NHAN_VIEN_ID = @NhanVienId,
	@CO_SO_ID = @CoSoId,
	@CHUC_NANG = @FunctionCode,
	@QUYEN=@V_ISVIEW OUTPUT
PRINT CONCAT('@V_ISVIEW = ',@V_ISVIEW)
--/ KIỂM TRA QUYỀN VIEW

-- DANH SÁCH CƠ SỞ TRƯC THUỘC
EXEC [dbo].[sp_CoSo_GetListCoSoTrucThuocById]
	@COSOID=@CoSoId
	,@COSOID_OUT=@_COSO_IDS OUTPUT
SET @_COSO_IDS = REPLACE(@_COSO_IDS,',','|')
PRINT CONCAT('@_COSO_IDS = ',@_COSO_IDS)
--/ DANH SÁCH CƠ SỞ TRƯC THUỘC

SELECT @V_PHONGBAN_ID = PhongBanId FROM NhanVien WHERE NhanVienId = @NhanVienId

SELECT		*
FROM		PhongBan PB
WHERE		(		(@V_ISVIEW = 'VA')
				OR	(@V_ISVIEW = 'VB' AND CHARINDEX('|' + CAST(PB.CoSoId AS VARCHAR(10)) + '|', '|' + @_COSO_IDS + '|') > 0)
				OR	(@V_ISVIEW IN ('VR','VE') AND PB.PhongBanId = @V_PHONGBAN_ID)
			)
			AND (@PhongBanId = '0' OR CHARINDEX('|' + CAST(PB.PhongBanId AS VARCHAR(10)) + '|', '|' + @PhongBanId + '|') > 0)
-----------------------------------------------------
SET NOCOUNT OFF
END

