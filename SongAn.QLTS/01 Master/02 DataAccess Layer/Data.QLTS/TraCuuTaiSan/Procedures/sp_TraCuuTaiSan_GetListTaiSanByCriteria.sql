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
						,@COSOID		=	16
						,@LOAIKEKHAI	=	''
						,@SEARCH		=	N''
						,@SKIP			=	0
						,@TAKE			=	0
						,@ORDERCLAUSE	=	''
						,@NHANVIEN_ID	=	10
						,@COSO_ID		=	16
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
			,@_COSO_IDS			NVARCHAR(MAX)	=	NULL
			,@V_FUNCTIONCODE	NVARCHAR(MAX)	=	'CN0037'
			,@V_PHONGBANID		INT				=	0
			,@V_ISVIEW			VARCHAR(10)		=	''
	
	-- SET DEFAULT
	SET @SEARCH = ISNULL(@SEARCH, '')
	SET @NHANVIENID = ISNULL(@NHANVIENID, 0)
	SET @PHONGBANID = ISNULL(@PHONGBANID, 0)
	SET @COSO_ID = ISNULL(@COSO_ID, 0)
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
	--/ KIỂM TRA QUYỀN VIEW

	IF @V_ISVIEW = 'VB' AND @COSOID = 0
		SET @COSOID = @COSO_ID

	-- DANH SÁCH CƠ SỞ TRƯC THUỘC
	EXEC [dbo].[sp_CoSo_GetListCoSoTrucThuocById]
		 @COSOID=@COSOID
		,@COSOID_OUT=@_COSO_IDS OUTPUT
	PRINT @_COSO_IDS
	SET @_COSO_IDS = REPLACE(@_COSO_IDS,',','|')
	--/ DANH SÁCH CƠ SỞ TRƯC THUỘC

	-- BUILD QUERY
	SET @V_SQL = N' 
				SELECT		 COUNT(TS.CoSoId) OVER () AS MAXCNT
							,TD.Nam
							,TS.TaiSanId ID,TS.MaTaiSan,TS.TenTaiSan,TS.LoaiKeKhai
							,PB.PhongBanId,PB.MaPhongBan,PB.TenPhongBan
							,NV.NhanVienId,NV.MaNhanVien,NV.TenNhanVien
							,CS.CoSoId,CS.MaCoSo,CS.TenCoSo
							,(TD.SLTon + TD.SLTang - TD.SLGiam) SoLuong
							,SUM(NG.GiaTri) NguyenGia,SUM(NG.GiaTri)*(TD.SLTon + TD.SLTang - TD.SLGiam) ThanhTien
				FROM		TheoDoi TD
							LEFT JOIN TaiSan TS ON TD.TaiSanId = TS.TaiSanId
							LEFT JOIN PhongBan PB ON TD.PhongBanId = PB.PhongBanId
							LEFT JOIN NhanVien NV ON TD.NhanVienId = NV.NhanVienId
							LEFT JOIN CoSo CS ON TS.CoSoId = CS.CoSoId
							LEFT JOIN NguyenGia NG ON NG.TaiSanId = TD.TaiSanId
				WHERE		1 = 1 
				'

	-- PHÂN QUYỀN
	IF @V_ISVIEW IN('VE')
	BEGIN 
		SET @V_SQL = @V_SQL + N' AND (@NHANVIEN_ID = 0 OR TD.NhanVienId = @NHANVIEN_ID) ';
	END

	IF @V_ISVIEW IN('VR')
	BEGIN 
		SET @V_SQL = @V_SQL + N' AND (PHONGBANID = 0 OR TD.PhongBanId = @PHONGBANID) ';
	END

	IF @V_ISVIEW IN('VB')
	BEGIN 
		SET @V_SQL = @V_SQL + N' AND (@COSO_ID = 0 OR charindex(''|''+cast(TS.CoSoId as varchar(10))+''|'',''|'+@_COSO_IDS+'|'') > 0) ';
	END

	IF @V_ISVIEW IN('VA')
	BEGIN 
		SET @V_SQL = @V_SQL + N' AND (@COSOID = 0 OR charindex(''|''+cast(TS.CoSoId as varchar(10))+''|'',''|'+@_COSO_IDS+'|'') > 0) ';
	END
	--/ PHÂN QUYỀN

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

	IF @SEARCH <> ''
	BEGIN
		SET @V_SQL = @V_SQL + N' AND ( ';
		SET @V_SQL = @V_SQL + N' (CS.MaCoSo LIKE N''%'' + @SEARCH + ''%'' OR CS.TenCoSo LIKE N''%'' + @SEARCH + ''%'') ';
		SET @V_SQL = @V_SQL + N' OR (TS.MaTaiSan LIKE N''%'' + @SEARCH + ''%'' OR TS.TenTaiSan LIKE N''%'' + @SEARCH + ''%'') ';
		SET @V_SQL = @V_SQL + N' OR (PB.MaPhongBan LIKE N''%'' + @SEARCH + ''%'' OR PB.TenPhongBan LIKE N''%'' + @SEARCH + ''%'') ';
		SET @V_SQL = @V_SQL + N' OR (NV.MaNhanVien LIKE N''%'' + @SEARCH + ''%'' OR NV.TenNhanVien LIKE N''%'' + @SEARCH + ''%'') ';
		SET @V_SQL = @V_SQL + N') ';
	END

	SET @V_SQL = @V_SQL + N' GROUP BY
		 TD.Nam,TS.CoSoId
		,TS.TaiSanId,TS.MaTaiSan,TS.TenTaiSan,TS.LoaiKeKhai
		,PB.PhongBanId,PB.MaPhongBan,PB.TenPhongBan
		,NV.NhanVienId,NV.MaNhanVien,NV.TenNhanVien
		,CS.CoSoId,CS.MaCoSo,CS.TenCoSo
		,TD.SLTon,TD.SLTang,TD.SLGiam 
	';

	IF @ORDERCLAUSE <> ''
		SET @V_SQL = @V_SQL + ' ORDER BY ' + @ORDERCLAUSE

	IF @OrderClause <> '' AND @TAKE <> 0
		SET @V_SQL = @V_SQL + ' OFFSET ' + CAST(@skip AS nvarchar(20)) + ' ROWS FETCH NEXT ' + CAST(@take AS nvarchar(20)) + ' ROWS ONLY '

	print @V_SQL
	exec sp_executesql @V_SQL,N'
			 @NHANVIENID	INT					=	NULL
			,@PHONGBANID	INT					=	NULL
			,@COSOID		INT					=	NULL
			,@COSO_ID		INT					=	NULL
			,@LOAIKEKHAI	VARCHAR(MAX)		=	NULL
			,@SEARCH		NVARCHAR(MAX)		=	NULL
			'
			,@NHANVIENID	=	@NHANVIENID
			,@PHONGBANID	=	@PHONGBANID
			,@COSOID		=	@COSOID
			,@COSO_ID		=	@COSO_ID
			,@LOAIKEKHAI	=	@LOAIKEKHAI
			,@SEARCH		=	@SEARCH
--------------------------------------------------
	SET NOCOUNT OFF;
END
