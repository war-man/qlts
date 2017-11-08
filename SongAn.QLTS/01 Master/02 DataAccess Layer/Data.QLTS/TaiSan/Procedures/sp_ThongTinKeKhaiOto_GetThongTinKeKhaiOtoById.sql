USE [QLTS]
GO

/**************************************************
1. Create Date	: 2017.09.14
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: 
4. Function		: 
5. Example		: 
					DECLARE @MESSAGE	NVARCHAR(MAX)
					EXEC [sp_ThongTinKeKhaiOto_GetThongTinKeKhaiOtoById]
						 @TaiSanId			=	34

						,@CoSoId			=	1
						,@NhanVienId		=	6
						,@MESSAGE			=	@MESSAGE OUTPUT
					SELECT	@MESSAGE MESSAGE
6. Precaution	:
7. History		:
				  2017.09.14 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
ALTER PROCEDURE [dbo].[sp_ThongTinKeKhaiOto_GetThongTinKeKhaiOtoById]
	 @TaiSanId			INT				=	NULL

	,@CoSoId			INT				=	NULL
	,@NhanVienId		INT				=	NULL
	,@MESSAGE			NVARCHAR(MAX)		OUTPUT
AS  
BEGIN
SET NOCOUNT ON  
	SELECT	TTKK_OTO.*,HTSD.NoiDung TenHienTrangSuDung,LX.NoiDung TenLoaiXe
	FROM	ThongTinKeKhai_Oto TTKK_OTO
			LEFT JOIN HienTrangSuDung HTSD ON TTKK_OTO.HienTrangSuDung = HTSD.HienTrangSuDungId
			LEFT JOIN LoaiXe LX ON TTKK_OTO.LoaiXe = LX.LoaiXeId
	WHERE	TaiSanId = @TaiSanId
SET NOCOUNT OFF
END

