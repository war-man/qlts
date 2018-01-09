
GO
/****** Object:  StoredProcedure [dbo].[sp_KD_BaoCaoDoanhThu_GetListBaoCaoDoanhThuByCriteria]    Script Date: 12/19/2017 9:43:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROC [dbo].[sp_KD_BaoCaoDoanhThu_GetListBaoCaoDoanhThuByCriteria]
( 
	  @UserId				NVARCHAR(500)	= null			
	, @NhanVienId			NVARCHAR(500)	= null		
	, @Search				NVARCHAR(500)   = null			
	, @SearchLoaiHopDongId	nvarchar(500)   = null			
	, @TuNgay				DATETIME		= null		
	, @DenNgay				DATETIME		= null	
	, @OrderClause			NVARCHAR(500)	= null				
	, @SKIP					INT				= null				-- Số dòng skip (để phân trang)
	, @TAKE					INT				= null				-- Số dòng take (để phân trang)
)
AS  
BEGIN
SET NOCOUNT ON  

------------------------------------------------  
---- Khai báo và chuẩn bị biến
---- Biến nội bộ có tiền tố V_ phía trước
	DECLARE @V_SQL NVARCHAR(4000) 
	DECLARE @V_SEARCH_STRING NVARCHAR(4000) 


	SET @Search = ISNULL(@Search, '')
	SET @SearchLoaiHopDongId = ISNULL(@SearchLoaiHopDongId, '0')
	IF (@SearchLoaiHopDongId = '') SET @SearchLoaiHopDongId = '0'

	IF @Search <> ''
	BEGIN	
		SET @Search = N'' + @Search + ''
		SET @V_SEARCH_STRING = CAST(@Search AS VARCHAR(200))	
	END	
	----------


	-- Chuẩn bị biến @Skip & @Take
	IF (@SKIP IS NULL)
		SET @SKIP = 0;

	IF (@TAKE IS NULL)
		SET @TAKE = 50;
	----------

	-- Chuẩn bị biến @ORDER_CLAUSE
	IF (@OrderClause IS NULL)
		SET @OrderClause = ' MAXCNT ';

	IF (@OrderClause = '')
		SET @OrderClause = ' MAXCNT ';
	----------
	
	--SELECT H.NhanVienId, CONCAT(nvkd.Ho, ' ', nvkd.Ten) TenNhanVien, H.SoHopDong, LHD.TenLoaiHopDong, H.SoTien, H.LoaiHopDongId,
	--		H.NgayHopDong, FORMAT(H.NgayHopDong,'MMyyyy') ThoiGian
	--FROM dbo.KDHopDong H
	--LEFT JOIN dbo.NhanVien nvkd ON nvkd.NhanVienId = H.NhanVienId
	--LEFT JOIN dbo.KDLoaiHopDong LHD ON LHD.LoaiHopDongId = H.LoaiHopDongId
	--WHERE H.TrangThai = 1

---- Xây dựng nội dung câu SQL  
	-- selects all rows from the table according to search criteria
	SET @V_SQL = N'
	SELECT COUNT(*) OVER () AS MAXCNT, ROW_NUMBER() over (order by SoHopDong) STT, H.NhanVienId, nvkd.Ma MaNhanVien, CONCAT(nvkd.Ho, '' '', nvkd.Ten) TenNhanVien, H.SoHopDong, LHD.TenLoaiHopDong, H.SoTien, 
			H.NgayHopDong, 
			CONVERT(VARCHAR, H.NgayHopDong, 103)  ThoiGian
			--FORMAT(H.NgayHopDong,''MMyyyy'') ThoiGian
			, '''' GhiChu
			, CAST(''' + CAST(@TuNgay AS VARCHAR) +''' AS DATE) TuNgay,CAST(''' + CAST(@DenNgay AS VARCHAR) + ''' AS DATE) DeNgay
	FROM dbo.KDHopDong H
	LEFT JOIN dbo.NhanVien nvkd ON nvkd.NhanVienId = H.NhanVienId
	LEFT JOIN dbo.KDLoaiHopDong LHD ON LHD.LoaiHopDongId = H.LoaiHopDongId
	WHERE 1 = 1 and H.TrangThai = 1 and CAST(H.NgayHopDong AS DATE) BETWEEN CAST(''' + CAST(@TuNgay AS VARCHAR) +''' AS DATE) AND CAST(''' + CAST(@DenNgay AS VARCHAR) + ''' AS DATE) ' 

	-- Build Where clause
	-- Where clause Quick search
	
	IF @Search > ''
	SET @V_SQL = @V_SQL + ' and (nvkd.Ma LIKE N''%' +@Search+ '%'' 
								--OR KH.Nam LIKE  N''%' +@Search+ '%'' 
								OR H.SoHopDong LIKE  N''%' +@Search+ '%'') ';							

	IF @SearchLoaiHopDongId <> '0'
	BEGIN
		SET @V_SQL = @V_SQL + ' and H.LoaiHopDongId = ' + @SearchLoaiHopDongId + ' ';
	END
	
	
	--SET @V_SQL = @V_SQL + ' GROUP BY a.NhanVienId,a.MaNhanVien,a.TenNhanVien,a.DienThoai,a.GhiChu,nv.TenNhanVien,a.NgayTao,PB.TenPhongBan '
	-- Build Order clause
	IF @OrderClause > ''
	SET @V_SQL = @V_SQL + ' ORDER BY ' + @OrderClause

	-- Build Skip clause
	SET @V_SQL = @V_SQL + ' ' + 'OFFSET '+ CAST(@Skip AS nvarchar(20)) +' ROWS'

	-- Build Take clause
	SET @V_SQL = @V_SQL + ' ' + 'FETCH NEXT '+CAST(@Take AS nvarchar(20)) +' ROWS ONLY'


---- Thực thi câu SQL
	PRINT(@V_SQL);
	EXEC(@V_SQL)

---- kết thúc và hủy bảng tạm (nếu có)

-----------------------------------------------------
SET NOCOUNT OFF
END

