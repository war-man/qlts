USE [QLTS]
GO

/**************************************************
1. Create Date	: 2017.09.14
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: 
4. Function		: 
5. Example		: 
					DECLARE @MESSAGE	NVARCHAR(MAX)
					EXEC [sp_ThongTinKeKhai500_GetThongTinKeKhai500ById]
						 @TaiSanId			=	34

						,@CoSoId			=	1
						,@NhanVienId		=	6
						,@MESSAGE			=	@MESSAGE OUTPUT
					SELECT	@MESSAGE MESSAGE
6. Precaution	:
7. History		:
				  2017.09.14 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
ALTER PROCEDURE [dbo].[sp_ThongTinKeKhai500_GetThongTinKeKhai500ById]
	 @TaiSanId			INT				=	NULL

	,@CoSoId			INT				=	NULL
	,@NhanVienId		INT				=	NULL
	,@MESSAGE			NVARCHAR(MAX)		OUTPUT
AS  
BEGIN
SET NOCOUNT ON 
	SET @MESSAGE = ISNULL(@MESSAGE, '')
	SELECT	*,
			HTSD.NoiDung TenHienTrangSuDung
	FROM	ThongTinKeKhai_Tren500 TTKK_500
			LEFT JOIN HienTrangSuDung HTSD ON TTKK_500.HienTrangSuDung = HTSD.HienTrangSuDungId
	WHERE	TaiSanId = @TaiSanId
SET NOCOUNT OFF
END

