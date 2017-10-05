/**************************************************
1. Create Date	: 2017.10.03
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: 
4. Function		: 
5. Example		: 
					DECLARE @MESSAGE	NVARCHAR(MAX)
					EXEC [sp_TraCuuTaiSan_GetListTaiSanByCriteria]
						 @NHANVIENID	=	0
						,@PHONGBANID	=	0
						,@COSOID		=	0
						,@LOAIKEKHAI	=	'1|2'
						,@SEARCH		=	N''
						,@SKIP			=	0
						,@TAKE			=	0
						,@ORDERCLAUSE	=	''
						,@NHANVIEN_ID	=	6
						,@COSO_ID		=	1
						,@MESSAGE		=	@MESSAGE	OUTPUT

					SELECT	@MESSAGE MESSAGE
6. Precaution	:
7. History		:
				  2017.10.03 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
ALTER PROCEDURE [dbo].[sp_TraCuuTaiSan_GetListTaiSanByCriteria]
			 @NHANVIENID	INT					=	NULL
			,@PHONGBANID	INT					=	NULL
			,@COSOID		INT					=	NULL
			,@LOAIKEKHAI	VARCHAR(MAX)		=	NULL
			,@SEARCH		NVARCHAR(MAX)		=	NULL
			,@SKIP			INT					=	NULL
			,@TAKE			INT					=	NULL
			,@ORDERCLAUSE	VARCHAR(MAX)		=	NULL
			,@NHANVIEN_ID	INT					=	NULL
			,@COSO_ID		INT					=	NULL
			,@MESSAGE		NVARCHAR(MAX)		OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
--------------------------------------------------
---------- BIẾN NỘI BỘ
	DECLARE  @V_SQL				NVARCHAR(MAX)	=	N''
			,@V_FUNCTIONCODE	NVARCHAR(MAX)	=	'CN0037'
			,@V_PHONGBANID		INT				=	0
			,@V_ISVIEW			VARCHAR(10)		=	''
	
	-- SET DEFAULT
	SET @SEARCH = ISNULL(@SEARCH, '')
	SET @NHANVIENID = ISNULL(@NHANVIENID, 0)
	SET @PHONGBANID = ISNULL(@PHONGBANID, 0)
	SET @COSOID = ISNULL(@COSOID, 0)
	SET @LOAIKEKHAI = ISNULL(@LOAIKEKHAI, '')

	SET @SKIP = ISNULL(@SKIP, 0)
	SET @TAKE = ISNULL(@TAKE, 0)

	SET @ORDERCLAUSE = ISNULL(@ORDERCLAUSE,'')
	IF (@ORDERCLAUSE = '')
		SET @ORDERCLAUSE = ' MAXCNT ';

	SET @NHANVIEN_ID = ISNULL(@NHANVIEN_ID,0)
	SET @MESSAGE = ISNULL(@MESSAGE,'')

	SELECT	@V_PHONGBANID = NV.PhongBanId 
	FROM	NhanVien NV
	WHERE NhanVienId = @NHANVIEN_ID

	SET @V_PHONGBANID = ISNULL(@V_PHONGBANID,0)

	-- KIỂM TRA QUYỀN VIEW
	EXEC [QLTS_MAIN].dbo.[sp_QuyenTacVu_CheckQuyenTacVuByChucNang]
		@NHAN_VIEN_ID = @NHANVIEN_ID,
		@CO_SO_ID = @COSO_ID,
		@CHUC_NANG = @V_FUNCTIONCODE,
		@QUYEN=@V_ISVIEW OUTPUT
	PRINT @V_ISVIEW

	-- BUILD QUERY
	SET @V_SQL = N' 
				SELECT		COUNT(TS.CoSoId) OVER () AS MAXCNT,
							TS.TaiSanId ID,TS.MaTaiSan,TS.TenTaiSan,TS.LoaiKeKhai,
							PB.PhongBanId,PB.MaPhongBan,PB.TenPhongBan,
							NV.NhanVienId,NV.MaNhanVien,NV.TenNhanVien,
							CS.CoSoId,CS.MaCoSo,CS.TenCoSo
				FROM		TheoDoi TD
							LEFT JOIN TaiSan TS ON TD.TaiSanId = TS.TaiSanId
							LEFT JOIN PhongBan PB ON TD.PhongBanId = PB.PhongBanId
							LEFT JOIN NhanVien NV ON TD.NhanVienId = NV.NhanVienId
							LEFT JOIN CoSo CS ON TS.CoSoId = CS.CoSoId
				WHERE		1 = 1 
				'

	-- PHÂN QUYỀN
	IF @V_ISVIEW IN('VE')
	BEGIN 
		SET @V_SQL = @V_SQL + N' AND TD.NhanVienId = ''' + CAST(@NHANVIEN_ID AS VARCHAR) + ''' ';
	END

	IF @V_ISVIEW IN('VR')
	BEGIN 
		SET @V_SQL = @V_SQL + N' AND TD.PhongBanId = ''' + CAST(@V_PHONGBANID AS VARCHAR) + ''' ';
	END

	IF @V_ISVIEW IN('VB')
	BEGIN 
		SET @V_SQL = @V_SQL + N' AND TS.CoSoId = ''' + CAST(@COSO_ID AS VARCHAR) + ''' ';
	END

	-- TÌM KIẾM
	IF @LOAIKEKHAI <> ''
	BEGIN
		SET @V_SQL = @V_SQL + N' AND (@LOAIKEKHAI = '''' OR CHARINDEX(''|'' + CAST(TS.LoaiKeKhai AS VARCHAR(20)) + ''|'', ''|'' + @LOAIKEKHAI + ''|'') > 0) ';
	END

	IF @NHANVIENID <> 0
	BEGIN
		SET @V_SQL = @V_SQL + N' AND (@NHANVIENID = 0 OR TD.NhanVienId = @NHANVIENID) ';
	END

	IF @PHONGBANID <> 0
	BEGIN
		SET @V_SQL = @V_SQL + N' AND (@PHONGBANID = 0 OR TD.PhongBanId = @PHONGBANID) ';
	END

	IF @COSOID <> 0
	BEGIN
		SET @V_SQL = @V_SQL + N' AND (@COSOID = 0 OR TS.CoSoId IN (SELECT CoSoId FROM CoSo WHERE TrucThuoc = @COSOID OR CoSoId = @COSOID)) ';
	END

	IF @SEARCH <> ''
	BEGIN
		SET @V_SQL = @V_SQL + N' AND ( ';
		SET @V_SQL = @V_SQL + N' (CS.MaCoSo LIKE N''%'' + @SEARCH + ''%'' OR CS.TenCoSo LIKE N''%'' + @SEARCH + ''%'') ';
		SET @V_SQL = @V_SQL + N' OR (TS.MaTaiSan LIKE N''%'' + @SEARCH + ''%'' OR TS.TenTaiSan LIKE N''%'' + @SEARCH + ''%'') ';
		SET @V_SQL = @V_SQL + N' OR (PB.MaPhongBan LIKE N''%'' + @SEARCH + ''%'' OR PB.TenPhongBan LIKE N''%'' + @SEARCH + ''%'') ';
		SET @V_SQL = @V_SQL + N' OR (NV.MaNhanVien LIKE N''%'' + @SEARCH + ''%'' OR NV.TenNhanVien LIKE N''%'' + @SEARCH + ''%'') ';
		SET @V_SQL = @V_SQL + N') ';
	END

	IF @ORDERCLAUSE <> ''
		SET @V_SQL = @V_SQL + ' ORDER BY ' + @ORDERCLAUSE

	IF @OrderClause <> '' AND @TAKE <> 0
		SET @V_SQL = @V_SQL + ' OFFSET ' + CAST(@skip AS nvarchar(20)) + ' ROWS FETCH NEXT ' + CAST(@take AS nvarchar(20)) + ' ROWS ONLY '

	print @V_SQL
	exec sp_executesql @V_SQL,N'
			 @NHANVIENID	INT					=	NULL
			,@PHONGBANID	INT					=	NULL
			,@COSOID		INT					=	NULL
			,@LOAIKEKHAI	VARCHAR(MAX)		=	NULL
			,@SEARCH		NVARCHAR(MAX)		=	NULL
			'
			,@NHANVIENID	=	@NHANVIENID
			,@PHONGBANID	=	@PHONGBANID
			,@COSOID		=	@COSOID
			,@LOAIKEKHAI	=	@LOAIKEKHAI
			,@SEARCH		=	@SEARCH
--------------------------------------------------
	SET NOCOUNT OFF;
END
