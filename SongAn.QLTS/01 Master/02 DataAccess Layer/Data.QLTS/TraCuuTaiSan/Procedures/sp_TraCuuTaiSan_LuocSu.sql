/**************************************************
1. Create Date	: 2017.10.06
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: 
4. Function		: 
5. Example		: 
					DECLARE @MESSAGE	NVARCHAR(MAX)
					EXEC [sp_TraCuuTaiSan_LuocSu]
						 @TAISANID		=	0
						,@NHANVIENID	=	0
						,@PHONGBANID	=	0
						,@NHANVIEN_ID	=	6
						,@COSO_ID		=	1
						,@MESSAGE		=	@MESSAGE	OUTPUT

					SELECT	@MESSAGE MESSAGE
6. Precaution	:
7. History		:
				  2017.10.06 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
ALTER PROCEDURE [dbo].[sp_TraCuuTaiSan_LuocSu]
			 @TAISANID		INT					=	NULL
			,@NHANVIENID	INT					=	NULL
			,@PHONGBANID	INT					=	NULL
			,@NHANVIEN_ID	INT					=	NULL
			,@COSO_ID		INT					=	NULL
			,@MESSAGE		NVARCHAR(MAX)		OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
--------------------------------------------------
SET @MESSAGE = ISNULL(@MESSAGE,'')

IF OBJECT_ID('TEMPDB..##LUOCSU') IS NOT NULL
	DROP TABLE ##LUOCSU

SELECT * INTO ##LUOCSU FROM
(
			SELECT		DG.DanhGiaId Id,DG.NoiDung,DG.NgayDanhGia Ngay,'DANHGIA' [Type],DG.TaiSanId,DG.NhanVienId,DG.PhongBanId 
			FROM		DanhGia DG
			WHERE		DG.TaiSanId = @TAISANID

	UNION	SELECT		KT.KhaiThacId ID,KT.GhiChu,KT.ThoiGianBatDau,'KHAITHAC',KT.TaiSanId,KT.NhanVienId,KT.PhongBanId
			FROM		KhaiThac KT 
			WHERE		KT.TaiSanId = @TAISANID AND KT.NhanVienId = @NHANVIENID AND KT.PhongBanId = @PHONGBANID

	UNION	SELECT		TDTT.ThayDoiThongTinId ID,TDTT.LyDo,TDTT.Ngay,'TDTT',TDTT.TaiSanId,'','' 
			FROM		ThayDoiThongTin TDTT 
			WHERE		TDTT.TaiSanId = @TAISANID

	UNION	SELECT		GTCT.GhiTangId,GT.NoiDung,GT.NgayGhiTang,'GHITANG',GTCT.TaiSanId,GTCT.NhanVienId,GTCT.PhongBanId 
			FROM		GhiTangChiTiet GTCT 
						LEFT JOIN GHITANG GT ON GTCT.GhiTangId = GT.GhiTangId
			WHERE		GTCT.TaiSanId = @TAISANID AND GTCT.NhanVienId = @NHANVIENID AND GTCT.PhongBanId = @PHONGBANID

	UNION	SELECT		GGCT.GhiGiamId,GG.NoiDung,GG.NgayGhiGiam,'GHIGIAM',GGCT.TaiSanId,GGCT.NhanVienId,GGCT.PhongBanId 
			FROM		GhiGiamChiTiet GGCT 
						LEFT JOIN GhiGiam GG ON GG.GhiGiamId = GGCT.GhiGiamId
			WHERE		GGCT.TaiSanId = @TAISANID AND GGCT.NhanVienId = @NHANVIENID AND GGCT.PhongBanId = @PHONGBANID

	UNION	SELECT		DCCT.DieuChuyenId,DC.GhiChu,DC.NgayDieuChuyen,'DIEUCHUYEN',DCCT.TaiSanId,DCCT.NhanVienSuDung,DCCT.PhongBanSuDung 
			FROM		DieuChuyenChiTiet DCCT 
						LEFT JOIN DieuChuyen DC ON DCCT.DieuChuyenId = DC.DieuChuyenId
			WHERE		DCCT.TaiSanId = @TAISANID AND DCCT.NhanVienSuDung = @NHANVIENID AND DCCT.PhongBanSuDung = @PHONGBANID
) TEMP

SELECT	LS.*,PB.TenPhongBan,NV.TenNhanVien,TS.TenTaiSan 
FROM	##LUOCSU LS
		LEFT JOIN TaiSan TS ON LS.TaiSanId = TS.TaiSanId
		LEFT JOIN PhongBan PB ON LS.PhongBanId = PB.PhongBanId
		LEFT JOIN NhanVien NV ON LS.NhanVienId = NV.NhanVienId
ORDER BY LS.Ngay DESC

IF OBJECT_ID('TEMPDB..##LUOCSU') IS NOT NULL
	DROP TABLE ##LUOCSU
--------------------------------------------------
	SET NOCOUNT OFF;
END
