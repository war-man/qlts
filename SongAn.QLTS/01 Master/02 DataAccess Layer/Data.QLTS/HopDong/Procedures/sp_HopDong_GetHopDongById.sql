ALTER PROC [dbo].[sp_HopDong_GetHopDongById]
( 
	  @HopDongId NVARCHAR(500)	= null			
)
AS  
BEGIN
SET NOCOUNT ON  
------------------------------------------------  

	SELECT HopDongId, SoHopDong, CONVERT(VARCHAR, NgayHopDong,103)NgayHopDong, TenNhaThau, DaiDien, 
			GiaTriHopDong, NoiDung, FileDinhKem, CoSoId, NgayTao, NguoiTao
	FROM dbo.HopDong
	WHERE HopDongId = @HopDongId
-----------------------------------------------------
SET NOCOUNT OFF
END

