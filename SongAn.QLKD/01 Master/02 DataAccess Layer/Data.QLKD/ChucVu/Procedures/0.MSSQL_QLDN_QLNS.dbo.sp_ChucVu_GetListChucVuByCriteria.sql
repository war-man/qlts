/*************************************************************  
1. Create Date	: 2017.04.15
2. Creator		: NGUYEN THANH BINH
3. Description	: Lấy danh sách Nhân viên theo điều kiện
4. Function		: QLKDMAIN/nhanvien/List
5. Example		: 
					--∬
					exec [sp_ChucVu_GetListChucVuByCriteria]  
					  @FIELD			='CV.*,NV.Ho,NV.Ten'
					, @SEARCH_STRING	= N''
					, @ORDER_CLAUSE		= ''
					, @SKIP				= 0
					, @TAKE				= 10

6. Precaution	:
7. History		:
				  2017.04.19(Nguyen Thanh Binh) - Tạo mới
*************************************************************/
ALTER PROC [dbo].[sp_ChucVu_GetListChucVuByCriteria]
( 
	  @FIELD			nvarchar(500)	= null			-- Danh sách các field cần lấy
	, @SEARCH_STRING	nvarchar(500)	= null			-- quick search.
	, @ORDER_CLAUSE		nvarchar(500)	= null			-- Mệnh đề order by
	, @SKIP				int				= null			-- Số dòng skip (để phân trang)
	, @TAKE				int				= null			-- Số dòng take (để phân trang)
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
	DECLARE @V_WHERE_CLAUSE NVARCHAR(4000) 

	-- Chuẩn bị biến @FIELD
	SET @FIELD = ISNULL(@FIELD, '');

	IF (@FIELD = '')
	SET @FIELD = '*';

	SET @SEARCH_STRING = ISNULL(@SEARCH_STRING, '')
	IF @SEARCH_STRING <> ''
	BEGIN	
		SET @SEARCH_STRING = N'%' + @SEARCH_STRING + '%'
		SET @V_SEARCH_STRING = CAST(@SEARCH_STRING AS VARCHAR(200))	
	END	
	----------

	SET @V_WHERE_CLAUSE = N' WHERE CV.XoaYN=''N'' ';

	-- Chuẩn bị biến @Skip & @Take
	IF (@SKIP IS NULL)
		SET @SKIP = 0;

	IF (@TAKE IS NULL)
		SET @TAKE = 50;
	----------

	-- Chuẩn bị biến @ORDER_CLAUSE
	IF (@ORDER_CLAUSE IS NULL)
		SET @ORDER_CLAUSE = ' MAXCNT ';

	IF (@ORDER_CLAUSE = '')
		SET @ORDER_CLAUSE = ' MAXCNT ';
	----------

    
---- Xây dựng nội dung câu SQL  
	-- selects all rows from the table according to search criteria
	SET @V_SQL = N'
	SELECT COUNT(*) OVER () AS MAXCNT, ' + @FIELD + '
	FROM ChucVu CV WITH(NOLOCK, READUNCOMMITTED)
	LEFT JOIN NhanVien NV WITH(NOLOCK, READUNCOMMITTED) ON CV.NguoiTao = NV.NhanVienId
	'

	-- Build Where clause
	-- Where clause Quick search
	IF @SEARCH_STRING <> ''
	BEGIN
		SET @V_WHERE_CLAUSE = @V_WHERE_CLAUSE + N' AND (MaChucVu LIKE ''' + @V_SEARCH_STRING + ''' OR TenChucVu LIKE N''' + @SEARCH_STRING + N''' OR TenChucVu LIKE ''' + @V_SEARCH_STRING + ''') '
	END
	
	
	SET @V_SQL = @V_SQL +  @V_WHERE_CLAUSE

	-- Build Order clause
	IF @ORDER_CLAUSE > ''
	SET @V_SQL = @V_SQL + ' ORDER BY ' + @ORDER_CLAUSE

	-- Build Skip clause
	SET @V_SQL = @V_SQL + ' ' + 'OFFSET '+ CAST(@Skip AS nvarchar(20)) +' ROWS'

	-- Build Take clause
	SET @V_SQL = @V_SQL + ' ' + 'FETCH NEXT '+CAST(@Take AS nvarchar(20)) +' ROWS ONLY'


---- Thực thi câu SQL
	
	EXEC(@V_SQL)

---- kết thúc và hủy bảng tạm (nếu có)

-----------------------------------------------------
SET NOCOUNT OFF
END

