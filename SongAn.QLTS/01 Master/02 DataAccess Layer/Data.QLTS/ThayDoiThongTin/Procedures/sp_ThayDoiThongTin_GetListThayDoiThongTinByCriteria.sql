/**************************************************
1. Create Date	: 2017.09.14
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: 
4. Function		: 
5. Example		: 
					DECLARE @MESSAGE	NVARCHAR(MAX)
					EXEC [sp_ThayDoiThongTin_GetListThayDoiThongTinByCriteria]
						 @Search			=	N'ghế'
						,@Skip				=	6
						,@Take				=	10
						,@OrderClause		=	'ID desc'

						,@CoSoId			=	1
						,@NhanVienId		=	6
						,@MESSAGE			=	@MESSAGE OUTPUT
					SELECT	@MESSAGE MESSAGE
6. Precaution	:
7. History		:
				  2017.09.14 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
ALTER PROCEDURE [dbo].[sp_ThayDoiThongTin_GetListThayDoiThongTinByCriteria]
	 @Search			NVARCHAR(MAX)	=	NULL
	,@Field				NVARCHAR(MAX)	=	NULL
	,@Skip				INT				=	NULL
	,@Take				INT				=	NULL
	,@OrderClause		NVARCHAR(MAX)	=	NULL

	,@CoSoId			INT				=	NULL
	,@NhanVienId		INT				=	NULL
	,@MESSAGE			NVARCHAR(MAX)		OUTPUT
AS  
BEGIN
SET NOCOUNT ON
	DECLARE @V_SQL NVARCHAR(MAX) 
			,@V_DELIMITER	VARCHAR(10)		=	'|'
			,@_COSO_IDS		VARCHAR(MAX)	=	NULL

---- SET DEFAULT PARAMS
	SET @CoSoId = ISNULL(@CoSoId,0)
	SET @NhanVienId = ISNULL(@NhanVienId,0)
	SET @MESSAGE = ISNULL(@MESSAGE,'')

	SET @Search = ISNULL(@Search,'')
	SET @Skip = ISNULL(@Skip,0)

	SET @Take = ISNULL(@Take,0)
	IF @Take = 0
		SET @Take = 10

	SET @OrderClause = ISNULL(@OrderClause,'')
	IF (@OrderClause = '')
		SET @OrderClause = ' MAXCNT ';

	SET @Field = ISNULL(@Field,'TDTT.*')

	EXEC [dbo].[sp_CoSo_GetListCoSoTrucThuocById]
	   @COSOID=@CoSoId
	  ,@COSOID_OUT=@_COSO_IDS OUTPUT
	SET @_COSO_IDS = REPLACE(@_COSO_IDS,',',@V_DELIMITER)
	PRINT concat('@_COSO_IDS=',@_COSO_IDS)

---- KIỂM TRA
---- BUILD SQL CLAUSE
	SET @V_SQL = N'
	SELECT		COUNT(TDTT.ThayDoiThongTinId) OVER () AS MAXCNT,' + @Field + ' 
				,TS.MaTaiSan,TS.TenTaiSan,TS.LoaiKeKhai
				,NV_ND.TenNhanVien TenNguoiDuyet
				,TDTT.ThayDoiThongTinId ID,TDTT.CtrVersion VERSION
	FROM		ThayDoiThongTin TDTT
				LEFT JOIN TaiSan TS ON TDTT.TaiSanId = TS.TaiSanId
				LEFT JOIN NhanVien NV_ND ON TDTT.NguoiDuyet = NV_ND.NhanVienId
	WHERE		CHARINDEX(''|'' + CAST(TDTT.CoSoId AS VARCHAR(10)) + ''|'',''|' + @_COSO_IDS + '|'') > 0
				AND (@Search = '''' OR TS.MaTaiSan LIKE ''%'' + @Search + ''%'' OR TS.TenTaiSan LIKE ''%'' + @Search + ''%'')
	ORDER BY	' + @OrderClause + ' 
				OFFSET @Skip ROWS FETCH NEXT @Take ROWS ONLY
	'
---- EXEC @V_SQL
	exec sp_executesql @V_SQL,N'
		 @Search			NVARCHAR(MAX)	=	NULL
		,@Field				NVARCHAR(MAX)	=	NULL
		,@Skip				INT				=	NULL
		,@Take				INT				=	NULL
		,@CoSoId			INT				=	NULL
		'
		,@Search		=	@Search
		,@Field			=	@Field
		,@Skip			=	@Skip
		,@Take			=	@Take
		,@CoSoId		=	@CoSoId
SET NOCOUNT OFF
END