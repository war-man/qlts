USE [MSSQL_QLDN_QLNS_DEMO]
GO
/****** Object:  StoredProcedure [dbo].[sp_KD_NhanVien_GetListNhanVienByCriteria]    Script Date: 12/19/2017 10:05:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROC [dbo].[sp_KD_NhanVien_GetListNhanVienByCriteria]
( 
	  @SearchString				nvarchar(500)	= null			
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

	SET		@V_WHERE_CLAUSE		= N' WHERE PB.PhongBanId=53 and NV.XoaYN=''N'' AND NV.MaTrangThai=''NV_DL''';
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
	SELECT COUNT(*) OVER () AS MAXCNT,NV.NhanVienId,NV.Ma,(NV.Ho +'' ''+ NV.Ten) AS HoTen,NV.GioiTinh,NV.NgaySinh,PB.TenPhongBan,NV.NgayTuyenDung,CV.TenChucVu,NV.DienThoai,NV.NhanVienId AS NV_ID,NV.CtrVersion AS NV_CTRVERSION
	FROM NhanVien NV WITH(NOLOCK, READUNCOMMITTED)
	LEFT JOIN PhongBan PB WITH(NOLOCK, READUNCOMMITTED) ON PB.PhongBanId = NV.PhongBanId
	LEFT JOIN NhanVienDuAn NVDA WITH(NOLOCK, READUNCOMMITTED) ON NV.NhanVienId = NVDA.NhanVienId
	LEFT JOIN DuAn DA WITH(NOLOCK, READUNCOMMITTED) ON DA.DuAnId = NVDA.DuAnId
	LEFT JOIN ChucVu CV WITH(NOLOCK, READUNCOMMITTED) ON NV.ChucVuId = CV.ChucVuId
	'
	-- Where clause Quick search
	IF @SearchString <> ''
	BEGIN
		SET @V_WHERE_CLAUSE = @V_WHERE_CLAUSE + N' AND (
		NV.Ma LIKE N''%' + @SearchString + '%'' 
		OR NV.Ho LIKE N''%' + @SearchString + '%'' 
		OR NV.Ten LIKE N''%' + @SearchString + '%'' 
		OR N''' + @SearchString + ''' LIKE N''%'' + NV.Ho + ''%'' 
		OR N''' + @SearchString + ''' LIKE N''%'' + NV.Ten + ''%'' 
		) '
	END


	
	SET @V_SQL = @V_SQL + ' ' + @V_WHERE_CLAUSE

	-- Build group clause
	IF @V_GROUP_BY > ''
	SET @V_SQL = @V_SQL + ' GROUP BY ' + @V_GROUP_BY

	SET @V_SQL = @V_SQL + ' ORDER BY NV.Ma ' 

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



