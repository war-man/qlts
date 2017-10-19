/**************************************************
1. Create Date	: 2017.10.19
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: 
4. Function		: 
5. Example		: 
					EXEC [sp_KhoTaiSan_cbxKhoTaiSanByCriteria]
						 @SEARCH		=	N'CHÍNH'
						,@KHOTAISANIDS	=	''
						,@MAKHOTAISAN	=	''
						,@COSOID		=	''
						,@FUNCTIONCODE	=	''
						,@COSO_ID		=	1
						,@NHANVIEN_ID	=	6
6. Precaution	:
7. History		:
				  2017.10.19 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
ALTER PROCEDURE [dbo].[sp_KhoTaiSan_cbxKhoTaiSanByCriteria]
	 @SEARCH		NVARCHAR(MAX)	=	NULL
	,@KHOTAISANIDS	VARCHAR(MAX)	=	NULL
	,@MAKHOTAISAN	VARCHAR(MAX)	=	NULL
	,@COSOID		VARCHAR(MAX)	=	NULL
	,@FUNCTIONCODE	VARCHAR(MAX)	=	NULL
	,@COSO_ID		INT				=	NULL
	,@NHANVIEN_ID	INT				=	NULL	
AS  
BEGIN
SET NOCOUNT ON  
--------------------------------------------------
DECLARE	 @V_DELIMITER	VARCHAR(10)		=	'|'
		,@V_ISVIEW		VARCHAR(MAX)	=	'VA'
		,@V_SEARCH		NVARCHAR(MAX)	=	NULL
		,@V_SQL			NVARCHAR(MAX)	=	NULL

SET @COSO_ID = ISNULL(@COSO_ID,0)
SET @NHANVIEN_ID = ISNULL(@NHANVIEN_ID,0)

SET @SEARCH = ISNULL(@SEARCH,'')
SET @V_SEARCH = '%' + @SEARCH + '%'
SET @KHOTAISANIDS = ISNULL(@KHOTAISANIDS,'')
SET @MAKHOTAISAN = ISNULL(@MAKHOTAISAN,'')
SET @COSOID = ISNULL(@COSOID,'')

SET @V_SQL = N'
	SELECT		TOP 10 COUNT(KHOTS.KhoTaiSanId) OVER () AS MAXCNT
				,KHOTS.*
				,NV.TenNhanVien TenNguoiTao
				,CS.TenCoSo TenCoSo
	FROM		KhoTaiSan KHOTS
				LEFT JOIN CoSo CS ON KHOTS.CoSoId = CS.CoSoId
				LEFT JOIN NhanVien NV ON KHOTS.NGUOITAO = NV.NHANVIENID
	WHERE		(
					@V_ISVIEW IN (''VA'')
					OR (@V_ISVIEW IN (''VB'',''VR'') AND KHOTS.CoSoId = @COSO_ID)
					OR (@V_ISVIEW IN (''VE'') AND KHOTS.NguoiTao = @NHANVIEN_ID)
				)
				AND (@SEARCH = '''' OR KHOTS.TenKhoTaiSan LIKE  @V_SEARCH OR KHOTS.MaKhoTaiSan LIKE @V_SEARCH)
				AND (@KHOTAISANIDS = '''' OR CHARINDEX(@V_DELIMITER + CAST(KHOTS.KhoTaiSanId AS VARCHAR(10)) + @V_DELIMITER, @V_DELIMITER + @KHOTAISANIDS + @V_DELIMITER) > 0)
				AND (@MAKHOTAISAN = '''' OR KHOTS.MaKhoTaiSan = @MAKHOTAISAN)
				AND (@COSOID = '''' OR KHOTS.CoSoId = @COSOID)
'
PRINT @V_SQL
exec sp_executesql @V_SQL,N'
	 @SEARCH		NVARCHAR(MAX)
	,@V_SEARCH		NVARCHAR(MAX)
	,@KHOTAISANIDS	VARCHAR(MAX)
	,@MAKHOTAISAN	VARCHAR(MAX)
	,@COSOID		VARCHAR(MAX)
	,@COSO_ID		INT
	,@NHANVIEN_ID	INT
	,@V_DELIMITER	VARCHAR(10)
	,@V_ISVIEW		VARCHAR(MAX)
'
	,@SEARCH		=	@SEARCH
	,@V_SEARCH		=	@V_SEARCH
	,@KHOTAISANIDS	=	@KHOTAISANIDS
	,@MAKHOTAISAN	=	@MAKHOTAISAN
	,@COSOID		=	@COSOID
	,@COSO_ID		=	@COSO_ID
	,@NHANVIEN_ID	=	@NHANVIEN_ID
	,@V_DELIMITER	=	@V_DELIMITER
	,@V_ISVIEW		=	@V_ISVIEW
--------------------------------------------------
SET NOCOUNT OFF
END
