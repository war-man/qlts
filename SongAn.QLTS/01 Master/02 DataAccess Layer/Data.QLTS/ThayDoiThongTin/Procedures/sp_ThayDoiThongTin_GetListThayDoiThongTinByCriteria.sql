USE [QLTS]
GO

ALTER PROCEDURE [dbo].[sp_ThayDoiThongTin_GetListThayDoiThongTinByCriteria]
	 @Search			NVARCHAR(MAX)	=	NULL
	,@Field				NVARCHAR(MAX)	=	NULL
	,@Skip				INT				=	NULL
	,@Take				INT				=	NULL
	,@OrderClause		NVARCHAR(MAX)	=	NULL

	,@CoSoId			VARCHAR(10)		=	NULL
	,@NhanVienId		VARCHAR(10)		=	NULL
	,@MESSAGE			NVARCHAR(MAX)		OUTPUT
AS  
BEGIN
SET NOCOUNT ON
	DECLARE @V_SQL NVARCHAR(MAX) 
			,@V_DELIMITER	VARCHAR(10)		=	'|'
			,@_COSO_IDS		VARCHAR(MAX)	=	NULL
			,@Nam	VARCHAR(MAX)	=	NULL
	--LAY SO LIEU CAU HINH THONG SO
	EXEC sp_ThongSoUser_GetThongSo @LOAITHONGSO='SoLieuNam',@NHANVIEN=@NhanVienId,@NAM=@Nam OUTPUT;
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

	--EXEC [dbo].[sp_CoSo_GetListCoSoTrucThuocById]
	--   @COSOID=@CoSoId
	--  ,@COSOID_OUT=@_COSO_IDS OUTPUT
	--SET @_COSO_IDS = REPLACE(@_COSO_IDS,',',@V_DELIMITER)
	--PRINT concat('@_COSO_IDS=',@_COSO_IDS)
	----
	DECLARE @IS_VIEW varchar(10) = '0'
	exec [QLTS_MAIN].dbo.[sp_QuyenTacVu_CheckQuyenTacVuByChucNang]
		@NHAN_VIEN_ID = @NhanVienId,
		@CO_SO_ID = @CoSoId,
		@CHUC_NANG = 'CN0027',
		@QUYEN=@IS_VIEW OUTPUT
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
				LEFT JOIN NhanVien NV_NT ON TDTT.NguoiTao = NV_NT.NhanVienId
				LEFT JOIN (SELECT pbnv.NhanVienId,
		STUFF((
				select CONCAT( '','' ,u1.PhongBanId)
				from dbo.PhongBan u1 JOIN dbo.PhongBanNhanVien pbnv1 ON pbnv1.PhongBanId = u1.PhongBanId
				where pbnv1.NhanVienId = pbnv.NhanVienId
				for xml path('''')
			),1,1,'''') PhongBanId
			FROM dbo.PhongBanNhanVien pbnv
			JOIN PhongBan b on pbnv.PhongBanId=b.PhongBanId 
			GROUP BY pbnv.NhanVienId) pbnv ON pbnv.NhanVienId=TDTT.NguoiTao
	WHERE		YEAR(TDTT.Ngay)='''+@Nam+''' AND (@Search = '''' OR TS.MaTaiSan LIKE ''%'' + @Search + ''%'' OR TS.TenTaiSan LIKE ''%'' + @Search + ''%'')';
				------------
	IF @IS_VIEW = 'VB' 
	BEGIN    
		SET @V_SQL = @V_SQL + ' and TDTT.CoSoId =''' + @CoSoId + '''';   
	END
	IF @IS_VIEW = 'VR' 
	BEGIN    
		SET @V_SQL = @V_SQL + ' and EXISTS (SELECT pbnv1.PhongBanId FROM dbo.NhanVien nv JOIN dbo.PhongBanNhanVien pbnv1 ON pbnv1.NhanVienId = nv.NhanVienId WHERE nv.NhanVienId=''' + @NhanVienId+ '''' +
							  ' AND CHARINDEX('','' + CAST(pbnv1.PhongBanId AS VARCHAR(10)) + '','', '','' + CAST(pbnv.PhongBanId AS VARCHAR(10)) + '','') > 0) ';   
	
	END
	IF @IS_VIEW = 'VE' 
	BEGIN    
		SET @V_SQL = @V_SQL + ' and NV_NT.NhanVienId =''' + @NhanVienId + '''';   
	END
	----------
	SET @V_SQL = @V_SQL + ' ORDER BY	' + @OrderClause + ' OFFSET @Skip ROWS FETCH NEXT @Take ROWS ONLY';

	print(@V_SQL)
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