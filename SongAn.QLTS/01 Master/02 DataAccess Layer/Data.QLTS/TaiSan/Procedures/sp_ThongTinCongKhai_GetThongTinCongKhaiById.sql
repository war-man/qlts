/**************************************************
1. Create Date	: 2017.09.07
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: 
4. Function		: 
5. Example		: 
					DECLARE @MESSAGE	NVARCHAR(MAX)
					EXEC [sp_ThongTinCongKhai_GetThongTinCongKhaiById]
						 @TaiSanId			=	1034

						,@CoSoId			=	1
						,@NhanVienId		=	6
						,@MESSAGE			=	@MESSAGE OUTPUT
					SELECT	@MESSAGE MESSAGE
6. Precaution	:
7. History		:
				  2017.09.07 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
ALTER PROCEDURE [dbo].[sp_ThongTinCongKhai_GetThongTinCongKhaiById]
	 @TaiSanId			INT				=	NULL

	,@CoSoId			INT				=	NULL
	,@NhanVienId		INT				=	NULL
	,@MESSAGE			NVARCHAR(MAX)		OUTPUT
AS  
BEGIN
SET NOCOUNT ON  
	SELECT	TTCK.*
	FROM	ThongTinCongKhai TTCK
	WHERE	TaiSanId = @TaiSanId
SET NOCOUNT OFF
END
