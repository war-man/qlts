/*************************************************************  
1. Create Date	: 2017.06.12
2. Creator		: NGUYEN THANH BINH
3. Description	: API CHO GIAO DIỆN NHÂN VIÊN LIST
4. Function		: QLKDMAIN/nhanvien/List
5. Example		: 
					--∬
					exec [sp_NhanVien_GetListNhanVienByCriteriaList]  
					  @FIELD					= ''
					, @SEARCH_STRING			= N'NGUYỄN THANH'
					, @NGAY_FROM				= ''
					, @NGAY_TO					= ''
					, @XOA						= ''
					, @NHAN_VIEN				= ''
					, @MA_FORM					= 'FM0001'
					, @PHONG_BAN				= ''
					, @DU_AN					= ''
					, @CHUC_VU					= ''
					, @DANG_LAM_VIEC			= '1'
					, @MA_TRANG_THAI			= ''
					, @LOGIN_ID					= ''
					, @ORDER_CLAUSE				= ''
					, @SKIP						= 0
					, @TAKE						= 100

6. Precaution	:
7. History		:
				  2017.06.12 (NGUYEN THANH BINH) - Tạo mới
*************************************************************/
ALTER PROCEDURE [dbo].[sp_NhanVien_GetListNhanVienByCriteriaList]
( 
	  @FIELD					nvarchar(500)	= null			-- Danh sách các field cần lấy

	, @SEARCH_STRING			nvarchar(500)	= null			-- quick search. VD: NhanVienId='Nguyễn Thanh Bình' OR HoTen='Nguyễn Thanh Bình' ...
	, @NGAY_FROM				nvarchar(500)	= null			-- 
	, @NGAY_TO					nvarchar(500)	= null			-- 
	, @NHAN_VIEN				nvarchar(500)	= null			-- nhận ds nhân viên id. VD: 1|2
	, @MA_FORM					nvarchar(500)	= null			-- nhận mã form trong cấu hình form cột
	, @PHONG_BAN				nvarchar(500)	= null			-- nhận ds phòng ban ID. VD: 1|2
	, @DU_AN					nvarchar(500)	= null			-- nhận ds dự án ID. VD: 2
	, @CHUC_VU					nvarchar(500)	= null			-- nhận ds chuc vu ID. VD: 3
	, @DANG_LAM_VIEC			BIT				= null			-- nhận trạng thái đang làm việc. VD: true
	, @LOGIN_ID					nvarchar(500)	= null			-- ID nhân viên đăng nhập.
	, @MA_TRANG_THAI			varchar(20)		= null			-- nhận trạng thái. VD: NV_DL, ...
	, @XOA						varchar(20)		= null			-- nhân viên bị xóa hay không. VD: NV_DL, ...
		
	, @ORDER_CLAUSE				nvarchar(500)	= null			-- Mệnh đề order by (VD: NhanVienId ASC|DESC,HoTen ASC|DESC)

	, @SKIP						int				= null			-- Số dòng skip (để phân trang)
	, @TAKE						int				= null			-- Số dòng take (để phân trang)
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

	SET		@V_WHERE_CLAUSE		= N' NV.XoaYN=''N'' ';
	SET		@V_FIELD			= ISNULL(@V_FIELD, '');
	SET		@V_ORDER_CLAUSE		= ISNULL(@V_ORDER_CLAUSE,'');

	-- Chuẩn bị biến @FIELD
	SET @FIELD = ISNULL(@FIELD, '');

	-- KIỂM TRA @SEARCH_STRING
	SET @SEARCH_STRING = ISNULL(@SEARCH_STRING, '')
	IF @SEARCH_STRING <> ''
	BEGIN	
		--SET @SEARCH_STRING = N'%' + @SEARCH_STRING + '%'
		SET @V_SEARCH_STRING = CAST(@SEARCH_STRING AS VARCHAR(200))	
	END	

	-- KIỂM TRA @NGAY_FROM, @NGAY_TO
	SET @NGAY_FROM = ISNULL(@NGAY_FROM, '')
	SET @NGAY_TO = ISNULL(@NGAY_TO, '')

	--
	SET @MA_TRANG_THAI = ISNULL(@MA_TRANG_THAI,'');

	-- KIỂM TRA @DANG_LAM_VIEC
	-- SET @V_MA_TRANG_THAI = ISNULL(@DANG_LAM_VIEC,N'');


	IF(@DANG_LAM_VIEC IS NULL)
	BEGIN
		SET @V_MA_TRANG_THAI = @MA_TRANG_THAI;
	END
	ELSE
	BEGIN
		SET @V_MA_TRANG_THAI = N'NV_DL';
	END
	
	-- KIỂM TRA @XOA
	SET @XOA	=	ISNULL(@XOA, '');
	IF(@XOA <> 'Y' AND @XOA <> 'N')
	BEGIN
		SET @XOA	=	'';
	END
	----------

	-- KIỂM TRA @LOGIN_ID
	SET @LOGIN_ID	=	ISNULL(@LOGIN_ID, 0);
	--IF(@LOGIN_ID = '')
	--	SET @LOGIN_ID	=	0;
	----------

	------ Check User has ViewAll whether or not
    DECLARE @IS_VIEW_ALL varchar = '0'
 
  	exec [MSSQL_QLKD_MAIN_DEMO].dbo.[sp_QuyenTacVu_CheckQuyenTacVuByChucNang]
		@LOGIN_ID = @LOGIN_ID,
		@CHUC_NANG = 'CN0001',
		@QUYEN_TAC_VU = 'View All',
		@YES_NO=@IS_VIEW_ALL OUTPUT

	--IF @LOGIN_ID = 0
	--	SET @IS_VIEW_ALL = '1'

		-- print '@IS_VIEW_ALL:'+@IS_VIEW_ALL
  ---------------------------------------------------

	-- Chuẩn bị biến @SKIP & @TAKE
	SET @SKIP = ISNULL(@SKIP, '');
	IF (@SKIP = '')
		SET @SKIP = 0;

	SET @TAKE = ISNULL(@TAKE, '');
	IF (@TAKE = '')
		SET @TAKE = 50;
	----------

	-- Chuẩn bị biến @ORDER_CLAUSE
	IF (@ORDER_CLAUSE IS NULL)
		SET @ORDER_CLAUSE = '';

	IF (@ORDER_CLAUSE = '')
		SET @ORDER_CLAUSE = ' NV_ID ';
	----------

---- Gọi SP lấy thông tin Cấu Hình
	IF (@MA_FORM <> '')
	BEGIN
		exec [MSSQL_QLKD_MAIN_DEMO].dbo.[sp_CauHinhFormCot_GetInfoByMaForm]
		@MA_FORM = @MA_FORM,
		@FIELD = @V_FIELD OUTPUT,
		@ORDER_CLAUSE = @V_ORDER_CLAUSE OUTPUT;

		IF (@FIELD = '' AND @V_FIELD <> '')
		BEGIN
			SET @FIELD = @V_FIELD;
		END

		IF (@ORDER_CLAUSE = ' NV_ID ' AND @V_ORDER_CLAUSE <> '')
		BEGIN
			SET @ORDER_CLAUSE = @V_ORDER_CLAUSE;
		END
	END

	IF (@FIELD = '')
		SET @FIELD = 'NV.NhanVienId,Ma,Ho,Ten';

	SET @V_GROUP_BY = @FIELD + ',NV.NhanVienId,NV.CtrVersion'

---- Xây dựng nội dung câu SQL  
	-- selects all rows from the table according to search criteria
	SET @V_SQL = N'
	SELECT COUNT(*) OVER () AS MAXCNT, ' + @FIELD + ',NV.NhanVienId AS NV_ID,NV.CtrVersion AS NV_CTRVERSION
	FROM NhanVien NV WITH(NOLOCK, READUNCOMMITTED)
	LEFT JOIN PhongBan PB WITH(NOLOCK, READUNCOMMITTED) ON PB.PhongBanId = NV.PhongBanId
	LEFT JOIN NhanVienDuAn NVDA WITH(NOLOCK, READUNCOMMITTED) ON NV.NhanVienId = NVDA.NhanVienId
	LEFT JOIN DuAn DA WITH(NOLOCK, READUNCOMMITTED) ON DA.DuAnId = NVDA.DuAnId
	LEFT JOIN ChucVu CV WITH(NOLOCK, READUNCOMMITTED) ON NV.ChucVuId = CV.ChucVuId
	'

	-- Build Where clause
	-- ĐIỀU KIỆN XÓA NHÂN VIÊN
	IF @XOA <> ''
	BEGIN
		SET @V_WHERE_CLAUSE = @V_WHERE_CLAUSE + N' AND (NV.XoaYN LIKE ''' + @XOA + ''') '
	END

	-- Where clause Quick search
	IF @SEARCH_STRING <> ''
	BEGIN
		SET @V_WHERE_CLAUSE = @V_WHERE_CLAUSE + N' AND (
		NV.Ma LIKE N''%' + @SEARCH_STRING + '%'' 
		OR NV.Ho LIKE N''%' + @SEARCH_STRING + '%'' 
		OR NV.Ten LIKE N''%' + @SEARCH_STRING + '%'' 
		OR N''' + @SEARCH_STRING + ''' LIKE N''%'' + NV.Ho + ''%'' 
		OR N''' + @SEARCH_STRING + ''' LIKE N''%'' + NV.Ten + ''%'' 
		) '
	END

	-- Where clause ngày tuyển dụng
	IF @NGAY_FROM > ''
	BEGIN
		SET @V_WHERE_CLAUSE = @V_WHERE_CLAUSE + N' AND (NV.NgayTuyenDung >= ''' + @NGAY_FROM +''') '
	END

	IF @NGAY_TO > ''
	BEGIN
		SET @V_WHERE_CLAUSE = @V_WHERE_CLAUSE + N' AND (NV.NgayTuyenDung <= ''' + @NGAY_TO +''') '
	END

	-- Where clause filter @NHAN_VIEN
	IF @NHAN_VIEN > ''
	BEGIN 
	IF CHARINDEX('|', @NHAN_VIEN) > 0
		SET @V_WHERE_CLAUSE = @V_WHERE_CLAUSE + ' AND CHARINDEX(''|'' + CAST(NV.NhanVienId AS VARCHAR(20)) + ''|'', ''|'' + ''' + @NHAN_VIEN + ''' + ''|'') > 0 ';
	ELSE 
		SET @V_WHERE_CLAUSE = @V_WHERE_CLAUSE + ' AND NV.NhanVienId=' + @NHAN_VIEN + ' ';
	END

	-- Where clause filter @PHONG_BAN
	IF @PHONG_BAN > ''
	BEGIN 
	IF CHARINDEX('|', @PHONG_BAN) > 0
		SET @V_WHERE_CLAUSE = @V_WHERE_CLAUSE + ' AND CHARINDEX(''|'' + CAST(NV.PhongBanId AS VARCHAR(20)) + ''|'', ''|'' + ''' + @PHONG_BAN + ''' + ''|'') > 0 ';
	ELSE 
		SET @V_WHERE_CLAUSE = @V_WHERE_CLAUSE + ' AND NV.PhongBanId=' + @PHONG_BAN + ' ';
	END

	-- Where clause filter @DU_AN
	IF @DU_AN > ''
	BEGIN 
	IF CHARINDEX('|', @DU_AN) > 0
		SET @V_WHERE_CLAUSE = @V_WHERE_CLAUSE + ' AND CHARINDEX(''|'' + CAST(DA.DuAnId AS VARCHAR(20)) + ''|'', ''|'' + ''' + @DU_AN + ''' + ''|'') > 0 ';
	ELSE 
		SET @V_WHERE_CLAUSE = @V_WHERE_CLAUSE + ' AND DA.DuAnId=' + @DU_AN + ' ';
	END

	-- Where clause filter @CHUC_VU
	IF @CHUC_VU > ''
	BEGIN 
	IF CHARINDEX('|', @CHUC_VU) > 0
		SET @V_WHERE_CLAUSE = @V_WHERE_CLAUSE + ' AND CHARINDEX(''|'' + CAST(NV.ChucVuId AS VARCHAR(20)) + ''|'', ''|'' + ''' + @CHUC_VU + ''' + ''|'') > 0 ';
	ELSE 
		SET @V_WHERE_CLAUSE = @V_WHERE_CLAUSE + ' AND NV.ChucVuId=' + @CHUC_VU + ' ';
	END

	-- Where clause filter @@DANG_LAM_VIEC
	--IF @V_MA_TRANG_THAI <> ''
	--	SET @V_WHERE_CLAUSE = @V_WHERE_CLAUSE + ' AND (NV.MaTrangThai = ''' + @V_MA_TRANG_THAI + ''') ';

	--IF(@DANG_LAM_VIEC IS NULL AND @V_MA_TRANG_THAI <> '')
	--BEGIN
	--	SET @V_WHERE_CLAUSE = @V_WHERE_CLAUSE + N' AND (NV.MaTrangThai = ''' + @V_MA_TRANG_THAI + ''')';
	--END
	--ELSE IF(@DANG_LAM_VIEC = 1)
	--BEGIN
	--	SET @V_WHERE_CLAUSE = @V_WHERE_CLAUSE + N' AND (NV.MaTrangThai = ''' + @V_MA_TRANG_THAI + ''')';
	--END
	--ELSE IF(@DANG_LAM_VIEC = 0)
	--BEGIN
	--	SET @V_WHERE_CLAUSE = @V_WHERE_CLAUSE + N' AND (NV.MaTrangThai <> ''' + @V_MA_TRANG_THAI + ''')';
	--END

	SET @DANG_LAM_VIEC = ISNULL(@DANG_LAM_VIEC , '')
	IF @DANG_LAM_VIEC = ''
		SET @DANG_LAM_VIEC =  0

	IF(@DANG_LAM_VIEC = 1)
	BEGIN
		SET @V_WHERE_CLAUSE = @V_WHERE_CLAUSE + N' AND (NV.MaTrangThai = ''NV_DL'')';
	END
	ELSE
	BEGIN
		SET @V_WHERE_CLAUSE = @V_WHERE_CLAUSE + N' AND (NV.MaTrangThai = ''NV_NL'')';
	END

	-- VIEW 
	IF @IS_VIEW_ALL = '0' OR @LOGIN_ID='0'
	BEGIN		
		SET @V_WHERE_CLAUSE = @V_WHERE_CLAUSE + ' AND (NV.NhanVienId =''' + @LOGIN_ID + ''' )';
	END

	IF @V_WHERE_CLAUSE > ''
	SET @V_SQL = @V_SQL + ' WHERE ' + @V_WHERE_CLAUSE

	-- Build group clause
	IF @V_GROUP_BY > ''
	SET @V_SQL = @V_SQL + ' GROUP BY ' + @V_GROUP_BY

	-- Build Order clause
	IF @ORDER_CLAUSE > ''
	SET @V_SQL = @V_SQL + ' ORDER BY ' + @ORDER_CLAUSE

	-- Build Skip clause
	SET @V_SQL = @V_SQL + ' ' + 'OFFSET '+ CAST(@SKIP AS nvarchar(20)) +' ROWS'

	-- Build Take clause
	SET @V_SQL = @V_SQL + ' ' + 'FETCH NEXT '+CAST(@TAKE AS nvarchar(20)) +' ROWS ONLY'


---- Thực thi câu SQL
	--PRINT(@V_SQL)
	EXEC(@V_SQL)

---- kết thúc và hủy bảng tạm (nếu có)

-----------------------------------------------------
SET NOCOUNT OFF
END


