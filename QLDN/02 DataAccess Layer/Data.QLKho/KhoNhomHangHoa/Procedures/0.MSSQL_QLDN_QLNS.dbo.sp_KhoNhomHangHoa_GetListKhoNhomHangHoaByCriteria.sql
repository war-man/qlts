ALTER PROC [dbo].[sp_KhoNhomHangHoa_GetListKhoNhomHangHoaByCriteria]
( 
	@FieldsField	nvarchar(500)	= null			-- Danh sách các field cần lấy
	, @WhereClause nvarchar(500) = null
	--, @WhereClause	nvarchar(500)	= null			
	, @SEARCH_STRING	nvarchar(500)	= null			
	, @OrderClause		nvarchar(500)	= null				
	, @SKIP				int				= null				-- Số dòng skip (để phân trang)
	, @TAKE				int				= null				-- Số dòng take (để phân trang)
)
AS  
BEGIN
SET NOCOUNT ON  
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
------------------------------------------------  
---- Khai báo và chuẩn bị biến
---- Biến nội bộ có tiền tố V_ phía trước
	DECLARE @V_SQL NVARCHAR(4000) 
	DECLARE @V_SEARCH_STRING NVARCHAR(4000) 

	-- Chuẩn bị biến @FIELD
	IF (@FieldsField IS NULL)
	SET @FieldsField = '*';

	IF (@FieldsField = '')
	SET @FieldsField = '*';

	SET @SEARCH_STRING = ISNULL(@SEARCH_STRING, '')
	IF @SEARCH_STRING <> ''
	BEGIN	
		SET @SEARCH_STRING = N'%' + @SEARCH_STRING + '%'
		SET @V_SEARCH_STRING = CAST(@SEARCH_STRING AS VARCHAR(200))	
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

    
---- Xây dựng nội dung câu SQL  
	-- selects all rows from the table according to search criteria
	SET @V_SQL = N'
	SELECT COUNT(*) OVER () AS MAXCNT,a.NhomHangHoaId,a.MaNhom,a.TenNhom,a.MoTa,b.HoTen as NguoiTao,a.NgayTao,a.XoaYN
	FROM [MSSQL_QLDN_QLNS_DEMO].[dbo].[KhoNhomHangHoa] a LEFT JOIN [MSSQL_QLDN_MAIN].[dbo].[NguoiDung] b on a.NguoiTao=b.NhanVienId' 

	-- Build Where clause
	-- Where clause Quick search

	SET @V_SQL = @V_SQL + ' WHERE XoaYN = ''N'' ' 
	IF @WhereClause > ''
	SET @V_SQL = @V_SQL + ' AND MaNhom LIKE N''%'+@WhereClause+'%'' OR TenNhom LIKE N''%'+@WhereClause+'%''' 

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
