/**************************************************
1. Create Date	: 2017.10.16
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: 
4. Function		: 
5. Example		: 
					DECLARE @MESSAGE	NVARCHAR(MAX)
					EXEC [sp_TaiSan_CheckMaTaiSan]
						 @TaiSanId			=	NULL
						,@MaTaiSan			=	'MAY003'

						,@CoSoId			=	1
						,@NhanVienId		=	6
						,@MESSAGE			=	@MESSAGE OUTPUT
					SELECT	@MESSAGE MESSAGE
6. Precaution	:
7. History		:
				  2017.10.16 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
ALTER PROCEDURE [dbo].[sp_TaiSan_CheckMaTaiSan]
	 @TaiSanId			INT				=	NULL
	,@MaTaiSan			NVARCHAR(MAX)	=	NULL

	,@CoSoId			INT				=	NULL
	,@NhanVienId		INT				=	NULL
	,@MESSAGE			NVARCHAR(MAX)		OUTPUT
AS  
BEGIN
SET NOCOUNT ON 
--------------------------------------------------
SET @MESSAGE = ISNULL(@MESSAGE,'')

SET @TaiSanId = ISNULL(@TaiSanId,0)
SET @MaTaiSan = ISNULL(@MaTaiSan,'')
SELECT *
FROM TaiSan TS
WHERE TS.MaTaiSan = @MaTaiSan AND TS.TaiSanId <> @TaiSanId
--------------------------------------------------
SET NOCOUNT OFF
END
