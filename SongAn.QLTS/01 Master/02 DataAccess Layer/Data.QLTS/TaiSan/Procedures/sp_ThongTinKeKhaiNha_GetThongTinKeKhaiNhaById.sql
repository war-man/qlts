/**************************************************
1. Create Date	: 2017.09.09
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: 
4. Function		: 
5. Example		: 
					DECLARE @MESSAGE	NVARCHAR(MAX)
					EXEC [sp_ThongTinKeKhaiNha_GetThongTinKeKhaiNhaById]
						 @TaiSanId			=	34

						,@CoSoId			=	1
						,@NhanVienId		=	6
						,@MESSAGE			=	@MESSAGE OUTPUT
					SELECT	@MESSAGE MESSAGE
6. Precaution	:
7. History		:
				  2017.09.09 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
ALTER PROCEDURE [dbo].[sp_ThongTinKeKhaiNha_GetThongTinKeKhaiNhaById]
	 @TaiSanId			INT				=	NULL

	,@CoSoId			INT				=	NULL
	,@NhanVienId		INT				=	NULL
	,@MESSAGE			NVARCHAR(MAX)		OUTPUT
AS  
BEGIN
SET NOCOUNT ON  
	SELECT	*
	FROM	ThongTinKeKhai_Nha
	WHERE	TaiSanId = @TaiSanId
SET NOCOUNT OFF
END

