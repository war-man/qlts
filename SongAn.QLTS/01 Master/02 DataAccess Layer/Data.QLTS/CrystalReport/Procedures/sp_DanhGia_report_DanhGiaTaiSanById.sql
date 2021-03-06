/**************************************************
1. Create Date	: 2017.09.29
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: 
4. Function		: 
5. Example		: 
					EXEC [sp_DanhGia_report_DanhGiaTaiSanById]
						 @DanhGiaId			=	79
6. Precaution	:
7. History		:
				  2017.09.29 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
ALTER PROCEDURE [dbo].[sp_DanhGia_report_DanhGiaTaiSanById]
	 @DanhGiaId		INT			=	NULL
AS  
BEGIN
SET NOCOUNT ON
--------------------------------------------------
DECLARE  @V_NGUYENGIA DECIMAL(18,4) = NULL
		,@V_NGUYENGIACU DECIMAL(18,4) = NULL
		,@V_TAISANID INT = NULL

SET @DanhGiaId = ISNULL(@DanhGiaId,0)

SELECT @V_TAISANID = TaiSanId FROM DanhGia WHERE DanhGiaId = @DanhGiaId

SELECT		TS.TaiSanId,TS.TenTaiSan,ISNULL(DG_NG.NguonNganSachId,NG.NguonNganSachId) NguonNganSachId,ISNULL(DG_NG.GiaTriCu,NG.GiaTri) GiaTriCu,NG.GiaTri
			,CASE WHEN DG_NG.NguonNganSachId IS NULL THEN 1 ELSE 0 END isCreate
INTO		#DANHGIA_NGUYENGIA
FROM		(	SELECT	DanhGia_NguyenGia.GiaTriCu,DanhGia_NguyenGia.NguonNganSachId,DanhGia.TaiSanId
				FROM	DanhGia_NguyenGia
						LEFT JOIN DanhGia ON DanhGia_NguyenGia.DanhGiaId = DanhGia.DanhGiaId
				WHERE	DanhGia_NguyenGia.DanhGiaId = @DanhGiaId ) DG_NG
			FULL JOIN (	SELECT * 
						FROM NguyenGia 
						WHERE TaiSanId = @V_TAISANID ) NG ON DG_NG.NguonNganSachId = NG.NguonNganSachId
			LEFT JOIN TaiSan TS ON DG_NG.TaiSanId = TS.TaiSanId OR NG.TaiSanId = TS.TaiSanId
WHERE TS.TaiSanId = @V_TAISANID

SELECT @V_NGUYENGIACU = SUM(GiaTriCu) FROM #DANHGIA_NGUYENGIA WHERE TaiSanId = @V_TAISANID AND isCreate = 0
SELECT @V_NGUYENGIA = SUM(GiaTri) FROM #DANHGIA_NGUYENGIA WHERE TaiSanId = @V_TAISANID

PRINT CONCAT('@V_NGUYENGIA',@V_NGUYENGIA)
PRINT CONCAT('@V_NGUYENGIACU',@V_NGUYENGIACU)
SELECT		-- THÔNG TIN CHUNG
			 TS.TenTaiSan,TS.LoaiKeKhai,CS.TenCoSo TenDonVi,CS_QL.TenCoSo TenDonViChuQuan
			,DG.NgayDanhGia
			--,@V_NGUYENGIA NguyenGia,@V_NGUYENGIACU NguyenGiaCu
			,CASE WHEN @V_NGUYENGIACU IS NOT NULL THEN @V_NGUYENGIA ELSE @V_NGUYENGIACU END NguyenGia
			,ISNULL(@V_NGUYENGIACU,@V_NGUYENGIA) NguyenGiaCu
			--,TS.SoNamSuDung,DG.SoNamSuDungCu
			,CASE WHEN DG.SoNamSuDungCu IS NOT NULL THEN TS.SoNamSuDung ELSE DG.SoNamSuDungCu END SoNamSuDung
			,ISNULL(DG.SoNamSuDungCu,TS.SoNamSuDung) SoNamSuDungCu

			-- THÔNG TIN NHÀ
			,TTKK_NHA.DiaChi			TTKK_NHA_DiaChi
			,TTKK_NHA.DienTich			TTKK_NHA_DienTich
			,TTKK_NHA.TongDienTichSan	TTKK_NHA_TongDienTichSan
			,TTKK_NHA.BoTrong			TTKK_NHA_BoTrong
			,TTKK_NHA.ChoThue			TTKK_NHA_ChoThue
			,TTKK_NHA.CoSoHDSuNghiep	TTKK_NHA_CoSoHDSuNghiep
			,TTKK_NHA.LamTruSo			TTKK_NHA_LamTruSo
			,TTKK_NHA.NhaO				TTKK_NHA_NhaO
			-- THÔNG TIN ĐẤT
			,TTKK_DAT.DiaChi			TTKK_DAT_DiaChi
			,TTKK_DAT.DienTich			TTKK_DAT_DienTich
			,TTKK_DAT.LamTruSo			TTKK_DAT_LamTruSo
			,TTKK_DAT.CoSoHDSuNghiep	TTKK_DAT_CoSoHDSuNghiep
			,TTKK_DAT.NhaO				TTKK_DAT_NhaO
			,TTKK_DAT.ChoThue			TTKK_DAT_ChoThue
			,TTKK_DAT.BoTrong			TTKK_DAT_BoTrong
			-- THÔNG TIN OTO
			,TTKK_OTO.BienKiemSoat		TTKK_OTO_BienKiemSoat
			,TTKK_OTO.LoaiXe			TTKK_OTO_LoaiXe
			,TTKK_OTO.TrongTai			TTKK_OTO_TrongTai
FROM		DanhGia DG
			LEFT JOIN CoSo CS ON DG.CoSoId = CS.CoSoId
			LEFT JOIN CoSo CS_QL ON CS.TrucThuoc = CS_QL.CoSoId
			LEFT JOIN TaiSan TS ON DG.TaiSanId = TS.TaiSanId
			LEFT JOIN ThongTinKeKhai_Dat TTKK_DAT ON TS.TaiSanId = TTKK_DAT.TaiSanId
			LEFT JOIN ThongTinKeKhai_Nha TTKK_NHA ON TS.TaiSanId = TTKK_NHA.TaiSanId
			LEFT JOIN ThongTinKeKhai_Oto TTKK_OTO ON TS.TaiSanId = TTKK_OTO.TaiSanId
			LEFT JOIN ThongTinKeKhai_Tren500 TTKK_500 ON TS.TaiSanId = TTKK_500.TaiSanId
WHERE		DG.DanhGiaId = @DanhGiaId

IF OBJECT_ID('tempdb..#DANHGIA_NGUYENGIA') IS NOT NULL
	DROP TABLE #DANHGIA_NGUYENGIA

--------------------------------------------------
SET NOCOUNT OFF
END

