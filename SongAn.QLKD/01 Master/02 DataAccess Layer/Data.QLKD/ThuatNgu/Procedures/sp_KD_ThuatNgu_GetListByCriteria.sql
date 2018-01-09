USE [MSSQL_QLDN_QLNS_DEMO]
GO
/****** Object:  StoredProcedure [dbo].[sp_KD_ThuatNgu_GetListByCriteria]    Script Date: 12/19/2017 10:07:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/***************************************************
1. Create Date	: 2017.11.13
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: 
4. Function		: 
5. Example		: 
					DECLARE @MESSAGE	NVARCHAR(MAX)
					EXEC sp_KD_ThuatNgu_GetListByCriteria
						 @THUATNGUID	=	NULL
						,@SEARCH		=	N'12'

						,@FIELD			=	NULL
						,@ORDERCLAUSE	=	''
						,@SKIP			=	0
						,@TAKE			=	10

						,@USER_ID		=	NULL
						,@NHANVIEN_ID	=	6
						,@MESSAGE		=	@MESSAGE	OUTPUT

					SELECT	@MESSAGE MESSAGE
6. Precaution	:
7. History		:
				  2017.11.13 (NGUYỄN THANH BÌNH) - Tạo mới
***************************************************/
ALTER PROCEDURE [dbo].[sp_KD_ThuatNgu_GetListByCriteria]
	 @THUATNGUID	INT					=	NULL
	,@SEARCH		NVARCHAR(MAX)		=	NULL

	,@FIELD			VARCHAR(MAX)		=	NULL
	,@ORDERCLAUSE	VARCHAR(MAX)		=	NULL
	,@SKIP			INT					=	NULL
	,@TAKE			INT					=	NULL
	
	,@USER_ID		INT					=	NULL
	,@NHANVIEN_ID	INT					=	NULL
	,@FUNCTIONCODE	VARCHAR(MAX)		=	NULL
	,@MESSAGE		NVARCHAR(MAX)		OUTPUT
AS
BEGIN
SET NOCOUNT ON;
BEGIN TRY
--------------------------------------------------
DECLARE @V_SQL NVARCHAR(MAX) = NULL
	,@V_SEARCH NVARCHAR(MAX) = ''

DECLARE @IS_VIEW_ALL varchar = '0'
    ----------
exec MSSQL_QLDN_MAIN_DEMO.dbo.[sp_KD_QuyenTacVu_CheckQuyenTacVuByChucNang]
@LOGIN_ID = @USER_ID,
@CHUC_NANG = 'KD0004',
@QUYEN_TAC_VU = 'View All',
@YES_NO=@IS_VIEW_ALL OUTPUT

SET @USER_ID = ISNULL(@USER_ID,0)
SET @NHANVIEN_ID = ISNULL(@NHANVIEN_ID,0)
SET @FUNCTIONCODE = ISNULL(@FUNCTIONCODE,'')
SET @MESSAGE = ''

SET @THUATNGUID = ISNULL(@THUATNGUID,0)
SET @SEARCH = ISNULL(@SEARCH,'')

SET @SKIP			=	ISNULL(@SKIP,0)
SET @TAKE			=	ISNULL(@TAKE,0)

SET @ORDERCLAUSE	=	ISNULL(@ORDERCLAUSE,'')
IF @ORDERCLAUSE = ''
	SET @ORDERCLAUSE = 'DB.ThuatNguId'

SET @FIELD = ISNULL(@FIELD,'')
IF @FIELD = ''
	SET @FIELD = 'DB.*'

SET @V_SEARCH = '%' + @SEARCH + '%'

-- SELECT
SET @V_SQL = N'
	SELECT COUNT(DB.ThuatNguId) OVER () AS MAXCNT,' + @FIELD + ',DB.ThuatNguId ID
		,CONCAT(NV.Ho,'' '',NV.Ten) TenNguoiTao
	FROM KDThuatNgu DB
	LEFT JOIN NhanVien NV ON DB.NguoiTao = NV.NhanVienId
'

-- WHERE
SET @V_SQL = @V_SQL + N'
	WHERE (@THUATNGUID = 0 OR DB.ThuatNguId = @THUATNGUID)
		AND (@SEARCH = '''' 
			OR DB.MaThuatNgu LIKE @V_SEARCH
			OR DB.ThuatNgu LIKE @V_SEARCH
			OR DB.ViDu LIKE @V_SEARCH
			OR DB.DienGiai LIKE @V_SEARCH
		)
'

PRINT @NHANVIEN_ID
print @IS_VIEW_ALL
IF @IS_VIEW_ALL = '0' 
BEGIN  
	SET @V_SQL = @V_SQL + '  and DB.NguoiTao =''' + CAST(@NHANVIEN_ID AS VARCHAR) + ''' ';
END

-- ORDER BY
SET @V_SQL = @V_SQL + N'
		ORDER BY DB.NgayTao desc,' + @ORDERCLAUSE + ' 
'

-- OFFSET
IF @ORDERCLAUSE <> '' AND @TAKE > 0
	SET @V_SQL = @V_SQL + N'
		OFFSET ' + CAST(@SKIP AS VARCHAR(10)) + ' ROWS FETCH NEXT ' + CAST(@TAKE AS VARCHAR(10)) + ' ROWS ONLY 
	'

PRINT @V_SQL
EXEC SP_EXECUTESQL @V_SQL,N'
	 @NHANVIEN_ID			INT				=	NULL

	,@SEARCH				NVARCHAR(MAX)	=	NULL
	,@V_SEARCH				NVARCHAR(MAX)	=	NULL
	,@THUATNGUID				INT				=	NULL

	'
	,@NHANVIEN_ID							=	@NHANVIEN_ID

	,@SEARCH								=	@SEARCH
	,@V_SEARCH								=	@V_SEARCH
	,@THUATNGUID								=	@THUATNGUID

--------------------------------------------------
END TRY
BEGIN CATCH
	DECLARE @ErrorMessage NVARCHAR(MAX);
    DECLARE @ErrorSeverity INT;
    DECLARE @ErrorState INT;

    SELECT 
        @ErrorMessage = ERROR_MESSAGE(),
        @ErrorSeverity = ERROR_SEVERITY(),
        @ErrorState = ERROR_STATE();

	IF @MESSAGE = ''
		RAISERROR (@ErrorMessage,@ErrorSeverity,@ErrorState);
END CATCH

SET NOCOUNT OFF;
END