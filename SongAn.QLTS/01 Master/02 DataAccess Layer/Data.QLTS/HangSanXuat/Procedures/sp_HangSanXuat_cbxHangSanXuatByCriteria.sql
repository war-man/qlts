/**************************************************
1. Create Date	: 2017.09.08
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: 
4. Function		: 
5. Example		: 
					EXEC [sp_HangSanXuat_cbxHangSanXuatByCriteria]
						 @Search			=	N''
						,@HangSanXuatId		=	N''
						,@MaHangSanXuat		=	N''
						,@CoSoId			=	1
						,@NhanVienId		=	6
6. Precaution	:
7. History		:
				  2017.09.08 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
ALTER PROC [dbo].[sp_HangSanXuat_cbxHangSanXuatByCriteria]
( 
	 @Search			NVARCHAR(500)   =	NULL
	,@HangSanXuatId		INT				=	NULL
	,@MaHangSanXuat		NVARCHAR(500)	=	NULL
	,@CoSoId			NVARCHAR(500)	=	NULL
	,@NhanVienId		NVARCHAR(500)	=	NULL
	
)
AS  
BEGIN
SET NOCOUNT ON  
------------------------------------------------  
	SET @Search				=	ISNULL(@Search,'')
	SET @HangSanXuatId		=	ISNULL(@HangSanXuatId, 0)
	SET @MaHangSanXuat		=	ISNULL(@MaHangSanXuat,'')

	SELECT TOP 10 HSX.*
	FROM	HangSanXuat HSX
	WHERE	(@HangSanXuatId = 0 OR HSX.HangSanXuatId = @HangSanXuatId)
			AND (@MaHangSanXuat = '' OR HSX.MaHangSanXuat = @MaHangSanXuat)
			AND (@Search = '' OR HSX.MaHangSanXuat LIKE N'%' + @Search + '%' OR HSX.TenHangSanXuat LIKE N'%' + @Search + '%')

-----------------------------------------------------
SET NOCOUNT OFF
END

