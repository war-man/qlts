/**************************************************
1. Create Date	: 2017.09.14
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: 
4. Function		: 
5. Example		: 
					DECLARE @MESSAGE	NVARCHAR(MAX)
					EXEC [sp_ThayDoiThongTin_GetThayDoiThongTinById]
						 @ThayDoiThongTinId			=	26

						,@CoSoId			=	1
						,@NhanVienId		=	6
						,@MESSAGE			=	@MESSAGE OUTPUT
					SELECT	@MESSAGE MESSAGE
6. Precaution	:
7. History		:
				  2017.09.14 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
ALTER PROCEDURE [dbo].[sp_ThayDoiThongTin_GetThayDoiThongTinById]
	 @ThayDoiThongTinId		INT				=	NULL

	,@CoSoId				INT				=	NULL
	,@NhanVienId			INT				=	NULL
	,@MESSAGE				NVARCHAR(MAX)		OUTPUT
AS  
BEGIN
SET NOCOUNT ON
	DECLARE @_COSO_IDS		VARCHAR(MAX)	=	NULL

	SET @MESSAGE = ISNULL(@MESSAGE,'')

	EXEC [dbo].[sp_CoSo_GetListCoSoTrucThuocById]
	   @COSOID=@CoSoId
	  ,@COSOID_OUT=@_COSO_IDS OUTPUT
	SET @_COSO_IDS = REPLACE(@_COSO_IDS,',','|')
	PRINT concat('@_COSO_IDS=',@_COSO_IDS)

	SELECT	TDTT.*, TS.LoaiKeKhai LoaiKeKhai
	FROM	ThayDoiThongTin TDTT
			LEFT JOIN TaiSan TS ON TDTT.TaiSanId = TS.TaiSanId
	WHERE	CHARINDEX('|' + CAST(TS.CoSoId AS VARCHAR(10)) + '|','|' + @_COSO_IDS + '|') > 0
			AND TDTT.ThayDoiThongTinId = @ThayDoiThongTinId
SET NOCOUNT OFF
END

