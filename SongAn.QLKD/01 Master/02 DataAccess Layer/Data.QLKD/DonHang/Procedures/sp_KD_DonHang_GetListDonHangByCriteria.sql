USE [MSSQL_QLDN_QLNS_DEMO]
GO
/****** Object:  StoredProcedure [dbo].[sp_KD_DonHang_GetListDonHangByCriteria]    Script Date: 12/19/2017 9:52:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROC [dbo].[sp_KD_DonHang_GetListDonHangByCriteria]
( 
	  @UserId	        nvarchar(500)	= null			
	, @NhanVienId	    nvarchar(500)	= null		
	, @Search			nvarchar(500)   = null			
	, @KhachHangId		nvarchar(500)   = null			
	, @TuNgay			DATETIME		= null		
	, @DenNgay			DATETIME		= null	
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


	SET @Search = ISNULL(@Search, '')
	SET @KhachHangId = ISNULL(@KhachHangId, '0')
	IF (@KhachHangId = '') SET @KhachHangId = '0'

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

	DECLARE @IS_VIEW_ALL varchar = '0'
     ----------
	exec MSSQL_QLDN_MAIN_DEMO.dbo.[sp_KD_QuyenTacVu_CheckQuyenTacVuByChucNang]
	@LOGIN_ID = @UserId,
	@CHUC_NANG = 'KD0011',
	@QUYEN_TAC_VU = 'View All',
	@YES_NO=@IS_VIEW_ALL OUTPUT


---- Xây dựng nội dung câu SQL  
	-- selects all rows from the table according to search criteria
	SET @V_SQL = N'
	SELECT COUNT(*) OVER () AS MAXCNT, H.DonHangId, H.SoPhieu, H.TenDonHang, H.NgayLap,  H.KhachHangId, KH.TenKhachHang, H.LyDo,H.DiaChiNhan
			,H.HopDongId, HD.SoHopDong, HD.TenHopDong, H.NhanVienId,nvkd.Ma MaNhanVienKD,  CONCAT(nvkd.Ho,'' '',nvkd.Ten) AS TenNhanVienKD
			,H.BoPhanNhan, H.NguoiNhan, H.GhiChu, H.TrangThai, H.NgayDuyet, H.NguoiTao, CONCAT(NV.Ho,'' '',NV.Ten) AS TenNguoiTao, H.NgayTao
			,CASE WHEN H.NgayDuyet IS NULL THEN '' '' ELSE ''X'' END Duyet,
			CASE WHEN H.TrangThai = 0 THEN N''Đang thực hiện'' 
				 WHEN H.TrangThai = 1 THEN N''Hoàn tất''
				 WHEN H.TrangThai = 2 THEN N''Hủy''				 
				 ELSE N''!'' END TenTrangThai
	FROM dbo.KDDonHang H 
	LEFT JOIN dbo.KDKhachHang KH ON KH.KhachHangId = H.KhachHangId
	LEFT JOIN dbo.KDHopDong HD ON HD.HopDongId = H.HopDongId
	LEFT JOIN NhanVien nvkd ON nvkd.NhanVienId = H.NhanVienId
	LEFT JOIN dbo.NhanVien nv ON nv.NhanVienId = H.NguoiTao
	WHERE 1 = 1 and CAST(H.NgayLap AS DATE) BETWEEN CAST(''' + CAST(@TuNgay AS VARCHAR) +''' AS DATE) AND CAST(''' + CAST(@DenNgay AS VARCHAR) + ''' AS DATE) ' 

	-- Build Where clause
	-- Where clause Quick search

	IF @Search > ''
	SET @V_SQL = @V_SQL + ' and (H.SoPhieu LIKE N''%' +@Search+ '%'' 
								--OR KH.Nam LIKE  N''%' +@Search+ '%'' 
								OR H.TenDonHang LIKE  N''%' +@Search+ '%'') ';							

	IF @KhachHangId <> '0'
	BEGIN
		SET @V_SQL = @V_SQL + ' and H.KhachHangId = ' + @KhachHangId + ' ';
	END
	
	IF @IS_VIEW_ALL = '0' 
	BEGIN  
		SET @V_SQL = @V_SQL + '  and H.NguoiTao =''' + @NhanVienId + ''' ';
	END

	--SET @V_SQL = @V_SQL + ' GROUP BY a.NhanVienId,a.MaNhanVien,a.TenNhanVien,a.DienThoai,a.GhiChu,nv.TenNhanVien,a.NgayTao,PB.TenPhongBan '
	-- Build Order clause
	IF @OrderClause > ''
	SET @V_SQL = @V_SQL + ' ORDER BY H.NgayTao desc, ' + @OrderClause

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

