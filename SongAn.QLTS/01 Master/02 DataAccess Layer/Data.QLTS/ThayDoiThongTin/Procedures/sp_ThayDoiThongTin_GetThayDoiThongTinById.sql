USE [QLTS]
GO

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

	SELECT	TDTT.ThayDoiThongTinId,TDTT.TaiSanId,TDTT.Ngay,
	TS.TenTaiSan  as TenTaiSanMoi,Isnull(TDTT.TenTaiSanCu,TS.TenTaiSan) as TenTaiSanCu
	,TDTT.LyDo,TDTT.DuyetId,TDTT.NguoiDuyet,TDTT.CoSoId,TDTT.NguoiTao,TDTT.NgayTao,TDTT.CtrVersion,
	 TS.LoaiKeKhai LoaiKeKhai
	FROM	ThayDoiThongTin TDTT 
			LEFT JOIN TaiSan TS ON TDTT.TaiSanId = TS.TaiSanId
	WHERE	CHARINDEX('|' + CAST(TS.CoSoId AS VARCHAR(10)) + '|','|' + @_COSO_IDS + '|') > 0
			AND TDTT.ThayDoiThongTinId = @ThayDoiThongTinId
SET NOCOUNT OFF
END

