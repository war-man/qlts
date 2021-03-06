/*************************************************************  
1. Create Date	: 2017.05.24
2. Creator		: NGUYEN THANH BINH
3. Description	: Lấy thông tin hợp đồng của nhân viên
4. Function		: QLDNMAIN/nhanvien/edit
5. Example		: 
					--∬
					exec [sp_QuanLyHopDong_GetListQuanLyHopDongByCriteria]  
					    @NHAN_VIEN_ID			=		'1'
					  , @HOP_DONG_ID			=		''
					  , @LOGIN_ID				=		''

6. Precaution	:
7. History		:
				  2017.05.24(Nguyen Thanh Binh) - Tạo mới
*************************************************************/
ALTER PROC [dbo].[sp_QuanLyHopDong_GetListQuanLyHopDongByCriteria]
(
	  @NHAN_VIEN_ID					NVARCHAR(500)	= NULL			-- nhân viên ID
	, @HOP_DONG_ID					NVARCHAR(500)	= NULL			-- HỢP ĐỒNG ID
	, @LOGIN_ID						NVARCHAR(500)	= NULL
	
	, @ORDER_CLAUSE					NVARCHAR(500)	= NULL			-- Mệnh đề order by (VD: NhanVienId ASC|DESC,HoTen ASC|DESC)
	, @SKIP							INT				= NULL			-- Số dòng skip (để phân trang)
	, @TAKE							INT				= NULL			-- Số dòng take (để phân trang)
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
	DECLARE @V_ORDER_CLAUSE		NVARCHAR(4000)

	-- Chuẩn bị biến @NHAN_VIEN_ID
	SET @NHAN_VIEN_ID = ISNULL(@NHAN_VIEN_ID, '');
	IF (@NHAN_VIEN_ID = '')
		SET @NHAN_VIEN_ID = '0';
	----------

	-- Chuẩn bị biến @HOP_DONG_ID
	SET @HOP_DONG_ID = ISNULL(@HOP_DONG_ID, '');
	IF (@HOP_DONG_ID = '')
		SET @HOP_DONG_ID = '0';
	----------

	-- Chuẩn bị biến @SKIP & @TAKE
	SET @SKIP = ISNULL(@SKIP, '');
	IF (@SKIP = '')
		SET @SKIP = 0;

	SET @TAKE = ISNULL(@TAKE, '');
	IF (@TAKE = '')
		SET @TAKE = 50;
	----------
	
	-- Chuẩn bị biến @ORDER_CLAUSE
	SET @ORDER_CLAUSE = ISNULL(@ORDER_CLAUSE, '');
	IF (@ORDER_CLAUSE = '')
		SET @ORDER_CLAUSE = ' MAXCNT ';
	----------

	SET @V_WHERE_CLAUSE = ' QLHD.XoaYN = ''N'' ';
    
---- Xây dựng nội dung câu SQL  
	-- selects all rows from the table according to search criteria
	SET @V_SQL = N'
		SELECT COUNT(*) OVER () AS MAXCNT,QLHD.CtrVersion QLHD_CTRVERSION,QLHD.QuanLyHopDongId QLHD_ID,QLHD.*,NV.Ho,NV.Ten
		FROM QuanLyHopDong QLHD WITH(NOLOCK, READUNCOMMITTED)
			LEFT JOIN NhanVien NV WITH(NOLOCK, READUNCOMMITTED) ON QLHD.NhanVienId = NV.NhanVienId
	'

	-- Where clause @NHAN_VIEN_ID
	IF @NHAN_VIEN_ID <> '0'
	SET @V_WHERE_CLAUSE = @V_WHERE_CLAUSE + N' AND QLHD.NhanVienId = ''' + @NHAN_VIEN_ID + ''' '
	
	-- Where clause @HOP_DONG_ID
	IF @HOP_DONG_ID <> '0'
	SET @V_WHERE_CLAUSE = @V_WHERE_CLAUSE + N' AND QLHD.QuanLyHopDongId = ''' + @HOP_DONG_ID + ''' '

	-- Build Where clause
	IF @V_WHERE_CLAUSE <> ''
	SET @V_SQL = @V_SQL + ' WHERE ' + @V_WHERE_CLAUSE

	-- Build Order clause
	IF @ORDER_CLAUSE <> ''
	SET @V_SQL = @V_SQL + ' ORDER BY ' + @ORDER_CLAUSE

	-- Build Skip clause
	SET @V_SQL = @V_SQL + ' ' + 'OFFSET '+ CAST(@SKIP AS nvarchar(20)) +' ROWS'

	-- Build Take clause
	SET @V_SQL = @V_SQL + ' ' + 'FETCH NEXT '+CAST(@TAKE AS nvarchar(20)) +' ROWS ONLY'

---- Thực thi câu SQL
	PRINT(@V_SQL);
	EXEC(@V_SQL)

---- kết thúc và hủy bảng tạm (nếu có)

-----------------------------------------------------
SET NOCOUNT OFF
END

