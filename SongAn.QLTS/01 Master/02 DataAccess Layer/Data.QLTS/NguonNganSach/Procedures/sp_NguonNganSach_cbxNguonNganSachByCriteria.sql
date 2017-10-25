/**************************************************
1. Create Date	: 2017.09.08
2. Creator		: NGUYỄN THANH BÌNH
3. Description	: 
4. Function		: 
5. Example		: 
					EXEC [sp_NguonNganSach_cbxNguonNganSachByCriteria]
						 @Search			=	N''
						,@NguonNganSachId	=	N''
						,@MaNguonNganSach	=	N''
						,@CoSoId			=	1
						,@NhanVienId		=	6
6. Precaution	:
7. History		:
				  2017.09.08 (NGUYỄN THANH BÌNH) - Tạo mới
**************************************************/
ALTER PROC [dbo].[sp_NguonNganSach_cbxNguonNganSachByCriteria]
( 
	 @Search			NVARCHAR(500)   =	NULL
	,@NguonNganSachId	VARCHAR(MAX)	=	NULL
	,@MaNguonNganSach	NVARCHAR(500)	=	NULL
	,@CoSoId			NVARCHAR(500)	=	NULL
	,@NhanVienId		NVARCHAR(500)	=	NULL
)
AS  
BEGIN
SET NOCOUNT ON  
------------------------------------------------  
	SET @Search				=	ISNULL(@Search,'')
	SET @NguonNganSachId	=	ISNULL(@NguonNganSachId, '')
	SET @MaNguonNganSach	=	ISNULL(@MaNguonNganSach,'')

	SELECT TOP 10 NNS.*
	FROM	NguonNganSach NNS
	WHERE	(@NguonNganSachId = '' OR NNS.NguonNganSachId = @NguonNganSachId)
			AND (@MaNguonNganSach = '' OR NNS.MaNguonNganSach = @MaNguonNganSach)
			AND (@Search = '' OR NNS.MaNguonNganSach LIKE N'%' + @Search + '%' OR NNS.MaNguonNganSach LIKE N'%' + @Search + '%')
-----------------------------------------------------
SET NOCOUNT OFF
END