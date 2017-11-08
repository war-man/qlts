USE [QLTS]
GO

/**************************************************
1. Create Date	: 2017.09.08
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: 
4. Function		: 
5. Example		: 
					EXEC [sp_PhuongThuc_cbxPhuongThucByCriteria]
						 @Search			=	N''
						,@PhuongThucId		=	N''
						,@MaPhuongThuc		=	N''
						,@CoSoId			=	1
						,@NhanVienId		=	6
6. Precaution	:
7. History		:
				  2017.09.08 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
ALTER PROCEDURE [dbo].[sp_PhuongThuc_cbxPhuongThucByCriteria]
( 
	 @Search			NVARCHAR(500)   =	NULL
	,@PhuongThucId		INT				=	NULL
	,@CoSoId			NVARCHAR(500)	=	NULL
	,@NhanVienId		NVARCHAR(500)	=	NULL
	
)
AS  
BEGIN
SET NOCOUNT ON  
------------------------------------------------  
	SET @Search				=	ISNULL(@Search,'')
	SET @PhuongThucId		=	ISNULL(@PhuongThucId, 0)

	SELECT TOP 10 PT.*
	FROM	PhuongThuc PT
	WHERE	(@PhuongThucId = 0 OR PT.PhuongThucId = @PhuongThucId)
			AND (PT.TenPhuongThuc LIKE N'%' + @Search + '%')
-----------------------------------------------------
SET NOCOUNT OFF
END

