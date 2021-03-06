USE [QLTS]
GO

/**************************************************
1. Create Date	: 2017.09.14
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: 
4. Function		: 
5. Example		: 
					DECLARE @MESSAGE	NVARCHAR(MAX)
					EXEC [sp_ThayDoiThongTinOto_GetThayDoiThongTinOtoById]
						 @ThayDoiThongTinId		=	26

						,@CoSoId				=	1
						,@NhanVienId			=	6
						,@MESSAGE				=	@MESSAGE OUTPUT
					SELECT	@MESSAGE MESSAGE
6. Precaution	:
7. History		:
				  2017.09.14 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
ALTER PROCEDURE [dbo].[sp_ThayDoiThongTinOto_GetThayDoiThongTinOtoById]
	 @ThayDoiThongTinId	INT				=	NULL

	,@CoSoId			INT				=	NULL
	,@NhanVienId		INT				=	NULL
	,@MESSAGE			NVARCHAR(MAX)		OUTPUT
AS  
BEGIN
SET NOCOUNT ON 
	SET @MESSAGE = ISNULL(@MESSAGE,'')
	SELECT	 TDTT_OTO.ThayDoiThongTinId
			,ISNULL(TDTT_OTO.BienKiemSoatCu		, TTKK_OTO.BienKiemSoat)	BienKiemSoatCu
			,ISNULL(TDTT_OTO.ChucDanhCu			, TTKK_OTO.ChucDanh)		ChucDanhCu
			,ISNULL(TDTT_OTO.CongSuatXeCu		, TTKK_OTO.CongSuatXe)		CongSuatXeCu
			,ISNULL(HTSD.NoiDung	, HTSD2.NoiDung)	TenHienTrangSuDungCu
			,ISNULL(LX.NoiDung			, LX2.NoiDung)			LoaiXeCu
			,ISNULL(TDTT_OTO.NguonGocXeCu		, TTKK_OTO.NguonGocXe)		NguonGocXeCu
			,ISNULL(TDTT_OTO.NhanHieuCu			, TTKK_OTO.NhanHieu)		NhanHieuCu
			,ISNULL(TDTT_OTO.TrongTaiCu			, TTKK_OTO.TrongTai)		TrongTaiCu
	FROM	ThayDoiThongTin_Oto TDTT_OTO
			LEFT JOIN ThayDoiThongTin TDTT ON TDTT_OTO.ThayDoiThongTinId = TDTT.ThayDoiThongTinId
			LEFT JOIN ThongTinKeKhai_Oto TTKK_OTO ON TDTT.TaiSanId = TTKK_OTO.TaiSanId
			LEFT JOIN HienTrangSuDung HTSD ON TDTT_OTO.HienTrangSuDungCu = HTSD.HienTrangSuDungId
			LEFT JOIN LoaiXe LX ON TDTT_OTO.LoaiXeCu = LX.LoaiXeId
			LEFT JOIN HienTrangSuDung HTSD2 ON TTKK_OTO.HienTrangSuDung = HTSD.HienTrangSuDungId
			LEFT JOIN LoaiXe LX2 ON TTKK_OTO.LoaiXe = LX.LoaiXeId
	WHERE	TDTT.ThayDoiThongTinId = @ThayDoiThongTinId
SET NOCOUNT OFF
END

select HTSD.* from ThayDoiThongTin_Oto TDTT_OTO
			LEFT JOIN ThayDoiThongTin TDTT ON TDTT_OTO.ThayDoiThongTinId = TDTT.ThayDoiThongTinId
			LEFT JOIN ThongTinKeKhai_Oto TTKK_OTO ON TDTT.TaiSanId = TTKK_OTO.TaiSanId
			LEFT JOIN HienTrangSuDung HTSD ON TDTT_OTO.HienTrangSuDungCu = HTSD.HienTrangSuDungId
			LEFT JOIN LoaiXe LX ON TDTT_OTO.LoaiXeCu = LX.LoaiXeId
			LEFT JOIN HienTrangSuDung HTSD2 ON TTKK_OTO.HienTrangSuDung = HTSD.HienTrangSuDungId
			LEFT JOIN LoaiXe LX2 ON TTKK_OTO.LoaiXe = LX.LoaiXeId

