/**************************************************
1. Create Date	: 2017.09.01
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: THÔNG TIN TÀI SẢN
4. Function		: 
5. Example		: 
					EXEC [sp_TaiSan_cbxTaiSanSuDungByCriteria]
						 @Search			=	N''
						,@TaiSanId			=	N''
						,@MaTaiSan			=	N''
						,@CoSoId			=	1
						,@NhanVienId		=	6
6. Precaution	:
7. History		:
				  2017.09.01 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
ALTER PROCEDURE [dbo].[sp_TaiSan_cbxTaiSanSuDungById]
( 
	  @CoSoId	        INT				= null			
	, @TaiSanId			INT				=	NULL
	, @PhongBanId		INT				=	NULL
	, @NhanVienId	    INT				=	null
	, @FunctionCode		NVARCHAR(500)   =	NULL	
)
AS  
BEGIN
SET NOCOUNT ON
	DECLARE  @_COSO_IDS		VARCHAR(MAX)	=	NULL
			,@V_ISVIEW		VARCHAR(MAX)	=	NULL

	EXEC [dbo].[sp_CoSo_GetListCoSoTrucThuocById]
	   @COSOID=@CoSoId
	  ,@COSOID_OUT=@_COSO_IDS OUTPUT
	SET @_COSO_IDS = REPLACE(@_COSO_IDS,',','|')
	PRINT concat('@_COSO_IDS=',@_COSO_IDS)

	SELECT	TOP 10 TS.TaiSanId,TS.MaTaiSan,TS.DonViTinh,TS.TenTaiSan,PB.PhongBanId,PB.TenPhongBan, ISNULL((TD.SLTon + TD.SLTang - TD.SLGiam),0) as SoLuongTon ,  ISNULL(SUM(NG.GiaTri),0) NguyenGia,nv.NhanVienId,nv.TenNhanVien
	FROM	TaiSan TS
			LEFT JOIN NguyenGia NG ON TS.TaiSanId = NG.TaiSanId
			LEFT JOIN TheoDoi TD ON TS.TaiSanId = TD.TaiSanId
			LEFT JOIN PhongBan PB ON TD.PhongBanId = PB.PhongBanId
			LEFT JOIN dbo.NhanVien nv ON nv.NhanVienId = TD.NhanVienId
	WHERE	TD.TaiSanId = @TaiSanId and TD.PhongBanId = @PhongBanId and TD.NhanVienId = @NhanVienId
			
	GROUP BY  TS.TaiSanId,TS.MaTaiSan,TS.TenTaiSan,TS.DonViTinh,PB.PhongBanId,PB.TenPhongBan,TD.SLTon,TD.SLTang,TD.SLGiam,nv.NhanVienId,nv.TenNhanVien
SET NOCOUNT OFF
END
