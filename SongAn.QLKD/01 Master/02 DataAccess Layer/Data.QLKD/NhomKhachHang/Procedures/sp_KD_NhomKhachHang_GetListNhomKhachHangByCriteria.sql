USE [MSSQL_QLDN_QLNS_DEMO]
GO
/****** Object:  StoredProcedure [dbo].[sp_KD_NhomKhachHang_GetListNhomKhachHangByCriteria]    Script Date: 12/19/2017 10:06:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROC [dbo].[sp_KD_NhomKhachHang_GetListNhomKhachHangByCriteria]
( 
	  @UserId	        nvarchar(500)	= null			
	, @NhanVienId	    nvarchar(500)	= null		
	, @Search			nvarchar(500)   = null			
	, @OrderClause		nvarchar(500)	= null				
	, @SKIP				int				= null				-- Số dòng skip (để phân trang)
	, @TAKE				int				= null				-- Số dòng take (để phân trang)
)
AS  
BEGIN
SET NOCOUNT ON  

------------------------------------------------  
---- Khai báo và chuẩn bị biến
---- Biến nội bộ có tiền tố V_ phía trước
	DECLARE @V_SQL NVARCHAR(4000) 
	DECLARE @V_SEARCH_STRING NVARCHAR(4000) 
	DECLARE @TenPhongBan NVARCHAR(max)


	SET @Search = ISNULL(@Search, '')
	IF @Search <> ''
	BEGIN	
		--SET @Search = N'%' + @Search + '%'
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
	DECLARE @IS_VIEW_ALL varchar = '0'
     ----------
	exec MSSQL_QLDN_MAIN_DEMO.dbo.[sp_KD_QuyenTacVu_CheckQuyenTacVuByChucNang]
	@LOGIN_ID = @UserId,
	@CHUC_NANG = 'KD0001',
	@QUYEN_TAC_VU = 'View All',
	@YES_NO=@IS_VIEW_ALL OUTPUT


---- Xây dựng nội dung câu SQL  
	-- selects all rows from the table according to search criteria
	SET @V_SQL = N'
	SELECT CONCAT(NV.Ho,'' '',NV.Ten) AS TenNguoiTao,
			NKH.NhomKhachHangId, NKH.MaNhom, NKH.TenNhom, NKH.NgayTao
	FROM dbo.KDNhomKhachHang NKH
	LEFT JOIN dbo.NhanVien Nv ON nv.NhanVienId = nkh.NguoiTao
	WHERE 1=1  ' 
	
	-- Build Where clause
	-- Where clause Quick search
	
	IF @Search > ''
	SET @V_SQL = @V_SQL + ' and (NKH.MaNhom LIKE N''%' +@Search+ '%'' 
								OR NKH.TenNhom LIKE  N''%' +@Search+ '%'')';
	

	IF @IS_VIEW_ALL = '0' 
	BEGIN  
		SET @V_SQL = @V_SQL + '  and NKH.NguoiTao =''' + @NhanVienId + ''' ';
	END


	--SET @V_SQL = @V_SQL + ' GROUP BY a.NhanVienId,a.MaNhanVien,a.TenNhanVien,a.DienThoai,a.GhiChu,nv.TenNhanVien,a.NgayTao,PB.TenPhongBan '
	-- Build Order clause
	IF @OrderClause > ''
	SET @V_SQL = @V_SQL + ' ORDER BY NKH.NgayTao desc,' + @OrderClause

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

