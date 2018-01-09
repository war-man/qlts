USE [MSSQL_QLDN_QLNS_DEMO]
GO
/****** Object:  StoredProcedure [dbo].[sp_KD_FileHopDong_GetListByCriteria]    Script Date: 12/19/2017 9:59:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/***************************************************
1. Create Date	: 2017.11.14
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: 
4. Function		: 
5. Example		: 
					DECLARE @MESSAGE	NVARCHAR(MAX)
					EXEC sp_KD_FileHopDong_GetListByCriteria
						 @FileHopDongID			=	NULL
						,@SEARCH			=	N''

						,@FIELD				=	NULL
						,@ORDERCLAUSE		=	''
						,@SKIP				=	0
						,@TAKE				=	10

						,@USER_ID			=	NULL
						,@NHANVIEN_ID		=	6
						,@MESSAGE			=	@MESSAGE	OUTPUT

					SELECT	@MESSAGE MESSAGE
6. Precaution	:
7. History		:
				  2017.11.14 (NGUYỄN THANH BÌNH) - Tạo mới
***************************************************/
ALTER PROCEDURE [dbo].[sp_KD_FileHopDong_GetListByCriteria]
	 @FileHopDongID			INT					=	NULL
	,@SEARCH			NVARCHAR(MAX)		=	NULL

	,@FIELD				VARCHAR(MAX)		=	NULL
	,@ORDERCLAUSE		VARCHAR(MAX)		=	NULL
	,@SKIP				INT					=	NULL
	,@TAKE				INT					=	NULL
	
	,@USER_ID			INT					=	NULL
	,@NHANVIEN_ID		INT					=	NULL
	,@FUNCTIONCODE		VARCHAR(MAX)		=	NULL
	,@MESSAGE			NVARCHAR(MAX)		OUTPUT
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
@CHUC_NANG = 'KD0014',
@QUYEN_TAC_VU = 'View All',
@YES_NO=@IS_VIEW_ALL OUTPUT

SET @USER_ID = ISNULL(@USER_ID,0)
SET @NHANVIEN_ID = ISNULL(@NHANVIEN_ID,0)
SET @FUNCTIONCODE = ISNULL(@FUNCTIONCODE,'')
SET @MESSAGE = ''

SET @FileHopDongID = ISNULL(@FileHopDongID,0)
SET @SEARCH = ISNULL(@SEARCH,'')

SET @SKIP			=	ISNULL(@SKIP,0)
SET @TAKE			=	ISNULL(@TAKE,0)

SET @ORDERCLAUSE	=	ISNULL(@ORDERCLAUSE,'')
IF @ORDERCLAUSE = ''
	SET @ORDERCLAUSE = 'DL.FileHopDongId'

SET @FIELD = ISNULL(@FIELD,'')
IF @FIELD = ''
	SET @FIELD = 'DL.*'

SET @V_SEARCH = '%' + @SEARCH + '%'

-- SELECT
SET @V_SQL = N'
	SELECT COUNT(DL.FileHopDongId) OVER () AS MAXCNT,HD.SoHopDong,HD.TenHopDong,CONVERT(VARCHAR(10),HD.NgayHopDong,103) as NgayHopDong,DL.FileHopDongId,DL.HopDongId,
	case when DL.DaLam =1 then ''x'' else '''' end  as DaLam,DL.NguoiLam,case when DL.DaChuyen =1 then ''x'' else '''' end as DaChuyen,DL.NguoiChuyen,CONVERT(VARCHAR(10),DL.NgayChuyen,103) as NgayChuyen,DL.NguoiNhan,CONVERT(VARCHAR(10),DL.NgayNhan,103) as NgayNhan
	,DL.FileMem,DL.FileCung,DL.GhiChu,DL.NguoiTao,DL.CtrVersion,HD.SoTien
	,DL.FileHopDongId ID
		,CONCAT(NV.Ho,'' '',NV.Ten) TenNguoiTao
	FROM KDFileHopDong DL
	INNER JOIN KDHopDong HD ON DL.HopDongId=HD.HopDongId
	LEFT JOIN NhanVien NV ON DL.NguoiTao = NV.NhanVienId
'

-- WHERE
SET @V_SQL = @V_SQL + N'
	WHERE (@FileHopDongID = 0 OR DL.FileHopDongId = @FileHopDongID)
		AND (@SEARCH = '''' 
			OR HD.SoHopDong LIKE @V_SEARCH
			OR HD.TenHopDong LIKE @V_SEARCH
		)
'

IF @IS_VIEW_ALL = '0' 
BEGIN  
	SET @V_SQL = @V_SQL + '  and DL.NguoiTao =''' + CAST(@NHANVIEN_ID AS VARCHAR) + ''' ';
END

-- ORDER BY
SET @V_SQL = @V_SQL + N'
		ORDER BY DL.NgayTao desc, ' + @ORDERCLAUSE + ' 
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
	,@FileHopDongID			INT				=	NULL

	'
	,@NHANVIEN_ID							=	@NHANVIEN_ID

	,@SEARCH								=	@SEARCH
	,@V_SEARCH								=	@V_SEARCH
	,@FileHopDongID							=	@FileHopDongID

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