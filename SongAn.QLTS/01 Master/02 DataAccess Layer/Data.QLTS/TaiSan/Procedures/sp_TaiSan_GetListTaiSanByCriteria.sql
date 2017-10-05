/**************************************************
1. Create Date	: 2017.09.05
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: DANH SÁCH TÀI SẢN
4. Function		: 
5. Example		: 
					DECLARE @MESSAGE	NVARCHAR(MAX)
					EXEC [sp_TaiSan_GetListTaiSanByCriteria]
						 @SEARCH_STRING		=	N'q'
						,@SKIP				=	''
						,@TAKE				=	''
						,@OrderClause		=	'MAXCNT ASC'
						,@CoSoId			=	1
						,@NhanVienId		=	6
						,@MESSAGE			=	@MESSAGE OUTPUT
					SELECT	@MESSAGE MESSAGE
6. Precaution	:
7. History		:
				  2017.09.05 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
ALTER PROCEDURE [dbo].[sp_TaiSan_GetListTaiSanByCriteria]
	 @SEARCH_STRING		NVARCHAR(MAX)	=	NULL
	,@SEARCH_MATAISAN	NVARCHAR(MAX)	=	NULL
	,@SEARCH_TENTAISAN	NVARCHAR(MAX)	=	NULL
	,@SKIP				INT				=	NULL
	,@TAKE				INT				=	NULL
	,@OrderClause		NVARCHAR(MAX)	=	NULL				
	,@CoSoId			INT				=	NULL
	,@NhanVienId		INT				=	NULL
	,@MESSAGE			NVARCHAR(MAX)		OUTPUT
AS  
BEGIN
SET NOCOUNT ON  
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
------------------------------------------------  
---- Khai báo và chuẩn bị biến
---- Biến nội bộ có tiền tố V_ phía trước
	DECLARE @V_SQL				NVARCHAR(MAX) 
	DECLARE @V_SEARCH_STRING	NVARCHAR(MAX) 

	SET @SKIP = ISNULL(@SKIP, 0)
	SET @TAKE = ISNULL(@TAKE, 0)
	IF @TAKE = 0
		SET @TAKE = 10
	
	SET @CoSoId = ISNULL(@CoSoId, 0)

	SET @NhanVienId = ISNULL(@NhanVienId, '')
	IF @NhanVienId = ''
		SET @NhanVienId = 0
	
	SET @SEARCH_MATAISAN = ISNULL(@SEARCH_MATAISAN, '')
	SET @SEARCH_TENTAISAN = ISNULL(@SEARCH_TENTAISAN, '')

	SET @SEARCH_STRING = ISNULL(@SEARCH_STRING, '')
	IF @SEARCH_STRING <> ''
	BEGIN	
		SET @SEARCH_STRING = N'%' + @SEARCH_STRING + '%'
		SET @V_SEARCH_STRING = CAST(@SEARCH_STRING AS VARCHAR(200))	
	END	
	----------

	DECLARE @IS_VIEW varchar(10) = '0'
	EXEC [QLTS_MAIN].dbo.[sp_QuyenTacVu_CheckQuyenTacVuByChucNang]
		@NHAN_VIEN_ID = @NhanVienId,
		@CO_SO_ID = @CoSoId,
		@CHUC_NANG = 'CN0022',
		@QUYEN=@IS_VIEW OUTPUT

	-- Chuẩn bị biến @ORDER_CLAUSE
	SET @OrderClause = ISNULL(@OrderClause, '')
	IF (@OrderClause = '')
		SET @OrderClause = ' MAXCNT ';
	----------

    
---- Xây dựng nội dung câu SQL  
	-- selects all rows from the table according to search criteria
	SET @V_SQL = N'
	SELECT	COUNT(TS.TaiSanId) OVER () AS MAXCNT, TS.*,l.TenLoai,n.TenNhom,h.TenHangSanXuat,nc.TenNuocSanXuat,ISNULL(NG.NguyenGia,0) NguyenGia 
	FROM	TaiSan TS 
			LEFT JOIN (
				select		TaiSanId, SUM(GiaTri) NguyenGia
				from		NguyenGia
				GROUP BY	TaiSanId
			) NG ON TS.TaiSanId = NG.TaiSanId
			LEFT JOIN LoaiTaiSan l ON TS.LoaiId=l.LoaiId
			LEFT JOIN NhomTaiSan n ON l.NhomId=n.NhomId
			LEFT JOIN HangSanXuat h ON TS.HangSanXuatId=h.HangSanXuatId
			LEFT JOIN NuocSanXuat nc ON TS.NuocSanXuatId=nc.NuocSanXuatId
			LEFT JOIN NhanVien NV ON TS.NguoiTao=NV.NhanVienId
	WHERE	1=1 ' 

	-- Build Where clause
	-- Where clause Quick search

	IF @SEARCH_STRING <> ''
	SET @V_SQL = @V_SQL + N' AND (TS.MaTaiSan LIKE N''' +@SEARCH_STRING+ ''' OR TS.TenTaiSan LIKE  N''' +@SEARCH_STRING+ ''')';

	IF @SEARCH_MATAISAN <> ''
	SET @V_SQL = @V_SQL + N' AND (TS.MaTaiSan LIKE N''%' + @SEARCH_MATAISAN + '%'')';

	IF @SEARCH_TENTAISAN <> ''
	SET @V_SQL = @V_SQL + N' AND (TS.TenTaiSan LIKE N''%' +@SEARCH_TENTAISAN+ '%'')';

	IF @IS_VIEW = 'VB' 
	BEGIN    
		SET @V_SQL = @V_SQL + ' and TS.CoSoId =''' + @CoSoId + '''';   
	END
	IF @IS_VIEW = 'VR' 
	BEGIN    
		SET @V_SQL = @V_SQL + ' and NV.PhongBanId = NV.PhongBanId';   
	END
	IF @IS_VIEW = 'VE' 
	BEGIN    
		SET @V_SQL = @V_SQL + ' and TS.NguoiTao =''' + @NhanVienId + '''';   
	END

	-- Build Order clause
	IF @OrderClause > ''
	SET @V_SQL = @V_SQL + ' ORDER BY ' + @OrderClause

	-- Build Skip clause
	SET @V_SQL = @V_SQL + ' ' + 'OFFSET '+ CAST(@SKIP AS NVARCHAR(20)) +' ROWS'

	-- Build Take clause
	SET @V_SQL = @V_SQL + ' ' + 'FETCH NEXT '+CAST(@TAKE AS NVARCHAR(20)) +' ROWS ONLY'


---- Thực thi câu SQL
	PRINT(@V_SQL);
	EXEC(@V_SQL)

---- kết thúc và hủy bảng tạm (nếu có)

-----------------------------------------------------
SET NOCOUNT OFF
END

