﻿/***************************************************
1. Create Date	: 2017.11.16
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: 
4. Function		: 
5. Example		: 
					DECLARE @MESSAGE	NVARCHAR(MAX)
					EXEC sp_KD_HopDong_GetListByCriteria
						 @SEARCH			=	NULL
						,@HOPDONGID			=	NULL
						,@LOAIHOPDONGID		=	NULL
						,@KHACHHANGID		=	NULL
						,@NHANVIENID		=	NULL
						,@DULIEUID			=	NULL
						,@TRANGTHAI			=	NULL
						,@STARTDATEHOPDONG	=	NULL
						,@ENDDATEHOPDONG	=	NULL
						,@STARTDATEHOADON	=	NULL
						,@ENDDATEHOADON		=	NULL


						,@FIELD				=	NULL
						,@ORDERCLAUSE		=	''
						,@SKIP				=	0
						,@TAKE				=	10

						,@USER_ID			=	NULL
						,@NHANVIEN_ID		=	70
						,@FUNCTIONCODE		=	''
						,@MESSAGE			=	@MESSAGE	OUTPUT

					SELECT	@MESSAGE MESSAGE
6. Precaution	:
7. History		:
				  2017.11.16 (NGUYỄN THANH BÌNH) - Tạo mới
***************************************************/
ALTER PROCEDURE sp_KD_HopDong_GetListByCriteria
	 @SEARCH			NVARCHAR(MAX)		=	NULL
	,@HOPDONGID			VARCHAR(MAX)		=	NULL
	,@LOAIHOPDONGID		VARCHAR(MAX)		=	NULL
	,@KHACHHANGID		VARCHAR(MAX)		=	NULL
	,@NHANVIENID		VARCHAR(MAX)		=	NULL
	,@DULIEUID			VARCHAR(MAX)		=	NULL
	,@TRANGTHAI			VARCHAR(MAX)		=	NULL
	,@STARTDATEHOPDONG	VARCHAR(MAX)		=	NULL
	,@ENDDATEHOPDONG	VARCHAR(MAX)		=	NULL
	,@STARTDATEHOADON	VARCHAR(MAX)		=	NULL
	,@ENDDATEHOADON		VARCHAR(MAX)		=	NULL

	,@FIELD				VARCHAR(MAX)		=	NULL
	,@ORDERCLAUSE		VARCHAR(MAX)		=	NULL
	,@SKIP				INT					=	NULL
	,@TAKE				INT					=	NULL

	,@USER_ID			INT					=	NULL
	,@NHANVIEN_ID		INT					=	NULL
	,@FUNCTIONCODE		VARCHAR(MAX)		=	NULL
	,@MESSAGE			NVARCHAR(MAX)		OUTPUT
AS
BEGIN
SET NOCOUNT ON;
BEGIN TRY
--------------------------------------------------
DECLARE
	 @V_SQL				NVARCHAR(MAX)		= NULL
	,@V_SEARCH			NVARCHAR(MAX)		= ''
	,@V_DELIMITER		CHAR(1)				= '|'

SET @USER_ID		=	ISNULL(@USER_ID,0)
SET @NHANVIEN_ID	=	ISNULL(@NHANVIEN_ID,0)
SET @FUNCTIONCODE	=	ISNULL(@FUNCTIONCODE,'')
SET @MESSAGE		=	''

SET @SEARCH			=	ISNULL(@SEARCH,'')
SET @HOPDONGID		=	ISNULL(@HOPDONGID,'')
SET @LOAIHOPDONGID	=	ISNULL(@LOAIHOPDONGID,'')
SET @KHACHHANGID	=	ISNULL(@KHACHHANGID,'')
SET @NHANVIENID		=	ISNULL(@NHANVIENID,'')
SET @DULIEUID		=	ISNULL(@DULIEUID,'')
SET @TRANGTHAI		=	ISNULL(@TRANGTHAI,'')

SET @STARTDATEHOPDONG	=	ISNULL(@STARTDATEHOPDONG,'')
SET @ENDDATEHOPDONG		=	ISNULL(@ENDDATEHOPDONG,'')
SET @STARTDATEHOADON	=	ISNULL(@STARTDATEHOADON,'')
SET @ENDDATEHOADON		=	ISNULL(@ENDDATEHOADON,'')

SET @SKIP			=	ISNULL(@SKIP,0)
SET @TAKE			=	ISNULL(@TAKE,0)

SET @ORDERCLAUSE	=	ISNULL(@ORDERCLAUSE,'')
IF @ORDERCLAUSE = ''
	SET @ORDERCLAUSE = 'HD.HopDongId'

SET @FIELD = ISNULL(@FIELD,'')
IF @FIELD = ''
	SET @FIELD = 'HD.*'

SET @V_SEARCH = '%' + @SEARCH + '%'

-- SELECT
SET @V_SQL = N'
	SELECT COUNT(HD.HopDongId) OVER () AS MAXCNT,' + @FIELD + ',HD.HopDongId ID
		,LHD.MaLoaiHopDong,LHD.TenLoaiHopDong
		,NV.Ma MaNhanVien,CONCAT(NV.Ho,'' '',NV.Ten) AS TenNhanVien
		,NV_NT.Ma MaNguoiTao,CONCAT(NV_NT.Ho,'' '',NV_NT.Ten) AS TenNguoiTao
		,KH.MaKhachHang,KH.TenKhachHang
		,DL.MaDuLieu,DL.TenDuLieu
	FROM KDHopDong HD
		LEFT JOIN KDLoaiHopDong LHD ON HD.LoaiHopDongId = LHD.LoaiHopDongId
		LEFT JOIN NhanVien NV ON HD.NhanVienId = NV.NhanVienId
		LEFT JOIN NhanVien NV_NT ON HD.NguoiTao = NV_NT.NhanVienId
		LEFT JOIN KDKhachHang KH ON HD.KhachHangId = KH.KhachHangId
		LEFT JOIN KDDuLieu DL ON HD.DuLieuId = DL.DuLieuId
'

-- WHERE
SET @V_SQL = @V_SQL + N'
	WHERE (@SEARCH = ''''
			OR HD.SoHopDong LIKE @V_SEARCH
			OR HD.TenHopDong LIKE @V_SEARCH
			OR HD.SoHoaDon LIKE @V_SEARCH
			OR NV.Ma LIKE @V_SEARCH
			OR KH.MaKhachHang LIKE @V_SEARCH
		)
		AND (@HOPDONGID = '''' OR CHARINDEX(@V_DELIMITER + CAST(HD.HopDongId AS VARCHAR(10)) + @V_DELIMITER,@V_DELIMITER + @HOPDONGID + @V_DELIMITER) > 0)
		AND (@LOAIHOPDONGID = '''' OR CHARINDEX(@V_DELIMITER + CAST(HD.LoaiHopDongId AS VARCHAR(10)) + @V_DELIMITER,@V_DELIMITER + @LOAIHOPDONGID + @V_DELIMITER) > 0)
		AND (@KHACHHANGID = '''' OR CHARINDEX(@V_DELIMITER + CAST(HD.KhachHangId AS VARCHAR(10)) + @V_DELIMITER,@V_DELIMITER + @KHACHHANGID + @V_DELIMITER) > 0)
		AND (@NHANVIENID = '''' OR CHARINDEX(@V_DELIMITER + CAST(HD.NhanVienId AS VARCHAR(10)) + @V_DELIMITER,@V_DELIMITER + @NHANVIENID + @V_DELIMITER) > 0)
		AND (@DULIEUID = '''' OR CHARINDEX(@V_DELIMITER + CAST(HD.DuLieuId AS VARCHAR(10)) + @V_DELIMITER,@V_DELIMITER + @DULIEUID + @V_DELIMITER) > 0)
		AND (@TRANGTHAI = '''' OR CHARINDEX(@V_DELIMITER + CAST(HD.Chi AS VARCHAR(10)) + @V_DELIMITER,@V_DELIMITER + @TRANGTHAI + @V_DELIMITER) > 0)
		AND (@STARTDATEHOPDONG = '''' OR HD.NgayHopDong >= @STARTDATEHOPDONG)
		AND (@ENDDATEHOPDONG = '''' OR HD.NgayHopDong <= @ENDDATEHOPDONG)
		AND (@STARTDATEHOADON = '''' OR HD.NgayHoaDon >= @STARTDATEHOADON)
		AND (@ENDDATEHOADON = '''' OR HD.NgayHoaDon <= @ENDDATEHOADON)
'

-- ORDER BY
SET @V_SQL = @V_SQL + N'
	ORDER BY ' + @ORDERCLAUSE + ' 
'

-- OFFSET
IF @ORDERCLAUSE <> '' AND @TAKE > 0
	SET @V_SQL = @V_SQL + N'
		OFFSET ' + CAST(@SKIP AS VARCHAR(10)) + ' ROWS FETCH NEXT ' + CAST(@TAKE AS VARCHAR(10)) + ' ROWS ONLY 
	'

PRINT @V_SQL
EXEC SP_EXECUTESQL @V_SQL,N'
	 @NHANVIEN_ID		INT					=	NULL
	,@V_DELIMITER		CHAR(1)				=	NULL

	,@SEARCH			NVARCHAR(MAX)		=	NULL
	,@HOPDONGID			VARCHAR(MAX)		=	NULL
	,@LOAIHOPDONGID		VARCHAR(MAX)		=	NULL
	,@KHACHHANGID		VARCHAR(MAX)		=	NULL
	,@NHANVIENID		VARCHAR(MAX)		=	NULL
	,@DULIEUID			VARCHAR(MAX)		=	NULL
	,@TRANGTHAI			VARCHAR(MAX)		=	NULL
	,@STARTDATEHOPDONG	VARCHAR(MAX)		=	NULL
	,@ENDDATEHOPDONG	VARCHAR(MAX)		=	NULL
	,@STARTDATEHOADON	VARCHAR(MAX)		=	NULL
	,@ENDDATEHOADON		VARCHAR(MAX)		=	NULL
	,@V_SEARCH			NVARCHAR(MAX)		=	NULL

	'
	,@NHANVIEN_ID		=	@NHANVIEN_ID
	,@V_DELIMITER		=	@V_DELIMITER

	,@SEARCH			=	@SEARCH
	,@HOPDONGID			=	@HOPDONGID
	,@LOAIHOPDONGID		=	@LOAIHOPDONGID
	,@KHACHHANGID		=	@KHACHHANGID
	,@NHANVIENID		=	@NHANVIENID
	,@DULIEUID			=	@DULIEUID
	,@TRANGTHAI			=	@TRANGTHAI
	,@STARTDATEHOPDONG	=	@STARTDATEHOPDONG
	,@ENDDATEHOPDONG	=	@ENDDATEHOPDONG
	,@STARTDATEHOADON	=	@STARTDATEHOADON
	,@ENDDATEHOADON		=	@ENDDATEHOADON
	,@V_SEARCH			=	@V_SEARCH

--------------------------------------------------
END TRY
BEGIN CATCH
	DECLARE @ErrorMessage NVARCHAR(MAX);
    DECLARE @ErrorSeverity INT;
    DECLARE @ErrorState INT;

    SELECT 
        @ErrorMessage = ERROR_MESSAGE(),
        @ErrorSeverity = ERROR_SEVERITY(),
        @ErrorState = ERROR_STATE();

	IF @MESSAGE = ''
		RAISERROR (@ErrorMessage,@ErrorSeverity,@ErrorState);
END CATCH

SET NOCOUNT OFF;
END