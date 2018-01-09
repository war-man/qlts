
GO
/****** Object:  StoredProcedure [dbo].[sp_KD_DanhGiaDoanhThu_GetListDanhGiaDoanhThuByCriteria]    Script Date: 12/19/2017 9:48:08 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- EXEC sp_KD_DanhGiaDoanhThu_GetListDanhGiaDoanhThuByCriteria 2017,0,1,1

ALTER PROC [dbo].[sp_KD_DanhGiaDoanhThu_GetListDanhGiaDoanhThuByCriteria]
(
	@Nam INT,
	@NhanVienKDId INT,
	@UserId NVARCHAR(10),
	@NhanVienId NVARCHAR(10)
)
AS 
BEGIN
	IF (@NhanVienKDId IS NULL)	SET @NhanVienKDId = 0
	
	---- doanh thu theo thang
	--SELECT DT.NhanVienId, SUM(DT.DoanhThu) DoanhThu, DT.Thang
	--FROM
	--(
	--	SELECT H.NhanVienId, H.SoTien DoanhThu, FORMAT(H.NgayHopDong, 'MM') Thang
	--	FROM dbo.KDHopDong H
	--	WHERE YEAR(H.NgayHopDong) = @Nam AND (@NhanVienKDId = 0 OR H.NhanVienId = @NhanVienKDId)
	--) AS DT
	--GROUP BY DT.NhanVienId, DT.Thang

	---- chi tieu
	--SELECT TOP 1 L.NhanVienId, L.Thang1, L.Thang2, L.Thang3, L.Thang4, L.Thang5, L.Thang6, L.Thang7, L.Thang8, L.Thang9, L.Thang10, L.Thang11, L.Thang12
	--FROM dbo.KDChiTieu H
	--JOIN dbo.KDChiTieuChiTiet L ON L.ChiTieuId = H.ChiTieuId
	--WHERE H.Nam = @Nam AND (@NhanVienKDId = 0 OR L.NhanVienId = @NhanVienKDId)

	--------------------------
	DECLARE @tb_NhanVien TABLE
	(
		RowId INT IDENTITY(1,1),
		NhanVienId INT
	)

	DECLARE @tb_Result TABLE
	(
		NhanVienId INT,
		DoanhThu01 DECIMAL(18,4) DEFAULT 0, 
		DoanhThu02 DECIMAL(18,4) DEFAULT 0,
		DoanhThu03 DECIMAL(18,4) DEFAULT 0,
		DoanhThu04 DECIMAL(18,4) DEFAULT 0,
		DoanhThu05 DECIMAL(18,4) DEFAULT 0,
		DoanhThu06 DECIMAL(18,4) DEFAULT 0,
		DoanhThu07 DECIMAL(18,4) DEFAULT 0,
		DoanhThu08 DECIMAL(18,4) DEFAULT 0,
		DoanhThu09 DECIMAL(18,4) DEFAULT 0,
		DoanhThu10 DECIMAL(18,4) DEFAULT 0,
		DoanhThu11 DECIMAL(18,4) DEFAULT 0,
		DoanhThu12 DECIMAL(18,4) DEFAULT 0,
		ChiTieu01 DECIMAL(18,4) DEFAULT 0,
		ChiTieu02 DECIMAL(18,4) DEFAULT 0,
		ChiTieu03 DECIMAL(18,4) DEFAULT 0,
		ChiTieu04 DECIMAL(18,4) DEFAULT 0,
		ChiTieu05 DECIMAL(18,4) DEFAULT 0,
		ChiTieu06 DECIMAL(18,4) DEFAULT 0,
		ChiTieu07 DECIMAL(18,4) DEFAULT 0,
		ChiTieu08 DECIMAL(18,4) DEFAULT 0,
		ChiTieu09 DECIMAL(18,4) DEFAULT 0,
		ChiTieu10 DECIMAL(18,4) DEFAULT 0,
		ChiTieu11 DECIMAL(18,4) DEFAULT 0,
		ChiTieu12 DECIMAL(18,4) DEFAULT 0,
		Per01 DECIMAL(18,4) DEFAULT 0,
		Per02 DECIMAL(18,4) DEFAULT 0,
		Per03 DECIMAL(18,4) DEFAULT 0,
		Per04 DECIMAL(18,4) DEFAULT 0,
		Per05 DECIMAL(18,4) DEFAULT 0,
		Per06 DECIMAL(18,4) DEFAULT 0,
		Per07 DECIMAL(18,4) DEFAULT 0,
		Per08 DECIMAL(18,4) DEFAULT 0,
		Per09 DECIMAL(18,4) DEFAULT 0,
		Per10 DECIMAL(18,4) DEFAULT 0,
		Per11 DECIMAL(18,4) DEFAULT 0,
		Per12 DECIMAL(18,4) DEFAULT 0
	)

	INSERT @tb_NhanVien( NhanVienId )
	SELECT L.NhanVienId
	FROM dbo.KDChiTieu H
	JOIN dbo.KDChiTieuChiTiet L ON L.ChiTieuId = H.ChiTieuId
	WHERE H.Nam = @Nam AND (@NhanVienKDId = 0 OR L.NhanVienId = @NhanVienKDId)

	INSERT @tb_Result( NhanVienId)
	SELECT NhanVienId FROM @tb_NhanVien
	

	DECLARE @v_nhanvienid INT, @v_index_thang INT, @v_doanhthuthang DECIMAL(18,4), @v_chitieuthang DECIMAL(18,4)
	SET @v_index_thang = 1
	WHILE EXISTS(SELECT 1 FROM @tb_NhanVien)
	BEGIN
		SELECT TOP 1 @v_nhanvienid = NhanVienId FROM @tb_NhanVien
		---------------------------------------------------------------------------------------
		WHILE (@v_index_thang < 13)
		BEGIN

			SELECT @v_doanhthuthang = SUM(H.SoTien)
			FROM dbo.KDHopDong H
			WHERE YEAR(H.NgayHopDong) = @Nam AND H.NhanVienId = @v_nhanvienid AND MONTH(H.NgayHopDong) = @v_index_thang

			SELECT @v_chitieuthang = CASE WHEN @v_index_thang = 1 THEN L.Thang1 
										  WHEN @v_index_thang = 2 THEN L.Thang2 
										  WHEN @v_index_thang = 3 THEN L.Thang3 
										  WHEN @v_index_thang = 4 THEN L.Thang4 
										  WHEN @v_index_thang = 5 THEN L.Thang5 
										  WHEN @v_index_thang = 6 THEN L.Thang6
										  WHEN @v_index_thang = 7 THEN L.Thang7 
										  WHEN @v_index_thang = 8 THEN L.Thang8 
										  WHEN @v_index_thang = 9 THEN L.Thang9 
										  WHEN @v_index_thang = 10 THEN L.Thang10 
										  WHEN @v_index_thang = 11 THEN L.Thang11 
										  WHEN @v_index_thang = 12 THEN L.Thang12 END 	
			FROM dbo.KDChiTieu H
			JOIN dbo.KDChiTieuChiTiet L ON L.ChiTieuId = H.ChiTieuId
			WHERE H.Nam = @Nam AND L.NhanVienId = @v_nhanvienid

			IF (@v_index_thang = 1)
			BEGIN
				UPDATE @tb_Result SET DoanhThu01 = isnull(@v_doanhthuthang,0), ChiTieu01 = ISNULL(@v_chitieuthang,0), Per01 = CASE when @v_chitieuthang IS NULL OR @v_doanhthuthang IS NULL OR  @v_chitieuthang = 0 THEN 0 else  @v_doanhthuthang/@v_chitieuthang*100 END WHERE NhanVienId = @v_nhanvienid
			END
			ELSE IF (@v_index_thang = 2)
			BEGIN
				UPDATE @tb_Result SET DoanhThu02 = isnull(@v_doanhthuthang,0), ChiTieu02 = ISNULL(@v_chitieuthang,0), Per02 = CASE when @v_chitieuthang IS NULL OR @v_doanhthuthang IS NULL OR  @v_chitieuthang = 0 THEN 0 else  @v_doanhthuthang/@v_chitieuthang*100 END WHERE NhanVienId = @v_nhanvienid
			END
			ELSE IF (@v_index_thang = 3)
			BEGIN
				UPDATE @tb_Result SET DoanhThu03 = isnull(@v_doanhthuthang,0), ChiTieu03= ISNULL(@v_chitieuthang,0), Per03 = CASE when @v_chitieuthang IS NULL OR @v_doanhthuthang IS NULL OR  @v_chitieuthang = 0 THEN 0 else  @v_doanhthuthang/@v_chitieuthang*100 END WHERE NhanVienId = @v_nhanvienid
			END
			ELSE IF (@v_index_thang = 4)
			BEGIN
				UPDATE @tb_Result SET DoanhThu04 = isnull(@v_doanhthuthang,0), ChiTieu04 = ISNULL(@v_chitieuthang,0), Per04 = CASE when @v_chitieuthang IS NULL OR @v_doanhthuthang IS NULL  OR  @v_chitieuthang = 0 THEN 0 else  @v_doanhthuthang/@v_chitieuthang*100 END WHERE NhanVienId = @v_nhanvienid
			END
			ELSE IF (@v_index_thang = 5)
			BEGIN
				UPDATE @tb_Result SET DoanhThu05 = isnull(@v_doanhthuthang,0), ChiTieu05 = ISNULL(@v_chitieuthang,0), Per05 = CASE when @v_chitieuthang IS NULL OR @v_doanhthuthang IS NULL  OR  @v_chitieuthang = 0 THEN 0 else  @v_doanhthuthang/@v_chitieuthang*100 END WHERE NhanVienId = @v_nhanvienid
			END
			ELSE IF (@v_index_thang = 6)
			BEGIN
				UPDATE @tb_Result SET DoanhThu06 = isnull(@v_doanhthuthang,0), ChiTieu06= ISNULL(@v_chitieuthang,0), Per06 = CASE when @v_chitieuthang IS NULL OR @v_doanhthuthang IS NULL  OR  @v_chitieuthang = 0 THEN 0 else  @v_doanhthuthang/@v_chitieuthang*100 END WHERE NhanVienId = @v_nhanvienid
			END
			ELSE IF (@v_index_thang = 7)
			BEGIN
				UPDATE @tb_Result SET DoanhThu07 = isnull(@v_doanhthuthang,0), ChiTieu07 = ISNULL(@v_chitieuthang,0), Per07 = CASE when @v_chitieuthang IS NULL OR @v_doanhthuthang IS NULL  OR  @v_chitieuthang = 0 THEN 0 else  @v_doanhthuthang/@v_chitieuthang*100 END WHERE NhanVienId = @v_nhanvienid
			END
			ELSE IF (@v_index_thang = 8)
			BEGIN
				UPDATE @tb_Result SET DoanhThu08 = isnull(@v_doanhthuthang,0), ChiTieu08 = ISNULL(@v_chitieuthang,0), Per08 = CASE when @v_chitieuthang IS NULL OR @v_doanhthuthang IS NULL  OR  @v_chitieuthang = 0 THEN 0 else  @v_doanhthuthang/@v_chitieuthang*100 END WHERE NhanVienId = @v_nhanvienid
			END
			ELSE IF (@v_index_thang = 9)
			BEGIN
				UPDATE @tb_Result SET DoanhThu09 = isnull(@v_doanhthuthang,0), ChiTieu09 = ISNULL(@v_chitieuthang,0), Per09 = CASE when @v_chitieuthang IS NULL OR @v_doanhthuthang IS NULL  OR  @v_chitieuthang = 0 THEN 0 else  @v_doanhthuthang/@v_chitieuthang*100 END WHERE NhanVienId = @v_nhanvienid
			END
			ELSE IF (@v_index_thang = 10)
			BEGIN
				UPDATE @tb_Result SET DoanhThu10 = isnull(@v_doanhthuthang,0), ChiTieu10 = ISNULL(@v_chitieuthang,0), Per10 = CASE when @v_chitieuthang IS NULL OR @v_doanhthuthang IS NULL  OR  @v_chitieuthang = 0 THEN 0 else  @v_doanhthuthang/@v_chitieuthang*100 END WHERE NhanVienId = @v_nhanvienid
			END
			ELSE IF (@v_index_thang = 11)
			BEGIN
				UPDATE @tb_Result SET DoanhThu11 = isnull(@v_doanhthuthang,0), ChiTieu11 = ISNULL(@v_chitieuthang,0), Per11 = CASE when @v_chitieuthang IS NULL OR @v_doanhthuthang IS NULL  OR  @v_chitieuthang = 0 THEN 0 else  @v_doanhthuthang/@v_chitieuthang*100 END WHERE NhanVienId = @v_nhanvienid
			END
			ELSE IF (@v_index_thang = 12)
			BEGIN
				UPDATE @tb_Result SET DoanhThu12 = isnull(@v_doanhthuthang,0), ChiTieu12 = ISNULL(@v_chitieuthang,0), Per12 = CASE when @v_chitieuthang IS NULL OR @v_doanhthuthang IS NULL  OR  @v_chitieuthang = 0 THEN 0 else  @v_doanhthuthang/@v_chitieuthang*100 END WHERE NhanVienId = @v_nhanvienid
			END

			SET @v_index_thang = @v_index_thang + 1
			SELECT @v_doanhthuthang = NULL, @v_chitieuthang = NULL
		END
		---------------------------------------------------------------------------------------
		DELETE @tb_NhanVien WHERE NhanVienId = @v_nhanvienid
		SET @v_nhanvienid = NULL
	END


	SELECT ROW_NUMBER() over (order by nv.Ma) STT, @Nam Nam, nv.Ma MaNhanVien, CONCAT(Nv.Ho, ' ', Nv.Ten) TenNhanVien
	,H.*
	FROM @tb_Result H
	LEFT JOIN dbo.NhanVien Nv ON Nv.NhanVienId = H.NhanVienId
END

