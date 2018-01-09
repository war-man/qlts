USE [MSSQL_QLDN_QLNS_DEMO]
GO
/****** Object:  StoredProcedure [dbo].[sp_KD_KeHoach_GetListKeHoachByCriteria]    Script Date: 12/19/2017 10:02:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROC [dbo].[sp_KD_KeHoach_GetListKeHoachByCriteria]
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
	@CHUC_NANG = 'KD0009',
	@QUYEN_TAC_VU = 'View All',
	@YES_NO=@IS_VIEW_ALL OUTPUT


	IF OBJECT_ID('tempdb..#V_TB_KYLAP') IS NOT NULL
		DROP TABLE #V_TB_KYLAP
	CREATE TABLE #V_TB_KYLAP
	(
			_id NVARCHAR(50),
			_name NVARCHAR(100)
	)

	insert #V_TB_KYLAP
	select 'CANAM',N'Cả năm'		union
	select 'QUY1',N'Quý I'			UNION
	select 'QUY2',N'Quý II'			UNION
	select 'QUY3',N'Quý III'		union
	select 'QUY4',N'Quý IV'			UNION
	select 'THANG1',N'Tháng 1'		union
	select 'THANG2',N'Tháng 2'		union
	select 'THANG3',N'Tháng 3'		union
	select 'THANG4',N'Tháng 4'		union
	select 'THANG5',N'Tháng 5'		union
	select 'THANG6',N'Tháng 6'		union
	select 'THANG7',N'Tháng 7'		union
	select 'THANG8',N'Tháng 8'		union
	select 'THANG9',N'Tháng 9'		union
	select 'THANG10',N'Tháng 10'	union
	select 'THANG11',N'Tháng 11'	union
	select 'THANG12',N'Tháng 12'


---- Xây dựng nội dung câu SQL  
	-- selects all rows from the table according to search criteria
	SET @V_SQL = N'
	SELECT KH.KeHoachId, KH.KyKeHoach, kL._name TenKyKeHoach, KH.Nam, KH.SoPhieu, KH.KhachHangId, KH.NguoiTao, KH.NgayTao,
			CONCAT(NV.Ho,'' '',NV.Ten) AS TenNguoiTao, KHS.TenKhachHang
	FROM dbo.KDKeHoach KH
	LEFT JOIN dbo.NhanVien nv ON nv.NhanVienId = KH.NguoiTao
	LEFT JOIN dbo.KDKhachHang KHS ON KHS.KhachHangId = KH.KhachHangId
	LEFT JOIN #V_TB_KYLAP KL ON KL._id = KH.KyKeHoach
	WHERE 1=1  ' 
	
	-- Build Where clause
	-- Where clause Quick search
	
	IF @Search > ''
	SET @V_SQL = @V_SQL + ' and (KH.SoPhieu LIKE N''%' +@Search+ '%'' 
								OR KH.Nam LIKE  N''%' +@Search+ '%'' 
								OR KH.KyKeHoach LIKE  N''%' +@Search+ '%'') ';							
	
	
	IF @IS_VIEW_ALL = '0' 
	BEGIN  
		SET @V_SQL = @V_SQL + '  and KH.NguoiTao =''' + @NhanVienId + ''' ';
	END

	--SET @V_SQL = @V_SQL + ' GROUP BY a.NhanVienId,a.MaNhanVien,a.TenNhanVien,a.DienThoai,a.GhiChu,nv.TenNhanVien,a.NgayTao,PB.TenPhongBan '
	-- Build Order clause
	IF @OrderClause > ''
	SET @V_SQL = @V_SQL + ' ORDER BY KH.NgayTao desc,' + @OrderClause

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

