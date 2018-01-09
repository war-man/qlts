USE [MSSQL_QLDN_QLNS_DEMO]
GO
/****** Object:  StoredProcedure [dbo].[sp_KD_ThuatNgu_cbxGetListByCriteria]    Script Date: 12/19/2017 10:07:04 AM ******/
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
					EXEC sp_KD_ThuatNgu_cbxGetListByCriteria
						 @THUATNGUID		=	NULL
						,@SEARCH		=	N'12'

						,@ORDERCLAUSE	=	''
						,@SKIP			=	0
						,@TAKE			=	10

						,@USER_ID		=	NULL
						,@NHANVIEN_ID	=	6
						,@FUNCTIONCODE	=	''
						,@MESSAGE		=	@MESSAGE	OUTPUT

					SELECT	@MESSAGE MESSAGE
6. Precaution	:
7. History		:
				  2017.11.13 (NGUYỄN THANH BÌNH) - Tạo mới
***************************************************/
ALTER PROCEDURE [dbo].[sp_KD_ThuatNgu_cbxGetListByCriteria]
	 @THUATNGUID	INT					=	NULL
	,@SEARCH		NVARCHAR(MAX)		=	NULL

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

SET @USER_ID = ISNULL(@USER_ID,0)
SET @NHANVIEN_ID = ISNULL(@NHANVIEN_ID,0)
SET @FUNCTIONCODE = ISNULL(@FUNCTIONCODE,'')
SET @MESSAGE = ''

SET @THUATNGUID = ISNULL(@THUATNGUID,0)
SET @SEARCH = ISNULL(@SEARCH,'')

SET @V_SEARCH = '%' + @SEARCH + '%'

SET @SKIP			=	ISNULL(@SKIP,0)
SET @TAKE			=	ISNULL(@TAKE,0)

SET @ORDERCLAUSE	=	ISNULL(@ORDERCLAUSE,'')
IF @ORDERCLAUSE = ''
	SET @ORDERCLAUSE = 'TN.ThuatNguId'

-- SELECT
SET @V_SQL = N'
	SELECT COUNT(TN.ThuatNguId) OVER () AS MAXCNT,TN.*,TN.ThuatNguId ID
	FROM KDThuatNgu TN
'

-- WHERE
SET @V_SQL = @V_SQL + N'
	WHERE (@ThuatNguID = 0 OR TN.ThuatNguId = @ThuatNguID)
		AND (@SEARCH = '''' 
			OR TN.MaThuatNgu LIKE @V_SEARCH
			OR TN.ThuatNgu LIKE @V_SEARCH
			OR TN.ViDu LIKE @V_SEARCH
			OR TN.DienGiai LIKE @V_SEARCH
		)
'

-- ORDER BY
SET @V_SQL = @V_SQL + N'
		ORDER BY ' + @ORDERCLAUSE + ' 
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
	,@ThuatNguID				INT				=	NULL

	'
	,@NHANVIEN_ID							=	@NHANVIEN_ID

	,@SEARCH								=	@SEARCH
	,@V_SEARCH								=	@V_SEARCH
	,@ThuatNguID								=	@ThuatNguID

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