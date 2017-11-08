/*************************************************************  
1. Create Date	: 2017.05.13
2. Creator		: NGUYEN THANH BINH
3. Description	: Lấy tất cả thông tin nhân viên
4. Function		: QLKDMAIN/nhanvien/List
5. Example		: 
					--∬
					exec [sp_NhanVien_GetThongTinNhanVienById]  
					  @NHAN_VIEN_ID			=		'79'

6. Precaution	:
7. History		:
				  2017.05.13(Nguyen Thanh Binh) - Tạo mới
				  2017.07.18(Nguyen Thanh Binh) - BỔ SUNG CHI NHÁNH
*************************************************************/
ALTER PROC [dbo].[sp_NhanVien_GetThongTinNhanVienById]
( 
	  @NHAN_VIEN_ID				nvarchar(500)	= null			-- nhân viên ID
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
	SET @NHAN_VIEN_ID = ISNULL(@NHAN_VIEN_ID, '');
	IF @NHAN_VIEN_ID = ''
		SET @NHAN_VIEN_ID = '0'
	----------

	SET @V_WHERE_CLAUSE = N' NV.XoaYN = ''N'' ';

    
---- Xây dựng nội dung câu SQL  
	-- selects all rows from the table according to search criteria
	SET @V_SQL = N'
	SELECT COUNT(*) OVER () MAXCNT,NV.NhanVienId PCT_ID,NV.CtrVersion PCT_CTRVERSION,NV.*,PB.TenPhongBan,CV.TenChucVu,CN.TenChiNhanh
	FROM NhanVien NV WITH(NOLOCK, READUNCOMMITTED)
	LEFT JOIN PhongBan PB WITH(NOLOCK, READUNCOMMITTED) ON NV.PhongBanId = PB.PhongBanId
	LEFT JOIN ChucVu CV WITH(NOLOCK, READUNCOMMITTED) ON NV.ChucVuId = CV.ChucVuId
	LEFT JOIN ChiNhanh CN WITH(NOLOCK, READUNCOMMITTED) ON NV.ChiNhanhId = CN.ChiNhanhId
	'

	-- Where clause Quick search
	SET @V_WHERE_CLAUSE = @V_WHERE_CLAUSE + N' AND NV.NhanVienId = ''' + @NHAN_VIEN_ID + ''' '
	

	-- Build Where clause
	IF @V_WHERE_CLAUSE > ''
	SET @V_SQL = @V_SQL + ' WHERE ' + @V_WHERE_CLAUSE

---- Thực thi câu SQL
	-- print(@V_SQL);
	EXEC(@V_SQL)

---- kết thúc và hủy bảng tạm (nếu có)

-----------------------------------------------------
SET NOCOUNT OFF
END


