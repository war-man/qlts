ALTER PROC [dbo].[sp_GhiGiam_GetListGhiGiamByCriteria]
( 
@CoSoId	        nvarchar(500)	= null			
, @NhanVienId	    nvarchar(500)	= null		
, @SoChungTu		nvarchar(500)   = null	
, @TuNgay			nvarchar(500)   = null	
, @DenNgay			nvarchar(500)   = null	
, @PhongBanId			nvarchar(500)	= null			
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

----------
DECLARE @IS_VIEW varchar(10) = '0'
		,@Nam	VARCHAR(MAX)	=	NULL
	--LAY SO LIEU CAU HINH THONG SO
EXEC sp_ThongSoUser_GetThongSo @LOAITHONGSO='SoLieuNam',@NHANVIEN=@NhanVienId,@NAM=@Nam OUTPUT;
-----------------
exec [QLTS_MAIN].dbo.[sp_QuyenTacVu_CheckQuyenTacVuByChucNang]
@NHAN_VIEN_ID = @NhanVienId,
@CO_SO_ID = @CoSoId,
@CHUC_NANG = 'CN0023',
@QUYEN=@IS_VIEW OUTPUT


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
SELECT DISTINCT  COUNT(*) OVER () AS MAXCNT,a.GhiGiamId,a.SoChungTu,a.NgayChungTu,a.NgayGhiGiam,a.PhongBanId,c.TenPhongBan,a.NoiDung,isnull(SUM(NG.GiaTri),0) TongNguyenGia,a.DuyetId, a.NguoiDuyet,a.CoSoId, a.NguoiTao, a.NgayTao,nv.TenNhanVien,ndd.TenNhanVien as NhanVienDuyet 
FROM GhiGiam a 
LEFT JOIN GhiGiamChiTiet b ON a.GhiGiamId =b.GhiGiamId
LEFT join PhongBan c on a.PhongBanId=c.PhongBanId 
LEFT JOIN TaiSan TS ON TS.TaiSanId = b.TaiSanId
LEFT JOIN NguyenGia NG ON NG.TaiSanId = TS.TaiSanId
LEFT JOIN NhanVien ndd ON ndd.NhanVienId = a.NguoiDuyet
LEFT JOIN NhanVien nv ON nv.NhanVienId = a.NguoiTao
LEFT JOIN (SELECT pbnv.NhanVienId,
		STUFF((
				select CONCAT( '','' ,u1.PhongBanId)
				from dbo.PhongBan u1 JOIN dbo.PhongBanNhanVien pbnv1 ON pbnv1.PhongBanId = u1.PhongBanId
				where pbnv1.NhanVienId = pbnv.NhanVienId
				for xml path('''')
			),1,1,'''') PhongBanId
			FROM dbo.PhongBanNhanVien pbnv
			JOIN PhongBan b on pbnv.PhongBanId=b.PhongBanId 
			GROUP BY pbnv.NhanVienId) pbnv ON pbnv.NhanVienId=a.NguoiTao
where YEAR(a.NgayGhiGiam) = '''+@Nam+''' ';  

-- Build Where clause
-- Where clause Quick search
IF (@SoChungTu > '')
BEGIN
SET @V_SQL = @V_SQL + ' and (a.SoChungTu LIKE N''%' +@SoChungTu+ '%'') ';
END

IF (@PhongBanId > '')
BEGIN
SET @V_SQL = @V_SQL + ' and a.PhongBanId in ('+@PhongBanId+') ';
END

IF( @TuNgay <> '' AND @DenNgay <> '')
BEGIN 
SET @V_SQL = @V_SQL + ' and a.NgayGhiGiam BETWEEN  ''' + @TuNgay + ''' AND '''+ @DenNgay + '''';
END
ELSE IF @TuNgay <> ''
BEGIN
SET @V_SQL = @V_SQL + ' and  a.NgayGhiGiam >=  ''' + @TuNgay + '''';
END
ELSE IF @DenNgay <>''
BEGIN 
SET @V_SQL = @V_SQL + ' and  a.NgayGhiGiam <=  ''' + @DenNgay + '''';
END
		

IF @IS_VIEW = 'VB' 
BEGIN    
SET @V_SQL = @V_SQL + ' and a.CoSoId =''' + @CoSoId + '''';   
END
IF @IS_VIEW = 'VR' 
BEGIN    
		SET @V_SQL = @V_SQL + ' and EXISTS (SELECT pbnv1.PhongBanId FROM dbo.NhanVien nv JOIN dbo.PhongBanNhanVien pbnv1 ON pbnv1.NhanVienId = nv.NhanVienId WHERE nv.NhanVienId=''' + @NhanVienId + '''' +
							  ' AND CHARINDEX('','' + CAST(pbnv1.PhongBanId AS VARCHAR(10)) + '','', '','' + CAST(pbnv.PhongBanId AS VARCHAR(10)) + '','') > 0) ';   
	END
IF @IS_VIEW = 'VE' 
BEGIN    
SET @V_SQL = @V_SQL + ' and nv.NhanVienId =''' + @NhanVienId + '''';   
END

	
SET @V_SQL = @V_SQL + 'GROUP BY  a.GhiGiamId,a.SoChungTu,a.NgayChungTu,a.NgayGhiGiam,a.PhongBanId,c.TenPhongBan,a.NoiDung,
				a.DuyetId, a.NguoiDuyet,a.CoSoId, a.NguoiTao, a.NgayTao,ndd.TenNhanVien,nv.TenNhanVien ';

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

