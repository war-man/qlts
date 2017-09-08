/**************************************************
1. Create Date	: 2017.09.06
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: 
4. Function		: 
5. Example		: 
					EXEC [sp_HienTrangSuDung_cbxHienTrangSuDungByCriteria]
						 @Search			=	NULL
						,@CoSoId			=	1
						,@NhanVienId		=	6
6. Precaution	:
7. History		:
				  2017.09.06 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
ALTER PROCEDURE [dbo].[sp_HienTrangSuDung_cbxHienTrangSuDungByCriteria]
( 
	  @CoSoId	        nvarchar(500)	= null			
	, @NhanVienId	    nvarchar(500)	= null		
	, @Search			nvarchar(500)   = null	
	
)
AS  
BEGIN
SET NOCOUNT ON 
	SET @Search = ISNULL(@Search,'')
	SELECT	TOP 10 HTSD.*
	FROM	HienTrangSuDung HTSD
SET NOCOUNT OFF
END

