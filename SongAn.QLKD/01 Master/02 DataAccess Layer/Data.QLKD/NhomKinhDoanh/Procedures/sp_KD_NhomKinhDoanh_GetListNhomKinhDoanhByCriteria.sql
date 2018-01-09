USE [MSSQL_QLDN_QLNS_DEMO]
GO
/****** Object:  StoredProcedure [dbo].[sp_KD_NhomKinhDoanh_GetListNhomKinhDoanhByCriteria]    Script Date: 12/19/2017 10:06:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROC [dbo].[sp_KD_NhomKinhDoanh_GetListNhomKinhDoanhByCriteria]
( 
	  @Search					nvarchar(500)	= null			
	, @NhanVienId				nvarchar(500)	= null			
	, @UserId					nvarchar(500)	= null			
	, @Skip						nvarchar(500)	= null			
	, @Take						nvarchar(500)	= null			
)
AS  
BEGIN
SET NOCOUNT ON  
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
------------------------------------------------  
---- Khai báo và chuẩn bị biến
---- Biến nội bộ có tiền tố V_ phía trước
	DECLARE @V_SQL				NVARCHAR(4000) 
	DECLARE @V_FIELD			NVARCHAR(4000)
	DECLARE @V_SEARCH_STRING	NVARCHAR(4000) 
	DECLARE @V_WHERE_CLAUSE		NVARCHAR(4000) 
	DECLARE @V_GROUP_BY			NVARCHAR(4000)
	DECLARE @V_MA_TRANG_THAI	NVARCHAR(4000)
	DECLARE @V_ORDER_CLAUSE		NVARCHAR(4000)

	SET		@V_WHERE_CLAUSE		= N' WHERE 1=1 ';
	SET		@V_FIELD			= ISNULL(@V_FIELD, '');
	SET		@V_ORDER_CLAUSE		= ISNULL(@V_ORDER_CLAUSE,'');

	-- Chuẩn bị biến @SKIP & @TAKE
	SET @SKIP = ISNULL(@SKIP, '');
	IF (@SKIP = '')
		SET @SKIP = 0;

	SET @TAKE = ISNULL(@TAKE, '');
	IF (@TAKE = '')
		SET @TAKE = 50;
	----------


---- Xây dựng nội dung câu SQL  
	-- selects all rows from the table according to search criteria
	SET @V_SQL = N'
	SELECT COUNT(*) OVER () AS MAXCNT,a.NhomKinhDoanhId,a.MaNhomKinhDoanh,a.TenNhomKinhDoanh,a.QuanLy,a.SoluongNhanVien,a.NgayTao,a.CtrVersion,(b.Ho +'' ''+ b.Ten)  as TenQuanLy,(nv.Ho +'' ''+ nv.Ten) as NguoiTao
	FROM KDNhomKinhDoanh a 
	LEFT JOIN NhanVien b on a.QuanLy=b.NhanVienId 
	LEFT JOIN NhanVien nv on a.NguoiTao=nv.NhanVienId 	'
	-- Where clause Quick search
	IF @Search <> ''
	BEGIN
		SET @V_WHERE_CLAUSE = @V_WHERE_CLAUSE + N' AND (
		a.MaNhomKinhDoanh LIKE N''%' + @Search + '%'' 
		OR a.TenNhomKinhDoanh LIKE N''%' + @Search + '%'' ) '
	END


	
	SET @V_SQL = @V_SQL + ' ' + @V_WHERE_CLAUSE

	SET @V_SQL = @V_SQL + ' ORDER BY a.MaNhomKinhDoanh ' 

	-- Build Skip clause
	SET @V_SQL = @V_SQL + ' ' + 'OFFSET '+ CAST(@SKIP AS nvarchar(20)) +' ROWS'

	-- Build Take clause
	SET @V_SQL = @V_SQL + ' ' + 'FETCH NEXT '+CAST(@TAKE AS nvarchar(20)) +' ROWS ONLY'


---- Thực thi câu SQL
	print @V_SQL
	EXEC(@V_SQL)

---- kết thúc và hủy bảng tạm (nếu có)

-----------------------------------------------------
SET NOCOUNT OFF
END



