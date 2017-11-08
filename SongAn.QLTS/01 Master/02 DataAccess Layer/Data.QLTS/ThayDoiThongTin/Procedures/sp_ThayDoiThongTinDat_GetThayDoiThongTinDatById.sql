USE [QLTS]
GO

/**************************************************
1. Create Date	: 2017.09.14
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: 
4. Function		: 
5. Example		: 
					DECLARE @MESSAGE	NVARCHAR(MAX)
					EXEC [sp_ThayDoiThongTinDat_GetThayDoiThongTinDatById]
						 @ThayDoiThongTinId		=	26

						,@CoSoId				=	1
						,@NhanVienId			=	6
						,@MESSAGE				=	@MESSAGE OUTPUT
					SELECT	@MESSAGE MESSAGE
6. Precaution	:
7. History		:
				  2017.09.14 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
ALTER PROCEDURE [dbo].[sp_ThayDoiThongTinDat_GetThayDoiThongTinDatById]
	 @ThayDoiThongTinId	INT				=	NULL

	,@CoSoId			INT				=	NULL
	,@NhanVienId		INT				=	NULL
	,@MESSAGE			NVARCHAR(MAX)		OUTPUT
AS  
BEGIN
SET NOCOUNT ON 
	SET @MESSAGE = ISNULL(@MESSAGE,'')
	SELECT	TDTT_DAT.ThayDoiThongTinId
			,ISNULL(TDTT_DAT.BiLanChiemCu		, TTKK_DAT.BiLanChiem)		BiLanChiemCu
			,ISNULL(TDTT_DAT.BoTrongCu			, TTKK_DAT.BoTrong)			BoTrongCu
			,ISNULL(TDTT_DAT.ChoThueCu			, TTKK_DAT.ChoThue)			ChoThueCu
			,ISNULL(TDTT_DAT.CoSoHDSuNghiepCu	, TTKK_DAT.CoSoHDSuNghiep)	CoSoHDSuNghiepCu
			,ISNULL(TDTT_DAT.DiaChiCu			, TTKK_DAT.DiaChi)			DiaChiCu
			,ISNULL(TDTT_DAT.DienTichCu			, TTKK_DAT.DienTich)		DienTichCu
			,ISNULL(TDTT_DAT.GiayToCu			, TTKK_DAT.GiayTo)			GiayToCu
			,ISNULL(TDTT_DAT.LamTruSoCu			, TTKK_DAT.LamTruSo)		LamTruSoCu
			,ISNULL(TDTT_DAT.NhaOCu				, TTKK_DAT.NhaO)			NhaOCu
			,ISNULL(TDTT_DAT.SuDungKhacCu		, TTKK_DAT.SuDungKhac)		SuDungKhacCu
	FROM	ThayDoiThongTin_Dat TDTT_DAT
			LEFT JOIN ThayDoiThongTin TDTT ON TDTT_DAT.ThayDoiThongTinId = TDTT.ThayDoiThongTinId
			LEFT JOIN ThongTinKeKhai_Dat TTKK_DAT ON TDTT.TaiSanId = TTKK_DAT.TaiSanId
	WHERE	TDTT_DAT.ThayDoiThongTinId = @ThayDoiThongTinId
SET NOCOUNT OFF
END

