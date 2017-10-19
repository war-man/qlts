/**************************************************
1. Create Date	: 2017.10.18
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: 
4. Function		: 
5. Example		: 
					EXEC [sp_VaiTro_GetListVaiTroByCriteria]
						 @VAITROIDS			=	''
						,@MAVAITRO			=	''
						,@COSOIDS			=	''
						,@SEARCH			=	''
						,@ORDERCLAUSE		=	''
						,@NHANVIEN_ID		=	6
						,@COSO_ID			=	1
						,@SKIP				=	0
						,@TAKE				=	10
6. Precaution	:
7. History		:
				  2017.10.18 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
ALTER PROCEDURE [dbo].[sp_VaiTro_GetListVaiTroByCriteria]
		 @VAITROIDS			VARCHAR(MAX)	=	NULL
		,@MAVAITRO			VARCHAR(MAX)	=	NULL
		,@COSOIDS			VARCHAR(MAX)	=	NULL
		,@SEARCH			NVARCHAR(MAX)	=	NULL
		,@ORDERCLAUSE		VARCHAR(MAX)	=	NULL
		,@NHANVIEN_ID		INT				=	NULL
		,@COSO_ID			INT				=	NULL
		,@SKIP				INT				=	NULL
		,@TAKE				INT				=	NULL
AS
BEGIN
	SET NOCOUNT ON;
--------------------------------------------------
---------- BIẾN NỘI BỘ
DECLARE  @V_SQL			NVARCHAR(MAX)	=	N''
		,@V_DELIMITER	VARCHAR(10)		=	'|'
		,@V_ISVIEW		VARCHAR(MAX)	=	'VB'
		,@V_VAITROID	INT				=	NULL
		,@V_SEARCH		NVARCHAR(MAX)	=	NULL
---------- SET DEFAULT
SET @COSO_ID = ISNULL(@COSO_ID, 0)
SET @NHANVIEN_ID = ISNULL(@NHANVIEN_ID, 0)

SET @VAITROIDS = ISNULL(@VAITROIDS, '')
SET @MAVAITRO = ISNULL(@MAVAITRO, '')
SET @COSOIDS = ISNULL(@COSOIDS, '')
SET @SEARCH = ISNULL(@SEARCH, '')
SET @V_SEARCH = '%' + @SEARCH + '%'
SET @SKIP = ISNULL(@SKIP, 0)
SET @TAKE = ISNULL(@TAKE, 0)

SET @ORDERCLAUSE = ISNULL(@ORDERCLAUSE,'')
IF (@ORDERCLAUSE = '')
	SET @ORDERCLAUSE = ' MAXCNT ';

SELECT TOP 1 @V_VAITROID = VaiTroId FROM NguoiDung WHERE NhanVienId = @NHANVIEN_ID
SET @V_VAITROID = ISNULL(@V_VAITROID,0)

---------- BUILD QUERY
SET @V_SQL = N' 
	SELECT		 COUNT(VT.VaiTroId) OVER () AS MAXCNT
				,VT.*
	FROM		VaiTro VT
	WHERE		1=1
			AND (
				@V_VAITROID = 1
				OR	@V_ISVIEW IN (''VA'')
				OR (@V_ISVIEW IN (''VB'',''VR'') AND VT.CoSoId = @COSO_ID)
				OR (@V_ISVIEW IN (''VE'') AND VT.NguoiTao = @NHANVIEN_ID AND VT.CoSoId = @COSO_ID)
			)
			AND (@VAITROIDS = '''' OR CHARINDEX(@V_DELIMITER+CAST(VT.VaiTroId AS VARCHAR(10))+@V_DELIMITER,@V_DELIMITER+@VAITROIDS+@V_DELIMITER) > 0)
			AND (@COSOIDS = '''' OR CHARINDEX(@V_DELIMITER+CAST(VT.CoSoId AS VARCHAR(10))+@V_DELIMITER,@V_DELIMITER+@COSOIDS+@V_DELIMITER) > 0)
			AND (@MAVAITRO = '''' OR VT.MaVaiTro = @MAVAITRO)
			AND (
				@SEARCH = '''' OR VT.MaVaiTro LIKE @V_SEARCH
				OR @SEARCH = '''' OR VT.TenVaiTro LIKE @V_SEARCH
				OR @SEARCH = '''' OR VT.MoTa LIKE @V_SEARCH
			)
'
	IF @ORDERCLAUSE <> ''
		SET @V_SQL = @V_SQL + ' ORDER BY ' + @ORDERCLAUSE

	IF @ORDERCLAUSE <> '' AND @TAKE > 0
		SET @V_SQL = @V_SQL + ' OFFSET ' + CAST(@SKIP AS nvarchar(20)) + ' ROWS FETCH NEXT ' + CAST(@TAKE AS nvarchar(20)) + ' ROWS ONLY '

	print @V_SQL
	exec sp_executesql @V_SQL
		,N'
		 @VAITROIDS			VARCHAR(MAX)
		,@MAVAITRO			VARCHAR(MAX)
		,@COSOIDS			VARCHAR(MAX)
		,@V_ISVIEW			VARCHAR(MAX)
		,@SEARCH			NVARCHAR(MAX)
		,@NHANVIEN_ID		INT
		,@COSO_ID			INT
		,@V_VAITROID		INT
		,@V_SEARCH			NVARCHAR(MAX)
		,@V_DELIMITER		VARCHAR(MAX)
		'
		,@VAITROIDS			=	@VAITROIDS
		,@MAVAITRO			=	@MAVAITRO
		,@COSOIDS			=	@COSOIDS
		,@SEARCH			=	@SEARCH
		,@NHANVIEN_ID		=	@NHANVIEN_ID
		,@COSO_ID			=	@COSO_ID
		,@V_VAITROID		=	@V_VAITROID
		,@V_SEARCH			=	@V_SEARCH
		,@V_ISVIEW			=	@V_ISVIEW
		,@V_DELIMITER		=	@V_DELIMITER
--------------------------------------------------
	SET NOCOUNT OFF;
END
