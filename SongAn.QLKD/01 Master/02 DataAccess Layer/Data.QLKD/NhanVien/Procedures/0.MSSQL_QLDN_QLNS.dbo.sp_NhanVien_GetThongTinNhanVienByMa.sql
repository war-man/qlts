/*************************************************************  
1. Create Date	: 2017.05.15
2. Creator		: NGUYEN THANH BINH
3. Description	: Lấy thông tin nhân viên bằng Mã
4. Function		: QLKDMAIN/nhanvien/create
5. Example		: 
					--∬
					exec [sp_NhanVien_GetThongTinNhanVienByMa]  
					  @MA			=		'NV0001'

6. Precaution	:
7. History		:
				  2017.05.15(Nguyen Thanh Binh) - Tạo mới
*************************************************************/
ALTER PROC [dbo].[sp_NhanVien_GetThongTinNhanVienByMa]
( 
	  @MA				nvarchar(500)	= null			-- nhân viên ID
)
AS  
BEGIN
SET NOCOUNT ON  
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
------------------------------------------------  
---- Khai báo và chuẩn bị biến
---- Biến nội bộ có tiền tố V_ phía trước
	DECLARE @V_SQL				NVARCHAR(4000)
	DECLARE @V_WHERE_CLAUSE		NVARCHAR(4000)

	-- Chuẩn bị biến @FIELD
	SET @MA = ISNULL(@MA, '');
	----------

	SET @V_WHERE_CLAUSE = N' 1=1 ';

    
---- Xây dựng nội dung câu SQL  
	-- selects all rows from the table according to search criteria
	SET @V_SQL = N'
	SELECT COUNT(*) OVER () MAXCNT,NV.NhanVienId PCT_ID,NV.CtrVersion PCT_CTRVERSION,NV.*,PB.TenPhongBan
	FROM NhanVien NV WITH(NOLOCK, READUNCOMMITTED)
	LEFT JOIN PhongBan PB WITH(NOLOCK, READUNCOMMITTED) ON NV.PhongBanId = PB.PhongBanId
	'

	-- Where clause @MA
	SET @V_WHERE_CLAUSE = @V_WHERE_CLAUSE + N' AND NV.Ma = ''' + @MA + ''' '
	

	-- Build Where clause
	IF @V_WHERE_CLAUSE > ''
	SET @V_SQL = @V_SQL + ' WHERE ' + @V_WHERE_CLAUSE

---- Thực thi câu SQL
	PRINT(@V_SQL);
	EXEC(@V_SQL)

---- kết thúc và hủy bảng tạm (nếu có)

-----------------------------------------------------
SET NOCOUNT OFF
END

