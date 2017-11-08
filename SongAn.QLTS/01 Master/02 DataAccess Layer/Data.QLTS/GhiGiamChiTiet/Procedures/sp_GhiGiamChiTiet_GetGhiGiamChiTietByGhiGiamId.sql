ALTER PROC [dbo].[sp_GhiGiamChiTiet_GetGhiGiamChiTietByGhiGiamId]
( 
	  @GhiGiamId	        nvarchar(500)	= null			

)
AS  
BEGIN
SET NOCOUNT ON  
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
------------------------------------------------  

	SELECT a.GhiGiamId,a.GhiGiamChiTietId,b.MaTaiSan,b.TaiSanId,b.DonViTinh,b.TenTaiSan,PB.PhongBanId,PB.TenPhongBan,a.NhanVienId,CAST(c.XuLyId AS VARCHAR) as XuLyId,c.TenXuLy,ISNULL((TD.SLTon + TD.SLTang - TD.SLGiam),0) as SoLuongTon ,a.SoLuong,ISNULL(sum(d.GiaTri),0) as NguyenGia 
	from GhiGiamChiTiet  a 
	left join TaiSan b on a.TaiSanId=b.TaiSanId  left join XuLy c on a.XuLyId=c.XuLyId
	left join NguyenGia d on a.TaiSanId=d.TaiSanId
	LEFT JOIN TheoDoi TD ON b.TaiSanId = TD.TaiSanId and a.PhongBanId=TD.PhongBanId and a.NhanVienId=TD.NhanVienId
			LEFT JOIN PhongBan PB ON TD.PhongBanId = PB.PhongBanId
	where GhiGiamId= @GhiGiamId
	group by  a.GhiGiamId,a.GhiGiamChiTietId,b.TaiSanId,b.MaTaiSan,b.DonViTinh,b.TenTaiSan,PB.PhongBanId,PB.TenPhongBan,a.NhanVienId,c.TenXuLy,a.SoLuong,TD.SLTon,TD.SLTang,TD.SLGiam,c.XuLyId
-----------------------------------------------------
SET NOCOUNT OFF
END

