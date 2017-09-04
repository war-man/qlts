/**************************************************
1. Create Date	: 2017.09.01
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: DANH SÁCH PHƯƠNG THỨC
4. Function		: 
5. Example		: 
					EXEC [sp_PhuongThuc_cbxPhuongThucByCriteria]
						 @Search			=	''
						,@CoSoId			=	1
						,@NhanVienId		=	6
6. Precaution	:
7. History		:
				  2017.09.01 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
ALTER PROCEDURE [dbo].[sp_PhuongThuc_cbxPhuongThucByCriteria]
( 
	  @CoSoId	        nvarchar(500)	= null			
	, @NhanVienId	    nvarchar(500)	= null		
	, @Search			nvarchar(500)   = null	
	
)
AS  
BEGIN
SET NOCOUNT ON  
------------------------------------------------  
	SELECT *
	FROM PhuongThuc 
-----------------------------------------------------
SET NOCOUNT OFF
END

