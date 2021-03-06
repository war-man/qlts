/**************************************************
1. Create Date	: 2017.10.09
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: 
4. Function		: 
5. Example		: 
					EXEC [sp_TaiSan_report_KeKhaiDat]
						 @TaiSanId			=	NULL
						,@Year				=	'2017'
						,@LoaiKeKhai		=	''
						,@COSO_ID			=	''
						,@NHANVIEN_ID		=	''
6. Precaution	:
7. History		:
				  2017.10.09 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
ALTER PROCEDURE [dbo].[sp_TaiSan_report_KeKhaiDat]
	 @TaiSanId		NVARCHAR(MAX)	=	NULL
	,@Year			NVARCHAR(MAX)	=	NULL
	,@LoaiKeKhai	NVARCHAR(MAX)	=	NULL
	,@COSO_ID		INT				=	NULL
	,@NHANVIEN_ID	INT				=	NULL
AS
BEGIN
SET NOCOUNT ON
--------------------------------------------------
DECLARE  @V_DELIMITER VARCHAR(10)	=	'|'
		,@_COSO_IDS		VARCHAR(MAX)	=	NULL

SET @TaiSanId = ISNULL(@TaiSanId, '')
SET @LoaiKeKhai = '1'

EXEC [dbo].[sp_CoSo_GetListCoSoTrucThuocById]
   @COSOID=@COSO_ID
  ,@COSOID_OUT=@_COSO_IDS OUTPUT
SET @_COSO_IDS = REPLACE(@_COSO_IDS,',',@V_DELIMITER)
PRINT @_COSO_IDS

SELECT		 COUNT(TS.TaiSanId) OVER () AS MAXCNT
			,CS.TenCoSo TenDonVi
			,CS_TT.TenCoSo TenDonViChuQuan

			,TS.TaiSanId TTKK_DAT_TaiSanId
			,TS.TenTaiSan TTKK_DAT_TenTaiSan

			,TTKK_DAT.DiaChi TTKK_DAT_DiaChi
			,TTKK_DAT.DienTich TTKK_DAT_DienTich
			,TTKK_DAT.GiayTo TTKK_DAT_GiayTo
			,TTKK_DAT.BiLanChiem TTKK_DAT_BiLanChiem
			,TTKK_DAT.ChoThue TTKK_DAT_ChoThue
			,TTKK_DAT.BoTrong TTKK_DAT_BoTrong
			,TTKK_DAT.CoSoHDSuNghiep TTKK_DAT_CoSoHDSuNghiep
			,TTKK_DAT.LamTruSo TTKK_DAT_LamTruSo
			,TTKK_DAT.NhaO TTKK_DAT_NhaO
			,TTKK_DAT.SuDungKhac TTKK_DAT_SuDungKhac


			,TS_NHA.TenTaiSan TTKK_NHA_TenTaiSan
			,TTKK_NHA.DienTich TTKK_NHA_DienTich
			,TTKK_NHA.BiLanChiem TTKK_NHA_BiLanChiem
			,TTKK_NHA.BoTrong TTKK_NHA_BoTrong
			,TTKK_NHA.CapHang TTKK_NHA_CapHang
			,TTKK_NHA.ChoThue TTKK_NHA_ChoThue
			,TTKK_NHA.CoSoHDSuNghiep TTKK_NHA_CoSoHDSuNghiep
			,TTKK_NHA.DiaChi TTKK_NHA_DiaChi
			,TTKK_NHA.LamTruSo TTKK_NHA_LamTruSo
			,TTKK_NHA.NamSuDung TTKK_NHA_NamSuDung
			,TTKK_NHA.NhaO TTKK_NHA_NhaO
			,TTKK_NHA.SoTang TTKK_NHA_SoTang
			,TTKK_NHA.SuDungKhac TTKK_NHA_SuDungKhac
FROM		(
			SELECT		TaiSanId,Nam,(SLTon + SUM(SLTang) - SUM(SLGiam)) TonCuoi
			FROM		TheoDoi
			WHERE		Nam = @Year
			GROUP BY	TaiSanId,Nam,SLTon
			HAVING		(SLTon + SUM(SLTang) - SUM(SLGiam)) > 0
			) TD
			LEFT JOIN TaiSan TS ON TD.TaiSanId = TS.TaiSanId
			LEFT JOIN ThongTinKeKhai_Dat TTKK_DAT ON TS.TaiSanId = TTKK_DAT.TaiSanId
			LEFT JOIN ThongTinKeKhai_Nha TTKK_NHA ON TTKK_DAT.TaiSanId = TTKK_NHA.ThuocDat
			LEFT JOIN TaiSan TS_NHA ON TTKK_NHA.TaiSanId = TS_NHA.TaiSanId
			LEFT JOIN CoSo CS ON TS.CoSoId = CS.CoSoId
			LEFT JOIN CoSo CS_TT ON  CS.TrucThuoc = CS_TT.CoSoId
WHERE		(@TaiSanId = '' OR CHARINDEX(@V_DELIMITER + CAST(TS.TaiSanId AS VARCHAR(20)) + @V_DELIMITER,@V_DELIMITER + @TaiSanId + @V_DELIMITER)>0)
			AND  CHARINDEX(@V_DELIMITER + CAST(TS.CoSoId AS VARCHAR(20)) + @V_DELIMITER,@V_DELIMITER + @_COSO_IDS + @V_DELIMITER) > 0
			AND (@LoaiKeKhai = '' OR CHARINDEX(@V_DELIMITER + CAST(TS.LoaiKeKhai AS VARCHAR(20)) + @V_DELIMITER,@V_DELIMITER + @LoaiKeKhai + @V_DELIMITER)>0)
--------------------------------------------------
SET NOCOUNT OFF
END

