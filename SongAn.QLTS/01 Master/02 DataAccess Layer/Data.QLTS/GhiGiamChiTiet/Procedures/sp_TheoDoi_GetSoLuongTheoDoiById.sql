ALTER PROC [dbo].[sp_TheoDoi_GetSoLuongTheoDoiById]
( 
	  @TaiSanId	        nvarchar(500)	= null,
	  @PhongBanId        nvarchar(500)	= null,
	  @NhanVienId	        nvarchar(500)	= null			

)
AS  
BEGIN
SET NOCOUNT ON  
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
------------------------------------------------  

	SELECT (SLTon + SLTang - SLGiam) as SoLuong from TheoDoi where TaiSanId = @TaiSanId and PhongBanId = @PhongBanId and NhanVienId = @NhanVienId
-----------------------------------------------------
SET NOCOUNT OFF
END

