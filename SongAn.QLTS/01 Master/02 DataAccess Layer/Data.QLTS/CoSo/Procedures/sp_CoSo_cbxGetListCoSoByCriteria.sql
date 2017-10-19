/**************************************************
1. Create Date	: 2017.09.01
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: THÔNG TIN TÀI SẢN
4. Function		: 
5. Example		: 
					EXEC [sp_CoSo_cbxGetListCoSoByCriteria]
						 @COSOIDS			=	''
						,@MACOSO			=	NULL
						,@SEARCH			=	NULL
						,@COSO_ID			=	16
						,@NHANVIEN_ID		=	10
6. Precaution	:
7. History		:
				  2017.09.01 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
ALTER PROCEDURE [dbo].[sp_CoSo_cbxGetListCoSoByCriteria]
	 @COSOIDS			VARCHAR(MAX)	=	NULL
	,@MACOSO			VARCHAR(MAX)	=	NULL
	,@SEARCH			NVARCHAR(MAX)	=	NULL
	,@COSO_ID			INT				=	NULL
	,@NHANVIEN_ID		INT				=	NULL
AS  
BEGIN
SET NOCOUNT ON
--------------------------------------------------
DECLARE  @V_DELIMITER	VARCHAR(10)		=	'|'
		,@V_ISVIEW		VARCHAR(MAX)	=	'VB'
		,@V_VAITROID	INT				=	NULL

SET @COSO_ID = ISNULL(@COSO_ID, 0)
SET @NHANVIEN_ID = ISNULL(@NHANVIEN_ID, 0)

SET @COSOIDS = ISNULL(@COSOIDS, '')
SET @MACOSO = ISNULL(@MACOSO, '')
SET @SEARCH = ISNULL(@SEARCH, '')

SELECT TOP 1 @V_VAITROID = VaiTroId FROM QLTS_MAIN.DBO.NguoiDung WHERE NhanVienId = @NHANVIEN_ID
SET @V_VAITROID = ISNULL(@V_VAITROID, 0)
PRINT CONCAT('@V_VAITROID=',@V_VAITROID)

SELECT		TOP 10 *
FROM		COSO CS
WHERE		( -- PHÂN QUYỀN VIEW
				@V_VAITROID = 1
				OR	@V_ISVIEW IN ('VA')
				OR (@V_ISVIEW IN ('VB','VR') AND CS.CoSoId = @COSO_ID)
				OR (@V_ISVIEW IN ('VE') AND CS.NguoiTao = @NHANVIEN_ID AND CS.CoSoId = @COSO_ID)
			)
			AND (@COSOIDS = '' OR CHARINDEX(@V_DELIMITER+CAST(CS.CoSoId AS VARCHAR(10))+@V_DELIMITER,@V_DELIMITER+@COSOIDS+@V_DELIMITER) > 0)
			AND (@MACOSO = '' OR CS.MaCoSo = @MACOSO)
			AND (
				@SEARCH = '' OR CS.MaCoSo LIKE '%' + @SEARCH + '%'
				OR @SEARCH = '' OR CS.TenCoSo LIKE '%' + @SEARCH + '%'
				OR @SEARCH = '' OR CS.DiaChi LIKE '%' + @SEARCH + '%'
				OR @SEARCH = '' OR CS.DienThoai LIKE '%' + @SEARCH + '%'
			)
--------------------------------------------------
SET NOCOUNT OFF
END

