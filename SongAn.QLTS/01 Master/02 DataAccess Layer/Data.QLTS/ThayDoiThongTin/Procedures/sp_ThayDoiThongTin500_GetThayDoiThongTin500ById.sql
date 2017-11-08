USE [QLTS]
GO
/****** Object:  StoredProcedure [dbo].[sp_ThayDoiThongTin500_GetThayDoiThongTin500ById]    Script Date: 11/8/2017 8:40:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**************************************************
1. Create Date	: 2017.09.14
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: 
4. Function		: 
5. Example		: 
					DECLARE @MESSAGE	NVARCHAR(MAX)
					EXEC [sp_ThayDoiThongTin500_GetThayDoiThongTin500ById]
						 @ThayDoiThongTinId		=	26

						,@CoSoId				=	1
						,@NhanVienId			=	6
						,@MESSAGE				=	@MESSAGE OUTPUT
					SELECT	@MESSAGE MESSAGE
6. Precaution	:
7. History		:
				  2017.09.14 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
ALTER PROCEDURE [dbo].[sp_ThayDoiThongTin500_GetThayDoiThongTin500ById]
	 @ThayDoiThongTinId	INT				=	NULL

	,@CoSoId			INT				=	NULL
	,@NhanVienId		INT				=	NULL
	,@MESSAGE			NVARCHAR(MAX)		OUTPUT
AS  
BEGIN
SET NOCOUNT ON 
	SET @MESSAGE = ISNULL(@MESSAGE,'')
	SELECT	 TDTT_500.ThayDoiThongTinId
			,ISNULL(TDTT_500.KyHieuCu			, TTKK_500.KyHieu)			KyHieuCu
			,ISNULL(TDTT_500.HienTrangSuDungCu	, TTKK_500.HienTrangSuDung)	HienTrangSuDungCu
			,ISNULL(HTSD_OLD.NoiDung			, HTSD_NEW.NoiDung)			TenHienTrangSuDungCu
	FROM	ThayDoiThongTin_Tren500 TDTT_500
			LEFT JOIN ThayDoiThongTin TDTT ON TDTT_500.ThayDoiThongTinId = TDTT.ThayDoiThongTinId
			LEFT JOIN ThongTinKeKhai_Tren500 TTKK_500 ON TDTT.TaiSanId = TTKK_500.TaiSanId
			LEFT JOIN HienTrangSuDung HTSD_OLD ON TDTT_500.HienTrangSuDungCu = HTSD_OLD.HienTrangSuDungId
			LEFT JOIN HienTrangSuDung HTSD_NEW ON TTKK_500.HienTrangSuDung = HTSD_NEW.HienTrangSuDungId
	WHERE	TDTT.ThayDoiThongTinId = @ThayDoiThongTinId
SET NOCOUNT OFF
END

