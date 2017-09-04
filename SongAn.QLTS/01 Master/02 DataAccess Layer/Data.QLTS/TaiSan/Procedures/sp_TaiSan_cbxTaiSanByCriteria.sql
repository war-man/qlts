/**************************************************
1. Create Date	: 2017.09.01
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: THÔNG TIN TÀI SẢN
4. Function		: 
5. Example		: 
					EXEC [sp_TaiSan_cbxTaiSanByCriteria]
						 @Search			=	N'1'
						,@CoSoId			=	1
						,@NhanVienId		=	6
6. Precaution	:
7. History		:
				  2017.09.01 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
ALTER PROCEDURE [dbo].[sp_TaiSan_cbxTaiSanByCriteria]
( 
	  @CoSoId	        nvarchar(500)	= null			
	, @NhanVienId	    nvarchar(500)	= null		
	, @Search			nvarchar(500)   = null	
	
)
AS  
BEGIN
SET NOCOUNT ON  
	SELECT	TOP 10 *
	FROM	TaiSan TS 
	WHERE	TS.MaTaiSan LIKE N'%' + @Search + '%'
			AND TS.TenTaiSan LIKE N'%' + @Search + '%'
SET NOCOUNT OFF
END

