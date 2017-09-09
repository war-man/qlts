/**************************************************
1. Create Date	: 2017.09.01
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: THÔNG TIN TÀI SẢN
4. Function		: 
5. Example		: 
					EXEC [sp_TaiSan_cbxTaiSanByCriteria]
						 @Search			=	N''
						,@TaiSanId			=	N''
						,@MaTaiSan			=	N''
						,@CoSoId			=	1
						,@NhanVienId		=	6
6. Precaution	:
7. History		:
				  2017.09.01 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
ALTER PROCEDURE [dbo].[sp_TaiSan_cbxTaiSanByCriteria]
( 
	  @CoSoId	        NVARCHAR(500)	=	NULL			
	, @NhanVienId	    NVARCHAR(500)	=	NULL		
	, @Search			NVARCHAR(500)   =	NULL	
	, @TaiSanId			INT				=	NULL	
	, @MaTaiSan			NVARCHAR(500)   =	NULL	
	
)
AS  
BEGIN
SET NOCOUNT ON 
	SET @Search = ISNULL(@Search,'')
	SET @TaiSanId = ISNULL(@TaiSanId, 0)
	SET @MaTaiSan = ISNULL(@MaTaiSan,'')

	SELECT	TOP 10 TS.TaiSanId,TS.MaTaiSan,TS.TenTaiSan, ISNULL(SUM(NG.GiaTri),0) NguyenGia, TS.DonViTinh
	FROM	TaiSan TS
			LEFT JOIN NguyenGia NG ON TS.TaiSanId = NG.TaiSanId
	WHERE	TS.CoSoId = @CoSoId
			AND (@TaiSanId = 0 OR TS.TaiSanId = @TaiSanId)
			AND (@MaTaiSan = '' OR TS.MaTaiSan = @MaTaiSan)
			AND (@Search = '' OR TS.MaTaiSan LIKE N'%' + @Search + '%' OR TS.TenTaiSan LIKE N'%' + @Search + '%')

	GROUP BY  TS.TaiSanId,TS.MaTaiSan,TS.TenTaiSan,TS.DonViTinh
SET NOCOUNT OFF
END

